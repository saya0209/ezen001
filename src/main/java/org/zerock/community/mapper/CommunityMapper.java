package org.zerock.community.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.community.vo.CommunityVO;
import org.zerock.util.page.PageObject;

@Repository
public interface CommunityMapper {

    // 1. 커뮤니티 게시판 리스트
    // 전체 데이터 개수를 가져와서 페이징 처리를 한다.
    public Long getTotalRow(PageObject pageObject);
    
    // 리스트를 가져오는 쿼리 실행
    public List<CommunityVO> list(PageObject pageObject);
    
    // 2. 커뮤니티 게시판 글보기
    // 조회수 증가
    public Integer increase(Long community_no);
    
    // 글 보기 (글정보)
    public CommunityVO view(Long community_no);
    
    // 3. 커뮤니티 게시판 글쓰기
    public Integer write(CommunityVO vo);
    
    // 4. 커뮤니티 게시판 글수정
    public Integer update(CommunityVO vo);
    
    // 5. 커뮤니티 게시판 글삭제
	public Integer delete(CommunityVO vo);
//    public Integer delete(Long community_no);
	
	// 6-1. 좋아요 증가
    public Integer increaseLike(Long community_no);
    // 6-2. 싫어요 증가
    public Integer increaseDislike(Long community_no);
    // 6-3. 좋아요 취소
    public Integer cancelLike(Long community_no);
    // 6-4. 싫어요 취소
    public Integer cancelDislike(Long community_no);
}










