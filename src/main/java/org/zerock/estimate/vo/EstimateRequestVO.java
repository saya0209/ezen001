package org.zerock.estimate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EstimateRequestVO {
	private Long request_no;        // 견적 요청 번호
    private String id;             // 요청자 ID
    private String nicname; // member 테이블에서 JOIN으로 가져올 데이터
    private String title;          // 요청 제목
    private String content;        // 요청 상세 내용
    private String category;       // 요청 카테고리
    private Long budget;           // 예상 예산
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date request_date;     // 요청 작성일
    private String status;         // 요청 상태

}

