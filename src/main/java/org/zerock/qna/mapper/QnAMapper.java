package org.zerock.qna.mapper;

import java.util.List;
import org.zerock.qna.vo.QnAVO;
import org.zerock.util.page.PageObject;
import org.zerock.qna.vo.AnswerVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface QnAMapper {

    // QnA 전체 게시글 수
	// 게시판 리스트 페이지 처리를 위한 전체 데이터 개수를 가져온다.
	public Long getTotalRow(PageObject pageObject);

    // 1. QnA 리스트 조회
    public List<QnAVO> list(PageObject pageObject);

    // 2. QnA 게시글 상세 조회
    // 글 보기
 	public QnAVO view(Long qna_no);

    // 3. QnA 게시글 작성
    public Integer write(QnAVO vo);

    
    // 4. QnA 게시글 수정
    public Integer update(QnAVO vo);

    // 5. QnA 게시글 삭제
    public Integer delete(Long qna_no);

    // 6. QnA에 대한 답변 목록 조회
    public List<AnswerVO> getAnswersByQnaNo(Long qna_no);

    // 7. 답변 작성
    public Integer writeAnswer(AnswerVO vo);
    
    // 7-2 답변 상태 업데이트
    public Integer updateStatus(Long qna_no, String status);
    
    // 7-3 글 확인 상태 업데이트
    public Integer updateViewStatus(@Param("qna_no") Long qna_no, @Param("id") String id);

    // 9. 답변 수정
    public Integer updateAnswer(AnswerVO vo);

    // 10. 답변 삭제
    public Integer deleteAnswer(Long answer_no);
}
