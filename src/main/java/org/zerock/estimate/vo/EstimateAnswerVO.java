package org.zerock.estimate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EstimateAnswerVO {
	private Long answer_no;        // 답변 번호
	private String id;             // 답변 작성자 ID
	private String nicname; // member 테이블에서 JOIN으로 가져올 데이터
	private String title;          // 답변 제목
	private String content;        // 답변 내용
	private Long total_price;      // 견적 총 가격
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date answer_date;      // 답변 작성일
	private Long reNo;             // 참조 답변 번호
	private Integer ordNo;            // 답변 순서
	private Integer levNo;            // 답변 깊이
	private Long parentNo;         // 참조 요청 번호
}