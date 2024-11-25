package org.zerock.event.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.event.mapper.EventMapper;
import org.zerock.event.vo.EventVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("eventServiceImpl")
public class EventServiceImpl implements EventService {

    @Setter(onMethod_ = @Autowired)
    private EventMapper mapper;

    @Override
    public List<EventVO> list(PageObject pageObject) {
        log.info("페이지 개체 목록 가져오기 : " + pageObject);
        // 총 게시물 수를 페이지 객체에 설정
        pageObject.setTotalRow(mapper.getTotalRow(pageObject));
        return mapper.list(pageObject);
    }

    @Override
    public EventVO view(Long event_no) {
        log.info("이벤트 상세보기 : " + event_no);
        return mapper.view(event_no);
    }

    @Override
    public Integer write(EventVO vo) {
        log.info("이벤트 글 쓰기 : " + vo);
        return mapper.write(vo);
    }

    @Override
    public Integer update(EventVO vo) {
        log.info("이벤트 글 수정 : " + vo);
        return mapper.update(vo);
    }

    @Override
    public Integer delete(Long event_no) {
        log.info("삭제할 이벤트 번호 : " + event_no);
        return mapper.delete(event_no);
    }
}
