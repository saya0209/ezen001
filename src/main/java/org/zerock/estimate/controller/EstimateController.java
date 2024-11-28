package org.zerock.estimate.controller;

import java.util.Date;
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
import org.zerock.estimate.service.EstimateService;
import org.zerock.estimate.vo.EstimateAnswerVO;
import org.zerock.estimate.vo.EstimateRequestVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/estimate")
@Log4j
public class EstimateController {
    
    @Autowired
    @Qualifier("estimateServiceImpl")
    private EstimateService service;
    
    // 1. request 게시글 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request) {
        log.info("list() =======");
        
        PageObject pageObject = PageObject.getInstance(request);
        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);
        
        log.info("PageObject: " + pageObject);
        log.info("estimate List: " + service.list(pageObject));
        
        return "estimate/list";
    }
    
    // 2. request 게시글 상세 조회
    @GetMapping("/view.do")
    public String view(Model model, Long request_no, HttpSession session) {
        log.info("view() ======");
        
        // 게시글 조회
        EstimateRequestVO requestVO = service.view(request_no);
        List<EstimateAnswerVO> answers = service.getAnswersByRequestNo(request_no);
        
        // 모델에 데이터 추가
        model.addAttribute("request", requestVO);
        model.addAttribute("answers", answers);
        
        // 로그인한 사용자가 글 작성자이고 답변이 있는 경우에만 상태 업데이트
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null && 
            loginVO.getId().equals(requestVO.getId()) && 
            !answers.isEmpty() && 
            "waiting".equals(requestVO.getStatus())) {  // status가 waiting일 때만 completed로 변경
            
            service.updateStatus(request_no, "completed");
            // 업데이트된 정보를 다시 조회하여 모델에 추가
            model.addAttribute("request", service.view(request_no));
        }
        
        return "estimate/view";
    }
    
    // 3-1. request 게시글 작성 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
        log.info("writeForm() =======");
        return "estimate/write";
    }
    
    // 3-2. request 게시글 작성 처리
    @PostMapping("/write.do")
    public String write(EstimateRequestVO vo, RedirectAttributes rttr, HttpSession session) {
        log.info("write() =======");
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            rttr.addFlashAttribute("msg", "로그인 후 견적 요청이 가능합니다.");
            return "redirect:/member/loginForm.do";
        }
        
        try {
            vo.setId(loginVO.getId());
            vo.setRequest_date(new Date());
            vo.setStatus("waiting");
            
            int result = service.write(vo);
            if (result > 0) {
                rttr.addFlashAttribute("msg", "견적 요청이 등록되었습니다.");
                return "redirect:list.do";
            }
        } catch (Exception e) {
            log.error("견적 요청 작성 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
        }
        return "redirect:writeForm.do";
    }
    
    // 4-1. request 게시글 수정 폼
    @GetMapping("/updateForm.do")
    public String updateForm(Model model, Long request_no) {
        log.info("updateForm() =======");
        model.addAttribute("request", service.view(request_no));
        return "estimate/update";
    }

    // 4-2. request 게시글 수정 처리
    @PostMapping("/update.do")
    public String update(EstimateRequestVO vo, 
    		RedirectAttributes rttr, 
    		HttpSession session, 
    		HttpServletRequest request)throws Exception {
        log.info("update() =======");
        
        // 로그인 체크
//        LoginVO loginVO = (LoginVO) session.getAttribute("login");
//        if (loginVO == null) {
//            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
//            return "redirect:/member/loginForm.do";
//        }
        
        // 로그인 세션에서 사용자 정보 가져오기
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null) {
            vo.setId(loginVO.getId());  // 로그인된 사용자의 id 설정
        } else {
            rttr.addFlashAttribute("msg", "로그인 후 수정할 수 있습니다.");
            return "redirect:/member/loginForm.do";  // 로그인 페이지로 리디렉션
        }
        
        // 작성자 확인
//        EstimateRequestVO original = service.view(vo.getRequest_no());
//        if (!loginVO.getId().equals(original.getId())) {
//            rttr.addFlashAttribute("msg", "자신의 견적 요청만 수정할 수 있습니다.");
//            return "redirect:view.do?request_no=" + vo.getRequest_no();
//        }
//        try {
//            // 기존 데이터의 변경되지 않아야 할 필드들 유지
//            vo.setId(original.getId());
//            vo.setRequest_date(original.getRequest_date());
//            vo.setStatus(original.getStatus());
//            
//            int result = service.update(vo);
//            if (result > 0) {
//                rttr.addFlashAttribute("msg", "견적 요청이 수정되었습니다.");
//                return "redirect:view.do?request_no=" + vo.getRequest_no();
//            }
//        } catch (Exception e) {
//            log.error("견적 요청 수정 중 오류 발생: ", e);
//            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
//        }
        
		// 게시물 수정 처리
		// 6. DB 업데이트
		Integer result = service.update(vo);
		if (result == 1) {
			rttr.addFlashAttribute("msg", "커뮤니티 게시판 " + vo.getRequest_no() + "번 글이 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("msg", "커뮤니티 게시판 글수정이 되지 않았습니다.");
		}

//        return "redirect:updateForm.do?request_no=" + vo.getRequest_no();
        return "redirect:/estimate/view.do?request_no=" + vo.getRequest_no();
    }
    
    // 5. request 게시글 삭제 처리
    @PostMapping("/delete.do")
    public String delete(EstimateRequestVO vo, RedirectAttributes rttr) {
        log.info("delete() =======");

        if (service.delete(vo.getRequest_no()) == 1) {
            rttr.addFlashAttribute("msg", "request 게시글 " + vo.getRequest_no() + "번이 삭제되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "request 게시글 삭제가 실패했습니다.");
        }

        return "redirect:list.do"; // 삭제 후 목록 페이지로 리디렉션
    }
    
/////// 답변 ////////////////////////////////////////////////////////
    
    // 1. 답변 작성 처리
    @PostMapping("/writeAnswer.do")
    public String writeAnswer(EstimateAnswerVO vo, RedirectAttributes rttr, HttpSession session) {
        log.info("writeAnswer() =======");
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            rttr.addFlashAttribute("msg", "로그인 후 견적 답변이 가능합니다.");
            return "redirect:/member/loginForm.do";
        }
        
        try {
            vo.setId(loginVO.getId());
            vo.setAnswer_date(new Date());
            
         // 답변 작성
            int result = service.writeAnswer(vo);
            if (result > 0) {
                service.updateStatus(vo.getParentNo(), "completed");
                rttr.addFlashAttribute("msg", "견적 답변이 등록되었습니다.");
            }
        } catch (Exception e) {
            log.error("견적 답변 작성 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
        }
        return "redirect:view.do?request_no=" + vo.getParentNo();
    }

    // 2-1. answer 수정 폼
    @GetMapping("/updateAnswerForm.do")
    public String updateAnswerForm(Model model, Long answer_no, Long request_no) {
        log.info("updateAnswerForm() =======");
        log.info("answer_no: " + answer_no); // 로그 추가
        log.info("request_no: " + request_no); // 로그 추가
        
        // 요청 정보 조회
        EstimateRequestVO request = service.view(request_no);
        if (request == null) {
            log.info("request is null");
            return "redirect:list.do";
        }
        
        // 답변 정보를 가져와서 모델에 추가
        List<EstimateAnswerVO> answers = service.getAnswersByRequestNo(request_no);
        EstimateAnswerVO targetAnswer = answers.stream()
                .filter(a -> a.getAnswer_no().equals(answer_no))
                .findFirst()
                .orElse(null);
        
        if (targetAnswer == null) {
            log.info("targetAnswer is null");
            return "redirect:view.do?request_no=" + request_no;
        }
        
        model.addAttribute("answer", targetAnswer);
        model.addAttribute("request", request);
        model.addAttribute("request_no", request_no);
        
        return "estimate/updateAnswer";
    }
    // 2-2. answer 수정 처리
    @PostMapping("/updateAnswer.do")
    public String updateAnswer(EstimateAnswerVO vo, RedirectAttributes rttr, HttpSession session) {
        log.info("updateAnswer() =======");
        log.info("vo: " + vo); // 로그 추가
        
        // 로그인 체크
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/member/loginForm.do";
        }
        
        try {
            // request_no 값 체크
            if (vo.getParentNo() == null || vo.getParentNo() == 0) {
                log.info("parentNo is null or 0");
                rttr.addFlashAttribute("msg", "요청 번호가 누락되었습니다.");
                return "redirect:list.do";
            }

            // answer_no 값 체크
            if (vo.getAnswer_no() == null || vo.getAnswer_no() == 0) {
                log.info("answer_no is null or 0");
                rttr.addFlashAttribute("msg", "답변 번호가 누락되었습니다.");
                return "redirect:view.do?request_no=" + vo.getParentNo();
            }

            // 답변 정보 조회
            List<EstimateAnswerVO> answers = service.getAnswersByRequestNo(vo.getParentNo());
            EstimateAnswerVO original = answers.stream()
                    .filter(a -> a.getAnswer_no().equals(vo.getAnswer_no()))
                    .findFirst()
                    .orElse(null);
                    
            if (original == null) {
                log.info("original answer not found");
                rttr.addFlashAttribute("msg", "해당 답변을 찾을 수 없습니다.");
                return "redirect:view.do?request_no=" + vo.getParentNo();
            }

            // 작성자 확인
            if (!loginVO.getId().equals(original.getId())) {
                rttr.addFlashAttribute("msg", "자신의 견적 답변만 수정할 수 있습니다.");
                return "redirect:view.do?request_no=" + vo.getParentNo();
            }
            
            // 기존 데이터 유지
            vo.setId(original.getId());
            vo.setAnswer_date(original.getAnswer_date());
            vo.setReNo(original.getReNo());
            vo.setOrdNo(original.getOrdNo());
            vo.setLevNo(original.getLevNo());
            
            int result = service.updateAnswer(vo);
            if (result > 0) {
                rttr.addFlashAttribute("msg", "견적 답변이 수정되었습니다.");
            } else {
                rttr.addFlashAttribute("msg", "견적 답변 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("견적 답변 수정 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
        }
        
        return "redirect:view.do?request_no=" + vo.getParentNo();
    }
    
    // 3. 답변 삭제 처리
    @PostMapping("/deleteAnswer.do")
    public String deleteAnswer(Long answer_no, Long request_no, RedirectAttributes rttr) {
        log.info("deleteAnswer() =======");
        service.deleteAnswer(answer_no);
        rttr.addFlashAttribute("msg", "견적 답변이 삭제되었습니다.");
        return "redirect:view.do?request_no=" + request_no;
    }
}