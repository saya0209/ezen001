package org.zerock.goods.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class GoodsVO {

	// goods
	private Long goods_no;
	private String goods_name;
	private Integer cate_code1;
	private Integer cate_code2;
	private String cate_name;
	private String image_name;
	private String content;
	private String company;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date product_date;
	
	// goods_price (현재 판매 기준)
	private Long goods_price_no;
	private Integer price;
	private Integer discount;
	private Integer sale_price;
	private Integer delivery_charge;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sale_start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sale_end_date;
	
	// 실제 판매가 getter 만들기 -> jsp ${vo.sale_price}
	// getter에서 일반메서드로 변경 (DB테이블에 sale_price칼럼추가)
	// DB에 Insert전에 => vo.setSale_price(vo.sale_price());
	
}




