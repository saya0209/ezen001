package org.zerock.memberAjax.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

@Repository
public interface MemberAjaxMapper {

	//내 주문목록 보기
	public List<HistoryVO> getPaymentHistory(String id);
	
	//내 장바구니 보기
	public List<CartItemVO> viewCart(String id);

	//내 정보 보기/수정
	public Object viewMember(String id);

}
