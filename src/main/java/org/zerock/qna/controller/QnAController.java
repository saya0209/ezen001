package org.zerock.qna.controller;

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
import org.zerock.member.vo.LoginVO;
import org.zerock.qna.service.QnAService;
import org.zerock.qna.vo.QnAVO;
import org.zerock.qna.vo.AnswerVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/qna")
@Log4j
public class QnAController {

    @Autowired
    @Qualifier("qnaServiceImpl")
    private QnAService service;

    // 1. QnA 게시글 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request) {
    	log.info("list() =======");
        
        // 페이지 처리를 위한 객체 생성
        PageObject pageObject = PageObject.getInstance(request);
        // QnA 게시글 리스트를 가져오고, 페이지 정보도 함께 전달
        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);
        
        log.info("PageObject: " + pageObject);
        log.info("QnA List: " + service.list(pageObject));
        
        return "qna/list";
    }

    // 2. QnA 게시글 상세 조회
//    @GetMapping("/view.do")
//    public String view(Model model, Long qna_no) {
//        log.info("view() ======");
//        
//        // QnA 게시글 조회
//        QnAVO qnaVO = service.view(qna_no);
//        // 답변 리스트 조회
//        model.addAttribute("qna", qnaVO);
//        model.addAttribute("answers", service.getAnswersByQnaNo(qna_no));
//        
//        return "qna/view";
//    }
    
    // 2. QnA 게시글 상세 조회 메서드 수정
    @GetMapping("/view.do")
    public String view(Model model, Long qna_no, HttpSession session) {
        log.info("view() ======");
        
        // QnA 게시글 조회
        QnAVO qnaVO = service.view(qna_no);
        // 답변 리스트 조회
        List<AnswerVO> answers = service.getAnswersByQnaNo(qna_no);
        
        // 로그인한 사용자가 글 작성자이고 답변이 있는 경우에만 상태 업데이트
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null && 
            loginVO.getId().equals(qnaVO.getId()) && 
            !answers.isEmpty() && 
            "completed".equals(qnaVO.getStatus())) {
            
            service.updateViewStatus(qna_no, loginVO.getId());
            // 업데이트된 정보를 다시 조회
            qnaVO = service.view(qna_no);
        }
        
        model.addAttribute("qna", qnaVO);
        model.addAttribute("answers", answers);
        
        return "qna/view";
    }

    // 3. QnA 게시글 작성 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
        log.info("writeForm() =======");
        return "qna/write";
    }

    // 4. QnA 게시글 작성 처리
    @PostMapping("/write.do")
    public String write(QnAVO vo, RedirectAttributes rttr, HttpSession session) {
        log.info("write() =======");

        // 로그인 세션에서 사용자 정보를 가져옴
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            rttr.addFlashAttribute("msg", "로그인 후 글을 작성할 수 있습니다.");
            return "redirect:/member/loginForm.do";
        }

        try {
            // 사용자 정보 설정
            vo.setId(loginVO.getId());
            vo.setNicname(loginVO.getNicname());
            
            // 기본값 설정
            if (vo.getStatus() == null) {
                vo.setStatus("waiting");
            }
            
            // 현재 시간 설정
            vo.setWriteDate(new Date());
            
            // 글 작성 실행
            int result = service.write(vo);
            
            if (result > 0) {
                rttr.addFlashAttribute("msg", "QnA 게시글이 등록되었습니다.");
                return "redirect:list.do";
            } else {
                rttr.addFlashAttribute("msg", "게시글 등록에 실패했습니다. 다시 시도해주세요.");
                return "redirect:writeForm.do";
            }
        } catch (Exception e) {
            log.error("QnA 작성 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다. 관리자에게 문의해주세요.");
            return "redirect:writeForm.do";
        }
    }
    
    // 5. QnA 게시글 수정 폼
    // @GetMapping("/updateForm.do")
    // public String updateForm(Model model, Long qna_no) {
    //     log.info("updateForm() =======");
    //     model.addAttribute("qna", service.view(qna_no));
    //     return "qna/update";
    // }

    // 6. QnA 게시글 수정 처리
    // @PostMapping("/update.do")
    // public String update(QnAVO vo, RedirectAttributes rttr) {
    //     log.info("update() =======");
    //     if (service.update(vo) == 1) {
    //         rttr.addFlashAttribute("msg", "QnA 게시글 " + vo.getQna_no() + "번이 수정되었습니다.");
    //     } else {
    //         rttr.addFlashAttribute("msg", "QnA 게시글 수정이 실패했습니다.");
    //     }
    //     return "redirect:view.do?qna_no=" + vo.getQna_no();
    // }

    // 7. QnA 게시글 삭제 처리
    @PostMapping("/delete.do")
    public String delete(QnAVO vo, RedirectAttributes rttr) {
        log.info("delete() =======");

        if (service.delete(vo.getQna_no()) == 1) {
            rttr.addFlashAttribute("msg", "QnA 게시글 " + vo.getQna_no() + "번이 삭제되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "QnA 게시글 삭제가 실패했습니다.");
        }

        return "redirect:list.do"; // 삭제 후 목록 페이지로 리디렉션
    }

    // 8. 답변 작성 처리
//    @PostMapping("/writeAnswer.do")
//    public String writeAnswer(AnswerVO vo, RedirectAttributes rttr, HttpSession session) {
//        log.info("writeAnswer() =======");
//
//        // 로그인 세션에서 사용자 정보를 가져옴
//        LoginVO loginVO = (LoginVO) session.getAttribute("login");
//        if (loginVO != null) {
//            vo.setId(loginVO.getId()); 
//            vo.setNicname(loginVO.getNicname());
//        } else {
//            rttr.addFlashAttribute("msg", "로그인 후 답변을 작성할 수 있습니다.");
//            return "redirect:/member/loginForm.do";
//        }
//
//        try {
//            // 답변 작성
//            int result = service.writeAnswer(vo);
//            
//            if (result > 0) {
//                // 답변 작성 성공 시 QnA 상태를 'completed'로 업데이트
//                service.updateStatus(vo.getParentNo(), "completed");
//                rttr.addFlashAttribute("msg", "답변이 등록되었습니다.");
//            } else {
//                rttr.addFlashAttribute("msg", "답변 등록에 실패했습니다.");
//            }
//        } catch (Exception e) {
//            log.error("답변 작성 중 오류 발생: ", e);
//            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
//        }
//        
//        return "redirect:view.do?qna_no=" + vo.getParentNo();
//    }
    @PostMapping("/writeAnswer.do")
    public String writeAnswer(AnswerVO vo, RedirectAttributes rttr, HttpSession session) {
        log.info("writeAnswer() =======");

        // 로그인 세션에서 사용자 정보를 가져옴
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null) {
            vo.setId(loginVO.getId());
            vo.setNicname(loginVO.getNicname());
        } else {
            rttr.addFlashAttribute("msg", "로그인 후 답변을 작성할 수 있습니다.");
            return "redirect:/member/loginForm.do";
        }

        try {
            // 답변 작성
            int result = service.writeAnswer(vo);
            
            if (result > 0) {
                // 답변 작성 성공 시 QnA 상태를 'completed'로 업데이트
                service.updateStatus(vo.getParentNo(), "completed");
                rttr.addFlashAttribute("msg", "답변이 등록되었습니다.");
            } else {
                rttr.addFlashAttribute("msg", "답변 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            log.error("답변 작성 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "시스템 오류가 발생했습니다.");
        }
        
        return "redirect:view.do?qna_no=" + vo.getParentNo();
    }
    
    // 10. 답변 삭제 처리
    @PostMapping("/deleteAnswer.do")
    public String deleteAnswer(Long answer_no, Long qna_no, RedirectAttributes rttr) {
        log.info("deleteAnswer() =======");

        service.deleteAnswer(answer_no);
        
        rttr.addFlashAttribute("msg", "답변이 삭제되었습니다.");
        
        return "redirect:view.do?qna_no=" + qna_no; // 삭제 후 해당 QnA 게시글 보기로 리디렉션
    }
}
