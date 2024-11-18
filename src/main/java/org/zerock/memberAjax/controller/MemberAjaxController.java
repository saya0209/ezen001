package org.zerock.memberAjax.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.cart.vo.HistoryVO;
import org.zerock.member.service.MemberService;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.memberAjax.service.MemberAjaxService;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/memberAjax")
public class MemberAjaxController {

	@Autowired
	@Qualifier("memberAjaxServiceImpl")
	private MemberAjaxService service;
	
	// 10. 마이페이지 - 주문내역 보기
	@GetMapping("/mypageMenu1.do")
	public String mypageMenu1(Model model, @RequestParam("id") String id) {
		log.info("========= mypageMenu1.do ============");
		log.info("★★★★★★★★★★★★★★★★★id = "+id);
        List<HistoryVO> paymentHistory = service.getPaymentHistory(id);
        
        model.addAttribute("paymentHistory", paymentHistory);
		model.addAttribute("id", id);
		log.info("★★★★★★★★★★★★★★★★★History Data: " + service.getPaymentHistory(id));
		return "memberAjax/mypageMenu1";
	}
	
	
	// 9. 마이페이지 - 장바구니 보기
	@GetMapping("/mypageMenu2.do")
	public String mypageMenu2(Model model, @RequestParam("id") String id) {
		log.info("========= mypageMenu2.do ============");
		log.info("★★★★★★★★★★★★★★★★★id = "+id);
		model.addAttribute("cartItems", service.viewCart(id));
		model.addAttribute("id", id);
		log.info("★★★★★★★★★★★★★★★★★Cart Data: " + service.viewCart(id));
		return "memberAjax/mypageMenu2";
	}
	
	
	// 11. 마이페이지 회원정보 보기
	@GetMapping("/mypageMenu3.do")
	public String mypageMenu3(Model model, String id) {
		log.info("========= mypageMenu3.do ============");
		log.info("id = "+id);
		model.addAttribute("vo", service.viewMember(id));
		return "memberAjax/mypageMenu3";
	}
	
	
}






