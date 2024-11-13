package org.zerock.community.vo;

import java.util.Date;

import org.zerock.vo.AttachFileVO;

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
	private Date writeDate;
	private Long hit;
	private Date updateDate;
	private Long likeCnt;       // 좋아요 수
    private Long dislikeCnt;    // 싫어요 수
	private String image;
	
	// AttachFileVO 추가
    private AttachFileVO attachFile;  // 파일 정보를 담을 필드 추가
}
