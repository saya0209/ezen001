package org.zerock.event.service;

import java.util.List;

import org.zerock.event.vo.EventVO;
import org.zerock.util.page.PageObject;

public interface EventService {

    // 1. 이벤트 리스트
    public List<EventVO> list(PageObject pageObject);

    // 2. 이벤트 글 보기
    public EventVO view(Long event_no);

    // 3. 이벤트 글 쓰기
    public Integer write(EventVO vo);

    // 4. 이벤트 글 수정
    public Integer update(EventVO vo);

    // 5. 이벤트 글 삭제
    public Integer delete(Long event_no);
}
