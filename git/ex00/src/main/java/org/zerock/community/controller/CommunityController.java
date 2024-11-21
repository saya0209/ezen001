package org.zerock.community.controller;

import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.community.service.CommunityService;
import org.zerock.community.vo.CommunityVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;
import org.zerock.vo.AttachFileVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/community")
@Log4j
public class CommunityController {

    @Autowired
    @Qualifier("communityServiceImpl")
    private CommunityService service;

    // 1. 커뮤니티 게시판 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request) {
        log.info("list() =======");

        // 페이지 처리를 위한 객체 생성
        PageObject pageObject = PageObject.getInstance(request);
        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);
        return "community/list";
    }

    // 2. 커뮤니티 게시판 글보기
    @GetMapping("/view.do")
    public String view(Model model, 
                       @RequestParam("community_no") Long community_no,
                       @RequestParam("inc") int inc) {
        log.info("view() ======");

        if (community_no == null) {
            log.error("community_no is null");
            return "error";  // 에러 페이지로 리다이렉트
        }
        model.addAttribute("vo", service.view(community_no, inc));
        return "community/view";
    }

    // 3-1. 커뮤니티 게시판 글쓰기 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
        log.info("writeForm() =======");
        return "community/write";
    }


    
    // 3-2. 커뮤니티 게시판 글쓰기 처리
    @PostMapping("/write.do")
    public String write(CommunityVO vo, 
                        @RequestParam("file") MultipartFile file,
                        HttpServletRequest request, 
                        RedirectAttributes rttr,
                        HttpSession session) {  // session을 HttpSession으로 수정
        log.info("write() =======");

        // 로그인 세션에서 사용자 정보를 가져옴
        LoginVO loginVO = (LoginVO) session.getAttribute("login");  // "login"으로 수정
        if (loginVO != null) {
            vo.setId(loginVO.getId());  // 로그인된 사용자의 id 설정
            vo.setNicname(loginVO.getNicname());  // 닉네임 설정
        } else {
            // 로그인 정보가 없을 경우 처리 (예: 로그인 안한 사용자 접근 차단)
            rttr.addFlashAttribute("msg", "로그인 후 글을 작성할 수 있습니다.");
            return "redirect:/member/loginForm.do";  // 로그인 페이지로 리디렉션
        }

        // 로그인 후, id와 nicname이 제대로 설정되었는지 확인
        log.info("CommunityVO id: " + vo.getId());      // 로그인된 id 확인
        log.info("CommunityVO nicname: " + vo.getNicname());  // 로그인된 nicname 확인

        // 파일 업로드 처리
        if (!file.isEmpty()) {
            try {
                String path = "/upload/community";
                String uploadPath = FileUtil.upload(path, file, request);

                // AttachFileVO 객체에 파일 정보 저장
                AttachFileVO attachFile = new AttachFileVO();
                attachFile.setFileName(file.getOriginalFilename());
                attachFile.setUploadPath(path);
                attachFile.setUuid(UUID.randomUUID().toString());
                attachFile.setImage(file.getContentType().startsWith("image"));

                vo.setAttachFile(attachFile);  // CommunityVO에 AttachFileVO 필드 설정

                vo.setImage(uploadPath + "/" + attachFile.getFileName());  // 이미지 경로 설정

            } catch (Exception e) {
                log.error("파일 업로드 실패: " + e.getMessage());
                rttr.addFlashAttribute("msg", "파일 업로드에 실패했습니다.");
                return "redirect:/community/list.do";
            }
        }

        // 작성일자, 조회수, 좋아요, 싫어요 기본값 설정
        vo.setWriteDate(new Date());  // 작성일자 현재 시간으로 설정
        vo.setHit(0L);  // 기본값 설정
        vo.setLikeCnt(0L);  // 좋아요 수 기본값 설정
        vo.setDislikeCnt(0L);  // 싫어요 수 기본값 설정

        // 글 작성 서비스 호출
        service.write(vo);
        
        // 성공 메시지와 함께 게시글 등록 후 리스트로 리디렉션
        rttr.addFlashAttribute("msg", "커뮤니티 게시판에 글이 등록되었습니다.");
        return "redirect:/community/list.do";  // 글 작성 후 게시글 목록 페이지로 리디렉션
    }


    
    // 4-1. 커뮤니티 게시판 글수정 폼
    @GetMapping("/updateForm.do")
    public String updateForm(Model model, Long community_no) {
        log.info("updateForm() ======== ");
        
        model.addAttribute("vo", service.view(community_no, 0));
        return "community/update";
    }

 // 4-2. 커뮤니티 게시판 글수정 처리
    @PostMapping("/update.do")
    public String update(CommunityVO vo, 
                         @RequestParam("file") MultipartFile file,
                         RedirectAttributes rttr, 
                         HttpServletRequest request,
                         HttpSession session) {
        log.info("update() =========");
        log.info(vo);

        // 로그인 세션에서 사용자 정보를 가져옴
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null) {
            vo.setId(loginVO.getId());  // 로그인된 사용자의 id 설정
            vo.setNicname(loginVO.getNicname());  // 로그인된 사용자의 nicname 설정
        } else {
            rttr.addFlashAttribute("msg", "로그인 후 수정할 수 있습니다.");
            return "redirect:/member/loginForm.do";  // 로그인 페이지로 리디렉션
        }

        // 파일 업로드 처리
        if (!file.isEmpty()) {
            try {
                String path = "/upload/community";
                String uploadPath = FileUtil.upload(path, file, request);

                // AttachFileVO 객체에 파일 정보 저장
                AttachFileVO attachFile = new AttachFileVO();
                attachFile.setFileName(file.getOriginalFilename());
                attachFile.setUploadPath(path);
                attachFile.setUuid(UUID.randomUUID().toString());
                attachFile.setImage(file.getContentType().startsWith("image"));

                vo.setAttachFile(attachFile);  // CommunityVO에 AttachFileVO 필드 설정
                vo.setImage(uploadPath + "/" + attachFile.getFileName());  // 이미지 경로 설정

            } catch (Exception e) {
                log.error("파일 업로드 실패: " + e.getMessage());
                rttr.addFlashAttribute("msg", "파일 업로드에 실패했습니다.");
                return "redirect:/community/list.do";
            }
        }

        // 글 수정 처리
        if (service.update(vo) == 1) {
            rttr.addFlashAttribute("msg", "커뮤니티 게시판 " + vo.getCommunity_no() + "번 글이 수정되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "커뮤니티 게시판 글수정이 되지 않았습니다.");
        }

        return "redirect:/community/view.do?community_no=" + vo.getCommunity_no() + "&inc=0";
    }


    
    // 5. 커뮤니티 게시판 글삭제 처리
    @PostMapping("delete.do")
    public String delete(CommunityVO vo, 
    		HttpServletRequest request, 
    		RedirectAttributes rttr) {
        log.info("delete() =========");

        LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
        if (loginVO == null || (!loginVO.getNicname().equals(vo.getNicname()) && !"ADMIN".equals(loginVO.getGradeName()))) {
            rttr.addFlashAttribute("msg", "삭제 권한이 없습니다.");
            return "redirect:view.do?community_no=" + vo.getCommunity_no() + "&inc=0";
        }

        // 삭제 권한 체크
        if (service.delete(vo) == 1) {
            rttr.addFlashAttribute("msg", "커뮤니티게시판 " + vo.getCommunity_no() + "번글이 삭제되었습니다.");
            return "redirect:list.do";
        } else {
            rttr.addFlashAttribute("msg", "커뮤니티게시판 글삭제가 되지 않았습니다.");
            return "redirect:view.do?community_no=" + vo.getCommunity_no() + "&inc=0";
        }
    }

 // 좋아요 증가
    @PostMapping("/like.do")
    public String like(@RequestParam("community_no") Long community_no, RedirectAttributes rttr) {
        // 이미 좋아요를 눌렀으면 좋아요 취소
        try {
            service.increaseLike(community_no);  // 좋아요 증가
            rttr.addFlashAttribute("msg", "좋아요가 추가되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("msg", "좋아요 추가에 실패했습니다.");
        }
        return "redirect:view.do?community_no=" + community_no + "&inc=0";
    }

    // 싫어요 증가
    @PostMapping("/dislike.do")
    public String dislike(@RequestParam("community_no") Long community_no, RedirectAttributes rttr) {
        // 이미 싫어요를 눌렀으면 싫어요 취소
        try {
            service.increaseDislike(community_no);  // 싫어요 증가
            rttr.addFlashAttribute("msg", "싫어요가 추가되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("msg", "싫어요 추가에 실패했습니다.");
        }
        return "redirect:view.do?community_no=" + community_no + "&inc=0";
    }

    // 좋아요 취소
    @PostMapping("/cancelLike.do")
    public String cancelLike(@RequestParam("community_no") Long community_no, RedirectAttributes rttr) {
        try {
            service.cancelLike(community_no);  // 좋아요 취소
            rttr.addFlashAttribute("msg", "좋아요가 취소되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("msg", "좋아요 취소에 실패했습니다.");
        }
        return "redirect:view.do?community_no=" + community_no + "&inc=0";
    }

    // 싫어요 취소
    @PostMapping("/cancelDislike.do")
    public String cancelDislike(@RequestParam("community_no") Long community_no, RedirectAttributes rttr) {
        try {
            service.cancelDislike(community_no);  // 싫어요 취소
            rttr.addFlashAttribute("msg", "싫어요가 취소되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("msg", "싫어요 취소에 실패했습니다.");
        }
        return "redirect:view.do?community_no=" + community_no + "&inc=0";
    }

}
