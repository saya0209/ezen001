package org.zerock.goods.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsPriceVO {

	private Long goods_price_no;
	private Integer price;
	private Integer discount;
	private Integer sale_price;
	private Integer delivery_charge;
	private Long goods_no;
	
}




