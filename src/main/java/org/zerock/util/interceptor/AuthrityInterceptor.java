package org.zerock.util.interceptor;					
					
import java.util.HashMap;					
import java.util.Map;					
					
import javax.servlet.http.HttpServletRequest;					
import javax.servlet.http.HttpServletResponse;					
import javax.servlet.http.HttpSession;					
					
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;					
import org.zerock.member.vo.LoginVO;					
					
import lombok.extern.log4j.Log4j;					
					
@Log4j					
public class AuthrityInterceptor extends HandlerInterceptorAdapter {					
							
	private Map<String, Integer> authMap = new HashMap<String, Integer>();				
					
	// 권한 정보를 등록하는 초기화 블럭				
	{				
		// 등급이 1 이상이면 로그인이 필요, 등급이 9이면 관리자 권한 필요
		//로그인 권한 필요	
			//카트 - 리스트, 수정, 상품선택, 결제창, 결제완료, 결제내역, 결제내역 상세, 추가, 결제추가, 삭제
			authMap.put("/cart/list.do", 1);
			authMap.put("/cart/list/{id}", 1);
			authMap.put("/cart/updateCartItem", 1);
			authMap.put("/cart/updateSelection", 1);
			authMap.put("/cart/paymentForm.do", 1);
			authMap.put("/cart/completePayment/{id}", 1);
			authMap.put("/cart/history", 1);
			authMap.put("/cart/history/detail/{orderNumber}", 1);
			authMap.put("/cart/add", 1);
			authMap.put("/cart/addbuy", 1);
			authMap.put("/cart/removeCartItem", 1);
			//커뮤니티 - 작성, 수정, 삭제, 파일삭제, 좋아요, 싫어요
			authMap.put("/community/write.do", 1);	
			authMap.put("/community/update.do", 1);	
			authMap.put("/community/delete.do", 1);	
			authMap.put("/community/deleteFile.do", 1);	
			authMap.put("/community/updateLike.do", 1);	
			authMap.put("/community/updateDislike.do", 1);	
			//커뮤니티댓글 - 작성, 수정, 삭제
			authMap.put("/communityreply/write.do", 1);			
			authMap.put("/communityreply/update.do", 1);			
			authMap.put("/communityreply/delete.do", 1);
			authMap.put("/communityreply/like.do", 1);
			authMap.put("/communityreply/dislike.do", 1);
			//회원 - 마이페이지, 회원가입, 내정보수정, 사진수정, 회원탈퇴
			authMap.put("/member/mypageMain.do", 1);
			authMap.put("/member/write.do", 1);
			authMap.put("/member/update.do", 1);
			authMap.put("/member/changePhoto.do", 1);
			authMap.put("/member/delete.do", 1);
			//견적 - 작성, 수정, 삭제
			authMap.put("/estimate/write.do", 1);
			authMap.put("/estimate/update.do", 1);
			authMap.put("/estimate/delete.do", 1);
			//굿즈 - 카트담기
			authMap.put("/goods/addCart.do", 1);
			//굿즈리뷰 - 작성, 수정, 삭제
			authMap.put("/goodsReview/write.do", 1);			
			authMap.put("/goodsReview/update.do", 1);			
			authMap.put("/goodsReview/delete.do", 1);
			//QnA - 작성, 삭제
			authMap.put("/qna/write.do", 1);
			authMap.put("/qna/delete.do", 1);
			
			
						
		// 로그아웃		
			//authMap.put("/member/logout.do", 1);

					
		//관리자 권한 필요						
			//회원 - 회원관리, 등급수정, 상태수정
			authMap.put("/member/list.do", 9);																			
			authMap.put("/member/changeGradeNo.do", 9);
			authMap.put("/member/changeStatus.do", 9);
			//카테고리 - 리스트, 작성, 수정, 삭제
			authMap.put("/category/list.do", 9);
			authMap.put("/category/write.do", 9);
			authMap.put("/category/update.do", 9);
			authMap.put("/category/delete.do", 9);
			//견적 - 답변작성, 답변수정, 답변삭제
			authMap.put("/estimate/writeAnswer.do", 9);
			authMap.put("/estimate/updateAnswer.do", 9);
			authMap.put("/estimate/deleteAnswer.do", 9);
			//이벤트 - 작성, 수정, 삭제, 파일삭제
			authMap.put("/event/write.do", 9);
			authMap.put("/event/update.do", 9);
			authMap.put("/event/delete.do", 9);
			authMap.put("/event/deleteFile.do", 9);
			//굿즈 - 작성, 이미지수정, 이미지삭제, 삭제
			authMap.put("/goods/write.do", 9);
			authMap.put("/goods/updateImage.do", 9);
			authMap.put("/goods/deleteImage.do", 9);
			authMap.put("/goods/delete.do", 9);
			//공지사항 - 작성, 수정, 삭제
			authMap.put("/notice/write.do", 9);
			authMap.put("/notice/update.do", 9);
			authMap.put("/notice/delete.do", 9);
			//QnA - 답변작성, 답변삭제
			authMap.put("/qna/writeAnswer.do", 9);
			authMap.put("/qna/deleteAnswer.do", 9);
			
	}				
					
	@Override				
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)				
			throws Exception {		
		// 권한 처리 진행 로그			
		log.info("==== 권한 처리 interceptor =========================");			
					
		// 현재 URI 가져와서 필요한 페이지 권한 확인			
		String uri = request.getRequestURI();			
		Integer pageGrade = authMap.get(uri);			
					
		// 페이지에 특정 등급의 권한이 필요할 경우			
		if (pageGrade != null) {			
			HttpSession session = request.getSession();		
			LoginVO vo = (LoginVO) session.getAttribute("login");		
					
			// 로그인하지 않은 경우		
			if (vo == null) {		
				// 로그인 오류 페이지로 이동	
				request.getRequestDispatcher("/WEB-INF/views/error/loginError.jsp").forward(request, response);	
				return false;	
			}		
					
			// 로그인된 사용자의 권한 등급 확인		
			Integer userGrade = vo.getGradeNo();		
					
			// 사용자 등급이 페이지 권한보다 낮은 경우 접근 차단		
			if (pageGrade > userGrade) {		
				// 관리자가 필요한 페이지에 일반 사용자가 접근하려는 경우	
				if (pageGrade == 9 && userGrade < 9) {	
					request.getRequestDispatcher("/WEB-INF/views/error/authError.jsp").forward(request, response);
				} else {	
					// 일반 권한 오류 페이지로 이동
					request.getRequestDispatcher("/WEB-INF/views/error/authError.jsp").forward(request, response);
				}	
				return false;	
			}		
		}			
					
		// 권한 조건을 모두 만족하면 요청을 이어감			
		return super.preHandle(request, response, handler);			
	}				
}					
					
