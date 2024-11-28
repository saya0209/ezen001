package org.zerock.estimate.service;

import java.util.List;
import org.zerock.util.page.PageObject;
import org.zerock.estimate.vo.EstimateAnswerVO;
import org.zerock.estimate.vo.EstimateRequestVO;

public interface EstimateService {

	// 1. request 게시글 리스트 조회 (페이징 처리 포함)
	public List<EstimateRequestVO> list(PageObject pageObject);

	// 2. Request 번호 상세 정보 조회
	public EstimateRequestVO view(Long request_no);

	// 3. Request 작성 (데이터베이스에 저장)
	public Integer write(EstimateRequestVO vo);

	// 4. Request 수정 (업데이트)
	public Integer update(EstimateRequestVO vo);

	// 5. Request 삭제
	public Integer delete(Long request_no);

	// 6. 답변 목록 조회
	public List<EstimateAnswerVO> getAnswersByRequestNo(Long request_no);

	// 7. 답변 작성 (데이터베이스에 저장)
	public Integer writeAnswer(EstimateAnswerVO vo);

	// 8. 답뼌 상태 업데이트
	public Integer updateStatus(Long request_no, String status);

	// 8-1. 글 확인 상태 업데이트
	public Integer updateViewStatus(Long request_no, String id);

	// 9. 답변 수정
	public Integer updateAnswer(EstimateAnswerVO vo);

	// 11. 특정 답변 삭제
	public Integer deleteAnswer(Long answer_no);

}
