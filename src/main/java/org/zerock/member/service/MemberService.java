package org.zerock.member.service;

import java.util.List;

import org.zerock.member.vo.LoginVO;
import org.zerock.util.page.PageObject;

public interface MemberService {

	// 로그인
	public LoginVO login(LoginVO vo);
	
	// 리스트
	public List<LoginVO> list(PageObject pageObject);
}
