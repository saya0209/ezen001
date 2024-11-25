package org.zerock.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EventVO {
    private Long event_no;                   // 이벤트 번호
    private String id;             			 // 작성자 ID
    private String title;                    // 이벤트 제목
    private String content;                  // 이벤트 내용
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date writeDate;                  // 작성일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;                  // 시작일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;                    // 종료일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateDate;                 // 최근 수정일
    private String files;                    // 첨부 파일 경로
    private String status;                   // 이벤트 상태 (예: UPCOMING, ONGOING, COMPLETED)
    private String category;                 // 이벤트 카테고리 (예: PROMOTION, EVENT, SEMINAR)
    
}
