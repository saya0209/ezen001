package org.zerock.goods.vo;

import lombok.Data;

@Data
public class Graphic_Card {

	private int graphic_Card_id;         // graphic_card 고유 번호
	private String graphic_Card_name;     // graphic_card 이름 (예: 'GTX1060', 'GTX2060', 'GTX3060')
	private int graphic_Card_price;      		// graphic_card 가격
	
}
	
