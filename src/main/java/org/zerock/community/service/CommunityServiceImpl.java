package org.zerock.community.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.community.mapper.CommunityMapper;
import org.zerock.community.vo.CommunityVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

// @Controller, RestController - uri
// @Service
// @Repository
// @Component
// @~~Advice
@Service
@Log4j
@Qualifier("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService {
	
	// 자동 DI @Setter+ spring, @Autowired (spring), @Inject (라이브러리) 
	@Inject
	private CommunityMapper mapper;

	// 1. 일반 게시판 리스트
	@Override
	public List<CommunityVO> list(PageObject pageObject) {
		log.info("list() 실행 =====");
		// 전체 데이터 개수 구해서(startRow와 endRow가 세팅된다) controller에 넘긴다.
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		
		// 총 게시글 수 로그 출력
	    log.info("list() 실행 ===== 총 게시글 수: " + pageObject.getTotalRow());
		return mapper.list(pageObject);
	}
	
	// 2. 일반 게시판 글보기
	@Override
	public CommunityVO view(Long community_no, int inc) {
	    log.info("view() 실행 =====");
	    log.info("community_no: " + community_no);
	    if (inc == 1) {
	        mapper.increase(community_no);
	    }
	    CommunityVO community = mapper.view(community_no);
	    log.info("CommunityVO: " + community);
//	    return community;
	    return mapper.view(community_no);
	}

//	@Override
//	public CommunityVO view(Long community_no, int inc) {
//		log.info("view() 실행 =====");
//		
//		// community_no가 null일 경우 예외 처리
//        if (community_no == null) {
//            throw new IllegalArgumentException("Community number cannot be null");
//        }
//        
//		// 조회수 증가
//		if (inc == 1) mapper.increase(community_no);
//		// 글정보 가져오기
//		return mapper.view(community_no);
//	}
	
	// 3. 일반 게시판 글등록
	@Override
	public Integer write(CommunityVO vo) {
		// 글 등록을 위한 mapper 호출
	    Integer result = mapper.write(vo);
	    log.info("write() 실행 =====");
	    return result;
	}

	// 4. 일반 게시판 글수정
	@Override
	public Integer update(CommunityVO vo) {
	    log.info("update() 실행 =====");
	    return mapper.update(vo);  // 게시물 수정 쿼리 호출
	}

	
	// 5. 일반 게시판 글삭제
	@Override
	public Integer delete(Long community_no) {
	    log.info("delete() 호출됨: community_no = " + community_no);
	    return mapper.delete(community_no);  // 게시글 삭제
	}

	
////////////////////////////////////////////////////////
	
	// 좋아요/싫어요
	@Override
	public Integer updateLike(Long community_no, int amount) {
	    return mapper.updateLike(community_no, amount);
	}

	@Override
	public Integer updateDislike(Long community_no, int amount) {
	    return mapper.updateDislike(community_no, amount);
	}
	
	@Override
	public Map<String, Object> processReaction(Long communityNo, String id, String reactionType) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        // 현재 사용자의 기존 반응 확인
	        String existingReaction = mapper.checkUserReaction(communityNo, id);
	        
	        if (existingReaction == null) {
	            // 처음 반응하는 경우
	            mapper.insertReaction(communityNo, id, reactionType);
	        } else if (existingReaction.equals(reactionType)) {
	            // 같은 반응을 다시 클릭한 경우 (취소)
	            mapper.deleteReaction(communityNo, id);
	        } else {
	            // 다른 반응에서 변경
	            mapper.deleteReaction(communityNo, id);
	            mapper.insertReaction(communityNo, id, reactionType);
	        }
	        
	        // 좋아요/싫어요 카운트 업데이트
	        if (reactionType.equals("like")) {
	            mapper.updateLike(communityNo, 0);  // 0을 전달하여 카운트 다시 계산
	            result.put("likeCnt", mapper.view(communityNo).getLikeCnt());
	        } else {
	            mapper.updateDislike(communityNo, 0);  // 0을 전달하여 카운트 다시 계산
	            result.put("dislikeCnt", mapper.view(communityNo).getDislikeCnt());
	        }
	        
	        result.put("status", "success");
	    } catch (Exception e) {
	        result.put("status", "error");
	        result.put("message", "처리 중 오류가 발생했습니다.");
	        log.error("Reaction processing error", e);
	    }
	    
	    log.info("result : " + result);
	    return result;
	}
}

