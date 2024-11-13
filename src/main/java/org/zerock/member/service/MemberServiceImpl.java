package org.zerock.member.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.member.mapper.MemberMapper;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public LoginVO login(LoginVO vo) {
		// TODO Auto-generated method stub
		return mapper.login(vo);
	}

	@Override
	public List<MemberVO> list(PageObject pageObject) {
		// TODO Auto-generated method stub
		return mapper.list(pageObject);
	}

	@Override
	public Object view(String id) {
		// TODO Auto-generated method stub
		return mapper.view(id);
	}

	@Override
	public Integer write(MemberVO vo) {
		Integer result = mapper.write(vo);
		// TODO Auto-generated method stub
		return result;
	}

	@Override
	public Integer update(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer changeGradeNo(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeGradeNo(vo);
	}

	@Override
	public Integer changeStatus(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeStatus(vo);
	}

	@Override
	public Integer delete(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

	@Override
	public Integer updateConDate(String id) {
		// TODO Auto-generated method stub
		return mapper.updateConDate(id);
	}

	@Override
	public boolean checkId(String id) {
		// TODO Auto-generated method stub
		return mapper.checkId(id) > 0;
	}


}
