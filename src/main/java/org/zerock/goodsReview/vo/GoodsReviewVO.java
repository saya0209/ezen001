package org.zerock.goodsReview.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsReviewVO {

	private Long rno; // 상품의 리뷰 번호
	private Long goods_no;  // 상품 번호
	private String content; // 리뷰 내용
	private String id; // 리뷰작성자 id
	private String nicname; // 리뷰작성자 닉네임
	private Date writeDate; // 리뷰작성일
	private String rating;
}
