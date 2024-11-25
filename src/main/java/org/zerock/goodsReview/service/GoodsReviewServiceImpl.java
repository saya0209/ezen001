package org.zerock.goodsReview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.goodsReview.mapper.GoodsReviewMapper;
import org.zerock.goodsReview.vo.GoodsReviewVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;

// 자동생성 어노테이션
// @Controller, @RestController
// @Service
// @Repository
// @Component
// @~~Advice
@Service
@Qualifier("boardReplyServiceImpl")
public class GoodsReviewServiceImpl implements GoodsReviewService {

	// 자동 DI
	@Setter(onMethod_ = @Autowired)
	private GoodsReviewMapper mapper;
	
	@Override
	public List<GoodsReviewVO> list(PageObject pageObject, Long no) {
		// TODO Auto-generated method stub
		// 전체 데이터 세팅 - 페이지 처리를 위해서
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, no));
		return mapper.list(pageObject, no);
	}

	@Override
	public Integer write(GoodsReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(GoodsReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(GoodsReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}
	
	@Override
	public Integer checkReviewExists(GoodsReviewVO vo) {
	    return mapper.checkReviewExists(vo);
	}

}
