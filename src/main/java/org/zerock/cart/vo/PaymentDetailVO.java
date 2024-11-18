package org.zerock.cart.vo;

import java.util.Date;

import lombok.Data;

// DB안의 Board table 의 한행의 데이터을 저장할 수 있는 클래스 
@Data
public class PaymentDetailVO {
    private String id;
    private String detailId;
    private String orderNumber;
    private Long goods_no;
    private String goods_name;
    private Long price;
    private Integer quantity;
    private Long goods_total_price;
    private Date paymentDate;
}

