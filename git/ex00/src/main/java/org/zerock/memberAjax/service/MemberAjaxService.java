package org.zerock.memberAjax.service;

import java.util.List;

import org.zerock.cart.vo.CartItemVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

public interface MemberAjaxService {
	
	// 장바구니 보기
	public List<CartItemVO> viewCart(String id);
	
	// 내 정보 보기
	public Object viewMember(String id);

}
