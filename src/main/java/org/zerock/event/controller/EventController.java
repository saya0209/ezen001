package org.zerock.event.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.event.service.EventService;
import org.zerock.event.vo.EventVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/event")
public class EventController {

    @Autowired
    @Qualifier("eventServiceImpl")
    private EventService service;
   
    // 파일이 저장될 경로
    private final String path = "/upload/event";
    
    // 파일 업로드 및 저장 처리 메서드
    private String handleFileUpload(MultipartFile file, HttpServletRequest request) throws Exception {
        if (file != null && !file.isEmpty()) {
            // FileUtil을 사용하여 파일 업로드
            return FileUtil.upload(path, file, request);
        }
        return null;
    }
   
    // 1. 이벤트 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request) {
        log.info("list.do ======");

        // 페이지 처리를 위한 객체생성
        PageObject pageObject = PageObject.getInstance(request);
        
        // Period 필터 적용: 전체, 진행중, 예정, 종료
        String period = request.getParameter("period");
        if (period == null || period.isEmpty()) {
            period = "all";  // 기본 값 설정
        }
        pageObject.setPeriod(period);  // period 필터링 값 설정

        // 처리된 데이터를 Model에 저장해서 jsp로 넘긴다.
        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);

        log.info("list.do ======");

        return "event/list";
    }

   
    // 2. 이벤트 상세보기
    @GetMapping("/view.do")
    public String view(Model model, Long event_no) {
        log.info("view.do ================");
        model.addAttribute("vo", service.view(event_no));
        return "event/view";
    }
   
    // 3-1. 이벤트 글쓰기 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
        log.info("writeForm.do ==================");
        return "event/write";
    }
   
    // 3-2. 이벤트 글쓰기 처리
    @PostMapping("/write.do")
    public String write(EventVO vo, 
            @RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
            RedirectAttributes rttr,
            HttpServletRequest request) throws Exception {
       
        // 기본 작성자 설정
        if (vo.getId() == null) {
            vo.setId("관리자");
        }

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
            vo.setFiles(String.join(",", fileNames));
        }

        // 이벤트 등록
        service.write(vo);
        rttr.addFlashAttribute("msg", "새로운 이벤트가 등록되었습니다.");
        
        return "redirect:/event/list.do";
    }
    
    // 4-1. 이벤트 수정 폼
    @GetMapping("/updateForm.do")
    public String updateForm(Model model, Long event_no) {
        log.info("updateForm.do ==================");
       
        model.addAttribute("vo", service.view(event_no));
       
        return "event/update";
    }
   
    // 4-2. 이벤트 수정 처리
    @PostMapping("/update.do")
    public String update(EventVO vo,
            @RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
            @RequestParam(value = "deletedFiles", required = false) String deletedFilesStr,
            RedirectAttributes rttr,
            HttpServletRequest request) throws Exception {

        // 1. 기존 파일 정보 가져오기
        EventVO originalVO = service.view(vo.getEvent_no());
        List<String> currentFiles = new ArrayList<>();
        
        // 2. 기존 파일이 있다면 리스트에 추가
        if (originalVO.getFiles() != null && !originalVO.getFiles().isEmpty()) {
            currentFiles.addAll(Arrays.asList(originalVO.getFiles().split(",")));
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
            vo.setFiles(String.join(",", currentFiles));
        } else {
            vo.setFiles(null);
        }
        
        // 6. DB 업데이트
        Integer result = service.update(vo);
        
        if (result == 1) {
            rttr.addFlashAttribute("msg", "이벤트가 수정되었습니다.");
            return "redirect:/event/list.do";
        } else {
            rttr.addFlashAttribute("msg", "이벤트 수정에 실패했습니다.");
            return "redirect:/event/view.do?event_no=" + vo.getEvent_no();
        }
    }

    // 5. 이벤트 삭제
    @PostMapping("/delete.do")
    public String delete(@RequestParam("event_no") Long event_no, RedirectAttributes rttr) {
        log.info("delete.do ==================");
        log.info("event_no: " + event_no);

        // 삭제 전, 기존 파일 삭제
        EventVO vo = service.view(event_no);
        if (vo.getFiles() != null) {
            String[] oldFiles = vo.getFiles().split(",");
            for (String oldFile : oldFiles) {
                File file = new File(path, oldFile);
                if (file.exists()) {
                    file.delete();  // 기존 파일 삭제
                }
            }
        }

        Integer result = service.delete(event_no);

        if (result == 1) {
            rttr.addFlashAttribute("msg", "이벤트가 삭제되었습니다.");
            return "redirect:list.do";
        } else {
            rttr.addFlashAttribute("msg", "이벤트 삭제에 실패했습니다.");
            return "redirect:/event/view.do?event_no=" + event_no;
        }
    }
    
    // 5-1 이벤트 파일 삭제
    @PostMapping("/deleteFile.do")
    public String deleteFile(@RequestParam("event_no") Long event_no, @RequestParam("fileName") String fileName, RedirectAttributes rttr) {
        log.info("deleteFile.do ==================");
        log.info("event_no: " + event_no + ", fileName: " + fileName);

        // 이벤트 정보 가져오기
        EventVO vo = service.view(event_no);
        if (vo != null && vo.getFiles() != null) {
            // 기존 파일 목록에서 삭제할 파일 제거
            List<String> fileList = new ArrayList<>(Arrays.asList(vo.getFiles().split(",")));
            
            // 파일 이름이 목록에 있는 경우만 삭제
            if (fileList.contains(fileName)) {
                fileList.remove(fileName);  // 삭제할 파일 목록에서 제거
            }

            // 파일 목록이 변경되었다면, 이벤트 객체 업데이트
            if (!fileList.isEmpty()) {
                vo.setFiles(String.join(",", fileList));
            } else {
                vo.setFiles(null);  // 모든 파일이 삭제되었으면 null로 설정
            }

            // 이벤트 수정
            service.update(vo);

            // 실제로 파일을 삭제
            File file = new File(path, fileName);
            if (file.exists()) {
                file.delete();
            }

            rttr.addFlashAttribute("msg", "파일이 삭제되었습니다.");
        }

        return "redirect:/event/updateForm.do?event_no=" + event_no;  // 수정 폼으로 리다이렉트
    }
}
