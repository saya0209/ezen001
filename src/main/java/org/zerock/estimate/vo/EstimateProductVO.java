package org.zerock.estimate.vo;

import lombok.Data;

@Data
public class EstimateProductVO {
	private Long product_id;
    private Long category_id;
    private String product_name;
    private Long price;
    private String description;
    private Integer stock;
    private EstimateCategoryVO category; // 연관된 카테고리 정보
}