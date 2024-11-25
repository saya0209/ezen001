package org.zerock.cart.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.buy.vo.BuyItemVO;
import org.zerock.cart.service.CartService;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.cart.vo.PaymentDetailVO;
import org.zerock.cart.vo.PaymentItemVO;

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
        
        // 리다이렉트할 URL을 생성 (id가 null이 아닐 때만)
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
    @GetMapping("/paymentForm.do")
    public String paymentPageForm(@RequestParam("id") String id, 
                                   @RequestParam(value = "now", required = false) Integer now, 
                                   @RequestParam(value = "goods_no", required = false) Integer goodsNo, 
                                   Model model) {
        List<CartItemVO> cartItems = service.cartList(id);
        List<PaymentItemVO> selectedItems = new ArrayList<>();
        List<BuyItemVO> buyItems = service.buyList(id);

        selectedItems.clear();
        log.info("paymentPageForm() 호출 - id: " + id);
        
        // 바로결제 모드일 경우
        for (BuyItemVO item : buyItems) {
            
	    	if (now != null && now == 1) {
	    		log.info("바로결제 실행");
	    		PaymentItemVO pvo = new PaymentItemVO();
	            pvo.setGoods_no(item.getGoods_no());
	            pvo.setGoods_name(item.getGoods_name());
	            pvo.setImage_name(item.getImage_name());
	            pvo.setPrice(item.getPrice());
	            pvo.setQuantity(item.getQuantity());
	            pvo.setGoods_total_price(item.getGoods_total_price());
	            selectedItems.add(pvo);
	    	
	    	}
        }
        log.info(selectedItems);

        // 장바구니에서 선택된 상품만 pvo에 추가
        for (CartItemVO item : cartItems) {
        	if (now == null) {
	            if (item.getSelected() == 1) { // `selected` 필드가 true인 경우
	                PaymentItemVO pvo = new PaymentItemVO();
	                pvo.setGoods_no(item.getGoods_no());
	                pvo.setGoods_name(item.getGoods_name());
	                pvo.setImage_name(item.getImage_name());
	                pvo.setPrice(item.getPrice());
	                pvo.setQuantity(item.getQuantity());
	                pvo.setGoods_total_price(item.getGoods_total_price());
	                selectedItems.add(pvo);
	            }
            }
        }

        // 결제에 필요한 데이터 추가
        model.addAttribute("id", id);
        model.addAttribute("cartItems", selectedItems);  // 선택된 항목만 전달
        
        log.info("paymentPageForm()----");
        
        return "cart/payment"; // 결제 페이지로 이동
    }
    

 // 결제완료 화면
    @PostMapping("/completePayment/{id}")
    public String completePayment(@PathVariable("id") String id, Model model) {
        log.info("completePayment() 호출 - id: " + id);

        // 주문번호 생성
        String orderNumber = "ORD-" + id + "-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        List<CartItemVO> cartItems = service.cartList(id);
        
        int totalAmount = 0;
        List<PaymentDetailVO> paymentDetails = new ArrayList<>();
        List<PaymentItemVO> selectedItems = new ArrayList<>();  // 추가된 부분
        
        // 선택된 상품 정보 저장 및 결제 총액 계산
        for (CartItemVO item : cartItems) {
            if (item.getSelected() == 1) {
                PaymentDetailVO detail = new PaymentDetailVO();
                detail.setId(id);
                detail.setOrderNumber(orderNumber);
                detail.setGoods_no(item.getGoods_no());
                detail.setGoods_name(item.getGoods_name());
                detail.setPrice(item.getPrice());
                detail.setPaymentDate(new Date());
                detail.setQuantity(item.getQuantity());
                detail.setGoods_total_price(item.getGoods_total_price());

                paymentDetails.add(detail);
                totalAmount += item.getGoods_total_price();
                
                // PaymentItemVO에 선택된 상품 추가 (selectedItems에 추가)
                PaymentItemVO pvo = new PaymentItemVO();
                pvo.setGoods_no(item.getGoods_no());
                pvo.setGoods_name(item.getGoods_name());
                pvo.setImage_name(item.getImage_name());  // 만약 이미지가 있다면 추가
                pvo.setPrice(item.getPrice());
                pvo.setQuantity(item.getQuantity());
                pvo.setGoods_total_price(item.getGoods_total_price());
                
                selectedItems.add(pvo);  // 선택된 상품을 selectedItems에 추가
            }
        }
        
     // 바로구매한 상품도 결제 내역에 추가
        List<BuyItemVO> buyItems = service.buyList(id);
        for (BuyItemVO item : buyItems) {
            PaymentDetailVO detail = new PaymentDetailVO();
            detail.setId(id);
            detail.setOrderNumber(orderNumber);
            detail.setGoods_no(item.getGoods_no());
            detail.setGoods_name(item.getGoods_name());
            detail.setPrice(item.getPrice());
            detail.setPaymentDate(new Date());
            detail.setQuantity(item.getQuantity());
            detail.setGoods_total_price(item.getGoods_total_price());

            paymentDetails.add(detail);
            totalAmount += item.getGoods_total_price();

            // PaymentItemVO에 바로구매한 상품 추가
            PaymentItemVO pvo = new PaymentItemVO();
            pvo.setGoods_no(item.getGoods_no());
            pvo.setGoods_name(item.getGoods_name());
            pvo.setImage_name(item.getImage_name());
            pvo.setPrice(item.getPrice());
            pvo.setQuantity(item.getQuantity());
            pvo.setGoods_total_price(item.getGoods_total_price());
            selectedItems.add(pvo);
        }
        // HistoryVO 생성 후 DB에 저장
        HistoryVO history = new HistoryVO();
        history.setOrderNumber(orderNumber);
        history.setId(id);
        history.setPaymentDate(new Date());
        history.setTotalAmount(totalAmount);
        history.setStatus("완료");

        log.info(history.getTotalAmount());
        log.info(history.getId());
        
        // CartMapper를 통해 결제 내역 저장
        service.savePaymentHistory(history, paymentDetails);

        // 결제 완료 후 선택 항목 제거
        service.removeSelectedItems(id);

        model.addAttribute("id", id);
        model.addAttribute("orderNumber", orderNumber);
        model.addAttribute("message", "결제가 성공적으로 완료되었습니다!");

        return "cart/completePayment"; // 결제 완료 페이지로 이동
    }

    // 결제 기록 조회 화면
    @GetMapping("/history")
    public String viewHistory(@RequestParam("id") String id, Model model) {
        log.info("viewHistory() 호출 - id: " + id);
        List<HistoryVO> paymentHistory = service.getPaymentHistory(id);
        model.addAttribute("id", id);
        model.addAttribute("paymentHistory", paymentHistory);
        return "cart/history";
    }

    // 특정 결제 내역 조회 화면
//    @GetMapping("/history/detail/{orderNumber}")
//    public String viewHistoryDetail(
//            @PathVariable("orderNumber") String orderNumber, 
//            @RequestParam("paymentDate") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date paymentDate,
//            Model model) {
//        List<PaymentDetailVO> paymentDetails = service.getPaymentDetails(orderNumber);
//        model.addAttribute("orderNumber", orderNumber);
//        model.addAttribute("paymentDate", paymentDate);
//        model.addAttribute("paymentDetails", paymentDetails);
//
//        log.info("orderNumber: " + orderNumber);
//        log.info("paymentDate: " + paymentDate);
//        return "cart/historyDetail";
//    }
    
    @GetMapping("/history/detail/{orderNumber}")
    public String viewHistoryDetail(@PathVariable("orderNumber") String orderNumber, Model model) {
        // orderNumber를 사용해 HistoryVO 조회
        HistoryVO history = service.getHistoryByOrderNumber(orderNumber);

        // 상세 결제 내역 조회
        List<PaymentDetailVO> paymentDetails = service.getPaymentDetails(orderNumber);

        // Model에 데이터 전달
        model.addAttribute("history", history); // HistoryVO 객체
        model.addAttribute("paymentDetails", paymentDetails);

        log.info("HistoryVO: " + history);
        return "cart/historyDetail";
    }
    
    @PostMapping("/add")
    @ResponseBody  // JSON 응답을 반환하기 위해 사용
    public ResponseEntity<String> addCart(@RequestBody CartItemVO cartItem) {
        try {
            service.addCartItem(cartItem);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
        }
    }
    
    @PostMapping("/addbuy")
    @ResponseBody  // JSON 응답을 반환하기 위해 사용
    public ResponseEntity<String> addBuy(@RequestBody BuyItemVO buyItem) {
        try {
        	// DB초기화
        	service.clearBuyItem(buyItem.getId());
            // DB에 데이터를 저장
            service.addBuyItem(buyItem);
            
            // DB 저장이 성공했으면 결제 페이지로 리디렉션
            return ResponseEntity.ok("/cart/paymentForm.do?id=" + buyItem.getId() + "&goods_no" + buyItem.getGoods_no() + "&now=1");
        } catch (Exception e) {
        	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
        }
    }
    
    @PostMapping("/removeCartItem")
    public String removeCartItem(@RequestParam("cart_no") Long cart_no, 
                                 @RequestParam("id") String id) {
        log.info("removeCartItem() 호출 - cart_no: " + cart_no + ", id: " + id);

        // Service를 통해 해당 상품을 삭제
        service.removeCartItem(id, cart_no);

        // 삭제 후 장바구니 목록으로 리다이렉트
        return "redirect:/cart/list/" + id;
    }
    


}
