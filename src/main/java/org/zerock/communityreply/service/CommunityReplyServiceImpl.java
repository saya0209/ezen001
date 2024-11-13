package org.zerock.communityreply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
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
        // 전체 데이터 세팅 - 페이지 처리를 위해서
        pageObject.setTotalRow(mapper.getTotalRow(pageObject, post_no));  // 수정된 부분
        return mapper.list(pageObject, post_no);
    }

    @Override
    public Integer write(CommunityReplyVO vo) {
        // 댓글 작성
        return mapper.write(vo);
    }

    @Override
    public Integer update(CommunityReplyVO vo) {
        // 댓글 수정
        return mapper.update(vo);
    }

    @Override
    public Integer delete(CommunityReplyVO vo) {
        // 댓글 삭제
        return mapper.delete(vo);
    }

    @Override
    public Integer increaseLike(Long rno) {
        // 댓글 좋아요 증가
        return mapper.increaseLike(rno);
    }

    @Override
    public Integer increaseDislike(Long rno) {
        // 댓글 싫어요 증가
        return mapper.increaseDislike(rno);
    }
}
