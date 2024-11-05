package org.zerock.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.service.MemberService;
import org.zerock.member.vo.LoginVO;
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
	
	// 회원 목록 조회		
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
	
}






