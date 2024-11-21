package org.zerock.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.notice.mapper.NoticeMapper;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {

	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;

	@Override
	public List<NoticeVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		log.info("페이지 개체 목록 가져오기 : " + pageObject);
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public NoticeVO view(Long notice_no) {
		// TODO Auto-generated method stub
		log.info("ID와 함께 notice 가져오는 중 : " + notice_no);
		return mapper.view(notice_no);
	}

	@Override
	public Integer write(NoticeVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(NoticeVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(Long notice_no) {
		// TODO Auto-generated method stub
		log.info("삭제할 notice_no: " + notice_no);
		return mapper.delete(notice_no);
	}

}
