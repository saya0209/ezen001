package org.zerock.estimate.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.estimate.mapper.EstimateMapper;
import org.zerock.estimate.vo.EstimateAnswerVO;
import org.zerock.estimate.vo.EstimateRequestVO;
import org.zerock.util.page.PageObject;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("estimateServiceImpl")
public class EstimateServiceImpl implements EstimateService {

    @Inject
    private EstimateMapper mapper;

    // 1. Request 리스트 조회 (페이징 처리 포함)
    @Override
    public List<EstimateRequestVO> list(PageObject pageObject) {
        log.info("list() 실행 =====");
        // 페이지 객체에 전체 데이터 개수를 설정하여 페이징 처리를 수행
        pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        return mapper.list(pageObject);
    }

    // 2. Request 상세 조회
    @Override
    public EstimateRequestVO view(Long request_no) {
        log.info("view() 실행 =====");
        return mapper.view(request_no);
    }

    // 3. Request 작성 (데이터베이스에 저장)
    @Override
    public Integer write(EstimateRequestVO vo) {
        log.info("write() 실행 =====");
        return mapper.write(vo);
    }

    // 4. Request 수정 (업데이트)
    @Override
    public Integer update(EstimateRequestVO vo) {
        log.info("update() 실행 =====");
        return mapper.update(vo);
    }

    // 5. Request 삭제
    @Override
    public Integer delete(Long request_no) {
        log.info("delete() 실행 =====");
        return mapper.delete(request_no);
    }

//////////////  답변  //////////////////////////////////////////////////
    
    // 6. Request 답변 목록 조회
    @Override
    public List<EstimateAnswerVO> getAnswersByRequestNo(Long request_no) {
        log.info("getAnswersByRequestNo() 실행 =====");
        return mapper.getAnswersByRequestNo(request_no);
    }

    // 7. Answer 작성 (데이터베이스에 저장)
    @Override
    public Integer writeAnswer(EstimateAnswerVO vo) {
        log.info("writeAnswer() 실행 =====");
        return mapper.writeAnswer(vo);
    }

    // 8. Answer Status 업데이트
    @Override
    public Integer updateStatus(Long request_no, String status) {
        log.info("updateStatus() 실행 =====");
        return mapper.updateStatus(request_no, status);
    }
    
    // 9. 글 확인 Status 업데이트 
    @Override
    public Integer updateViewStatus(Long request_no, String id) {
        log.info("updateViewStatus() 실행 =====");
        return mapper.updateViewStatus(request_no, id);
    }
    
    // 10. Answer 수정 (업데이트)
    @Override
    public Integer updateAnswer(EstimateAnswerVO vo) {
        log.info("updateAnswer() 실행 =====");
        return mapper.updateAnswer(vo);
    }

    // 11. Answer 삭제
    @Override
    public Integer deleteAnswer(Long answer_no) {
        log.info("deleteAnswer() 실행 =====");
        return mapper.deleteAnswer(answer_no);
    }
}
