package org.zerock.goods.vo;

import lombok.Data;

@Data
public class ProductsVO {


    private Long goods_no;
	private String goods_name;
	private String company;
    private String pro_code1;
    private String pro_code2;
    private String image_name;	
	private Integer price;
	
}
