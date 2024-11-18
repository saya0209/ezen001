<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 오진영 -->
<!-- 작성일 : 2024-11-01 -->
<!-- 최종수정일 : 2024-00-00 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!-- CSS -->
<c:set var="path" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMMAKASE:<decorator:title /></title>
   
    <!-- Custom CSS -->
    <link href="${path}/css/default_decorator.css" rel="stylesheet">
<%--     <link href="${path}/resources/css/default_decorator.css" rel="stylesheet"> --%>
   
    <!-- Bootstrap 4 + jQuery -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Datepicker : jquery -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- Google Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


	<style type="text/css">
		/* 기본 텍스트 색상 */
		body {
		    color: #002244;
		}
		
		/* 네비게이션 바 */
		.navbar {
		    background-color: #004080 !important;
		}
		.nav-link {
		    color: white !important; /* 텍스트 색을 흰색으로 */
		}
		.top-link {
		    color: #004080 !important; 
		}
		
		.nav-link:hover {
		    text-decoration: underline; /* 호버 시 밑줄 추가 */
		}
		
		/* "전체카테고리" 버튼 색상 */
		.category-button {
		    color: #fff;
		    cursor: pointer;
		    padding: 10px 15px;
		}
		.category-button:hover {
		    color: #fff;
		    
		}
		
		.category-center {
		    flex: 1;
		    display: flex;
		    justify-content: center; /* 중앙 정렬 */
		    gap: 10px; /* 중앙 메뉴 간격 */
		}
		
		.category-center a {
		    color: #fff;
		    font-size: 16px;
		    text-decoration: none;
		    font-weight: bold;
		    transition: color 0.3s;
		}
		
		/* 푸터 스타일 */
		footer {
		    background-color: #002244;
		    color: #d9e6f2;
		    padding: 20px;
		    text-align: center;
		    position: fixed;
 		    bottom: 0; /* 화면의 아래쪽에 위치 */ 
 		    left: 0;
		    width: 100%; /* 화면 너비를 꽉 채움 */
		}
		body {
			padding-bottom: 300px;
		}
		
		footer a {
		    color: #d9e6f2;
		    text-decoration: none;
		}
		
		footer a:hover {
		    color: #b3cde0;
		}

        /* 상단 로고 및 사용자 메뉴 */
        .header-top {
		    display: flex;
		    padding: 10px 20px;
		    background-color: #fff; /* 흰색 배경 */
		    border-bottom: 1px solid #ddd;
		    justify-content: center; /* 요소들을 중앙으로 정렬 */
		    align-items: center; /* 세로 중앙 정렬 */
		}
		
		.header-logo {
		    display: flex; /* flexbox 적용 */
		    justify-content: center; /* 수평 중앙 정렬 */
		    align-items: center; /* 수직 중앙 정렬 */
		    flex-grow: 1; /* 로고가 공간을 차지하도록 설정 */
		}
		
		.header-logo img {
		    max-width: 220px;
		    height: auto; /* 이미지의 비율을 유지하면서 크기를 조절 */
		}

        /* 사용자 메뉴 스타일 */
        .user-menu {
            display: flex;
            align-items: center;
            justify-content: flex-end; /* 오른쪽 정렬 추가 */	
        }

        .user-menu .nav-item {
            margin-left: 15px;
        }

        .user-menu a {
            color: #fff;
            font-size: 14px;
            text-decoration: none;
        }
        .user-menu a:hover {
            color: #6db33f;
        }

        /* 카테고리 메뉴 스타일 */
		.category-menu {
		    display: flex;
		    align-items: center;
		    justify-content: space-between; /* 왼쪽과 중앙3 정렬 */
		    background-color: #fff;
		    padding: 10px 0;
		    position: relative;
		}


		/* 사이드바 */
		.sidebar {
		    display: none;
		    position: absolute;
		    top: 255px;
		    left: 0; /* 왼쪽 정렬 */
		    background-color: #002244;
		    padding: 20px;
		    width: 250px;
		    color: white;
		}
		.sidebar a {
		    color: #d9e6f2;
		    display: block;
		    padding: 10px;
		    text-align: left; /* 왼쪽 정렬1 */
		    text-decoration: none;
		}
		.sidebar a:hover {
		    background-color: #004080;
		}
		
	</style>



<script type="text/javascript">
$(document).ready(function() {
    // 마우스를 "전체카테고리" 버튼에 올리면 사이드바를 표시
    $('.category-button').hover(
        function() {
            $('.sidebar').show();
        }
    );

    // 마우스가 사이드바에 올라가면 계속 표시
    $('.sidebar').hover(
        function() {
            $(this).show();
        },
        function() {
            $(this).hide(); // 마우스가 벗어날 때 사이드바 숨기기
        }
    );
});

</script>


    <!-- 개발자가 작성한 소스의 head 태그를 여기에 넣게 된다. title은 제외 -->
    <decorator:head/>
</head>

<body>
    	<div class="user-menu">
			<ul class="navbar-nav d-flex flex-row">
                <c:if test="${ empty login }">
                    <li class="nav-item">
						<a class="top-link" href="/member/loginForm.do">
						<i class="fa fa-sign-in"></i> 로그인</a>
					</li>
						<li class="nav-item">
							<a class="top-link" href="/member/writeForm.do">
							<i class="fa fa-address-card-o"></i> 회원가입</a>
						</li>
<!-- 						<li class="nav-item"> -->
<!-- 							<a class="nav-link" href="/member/searchID.do"> -->
<!-- 							<i class="fa fa-search"></i>아이디/비밀번호 찾기</a> -->
<!-- 						</li> -->
                </c:if>
                <c:if test="${ !empty login }">
                    <li class="nav-item">
                        <span class="top-link">
                            <c:if test="${ empty login.grade_image }">
                                <i class="fa fa-user-circle-o"></i>
                            </c:if>
                            <c:if test="${ !empty login.grade_image }">
                                <img src="${login.grade_image }" class="round-circle" style="width:30px; height:30px">
                            </c:if>
                            ${login.id }
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="top-link" href="/member/logout.do">
                        <i class="fa fa-sign-out"></i> 로그아웃</a>
                    </li>
                    <c:if test="${login.gradeNo == 9 }">
                        <li class="nav-item">
                            <a class="top-link" href="/member/list.do">회원리스트보기</a>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <a class="top-link" href="/member/mypageMain.do">마이페이지</a>
                    </li>
                    <li class="nav-item">
                        <a class="top-link" href="/cart/list/${login.id }">장바구니</a>
                    </li>
                </c:if>
            </ul>
          </div>
        
        <!-- 상단 로고 및 사용자 메뉴 -->
   		<div class="header-top d-flex justify-content-between align-items-center p-2">
            <!-- 로고 -->
            <div class="header-logo">
                <a href="/" title="메인으로 이동">
                    <img src="/images/logo.png" alt="COMMAKASE">
                </a>
            </div>
        </div>
      
      	
      
		 <!-- 카테고리 메뉴 -->      
         <nav class="navbar navbar-expand-md navbar-dark">
            <div class="category-button">
                <i class="fa fa-align-justify"></i> 전체카테고리
            </div>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarContent">
				<ul class="navbar-nav mx-auto">
				    <li class="nav-item"><a class="nav-link" href="/quote.do">PC견적</a></li>
				    <li class="nav-item"><a class="nav-link" href="/shop/list.do">컴퓨터 전체보기</a></li>
				    <li class="nav-item"><a class="nav-link" href="/weeklyBest.do">주간 BEST</a></li>
				    <li class="nav-item"><a class="nav-link" href="/events.do">이벤트</a></li>
				    <li class="nav-item"><a class="nav-link" href="/notice/list.do">공지사항</a></li>
				    <li class="nav-item"><a class="nav-link" href="/community/list.do">커뮤니티</a></li>
				    <c:if test="${(!empty login) && (login.gradeNo == 9)}">
				        <li class="nav-item"><a class="nav-link" href="/goods/list.do">상품관리</a></li>
				    </c:if>
				</ul>
            </div>
        </nav>
		<!-- 사이드바 메뉴 -->
        <div class="sidebar">
            <a href="#">부품/주변기기</a>
            <a href="#">인터넷/사무용</a>
            <a href="#">3D게임/그래픽용</a>
            <a href="#">고성능/전문가용</a>
            <a href="#">노트북</a>
            <a href="#">QNA게시판</a>
        </div>

    <article>
        <decorator:body />
    </article>

    <footer class="container-fluid text-center">
        <div>이 홈페이지의 저작권 © COMMAKASE에 있습니다.</div>
        <div>
            <a href="#" class="text-light">개인정보 처리방침</a> | <a href="#" class="text-light">이용약관</a>
        </div>
    </footer>

    <!-- The Modal -->
	  <div class="modal fade" id="msgModal">
	    <div class="modal-dialog">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">처리 결과 모달 창</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	          ${msg}
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	        </div>
	        
	      </div>
	    </div>
	  </div>
  
	<!-- session 담은 msg를 보여주는 모달창 -->
	<c:if test="${!empty msg}">
		<!-- 모달을 보이게하는 javascript -->
		<script type="text/javascript">
			$(function() {
				$("#msgModal").modal("show");
				
			})
		</script>
	</c:if>
</body>
</html>