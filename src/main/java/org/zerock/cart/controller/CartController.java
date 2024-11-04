package org.zerock.cart.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.cart.service.CartService;
import org.zerock.cart.vo.CartItemVO;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {

    @Autowired
    @Qualifier("cartServiceImpl")
    private CartService service;

    @GetMapping("/list.do")
    public String cartList(@RequestParam("id") String id, Model model) {
        log.info("list() 실행 =====");
        log.info("list()가 불러온 id: " + id);
        
        // id를 Long으로 변환 (필요한 경우)
//        Long idLong = null;
//        try {
//            idLong = Long.parseLong(id);
//        } catch (NumberFormatException e) {
//            log.error("Invalid id format: " + id);
//            // 오류 처리 로직 추가 (예: 에러 페이지로 리다이렉트)
//        }

        // 리다이렉트할 URL을 생성 (idLong이 null이 아닐 때만)
        return id != null ? "redirect:/cart/list/" + id : "redirect:/error"; // 에러 페이지로 리다이렉트하는 로직 추가 가능
    }
    
    @GetMapping("/list/{id}")
    public String cartItems(@PathVariable("id") String id, Model model) {
        log.info("list() 실행 =====");
        log.info("list()가 불러온 id: " + id);
        model.addAttribute("id", id);
        model.addAttribute("cartItems", service.cartList(id)); // cartService 호출
        return "cart/list"; // JSP 경로를 정확히 지정
    }
    
    // 장바구니 상품 수량 및 가격 수정 처리
    @PostMapping("/updateCartItem")
    public String updateCartItem(Model model,
                                 @RequestParam("goods_no") Long goods_no,
                                 @RequestParam("id") String id,
                                 @RequestParam("quantity") int quantity) {
        // 장바구니 업데이트 로직
        service.updateCartItem(id, goods_no, quantity); // goods_total_price를 전달하지 않음
        return "redirect:/cart/list/" + id; // id를 URL에 포함
    }
    
    // 장바구니 선택여부변경 처리
    @PostMapping("/updateSelection")
    @ResponseBody
    public ResponseEntity<String> updateSelection(
            @RequestParam("goods_no") Long goodsNo,
            @RequestParam("selected") int selected,
            @RequestParam("id") String id) {
    		log.info("goodsNo = "+goodsNo);
    		log.info("selected = "+selected);
    		log.info("id = "+id);
        try {
            service.updateSelection(goodsNo, selected, id);
            return ResponseEntity.ok("Success");
        } catch (Exception e) {
            log.error("Error updating selection: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update selection");
        }
    }
    
    
    // 결제화면
    @PostMapping("/paymentForm.do")
    public String paymentPageForm(@RequestParam("id") String id, 
                              Model model) {
        List<CartItemVO> cartItems = service.cartList(id);
        Long totalAmount = service.calculateTotalAmount(cartItems);

        log.info("paymentPageForm() 호출 - id: " + id);
        log.info("paymentPage() 호출 - totalAmount: " + totalAmount);
        // 결제에 필요한 데이터 추가
        model.addAttribute("id", id);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);

        return "cart/payment"; // 결제 페이지로 이동
    }
    

    // 결제완료 화면
    @PostMapping("/completePayment/{id}")
    public String completePayment(@PathVariable("id") String id, Model model) {
        log.info("completePayment() 호출 - id: " + id);
        String orderNumber = "ORD-" + id + "-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        // 필요한 경우 결제 완료에 필요한 정보 추가
        model.addAttribute("id", id);
        model.addAttribute("orderNumber", orderNumber);
        model.addAttribute("message", "결제가 성공적으로 완료되었습니다!");

        return "cart/completePayment"; // 결제 완료 페이지로 이동
    }
}
