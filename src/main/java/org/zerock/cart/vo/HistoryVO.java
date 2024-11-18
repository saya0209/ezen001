package org.zerock.cart.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

// DB안의 Board table 의 한행의 데이터을 저장할 수 있는 클래스 
@Data
public class HistoryVO {
    private String orderNumber;
    private String id;
    private Date paymentDate;
    private Integer totalAmount;
    private String status;
}


