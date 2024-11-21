package org.zerock.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.service.CategoryService;
import org.zerock.category.vo.CategoryVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    @Qualifier("categoryServiceImpl")
    private CategoryService service;

    // 1. 카테고리 리스트
    @GetMapping("/list.do")
    public String list(@RequestParam(defaultValue = "0") Integer cate_code1,
                       @RequestParam(defaultValue = "0") Integer cate_code2,
                       @RequestParam(defaultValue = "0") Integer cate_code3, // cate_code3 추가
                       Model model) {
        
        log.info("cate_code1 = " + cate_code1);
        
        // 대분류 가져오기
        List<CategoryVO> listBig = service.list(0, 0, 0);

        // 중분류 가져오기
        if (cate_code1 == 0 && !listBig.isEmpty()) {
            cate_code1 = listBig.get(0).getCate_code1();
        }
        
        log.info("after listBig - cate_code1 = " + cate_code1);

        List<CategoryVO> listMid = service.list(cate_code1, 0, 0);
        
        // 카테고리 2번세팅
        if (cate_code2 == 0 && !listMid.isEmpty()) {
            cate_code2 = listMid.get(0).getCate_code2();
        }

        // 소분류 가져오기
        List<CategoryVO> listSmall = service.list(cate_code1, cate_code2, 0); // cate_code3 추가

        // 처리된 값을 model에 담아서 넘긴다.
        model.addAttribute("listBig", listBig);
        model.addAttribute("listMid", listMid);
        model.addAttribute("listSmall", listSmall); 
        model.addAttribute("cate_code1", cate_code1);
        model.addAttribute("cate_code2", cate_code2);
        model.addAttribute("cate_code3", cate_code3); // cate_code3 추가

        log.info("cate_code1 = " + cate_code1 + ", cate_code2 = " + cate_code2 + ", cate_code3 = " + cate_code3); // 로그에 cate_code3 추가
        
        // "/WEB-INF/views/ + category/list + .jsp"
        return "category/list";
    }
    
    // 2. 카테고리 등록
    @PostMapping("/write.do")
    public String write(CategoryVO vo, RedirectAttributes rttr) {
        if (vo.getCate_code1() == 0) {
            // 대분류 등록
            service.writeBig(vo);
        } else if (vo.getCate_code2() == 0) {
            // 중분류 등록
            service.writeMid(vo);
        } else {
            // 소분류 등록
            service.writeSmall(vo);
        }
        
        rttr.addFlashAttribute("msg", "카테고리가 등록되었습니다.");
        return "redirect:list.do?cate_code1=" + vo.getCate_code1() + "&cate_code2=" + vo.getCate_code2();
    }
    
    // 3. 카테고리 수정
    @PostMapping("/update.do")
    public String update(CategoryVO vo, RedirectAttributes rttr) {
        Integer result = service.update(vo);
        
        if (result == 1) {
            rttr.addFlashAttribute("msg", "카테고리가 수정되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "카테고리가 수정되지 않았습니다.");
        }
        
        return "redirect:list.do?cate_code1=" + vo.getCate_code1() + "&cate_code2=" + vo.getCate_code2(); // 소분류 코드 추가
    }
    
    // 4. 카테고리 삭제 처리
    @PostMapping("/delete.do")
    public String delete(CategoryVO vo, RedirectAttributes rttr) {
        Integer result = service.delete(vo);
        
        if (result >= 1) {
            rttr.addFlashAttribute("msg", "카테고리가 삭제되었습니다.");
        } else {
            rttr.addFlashAttribute("msg", "카테고리가 삭제되지 않았습니다.");
        }
        
        return "redirect:list.do?cate_code1=" + vo.getCate_code1() + "&cate_code2=" + vo.getCate_code2(); // 소분류 코드 추가
    }
}







