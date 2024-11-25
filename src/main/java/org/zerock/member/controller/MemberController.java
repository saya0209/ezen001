package org.zerock.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.service.MemberService;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;
	
	// 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {
		log.info("========= loginForm.do ============");
		return "member/loginForm";
	}
	
	// 로그인 처리
	@PostMapping("/login.do")
	public String login(LoginVO vo,
			HttpSession session, RedirectAttributes rttr) {
		log.info("========= login.do =============");
		
		// DB에서 로그인 정보를 가져옵니다. - id, pw를 넘겨서
		LoginVO loginVO = service.login(vo);
		
		if (loginVO == null) {
			rttr.addFlashAttribute("msg",
				"로그인 정보가 맞지 않습니다.<br>정보를 확인하시고 다시 시도해 주세요");
			
			return "redirect:/member/loginForm.do";
		}
		
		// 로그인 정보를 찾았을때
		session.setAttribute("login", loginVO);
		rttr.addFlashAttribute("msg",
			loginVO.getNicname() + "님은 " + 
			loginVO.getGradeName() + "(으)로 로그인 되었습니다.");
		
	    // 로그인 시, 최근 접속일을 현재 시간으로 갱신
	    service.updateConDate(loginVO.getId());  // 로그인 시 conDate 갱신
	    session.setAttribute("loginUserId", vo.getId());
		return "redirect:/main/main.do";
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session,
			RedirectAttributes rttr) {
		log.info("========= logout.do =============");
		
		session.removeAttribute("login");
		
		rttr.addFlashAttribute("msg",
				"로그 아웃이 되었습니다.<br>불편한 사항은 질문 답변 게시판을 이용해 주세요");
		
		
		return "redirect:/main/main.do";
	}
	
	// 1. 회원 목록 조회		
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) {
		log.info("list.do ======");
		
		// 페이지 처리를 위한 객체생성
		PageObject pageObject = PageObject.getInstance(request);
		
		// 처리된 데이터를 Model에 저장해서 jsp로 넘긴다.
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		
		return "member/list";
	}
	
	// 2. 멤버목록 글보기
	@GetMapping("/view.do")
	public String view(Model model, String id) {
		log.info("view.do ================");
		model.addAttribute("vo", service.view(id));
		return "member/view";
	}
	// 3-1. 회원가입 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do ==================");
		return "member/write";
	}	
	
	// 3-2. 회원가입 처리
	@PostMapping("/write.do")
	public String write(MemberVO vo, RedirectAttributes rttr) {
		log.info("write.do =================");
		
		service.write(vo);
		
		rttr.addFlashAttribute("msg",
			"회원가입이 완료되었습니다!");
		
		return "redirect:/main/main.do";
	}
	
	// 3-3. Id 중복 확인
	@PostMapping("/ConfirmId")
	@ResponseBody
	public ResponseEntity<Boolean> confirmId(String id) {
		log.info("ConfirmId.........");
		log.info("id : " + id);
		boolean result = true;
		
		if(id.trim().isEmpty()) {
			log.info("id : " + id);
			result = false;
		} else {
			if (service.selectId(id)) {
				result = false;
			} else {
				result = true;
			}
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	// 4-1. 내정보 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, String id) {
		log.info("updateForm.do ==================");
		
		model.addAttribute("vo", service.view(id));
		
		return "member/update";
	}
	// 4-2. 내정보 수정 처리
	@PostMapping("/update.do")
	public String update(MemberVO vo, RedirectAttributes rttr) {
		log.info("update.do =================");
		log.info("gradeNo = "+vo.getGradeNo());
		log.info("Id = "+vo.getId());
		
		Integer result = service.update(vo);
		
		if (result == 1) {
			rttr.addFlashAttribute("msg",
					"내 정보가 수정되었습니다.");

			if (vo.getGradeNo() == 9) {
				return "redirect:/member/list.do";
			}
				return "redirect:/member/mypageMain.do?id="+vo.getId();
		}
		else {
			rttr.addFlashAttribute("msg",
					"내 정보가 수정되지 않았습니다.");
			
			return "redirect:/member/view.do?id=" + vo.getId();
		}
	}
	
	// 5. 회원 등급 수정
	@GetMapping("/changeGradeNo.do")
	public String changeGradeNo(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeGradeNo.do =================");
		log.info("gradeNo = "+vo.getGradeNo());
		log.info("Id = "+vo.getId());
		
		Integer result = service.changeGradeNo(vo);
		
		if (result == 1) {
			rttr.addFlashAttribute("msg",
					"회원 등급이 수정되었습니다.");
			return "redirect:/member/list.do";

		}
		else {
			rttr.addFlashAttribute("msg",
					"회원 등급이 수정되지 않았습니다.");
			
			return "redirect:/member/list.do";
		}
	}
	
	
	// 6. 회원 상태 수정
	@GetMapping("/changeStatus.do")
	public String changeStatus(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeStatus.do =================");
		log.info("status = "+vo.getStatus());
		log.info("Id = "+vo.getId());
		
		Integer result = service.changeStatus(vo);
		
		if (result == 1) {
			rttr.addFlashAttribute("msg",
					"회원 상태가 수정되었습니다.");
			return "redirect:/member/list.do";

		}
		else {
			rttr.addFlashAttribute("msg",
					"회원 상태가 수정되지 않았습니다.");
			
			return "redirect:/member/list.do";
		}
	}
	
	// 7. 회원 정보 사진 바꾸기
	@PostMapping("/changePhoto.do")
	public String changePhoto(@ModelAttribute MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) {
	    log.info("changePhoto.do ==============");
	    
	    // 업로드된 파일을 가져오기
	    MultipartFile imageFile = vo.getImageFile();
	    
	    if (imageFile != null && !imageFile.isEmpty()) {
	        try {
	            // 파일 이름 가져오기
	            String fileName = imageFile.getOriginalFilename();
	            
	            // 웹 애플리케이션의 실제 경로로 저장할 경로 설정
	            String savePath = "/resources/images/" + fileName;
	            String realPath = request.getServletContext().getRealPath(savePath); // 실제 서버 경로
	            
	            // 파일 저장
	            imageFile.transferTo(new File(realPath));
	            
	            // 저장된 파일 경로를 vo.grade_image에 설정
	            vo.setGrade_image(savePath);
	            
	    	    log.info("fileName = " + imageFile.getOriginalFilename());
	    	    log.info("savePath = " + "/resources/images/" + imageFile.getOriginalFilename());
	    	    log.info("grade_image = " + vo.getGrade_image());
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "파일 업로드 실패");
	            return "redirect:/member/view.do?id=" + vo.getId();
	        }
	    }
	    
	    // 서비스 메서드를 통해 이미지 경로 업데이트
	    Integer result = service.changePhoto(vo);

	    
	    if (result == 1) {
	        rttr.addFlashAttribute("msg", "회원 이미지가 수정되었습니다.");
	    } else {
	        rttr.addFlashAttribute("msg", "회원 이미지가 수정되지 않았습니다.");
	    }
	    
	    return "redirect:/member/view.do?id=" + vo.getId();
	}
	
	// 8. 마이페이지 메인
	@GetMapping("/mypageMain.do")
	public String mypageForm(Model model, String id) {
		log.info("========= mypageMain.do ============");
		if (id != null && !id.equals("")) {
			model.addAttribute("id", id);
		}
		log.info("----------------");
		return "member/mypageMain";
	}
	
	// 9. 회원 탈퇴
	@PostMapping("/delete.do")
	public String delete(HttpSession session, MemberVO vo, RedirectAttributes rttr) {
		log.info("delete.do ==================");
		
		Integer result = service.delete(vo);
		
		if (result == 1) {
			session.removeAttribute("login");
			rttr.addFlashAttribute("msg",
					"회원 탈퇴가 완료되었습니다.");
			return "redirect:/main/main.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"회원 탈퇴가 완료되지 않았습니다.");
			
			return "redirect:/member/mypageMain.do?id="+vo.getId();
		}
		
	}	
	// 10. 마이페이지 - 주문내역 보기 - MemberAjaxController.java	
	// 11. 마이페이지 - 장바구니 보기 - MemberAjaxController.java	
	// 12. 마이페이지 회원정보 보기 - MemberAjaxController.java	
	
	
}






