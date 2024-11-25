package org.zerock.qna.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AnswerVO {
	
    private Long answer_no;
    private String id;
    private String nicname; // member 테이블에서 JOIN으로 가져올 데이터
    private String answer_title;
    private String answer_content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date answerDate;
    private Long refNo;
    private Integer ordNo;
    private Integer levNo;
    private Long parentNo;  // qna_no를 참조하는 외래키
}