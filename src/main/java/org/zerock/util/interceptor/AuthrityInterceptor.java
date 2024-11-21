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
		
		// 댓글 관련 기능 (로그인 권한 필요)			
		authMap.put("/goodsreply/write.do", 1);			
		authMap.put("/goodsreply/update.do", 1);			
		authMap.put("/goodsreply/delete.do", 1);			
		authMap.put("/communityreply/write.do", 1);			
		authMap.put("/communityreply/update.do", 1);			
		authMap.put("/communityreply/delete.do", 1);
					
		// 관리자 전용 페이지 (관리자 등급 필요)							
		authMap.put("/member/list.do", 9);										
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
					
