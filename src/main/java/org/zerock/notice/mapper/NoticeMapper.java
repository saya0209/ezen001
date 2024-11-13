package org.zerock.notice.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

@Repository
public interface NoticeMapper {

	// 1. 이벤트(공지사항) 리스트
	// 1-1. 이벤트(공지사항) getTotalRow
	public Long getTotalRow(PageObject pageObject);
	// 1-2. 리스트
	public List<NoticeVO> list(PageObject pageObject);

	// 2. 이벤트(공지사항) 상세보기
	public NoticeVO view(Long notice_no);

	// 3. 이벤트(공지사항) 글 쓰기
	public Integer write(NoticeVO vo);
	
	// 4. 이벤트(공지사항) 글 수정
	public Integer update(NoticeVO vo);
	
	// 5. 이벤트(공지사항) 글 삭제
	public Integer delete(Long notice_no);
}
