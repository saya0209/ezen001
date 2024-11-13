package org.zerock.memberAjax.service;

import java.util.List;

import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

public interface MemberAjaxService {
	
	// 내 정보 보기
	public Object view(String id);

}
