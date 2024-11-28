package org.zerock.estimate.mapper;

import java.util.List;

import org.zerock.estimate.vo.EstimateAnswerVO;
import org.zerock.estimate.vo.EstimateRequestVO;
import org.zerock.util.page.PageObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface EstimateMapper {

    // 1. 견적 요청 관련

    // 1. 리스트 페이지 처리를 위한 전체 데이터 개수를 가져온다.
    public Long getTotalRow(PageObject pageObject);

    // 2. Request 리스트 조회
    public List<EstimateRequestVO> list(PageObject pageObject);

    // 3. Request 상세 조회
    public EstimateRequestVO view(Long request_no);

    // 4. Request 작성 (데이터베이스에 저장)
    public Integer write(EstimateRequestVO vo);

    // 5. Request 수정 (업데이트)
    public Integer update(EstimateRequestVO vo);

    // 6. Request 삭제
    public Integer delete(Long request_no);

    
    // 2. 견적 요청에 대한 답변 관련

    // 1. Request에 대한 답변 목록 조회
    public List<EstimateAnswerVO> getAnswersByRequestNo(Long request_no);

    // 2. Answer 생성 (데이터베이스에 저장)
    public Integer writeAnswer(EstimateAnswerVO vo);

    // 3. Answer 상태 업데이트
    public Integer updateStatus(Long request_no, String status);

    // 7-3 글 확인 상태 업데이트
    public Integer updateViewStatus(@Param("request_no") Long request_no, @Param("id") String id);

    // 4. Answer 수정 (업데이트)
    public Integer updateAnswer(EstimateAnswerVO vo);

    // 5. Answer 삭제
    public Integer deleteAnswer(Long answer_no);
}
