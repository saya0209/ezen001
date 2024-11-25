package org.zerock.communityreply.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.community.vo.CommunityVO;
import org.zerock.communityreply.service.CommunityReplyService;
import org.zerock.communityreply.vo.CommunityReplyVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

// 자동생성 어노테이션
// @Controller, @RestController
// @Service
// @Repository
// @Component
// @~~Advice
@RestController
// sitemesh에 적용안되는 uri 사용 - 이유는 화면에 구성하는 uri가 아니기 때문이다.
@RequestMapping("/communityreply")
@Log4j
public class CommunityReplyRestController {

	// 자동DI
	@Autowired
	@Qualifier("communityReplyServiceImpl")
	private CommunityReplyService service;
	
	// 파일이 저장될 경로
    private final String path = "/upload/community";

    // 파일 업로드 및 저장 처리 메서드
//    private String handleFileUpload(MultipartFile file, 
//    		HttpServletRequest request) throws Exception {
//        if (file != null && !file.isEmpty()) {
//            // FileUtil을 사용하여 파일 업로드
//            return FileUtil.upload(path, file, request);
//        }
//        return null;
//    }
    
 // handleFileUpload 메서드에 파일 검증 로직 추가
    private String handleFileUpload(MultipartFile file, HttpServletRequest request) throws Exception {
        if (file != null && !file.isEmpty()) {
            // 파일 확장자 검증
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
            List<String> allowedExtensions = Arrays.asList("jpg", "jpeg", "png", "gif");
            
            if (!allowedExtensions.contains(extension.toLowerCase())) {
                throw new IllegalArgumentException("허용되지 않는 파일 형식입니다.");
            }
            
            return FileUtil.upload(path, file, request);
        }
        return null;
    }
	
	// 1.리스트 - get
	// 댓글 목록 조회 - 비회원도 조회 가능
    @GetMapping(value = "/list.do", produces = { 
        MediaType.APPLICATION_XML_VALUE,
        MediaType.APPLICATION_JSON_UTF8_VALUE
    })
    public ResponseEntity<Map<String, Object>> list(
    		PageObject pageObject, Long post_no, HttpSession session) {
        log.info("list - page : " + pageObject.getPage() + ", post_no : " + post_no);

        // DB에서 댓글 목록 조회
        List<CommunityReplyVO> list = service.list(pageObject, post_no);

        // 로그인한 사용자의 정보를 세션에서 가져옴 (로그인된 경우만)
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        // 데이터 전달용 Map 생성
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        
        // 로그인한 사용자의 등급 정보 추가 (로그인된 경우에만)
        if (loginVO != null) {
            map.put("id", loginVO.getId());
            map.put("gradeNo", loginVO.getGradeNo());
        } else {
            // 비회원일 경우 gradeNo를 0으로 설정
            map.put("gradeNo", 0);
        }

        map.put("pageObject", pageObject);

        log.info("After map : " + map);

        return new ResponseEntity<>(map, HttpStatus.OK);
    }
	
	// 2. 일반게시판 댓글 쓰기 - write - post
    @PostMapping(value = "/write.do")
    public ResponseEntity<String> write(
            @RequestPart("reply") CommunityReplyVO vo,
            @RequestPart(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
            HttpServletRequest request,
            HttpSession session) throws Exception {

        // 로그인 체크
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        vo.setId(loginVO.getId());
        vo.setNicname(loginVO.getNicname());


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
        try {
            Integer result = service.write(vo);
            return result == 1 ? 
                new ResponseEntity<>("댓글이 등록되었습니다.", HttpStatus.OK) :
                new ResponseEntity<>("댓글 등록에 실패했습니다.", HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            log.error("댓글 등록 오류: ", e);
            return new ResponseEntity<>("서버 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

	// 3. 일반게시판 댓글 수정 - update - post
    @PostMapping(value = "/update.do")
    public ResponseEntity<String> update(
            @RequestPart("reply") CommunityReplyVO vo,
            @RequestPart(value = "uploadFiles", required = false) MultipartFile[] uploadFiles,
            @RequestParam(value = "deletedFiles", required = false) String deletedFiles,
            HttpServletRequest request,
            HttpSession session) throws Exception {

        // 로그인 체크
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }

        // 권한 체크
        CommunityReplyVO originalReply = service.getReply(vo.getRno());
        if (!loginVO.getId().equals(originalReply.getId()) && loginVO.getGradeNo() != 9) {
            return new ResponseEntity<>("수정 권한이 없습니다.", HttpStatus.FORBIDDEN);
        }

     // 1. 기존 파일 정보 가져오기
        // 댓글 정보를 가져오기
        CommunityReplyVO originalVO = service.getReply(vo.getRno());
        List<String> currentFiles = new ArrayList<>();
        
        // 2. 기존 파일이 있다면 리스트에 추가
        if (originalVO.getImage() != null && !originalVO.getImage().isEmpty()) {
            currentFiles.addAll(Arrays.asList(originalVO.getImage().split(",")));
        }

        // 3. 삭제된 파일 처리
        if (deletedFiles != null && !deletedFiles.isEmpty()) {
            String[] deletedFilesArray = deletedFiles.split(",");
            for (String fileName : deletedFilesArray) {
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

        try {
            Integer result = service.update(vo);
            return result == 1 ? 
                new ResponseEntity<>("댓글이 수정되었습니다.", HttpStatus.OK) :
                new ResponseEntity<>("댓글 수정에 실패했습니다.", HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            log.error("댓글 수정 오류: ", e);
            return new ResponseEntity<>("서버 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

	// 4-1. 댓글 삭제 처리 - 로그인된 사용자만 삭제 가능
	@GetMapping(value = "/delete.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> delete(CommunityReplyVO vo) {
	    log.info("delete.do --------------------------------------");
	    
	    Integer result = service.delete(vo);
	    if (result == 1) {
	        return new ResponseEntity<>("댓글이 삭제되었습니다.", HttpStatus.OK);
	    }
	    return new ResponseEntity<>("댓글이 삭제되지 않았습니다.", HttpStatus.BAD_REQUEST);
	}
	
	// 4-2 이벤트 파일 삭제
	@GetMapping(value = "/deleteFile.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> deleteFile(
	        @RequestParam("rno") Long rno, 
	        @RequestParam("fileName") String fileName, 
	        HttpServletRequest request) {
	    
	    log.info("deleteFile.do ==================");
	    log.info("rno: " + rno + ", fileName: " + fileName);

	    try {
	        // 댓글 정보 가져오기
	        CommunityReplyVO vo = service.getReply(rno);  // `getReply`로 변경

	        if (vo != null && vo.getImage() != null) {
	            // 기존 파일 목록을 ArrayList로 변환
	            List<String> fileList = new ArrayList<>(Arrays.asList(vo.getImage().split(",")));
	            
	            // 파일 이름이 목록에 있는 경우 삭제 처리
	            if (fileList.contains(fileName)) {
	                fileList.remove(fileName); // 목록에서 파일 제거
	                
	                // 실제 파일 삭제
	                File file = new File(request.getServletContext().getRealPath(path), fileName);
	                if (file.exists() && file.delete()) {
	                    log.info("파일 삭제 성공: " + fileName);
	                } else {
	                    log.warn("파일 삭제 실패: " + fileName);
	                }
	            }

	            // 파일 목록 업데이트
	            if (!fileList.isEmpty()) {
	                vo.setImage(String.join(",", fileList));
	            } else {
	                vo.setImage(null);  // 모든 파일 삭제 시 null
	            }

	            // DB에 업데이트
	            service.update(vo);
	        } else {
	            return new ResponseEntity<>("파일 정보가 없습니다.", HttpStatus.BAD_REQUEST);
	        }

	        return new ResponseEntity<>("파일이 삭제되었습니다.", HttpStatus.OK);

	    } catch (Exception e) {
	        log.error("파일 삭제 중 오류 발생: ", e);
	        return new ResponseEntity<>("서버 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	
	
/////////////////////////////////////////////////////////////////
	
	// 좋아요 업데이트
	@PostMapping(value = "/like", produces = "application/json")
	public ResponseEntity<Map<String, Object>> updateLike(@RequestParam("rno") Long rno,
			@RequestParam("amount") int amount) {

		log.info("updateLike - rno: " + rno + ", amount: " + amount);

		Map<String, Object> result = new HashMap<>();
		try {
			service.updateLike(rno, amount);
			// 댓글 데이터 조회
			CommunityReplyVO updatedVO = service.getReply(rno);
			result.put("status", "success");
			result.put("likeCnt", updatedVO.getLikeCnt());
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error("Error in updateLike: ", e);
			result.put("status", "error");
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 싫어요 업데이트
	@PostMapping(value = "/dislike", produces = "application/json")
	public ResponseEntity<Map<String, Object>> updateDislike(@RequestParam("rno") Long rno,
			@RequestParam("amount") int amount) {

		log.info("updateDislike - rno: " + rno + ", amount: " + amount);

		Map<String, Object> result = new HashMap<>();
		try {
			service.updateDislike(rno, amount);
			// 댓글 데이터 조회
			CommunityReplyVO updatedVO = service.getReply(rno);
			result.put("status", "success");
			result.put("dislikeCnt", updatedVO.getDislikeCnt());
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error("Error in updateDislike: ", e);
			result.put("status", "error");
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
}