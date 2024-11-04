package org.zerock.cart.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

// DB안의 Board table 의 한행의 데이터을 저장할 수 있는 클래스 
@Data
public class CartItemVO {
	private String id;                // 로그인 아이디 
    private Long goods_no;            // 상품 번호
    private String goods_name;         // 상품 이름
    private String image_name;         // 상품 이미지 파일명
    private Long price;                // 상품 가격
    private Integer quantity;          // 상품 수량
    private Long goods_total_price;         // 상품 총 가격 (price * quantity + delivery_charge)
    private Long selected_goods_price; // 선택된 상품 총 가격 (체크된 상품의 총 합계)
    private Long delivery_charge;       // 배송비
    private Long cart_no;              // 장바구니 번호
    private Long discount;              // 개별 상품의 할인액
    private Long total_discount;        // 전체 할인가
    private Integer selected;           // 선택 여부 (1: 선택, 0: 미선택)
    private Long totalAmount;           // 최종 가격 (장바구니에 담긴 모든 상품의 총 합계)
    private Date purchase_date;         // 구매 날짜
    private String category;            // 상품 카테고리

    
    
}


