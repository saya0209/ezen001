package org.zerock.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long no;
	private String title;
	private String content;
	private String writer;
	// sql 과 java의 Date 구조가 달라서 캐스팅이 필요하다.
	// spring에서는 자동으로 캐스팅 해준다.
	private Date writeDate;
	private Long hit;
	private String pw;
	
}
