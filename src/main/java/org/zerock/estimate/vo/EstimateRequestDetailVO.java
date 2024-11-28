package org.zerock.estimate.vo;

import lombok.Data;

@Data
public class EstimateRequestDetailVO {
    private Long detail_id;
    private Long request_no;
    private Long product_id;
    private Integer quantity;
    private EstimateProductVO product; // 연관된 제품 정보
}