package org.zerock.communityreply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.communityreply.mapper.CommunityReplyMapper;
import org.zerock.communityreply.vo.CommunityReplyVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("communityReplyServiceImpl")
public class CommunityReplyServiceImpl implements CommunityReplyService {

    @Setter(onMethod_ = @Autowired)
    private CommunityReplyMapper mapper;
    
    @Override
    public List<CommunityReplyVO> list(PageObject pageObject, Long post_no) {
//    	public List<CommunityReplyVO> list(PageObject pageObject, Long post_no) {
        // 전체 데이터 세팅 - 페이지 처리를 위해서
        pageObject.setTotalRow(mapper.getTotalRow(pageObject, post_no));  // 수정된 부분
        return mapper.list(pageObject, post_no);
    }

//	@Override
//	public Integer write(CommunityReplyVO vo) {
//		// 댓글 작성
//		return mapper.write(vo);
//	}
//
//	@Override
//	public Integer update(CommunityReplyVO vo) {
//		// 댓글 수정
//		return mapper.update(vo);
//	}

    @Transactional
    public Integer write(CommunityReplyVO vo) {
        return mapper.write(vo);
    }

    @Transactional
    public Integer update(CommunityReplyVO vo) {
        return mapper.update(vo);
    }
    
    @Override
    public Integer delete(CommunityReplyVO vo) {
        // 댓글 삭제
        return mapper.delete(vo);
    }

    
////////////////////////////////////////////////////////
    
    // 좋아요/싫어요
 	@Override
 	public Integer updateLike(Long rno, int amount) {
 	    return mapper.updateLike(rno, amount);
 	}

 	@Override
 	public Integer updateDislike(Long rno, int amount) {
 	    return mapper.updateDislike(rno, amount);
 	}

 	@Override
    public CommunityReplyVO getReply(Long rno) {
        if (rno == null) {
            throw new IllegalArgumentException("댓글 번호가 null입니다.");
        }
        CommunityReplyVO reply = mapper.getReply(rno);
        if (reply == null) {
            throw new RuntimeException("존재하지 않는 댓글입니다: " + rno);
        }
        return reply;
    }
}
