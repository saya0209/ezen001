package org.zerock.qna.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.qna.mapper.QnAMapper;
import org.zerock.qna.vo.QnAVO;
import org.zerock.util.page.PageObject;
import org.zerock.qna.vo.AnswerVO;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("qnaServiceImpl")
public class QnAServiceImpl implements QnAService {

	@Inject
//    @Autowired
    private QnAMapper mapper;

    // 1. QnA 게시글 리스트 조회
//    @Override
//    public List<QnAVO> list(PageObject pageObject) {
//        log.info("list() 실행 =====");
//        pageObject.setTotalRow(mapper.getTotalRow(pageObject));
//		return mapper.list(pageObject);
//    }
//    
    @Override
    public List<QnAVO> list(PageObject pageObject) {
        log.info("list() 실행 =====");
        pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        // 총 게시글 수 로그 출력
	    log.info("list() 실행 ===== 총 게시글 수: " + pageObject.getTotalRow());
		return mapper.list(pageObject);
    }


    // 2. QnA 게시글 상세 조회
    @Override
    public QnAVO view(Long qna_no) {
        log.info("view() 실행 =====");
        log.info("qna_no: " + qna_no);
     	// 글정보 가져오기
        return mapper.view(qna_no);
    }

    // 3. QnA 게시글 작성
    @Override
    public Integer write(QnAVO vo) {
        if (vo.getStatus() == null) {
            vo.setStatus("waiting"); // 기본값 설정
        }
        log.info("write() 실행 =====");
        return mapper.write(vo);
    }


    // 4. QnA 게시글 수정
    @Override
    public Integer update(QnAVO vo) {
        log.info("update() 실행 =====");
        return mapper.update(vo);
    }

    // 5. QnA 게시글 삭제
    @Override
    public Integer delete(Long qna_no) {
        log.info("delete() 실행 =====");
        return mapper.delete(qna_no);
    }

//////////////  답변  //////////////////////////////////////////////////
    
    // 6. 답변 목록 조회
    @Override
    public List<AnswerVO> getAnswersByQnaNo(Long qna_no) {
        log.info("getAnswersByQnaNo() 실행 =====");
        return mapper.getAnswersByQnaNo(qna_no);
    }

    // 7. 답변 작성
    @Override
    public Integer writeAnswer(AnswerVO vo) {
        log.info("writeAnswer() 실행 =====");
        return mapper.writeAnswer(vo);
    }
    
    // 7-1 답변상태 업데이트
    @Override
    public Integer updateStatus(Long qna_no, String status) {
        log.info("updateStatus() 실행 =====");
        return mapper.updateStatus(qna_no, status);
    }

    // 7-3 글 확인 상태 업데이트
    @Override
    public Integer updateViewStatus(Long qna_no, String id) {
        log.info("updateViewStatus() 실행 =====");
        return mapper.updateViewStatus(qna_no, id);
    }
    
    // 8. 답변 수정
    @Override
    public Integer updateAnswer(AnswerVO vo) {
        log.info("updateAnswer() 실행 =====");
        return mapper.updateAnswer(vo);
    }

    // 9. 답변 삭제
    @Override
    public Integer deleteAnswer(Long answer_no) {
        log.info("deleteAnswer() 실행 =====");
        return mapper.deleteAnswer(answer_no);
    }

}
