package org.zerock.cart.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    // 장바구니 상품 조회
    @GetMapping("/list/{id}")
    public String cartItems(@PathVariable("id") Long id, Model model) {
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
                                 @RequestParam("id") Long id,
                                 @RequestParam("quantity") int quantity) {
        // 장바구니 업데이트 로직
        service.updateCartItem(id, goods_no, quantity); // goods_total_price를 전달하지 않음
        return "redirect:/cart/list/" + id; // id를 URL에 포함
    }
    
    
    
    // 결제화면
    @PostMapping("/paymentForm.do")
    public String paymentPageForm(@RequestParam("id") Long id, 
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
    public String completePayment(@PathVariable("id") Long id, Model model) {
        log.info("completePayment() 호출 - id: " + id);

        // 필요한 경우 결제 완료에 필요한 정보 추가
        model.addAttribute("id", id);
        model.addAttribute("message", "결제가 성공적으로 완료되었습니다!");

        return "cart/completePayment"; // 결제 완료 페이지로 이동
    }
}
