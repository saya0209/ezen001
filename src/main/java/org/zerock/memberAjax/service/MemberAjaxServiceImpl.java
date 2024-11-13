package org.zerock.memberAjax.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
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
	
	@Override
	public Object view(String id) {
		// TODO Auto-generated method stub
		return mapper.view(id);
	}

}
