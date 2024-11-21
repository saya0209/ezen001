package org.zerock.notice.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.notice.service.NoticeService;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    @Qualifier("noticeServiceImpl")
    private NoticeService service;
   
    // 파일이 저장될 경로
    @Value("${file.upload.path}")
    private String path;

    // 파일 업로드 및 저장 처리 메서드 (FileUtil 사용)
    private List<String> saveFiles(List<MultipartFile> files, HttpServletRequest request) throws Exception {
        List<String> fileNames = new ArrayList<>();
       
        // FileUtil을 사용하여 파일 업로드 처리
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String uploadedFilePath = FileUtil.upload(path, file, request); // FileUtil 사용
                String fileName = uploadedFilePath.substring(uploadedFilePath.lastIndexOf("/") + 1);
                fileNames.add(fileName);  // 저장된 파일명을 리스트에 추가
            }
        }
        return fileNames;
    }
   
    // 1. 이벤트(공지사항) 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request) {
        log.info("list.do ======");
       
        // 페이지 처리를 위한 객체생성
        PageObject pageObject = PageObject.getInstance(request);
       
        pageObject.setPeriod("all");
        // 처리된 데이터를 Model에 저장해서 jsp로 넘긴다.
        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);
       
        log.info("list.do ======");
       
        return "notice/list";
    }
   
    // 2. 이벤트(공지사항) 글보기
    @GetMapping("/view.do")
    public String view(Model model, Long no) {
        log.info("view.do ================");
        model.addAttribute("vo", service.view(no));
        return "notice/view";
    }
   
    // 3-1. 이벤트(공지사항) 글쓰기 폼
    @GetMapping("/writeForm.do")
    public String writeForm() {
        log.info("writeForm.do ==================");
        return "notice/write";
    }
   
    // 3-2. 이벤트(공지사항) 글쓰기 처리
    @PostMapping("/write.do")
    public String write(
            NoticeVO vo,
            @RequestParam("uploadFileMulti") List<MultipartFile> files,
            RedirectAttributes rttr,
            HttpServletRequest request) throws Exception {
       
        // 기본 작성자 설정
        if (vo.getWriter_id() == null) {
            vo.setWriter_id("관리자");
        }

        // 업로드된 파일을 저장할 리스트
        List<String> fileNames = saveFiles(files, request);

        // 파일 리스트를 하나의 문자열로 변환하여 NoticeVO에 설정
        if (!fileNames.isEmpty()) {
            vo.setFiles(String.join(",", fileNames));  // 파일 경로를 CSV 형식으로 저장
        }

        // 이벤트(공지사항) 등록
        service.write(vo);

        // 성공 메시지 전달
        rttr.addFlashAttribute("msg", "새로운 이벤트가 등록되었습니다.");

        return "redirect:/notice/list.do";  // 이벤트(공지사항) 목록으로 리다이렉트
    }
   
    // 4-1. 이벤트(공지사항) 글수정 폼
    @GetMapping("/updateForm.do")
    public String updateForm(Model model, Long no) {
        log.info("updateForm.do ==================");
       
        model.addAttribute("vo", service.view(no));
       
        return "notice/update";
    }
   
    // 4-2. 이벤트(공지사항) 글수정 처리
    @PostMapping("/update.do")
    public String update(NoticeVO vo,
                         @RequestParam("uploadFileMulti") List<MultipartFile> files,
                         RedirectAttributes rttr,
                         HttpServletRequest request) throws Exception {
        log.info("update.do =================");
       
        // 기존 파일이 있을 경우, 새로운 파일이 있으면 기존 파일을 삭제하고 새 파일 저장
        if (!files.isEmpty()) {
            // 기존 파일 삭제
            if (vo.getFiles() != null) {
                String[] oldFiles = vo.getFiles().split(",");
                for (String oldFile : oldFiles) {
                    File file = new File(path, oldFile);
                    if (file.exists()) {
                        file.delete();  // 기존 파일 삭제
                    }
                }
            }
           
            // 새로운 파일 저장
            List<String> fileNames = saveFiles(files, request);

            // 새로운 파일 리스트를 하나의 문자열로 변환하여 NoticeVO에 설정
            if (!fileNames.isEmpty()) {
                vo.setFiles(String.join(",", fileNames));  // 파일 경로를 CSV 형식으로 저장
            }
        } else {
            // 파일이 없으면 기존 파일을 그대로 사용
            if (vo.getFiles() == null) {
                vo.setFiles(""); // 파일이 없을 경우 빈 문자열 처리
            }
        }
       
        // NoticeVO를 사용하여 이벤트(공지사항) 수정 처리
        Integer result = service.update(vo);
       
        // 수정 결과에 따라 리다이렉트
        if (result == 1) {
            rttr.addFlashAttribute("msg", "이벤트가 성공적으로 수정되었습니다.");
            return "redirect:/notice/list.do";  // 수정 후 목록으로 리다이렉트
        } else {
            rttr.addFlashAttribute("msg", "이벤트 수정에 실패했습니다. 다시 시도해주세요.");
            return "redirect:/notice/view.do?no=" + vo.getNotice_no();  // 수정 실패 시 상세보기 페이지로 리다이렉트
        }
    }
   
    // 5. 이벤트(공지사항) 글 삭제
    @PostMapping("/delete.do")  // POST로 요청을 받음
    public String delete(@RequestParam("notice_no") Long notice_no, RedirectAttributes rttr) {
        log.info("delete.do ==================");
        log.info("notice_no: " + notice_no);  // 디버깅용으로 확인

        // 삭제 전, 기존 파일 삭제
        NoticeVO vo = service.view(notice_no);
        if (vo.getFiles() != null) {
            String[] oldFiles = vo.getFiles().split(",");
            for (String oldFile : oldFiles) {
                File file = new File(path, oldFile);
                if (file.exists()) {
                    file.delete();  // 기존 파일 삭제
                }
            }
        }

        Integer result = service.delete(notice_no);

        if (result == 1) {
            rttr.addFlashAttribute("msg", "이벤트가 삭제되었습니다.");
            return "redirect:list.do";
        } else {
            rttr.addFlashAttribute("msg", "이벤트가 삭제되지 않았습니다.");
            return "redirect:/notice/view.do?no=" + notice_no;
        }
    }


}
