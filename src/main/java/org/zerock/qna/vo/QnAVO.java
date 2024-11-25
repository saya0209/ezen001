package org.zerock.qna.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class QnAVO {

	private Long qna_no;
    private String id;
    private String nicname; // member 테이블의 닉네임
    private String title;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date writeDate;
    private String category;	// 질문 유형 (배송, 환불 등)
//    private String status;		// 답변 상태 (waiting: 답변대기, completed: 답변완료)
    private String status;		// 답변 상태 (waiting: 답변대기, completed: 답변완료)
	
}


