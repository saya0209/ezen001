package org.zerock.goodsReview.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.goodsReview.service.GoodsReviewService;
import org.zerock.goodsReview.vo.GoodsReviewVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

// 자동생성 어노테가션
// @Controller, @RestController
// @Service
// @Repository
// @Component
// @~~Advice
@RestController
@RequestMapping("/goodsReview")
@Log4j
public class GoodsReviewRestController {

    @Autowired
    @Qualifier("goodsReviewServiceImpl")
    private GoodsReviewService service;
    
    @GetMapping(value = "/list.do", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<Map<String, Object>> list(PageObject pageObject, Long goods_no) {
        log.info("list - page : " + pageObject.getPage() + ", goods_no : " + goods_no);
        List<GoodsReviewVO> list = service.list(pageObject, goods_no);
        
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pageObject", pageObject);
        
        log.info("After map : " + map);
                
        return new ResponseEntity<>(map, HttpStatus.OK);
    }
    
    @PostMapping(value = "/write.do", consumes = "application/json", produces = "text/plain; charset=UTF-8")
    public ResponseEntity<String> write(@RequestBody GoodsReviewVO vo, HttpSession session) {
        vo.setId(getId(session));
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        
        // 로그인 여부 체크 후 nicname 설정
        if (loginVO != null && loginVO.getNicname() != null) {
            vo.setNicname(loginVO.getNicname());
        } else {
            // nicname이 없을 경우 기본값 설정 (옵션)
            vo.setNicname("Anonymous");
        }
        
     // 중복 체크
        Integer existingReview = service.checkReviewExists(vo);
        if (existingReview > 0) {
            return new ResponseEntity<>("이미 해당 상품에 리뷰를 작성하셨습니다.", HttpStatus.OK);
        }
        
        service.write(vo);
        
        return new ResponseEntity<>("리뷰 등록이 완료되었습니다.", HttpStatus.OK);
    }

    
    @PostMapping(value = "/update.do", consumes = "application/json", produces = "text/plain; charset=UTF-8")
    public ResponseEntity<String> update(@RequestBody GoodsReviewVO vo, HttpSession session) {
        log.info("update.do ---------------------------------");
        vo.setId(getId(session));
        
        Integer result = service.update(vo);
        
        if (result == 1) {
            return new ResponseEntity<>("리뷰가 수정되었습니다.", HttpStatus.OK);
        }
        
        return new ResponseEntity<>("리뷰가 수정되지 않았습니다.", HttpStatus.BAD_REQUEST);
    }
    
    @GetMapping(value = "/delete.do", produces = "text/plain; charset=UTF-8")
    public ResponseEntity<String> delete(GoodsReviewVO vo, HttpSession session) {
        log.info("delete.do --------------------------------------");
        vo.setId(getId(session));
        
        Integer result = service.delete(vo);
        
        if (result == 1) {
            return new ResponseEntity<>("리뷰가 삭제 되었습니다.", HttpStatus.OK);
        }
        return new ResponseEntity<>("리뷰가 삭제되지 않았습니다.", HttpStatus.BAD_REQUEST);
    }

    private String getId(HttpSession session) {
        LoginVO vo = (LoginVO) session.getAttribute("login");
        if (vo == null) {
            return null;  // 로그인되지 않은 경우 처리
        }
        return vo.getId();
    }
}
