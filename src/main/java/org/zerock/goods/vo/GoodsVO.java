package org.zerock.goods.vo;

import lombok.Data;

@Data
public class GoodsVO {
    private Long goods_no;               // 상품 고유번호
    private Integer cpu_id;                    // CPU 객체 (외래 키)
    private Integer memory_id;              // 메모리 객체 (외래 키)
    private Integer graphic_Card_id;    // 그래픽카드 객체 (외래 키)
    private String cpu_name;
    private String memory_name;
    private String graphic_Card_name;
    private Integer cpu_price;
    private Integer memory_price;
    private Integer graphic_Card_price;
    private String image_main;
    private String[] image_files;
    private int total_price;            // 총 가격 (CPU + Memory + GPU 가격 합산)
}

