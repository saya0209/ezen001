package org.zerock.community.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommunityVO {

	private Long community_no;
	private String id;
	private String nicname;
	private String title;
	private String content;
	// sql 과 java의 Date 구조가 달라서 캐스팅이 필요하다.
	// spring에서는 자동으로 캐스팅 해준다.
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
	private Long hit;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updateDate;
	private Long likeCnt;       // 좋아요 수
    private Long dislikeCnt;    // 싫어요 수
	private String image;
}
