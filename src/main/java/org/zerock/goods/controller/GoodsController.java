package org.zerock.goods.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.zerock.cart.vo.CartItemVO;
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
    public GoodsVO checkOrCreateGoods(
            @RequestParam(value = "cpu_id", defaultValue = "0") int cpu_id,
            @RequestParam(value = "memory_id", defaultValue = "0") int memory_id,
            @RequestParam(value = "graphic_Card_id", defaultValue = "0") int graphic_Card_id
    ) {
        // 1. 기존 구성 조회
        GoodsVO goods = goodsService.GoodsCheck(cpu_id, memory_id, graphic_Card_id);

        // 2. 기존 구성이 없으면 새 구성 생성
        if (goods == null) {
            goods = goodsService.insertGoods(cpu_id, memory_id, graphic_Card_id);
        }

        return goods;
    }
    
    @GetMapping("/list.do")
    public String listGoods(PageObject pageObject,
                            @RequestParam(value = "category", required = false) String category,
                            @RequestParam(value = "sort", defaultValue = "hit") String sort, 
                            Model model) {
        // category가 null 또는 빈 문자열이면 기본값 설정
        if (category == null || category.isEmpty()) {
            category = "goods1"; // 기본 카테고리
        }

        // 상품 목록을 가져오는 서비스 호출
        List<GoodsVO> goodsList = goodsService.getGoodsList(pageObject, sort, category);
        
        // 모델에 데이터 추가
        model.addAttribute("goodsList", goodsList);
        model.addAttribute("category", category);  // category 전달
        model.addAttribute("sort", sort);  // 정렬 정보 전달
        model.addAttribute("pageObject", pageObject);  // 페이지 정보 전달
        
        return "goods/list";  // JSP로 포워딩
    }
    
    // 상품 상세 보기
    @GetMapping("view.do")
    public String view(@RequestParam("goods_no") Long goods_no,
    		@RequestParam(value = "category", required = false) String category, Model model) {
    	// 조회수 증가
        goodsService.increaseHit(goods_no);
        GoodsVO goodsVO = goodsService.view(goods_no);
        //정가를 세팅
        goodsVO.setPrice(goodsVO.getCpu_price()+goodsVO.getGraphic_Card_price()+goodsVO.getMemory_price());
        model.addAttribute("goods", goodsVO);
        model.addAttribute("category", category);  // category 전달
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
    public String writeForm(@RequestParam("category") String category, Model model) {
        model.addAttribute("cpuList", goodsService.getCpuList());
        model.addAttribute("memoryList", goodsService.getMemoryList());
        model.addAttribute("graphic_CardList", goodsService.getGraphic_CardList());
        model.addAttribute("category", category);

        return "goods/write";
    }

    // 상품 등록 처리
    @PostMapping("/write.do")
    public String write(@RequestParam("cpu_id") int cpu_id,
                        @RequestParam("memory_id") int memory_id,
                        @RequestParam("graphic_Card_id") int graphic_Card_id,
                        @RequestParam("image_name") MultipartFile image_name,
                        @RequestParam(value = "image_files", required = false) MultipartFile[] image_files,
                        @RequestParam("category") String category,  // 카테고리 값 추가
                        @RequestParam("delivery_charge") Long delivery_charge,
                        @RequestParam("discount") Long discount,
                        HttpServletRequest request) {

        GoodsVO goods = new GoodsVO();
        goods.setCpu_id(cpu_id);
        goods.setMemory_id(memory_id);
        goods.setGraphic_Card_id(graphic_Card_id);
        goods.setCategory(category);  // 카테고리 값 설정
        goods.setDelivery_charge(delivery_charge);
        goods.setDiscount(discount);

        // 대표 이미지 처리
        String mainImagePath = goodsService.uploadImage(image_name, request);
        goods.setImage_name(mainImagePath);

        // 추가 이미지 처리
        if (image_files != null) {
            String[] imagePaths = goodsService.uploadImages(image_files);
            goods.setImage_files(imagePaths);
        }  

        // 상품 등록
        goodsService.registerGoods(goods);  

        // 등록 후 카테고리
        return "redirect:/goods/list.do?category=" + category;  // 리다이렉트 시 카테고리와 페이지 유지
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
    
    @WebServlet("/addCart")
    public class AddCartServlet extends HttpServlet {
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // 전달된 데이터 가져오기
            Long goods_no = Long.parseLong(request.getParameter("goods_no"));
            String goods_name = request.getParameter("goods_name");
            Long price = Long.parseLong(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("Quantity"));
            Long discount = Long.parseLong(request.getParameter("discount"));
            Long delivery_charge = Long.parseLong(request.getParameter("delivery_charge"));

            // 세션에서 장바구니 리스트 가져오기
            HttpSession session = request.getSession();
            List<CartItemVO> cart = (List<CartItemVO>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            // 장바구니에 추가할 상품 생성
            CartItemVO item = new CartItemVO();
            item.setGoods_no(goods_no);
            item.setGoods_name(goods_name);
            item.setPrice(price);
            item.setQuantity(quantity);
            item.setDiscount(discount);
            item.setDelivery_charge(delivery_charge);

            // 장바구니에 상품 추가
            cart.add(item);

            // 세션에 장바구니 저장
            session.setAttribute("cart", cart);

            // 장바구니 페이지로 리디렉션
            response.sendRedirect("cart.jsp");
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