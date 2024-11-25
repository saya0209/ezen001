package org.zerock.event.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.event.vo.EventVO;
import org.zerock.util.page.PageObject;

@Repository
public interface EventMapper {

    // 1. 이벤트 리스트
    // 1-1. 이벤트 총 개수
    public Long getTotalRow(PageObject pageObject);

    // 1-2. 이벤트 리스트
    public List<EventVO> list(PageObject pageObject);

    // 2. 이벤트 상세보기
    public EventVO view(Long event_no);

    // 3. 이벤트 글 쓰기
    public Integer write(EventVO vo);

    // 4. 이벤트 글 수정
    public Integer update(EventVO vo);

    // 5. 이벤트 글 삭제
    public Integer delete(Long event_no);
}
