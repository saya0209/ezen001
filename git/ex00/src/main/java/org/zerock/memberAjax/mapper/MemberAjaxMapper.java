package org.zerock.memberAjax.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

@Repository
public interface MemberAjaxMapper {

	//내 정보 보기/수정
	public List<CartItemVO> viewCart(String id);

	public Object viewMember(String id);
}
