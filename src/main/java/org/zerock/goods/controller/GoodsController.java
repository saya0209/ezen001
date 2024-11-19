package org.zerock.goods.controller;

import java.security.Provider.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.goods.service.GoodsService;
import org.zerock.goods.vo.Cpu;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.goods.vo.Graphic_Card;
import org.zerock.goods.vo.Memory;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/goods")
@Log4j
public class GoodsController {

    @Autowired
    @Qualifier("goodsServiceImpl")
    private GoodsService goodsService;

    
    // 고객의 부품 선택에 따라 상품을 조회하거나 새로 생성
    @PostMapping("/checkOrCreate")
    public GoodsVO checkOrCreateGoods(@RequestParam int cpu_id,
                                      @RequestParam int memory_id,
                                      @RequestParam int graphic_Card_id
                                      ) {
        // 1. 기존 구성 조회
        GoodsVO goods = goodsService.GoodsCheck(cpu_id, memory_id, graphic_Card_id);

        // 2. 기존 구성이 없으면 새 구성 생성
        if (goods == null) {
            goods = goodsService.insertGoods(cpu_id, memory_id, graphic_Card_id);
        }

        return goods;
    }
    
    // 상품 리스트 조회
    @GetMapping("/list.do")
    public String list(PageObject pageObject, Model model) {
        List<GoodsVO> goodsList = goodsService.list(pageObject);
        model.addAttribute("list", goodsList);
        model.addAttribute("pageObject", pageObject); // 페이지네이션
        
        
        log.info(model);
        return "goods/list";  // 상품 리스트 JSP로 포워딩
    }

    // 상품 상세 보기
    @GetMapping("view.do")
    public String view(@RequestParam("goods_no") Long goods_no, Model model) {
        GoodsVO goodsVO = goodsService.view(goods_no);
        model.addAttribute("goods", goodsVO);
        return "goods/view";  // 상품 상세보기 JSP로 포워딩
    }
    
    @GetMapping(value = "/cpu_id",
    		produces = {
    			MediaType.APPLICATION_JSON_UTF8_VALUE	
    		}
    		)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCpu_id() {
        List<Cpu> cpu_id = goodsService.getcpu_id();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cpu_id", cpu_id);
        return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
    }
    
    @GetMapping(value = "/memory_id",
    		produces = {
    			MediaType.APPLICATION_JSON_UTF8_VALUE	
    		}
    		)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getMemory_id() {
        List<Memory> memory_id = goodsService.getmemory_id();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("memory_id", memory_id);
        return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
    }
    
    @GetMapping(value = "/graphic_Card_id",
    		produces = {
    				MediaType.APPLICATION_JSON_UTF8_VALUE	
    }
    		)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getGraphic_Card_id() {
    	List<Graphic_Card> graphic_Card_id = goodsService.getgraphic_Card_id();
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("graphic_Card_id", graphic_Card_id);
    	return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
    }
    
    
    
	    // 사양 변경 후 업데이트
	    @PostMapping("/updateOptions")
	    public String updateOptions(@RequestParam Long goods_no,
                                @RequestParam int cpu_id,
                                @RequestParam int memory_id,
                                @RequestParam int graphic_Card_id,
                                Model model) {
        // 상품 조회
        GoodsVO goods = goodsService.view(goods_no);

        // 옵션 변경 처리
        goods.setCpu_id(cpu_id);
        goods.setMemory_id(memory_id);
        goods.setGraphic_Card_id(graphic_Card_id);

        // 옵션에 맞는 정보 설정
        Cpu cpu = goodsService.getcpu_id(cpu_id);
        Memory memory = goodsService.getmemory_id(memory_id);
        Graphic_Card graphic_Card = goodsService.getgraphic_Card_id(graphic_Card_id);

        goods.setCpu_name(cpu.getCpu_name());
        goods.setMemory_name(memory.getMemory_name());
        goods.setGraphic_Card_name(graphic_Card.getGraphic_Card_name());

        // 변경된 상품 정보 DB 업데이트
        goodsService.update(goods);

        // 변경된 상품 정보 모델에 추가
        model.addAttribute("goods", goods);
        model.addAttribute("cpuList", goodsService.getCpuList());
        model.addAttribute("memoryList", goodsService.getMemoryList());
        model.addAttribute("graphicCardList", goodsService.getGraphic_CardList());

        return "goods/view"; // 상품 상세 페이지로 이동
    }
    


    // 상품 등록 폼
    @GetMapping("/writeForm.do")
    public String writeForm(Model model) {
        model.addAttribute("cpuList", goodsService.getcpu_id());
        model.addAttribute("memoryList", goodsService.getmemory_id());
        model.addAttribute("graphic_CardList", goodsService.getgraphic_Card_id());
        return "goods/write";
    }

    // 상품 등록 처리
    @PostMapping("/write.do")
    public String write(@RequestParam("cpu_id") int cpu_id,
                        @RequestParam("memory_id") int memory_id,
                        @RequestParam("graphic_Card_id") int graphic_Card_id,
                        @RequestParam("image_main") MultipartFile image_main,		
                        @RequestParam(value = "image_files", required = false) MultipartFile[] image_files,
                        HttpServletRequest request) {

        GoodsVO goods = new GoodsVO();
        goods.setCpu_id(cpu_id);
        goods.setMemory_id(memory_id);
        goods.setGraphic_Card_id(graphic_Card_id);

        // 대표 이미지 처리
        String mainImagePath = goodsService.uploadImage(image_main, request);
        goods.setImage_main(mainImagePath);

        // 추가 이미지 처리
        if (image_files != null) {
            String[] imagePaths = goodsService.uploadImages(image_files);
            goods.setImage_files(imagePaths);
            
        }  
        goodsService.registerGoods(goods);

        return "redirect:/goods/list.do";  // 등록 후 리스트 페이지로 리다이렉트
    }   



    // 상품 삭제 처리
    @GetMapping("/delete.do")
	public String delete(Long goods_no, RedirectAttributes rttr) {
		log.info("delete.do ==================");
		
		log.info("goods_no : " + goods_no);
		Long result = goodsService.delete(goods_no);
		
		log.info("result : " + result);
		if (result == 1) {
			rttr.addFlashAttribute("msg",
					"상품이 삭제되었습니다.");
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"상품이 삭제되지 않았습니다.");
			
			return "redirect:/notice/view.do?no=" + goods_no;
		}
		
	}

    // 이미지 수정 처리
    @PostMapping("/updateImage.do")
    public String updateImage(@RequestParam("goods_no") Long goods_no) {
        // 이미지 수정 로직을 처리한 후, 수정된 상품 페이지로 리다이렉트
        return "redirect:/goods/updateForm.do?goods_no=" + goods_no;
    }

    // 이미지 삭제 처리
    @PostMapping("/deleteImage.do")
    public String deleteImage(@RequestParam("goods_no") Long goods_no) {
        // 이미지 삭제 후 상품 수정 페이지로 리다이렉트
        return "redirect:/goods/updateForm.do?goods_no=" + goods_no;
    }
}