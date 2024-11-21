package org.zerock.member.service;

import java.util.List;

import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

public interface MemberService {

	// 로그인
	public LoginVO login(LoginVO vo);
	
	// 회원리스트
	public List<MemberVO> list(PageObject pageObject);
	
	// 회원정보 보기
	public Object view(String id);

	public Object write(MemberVO vo);

	public Integer update(MemberVO vo);
	
	public Integer changeGradeNo(MemberVO vo);

	public Integer changeStatus(MemberVO vo);

	public Integer delete(MemberVO vo);

	public Integer updateConDate(String id);

	public boolean selectId(String id);

	public Integer changePhoto(MemberVO vo);

}
