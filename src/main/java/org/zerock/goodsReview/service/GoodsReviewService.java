package org.zerock.goodsReview.service;

import java.util.List;

import org.zerock.boardreply.vo.BoardReplyVO;
import org.zerock.goodsReview.vo.GoodsReviewVO;
import org.zerock.util.page.PageObject;

public interface GoodsReviewService {

	// 1. list
	public List<GoodsReviewVO> list(PageObject pageObject, Long no);
	// 2. write
	public Integer write(GoodsReviewVO vo);
	// 3. update
	public Integer update(GoodsReviewVO vo);
	// 4. delete
	public Integer delete(GoodsReviewVO vo);
	
	public Integer checkReviewExists(GoodsReviewVO vo);
}
