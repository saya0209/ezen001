package org.zerock.communityreply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.communityreply.vo.CommunityReplyVO;
import org.zerock.util.page.PageObject;

@Repository
public interface CommunityReplyMapper {

    // 1-1. 전체 데이터 개수 조회 (댓글 수)
    public Long getTotalRow(
        @Param("pageObject") PageObject pageObject,
        @Param("post_no") Long post_no);  // 게시글 번호로 댓글 수 조회

    // 1-2. 댓글 목록 조회
    public List<CommunityReplyVO> list(
        @Param("pageObject") PageObject pageObject,
        @Param("post_no") Long post_no);  // 게시글 번호로 댓글 목록 조회

    // 2. 댓글 작성
    public Integer write(CommunityReplyVO vo);  // 댓글 작성 (댓글 정보, 작성자, 게시글 번호)

    // 3. 댓글 수정
    public Integer update(CommunityReplyVO vo);  // 댓글 수정 (댓글 번호, 수정된 내용)

    // 4. 댓글 삭제
    public Integer delete(CommunityReplyVO vo);  // 댓글 삭제 (댓글 번호, 삭제할 작성자)

    
    //////////////////////////////////////////////////////////
    
    // 좋아요/싫어요
    public Integer updateLike(Long rno, int amount);
	public Integer updateDislike(Long rno, int amount);

	public CommunityReplyVO getReply(Long rno);

}
