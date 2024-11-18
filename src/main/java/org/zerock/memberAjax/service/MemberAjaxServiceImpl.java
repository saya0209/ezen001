package org.zerock.memberAjax.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.cart.vo.CartItemVO;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.member.mapper.MemberMapper;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.memberAjax.mapper.MemberAjaxMapper;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("memberAjaxServiceImpl")
public class MemberAjaxServiceImpl implements MemberAjaxService {

	@Setter(onMethod_ = @Autowired)
	private MemberAjaxMapper mapper;
	
	//주문리스트 보기
	@Override
	public List<HistoryVO> getPaymentHistory(String id) {
		// TODO Auto-generated method stub
		return mapper.getPaymentHistory(id);
	}
	
	
	//장바구니 보기
	public List<CartItemVO> viewCart(String id) {
		// TODO Auto-generated method stub
		return mapper.viewCart(id);
	}
	
	// 내 정보 보기
	@Override
	public Object viewMember(String id) {
		// TODO Auto-generated method stub
		return mapper.viewMember(id);
	}


}
