package org.zerock.board.service;

import java.util.List;

import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

public interface BoardService {
	
	// 1. 일반 게시판 리스트
	public List<BoardVO> list(PageObject pageObject);
	
	// 2. 일반 게시판 글보기
	public BoardVO view(Long no, int inc);
	
	// 3. 일반 게시판 글등록
	public Integer write(BoardVO vo);
	
	// 4. 일반 게시판 글수정
	public Integer update(BoardVO vo);
	
	// 5. 일반 게시판 글삭제
	public Integer delete(BoardVO vo);
}










