package org.zerock.member.mapper;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

@Repository
public interface MemberMapper {
	
	@Bean
	public static CommonsMultipartResolver multipartResolver() {
	    CommonsMultipartResolver resolver = new CommonsMultipartResolver();
	    resolver.setMaxUploadSize(10485760); // 10MB
	    return resolver;
	}

	// login
	public LoginVO login(LoginVO vo);

	public List<MemberVO> list(PageObject pageObject);

	public Object view(String id);
	
	public Integer write(MemberVO vo);

	public Integer update(MemberVO vo);

	public Integer changeGradeNo(MemberVO vo);

	public Integer changeStatus(MemberVO vo);

	public Integer delete(MemberVO vo);

	public Integer updateConDate(String id);

	public boolean selectId(String id);

	public Integer changePhoto(MemberVO vo);

}
