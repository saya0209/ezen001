package org.zerock.communityreply.service;

import java.util.List;

import org.zerock.communityreply.vo.CommunityReplyVO;
import org.zerock.util.page.PageObject;

public interface CommunityReplyService {

    // 댓글 목록 조회
    public List<CommunityReplyVO> list(PageObject pageObject, Long post_no);
    
    // 댓글 작성
    public Integer write(CommunityReplyVO vo);

    // 댓글 수정
    public Integer update(CommunityReplyVO vo);

    // 댓글 삭제
    public Integer delete(CommunityReplyVO vo);

////////////////////////////////////////////////////////

    // 좋아요/싫어요
	public Integer updateLike(Long rno, int amount);
	public Integer updateDislike(Long rno, int amount);

	CommunityReplyVO getReply(Long rno);





}
