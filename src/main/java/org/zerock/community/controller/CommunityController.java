package org.zerock.community.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.community.service.CommunityService;
import org.zerock.community.vo.CommunityVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.notice.vo.NoticeVO;
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
    
    // 파일이 저장될 경로
    private final String path = "/upload/community";
    

    // 파일 업로드 및 저장 처리 메서드
    private String handleFileUpload(MultipartFile file, HttpServletRequest request) throws Exception {
        if (file != null && !file.isEmpty()) {
            // FileUtil을 사용하여 파일 업로드
            return FileUtil.upload(path, file, request);
        }
        return null;
    }
    

    // 1. 커뮤니티 게시판 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request) {
        log.info("list() =======");
        log.info("test =======");

        // 페이지 처리를 위한 객체 생성
        PageObject pageObject = PageObject.getInstance(request);
        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);
        return "community/list";
    }

    // 2. 커뮤니티 게시판 글보기
    @GetMapping("/view.do")
    public String view(Model model, 
                       @RequestParam("post_no") Long community_no,
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
    		@RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
            RedirectAttributes rttr,
            HttpServletRequest request,
            HttpSession session) throws Exception { 
        log.info("write() =======");

        // 로그인 세션에서 사용자 정보를 가져옴
        LoginVO loginVO = (LoginVO) session.getAttribute("login");  
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

        List<String> fileNames = new ArrayList<>();
        
        // 파일 업로드 처리
        for (MultipartFile file : uploadFiles) {
            if (!file.isEmpty()) {
                String uploadedPath = handleFileUpload(file, request);
                if (uploadedPath != null) {
                    fileNames.add(uploadedPath.substring(uploadedPath.lastIndexOf('/')+1));
                }
            }
        }

        // 파일 경로들을 쉼표로 구분하여 저장
        if (!fileNames.isEmpty()) {
            vo.setImage(String.join(",", fileNames));
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
    		@RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
            @RequestParam(value = "deletedFiles", required = false) String deletedFilesStr,
            RedirectAttributes rttr,
            HttpServletRequest request,
            HttpSession session) throws Exception {
        log.info("update() =========");
        log.info(vo);

        // 로그인 세션에서 사용자 정보 가져오기
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null) {
            vo.setId(loginVO.getId());  // 로그인된 사용자의 id 설정
        } else {
            rttr.addFlashAttribute("msg", "로그인 후 수정할 수 있습니다.");
            return "redirect:/member/loginForm.do";  // 로그인 페이지로 리디렉션
        }

        // 1. 기존 파일 정보 가져오기
        CommunityVO originalVO = service.view(vo.getCommunity_no(), 0);
        List<String> currentFiles = new ArrayList<>();
        
        // 2. 기존 파일이 있다면 리스트에 추가
        if (originalVO.getImage() != null && !originalVO.getImage().isEmpty()) {
            currentFiles.addAll(Arrays.asList(originalVO.getImage().split(",")));
        }

        // 3. 삭제된 파일 처리
        if (deletedFilesStr != null && !deletedFilesStr.isEmpty()) {
            String[] deletedFiles = deletedFilesStr.split(",");
            for (String fileName : deletedFiles) {
                // 물리적 파일 삭제
                File file = new File(request.getServletContext().getRealPath(path), fileName);
                if (file.exists()) {
                    file.delete();
                }
                // 목록에서 제거
                currentFiles.remove(fileName);
            }
        }
        
        // 4. 새로운 파일 업로드 처리
        for (MultipartFile file : uploadFiles) {
            if (!file.isEmpty()) {
                String uploadedPath = handleFileUpload(file, request);
                if (uploadedPath != null) {
                    String fileName = uploadedPath.substring(uploadedPath.lastIndexOf('/') + 1);
                    currentFiles.add(fileName);
                }
            }
        }
        
        // 5. 최종 파일 목록 설정
        if (!currentFiles.isEmpty()) {
            vo.setImage(String.join(",", currentFiles));
        } else {
            vo.setImage(null);
        }
        
        // 6. DB 업데이트
        Integer result = service.update(vo);

        // 게시물 수정 처리
//        if (service.update(vo) == 1) {
        if (result == 1) {
            rttr.addFlashAttribute("msg", "커뮤니티 게시판 " + vo.getCommunity_no() + "번 글이 수정되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "커뮤니티 게시판 글수정이 되지 않았습니다.");
        }

        return "redirect:/community/view.do?post_no=" + vo.getCommunity_no() + "&inc=0";
    }


    // 5. 커뮤니티 게시판 글삭제 처리
    @PostMapping("delete.do")
    public String delete(@RequestParam("community_no") Long community_no, 
    		RedirectAttributes rttr) {
        log.info("delete() 호출됨: community_no = " + community_no);
        
        // 삭제 전, 기존 파일 삭제
        CommunityVO vo = service.view(community_no, 0);
        if (vo.getImage() != null) {
            String[] oldFiles = vo.getImage().split(",");
            for (String oldFile : oldFiles) {
                File file = new File(path, oldFile);
                if (file.exists()) {
                    file.delete();  // 기존 파일 삭제
                }
            }
        }

        Integer result = service.delete(community_no);
        
        
        // 삭제 처리
        if (result == 1) {
//        if (service.delete(community_no) == 1) {
            rttr.addFlashAttribute("msg", "커뮤니티 게시판 " + community_no + "번 글이 삭제되었습니다.");
            return "redirect:list.do";
        } else {
            rttr.addFlashAttribute("msg", "커뮤니티 게시판 글이 삭제되지 않았습니다.");
            return "redirect:view.do?community_no=" + community_no + "&inc=0";
        }
    }

 // 5-1 이벤트 파일 삭제
    @PostMapping("/deleteFile.do")
    public String deleteFile(@RequestParam("community_no") Long community_no, 
    		@RequestParam("fileName") String fileName, 
    		RedirectAttributes rttr) {
        log.info("deleteFile.do ==================");
        log.info("community_no: " + community_no + ", fileName: " + fileName);  // 디버깅용으로 확인

        // 공지사항 정보 가져오기
        CommunityVO vo = service.view(community_no, 0);
        if (vo != null && vo.getImage() != null) {
            // 기존 파일 목록에서 삭제할 파일 제거
            List<String> fileList = new ArrayList<>(Arrays.asList(vo.getImage().split(",")));
            
            // 파일 이름이 목록에 있는 경우만 삭제
            if (fileList.contains(fileName)) {
                fileList.remove(fileName);  // 삭제할 파일 목록에서 제거
            }

            // 파일 목록이 변경되었다면, 공지사항 객체 업데이트
            if (!fileList.isEmpty()) {
                vo.setImage(String.join(",", fileList));
            } else {
                vo.setImage(null);  // 모든 파일이 삭제되었으면 null로 설정
            }

            // 공지사항 수정
            service.update(vo);

            // 실제로 파일을 삭제
            File file = new File(path, fileName);
            if (file.exists()) {
                file.delete();
            }

            rttr.addFlashAttribute("msg", "파일이 삭제되었습니다.");
        }

        return "redirect:/community/updateForm.do?no=" + community_no;  // 수정 폼으로 리다이렉트
    }

////////////////////////////////////////////////////////

	// 좋아요/싫어요
	@PostMapping("/updateLike")
	@ResponseBody
	public Map<String, Object> updateLike(@RequestParam("community_no") Long community_no,
			@RequestParam("amount") int amount) {
		Map<String, Object> result = new HashMap<>();
		try {
			service.updateLike(community_no, amount);
			CommunityVO updatedVO = service.view(community_no, 0);
			result.put("status", "success");
			result.put("likeCnt", updatedVO.getLikeCnt());
		} catch (Exception e) {
			result.put("status", "error");
		}
		return result;
	}

	@PostMapping("/updateDislike")
	@ResponseBody
	public Map<String, Object> updateDislike(@RequestParam("community_no") Long community_no,
			@RequestParam("amount") int amount) {
		Map<String, Object> result = new HashMap<>();
		try {
			service.updateDislike(community_no, amount);
			CommunityVO updatedVO = service.view(community_no, 0);
			result.put("status", "success");
			result.put("dislikeCnt", updatedVO.getDislikeCnt());
		} catch (Exception e) {
			result.put("status", "error");
		}
		return result;
	}

}
