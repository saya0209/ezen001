package org.zerock.community.service;

import java.util.List;

import org.zerock.community.vo.CommunityVO;
import org.zerock.util.page.PageObject;

public interface CommunityService {
	
	// 1. 커뮤니티 게시판 리스트
	public List<CommunityVO> list(PageObject pageObject);
	
	// 2. 커뮤니티 게시판 글보기
	public CommunityVO view(Long community_no, int inc);
//	public CommunityVO view(Long community_no);
	
	// 3. 커뮤니티 게시판 글등록
	public Integer write(CommunityVO vo);
	
	// 4. 커뮤니티 게시판 글수정
	public Integer update(CommunityVO vo);
	
	// 5. 커뮤니티 게시판 글삭제
	public Integer delete(Long community_no);
	
	
////////////////////////////////////////////////////////

	// 좋아요/싫어요
	public Integer updateLike(Long community_no, int amount);
	public Integer updateDislike(Long community_no, int amount);
}

