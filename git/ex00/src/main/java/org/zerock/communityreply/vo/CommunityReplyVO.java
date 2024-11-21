package org.zerock.communityreply.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityReplyVO {

	private Long rno;           // 댓글 번호
    private Long post_no;       // 게시물 번호
    private Long parent_no;     // 부모 댓글 번호 (답글을 위한 필드)
    private String id;          // 댓글 작성자 (회원 ID)
    private String nicname;		// 댓글작성자 이름
    private String content;     // 댓글 내용
    private Date writeDate;     // 작성일
    private Date updateDate;    // 수정일
    private Long likeCnt;       // 좋아요 수
    private Long dislikeCnt;    // 싫어요 수
    private String image;       // 이미지 URL (있을 경우) 
}
