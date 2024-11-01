<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>컴마카세</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        /* 기본 스타일 설정 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* 상단 로고 및 사용자 메뉴 */
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #fff; /* 흰색 배경 */
            border-bottom: 1px solid #ddd;
        }

        .header-logo img {
            max-width: 180px;
        }

        /* 사용자 메뉴 스타일 */
        .user-menu {
            display: flex;
            align-items: center;
        }

        .user-menu .nav-item {
            margin-left: 15px;
        }

        .user-menu a {
            color: #343a40;
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
		    justify-content: space-between; /* 왼쪽과 중앙 정렬 */
		    background-color: #6db33f;
		    padding: 10px 0;
		    position: relative;
		}
		
		.category-button {
		    margin-left: 20px; /* 전체카테고리 버튼 왼쪽 여백 */
		    color: #fff;
		    font-weight: bold;
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
		
		.category-center a:hover {
		    color: #e9ecef;
		}

		/* 사이드바 스타일 */
        .sidebar {
            width: 250px;
            position: fixed;
            top: 56px;
            left: 0;
            height: calc(100% - 56px);
            background-color: #f8f9fa;
            padding-top: 20px;
            border-right: 1px solid #ddd;
            display: none; /* 기본적으로 숨김 */
            z-index: 1000; /* 사이드바가 다른 요소 위에 표시되도록 설정 */
        }
        
        .sidebar a {
            padding: 10px 15px;
            font-size: 18px;
            display: block;
            color: #333;
            text-decoration: none;
        }

        .content {
            padding: 20px;
            text-align: center;
        }
        
        .category-menu a {
            color: #fff;
            font-size: 16px;
            padding: 0 20px;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        .category-menu a:hover {
            color: #e9ecef;
        }
    </style>
    <script>
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
</head>
<body>
    <!-- 상단 로고 및 사용자 메뉴 -->
    <div class="header-top">
        <!-- 로고 -->
        <div class="header-logo">
            <a href="/" title="메인으로 이동">
                <img src="로고 이미지 경로" alt="컴마카세 로고">
            </a>
        </div>

        

        <!-- 사용자 메뉴 -->
        <div class="user-menu">
            <ul class="navbar-nav d-flex flex-row">
                <c:if test="${ empty login }">
                    <li class="nav-item">
                        <a class="nav-link" href="/member/loginForm.do">
                        <i class="fa fa-sign-in"></i> 로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/member/writeForm.do">
                        <i class="fa fa-address-card-o"></i> 회원가입</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/member/searchID.do">
                        <i class="fa fa-search"></i> 아이디/비밀번호 찾기</a>
                    </li>
                </c:if>
                <c:if test="${ !empty login }">
                    <li class="nav-item">
                        <span class="nav-link">
                            <c:if test="${ empty login.photo }">
                                <i class="fa fa-user-circle-o"></i>
                            </c:if>
                            <c:if test="${ !empty login.photo }">
                                <img src="${login.photo }" class="round-circle" style="width:30px; height:30px">
                            </c:if>
                            ${login.id }
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/member/logout.do">
                        <i class="fa fa-sign-out"></i> 로그아웃</a>
                    </li>
                    <c:if test="${login.gradeNo == 9 }">
                        <li class="nav-item">
                            <a class="nav-link" href="/member/list.do">회원리스트보기</a>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <a class="nav-link" href="/member/view.do">내정보보기</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/cart/list.do">장바구니</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>

    <!-- 카테고리 메뉴 -->
	<nav class="category-menu">
	    <!-- 전체카테고리 버튼 -->
	    <div class="category-button">
	        <i class="fa fa-align-justify"></i> 전체카테고리
	    </div>
	    
	    <!-- 중앙 메뉴 -->
	    <div class="category-center">
	        <a href="/quote.do">온라인 견적서</a>
	        <a href="/shop/list.do">컴퓨터 전체보기</a>
	        <a href="/weeklyBest.do">주간 BEST</a>
	        <a href="/events.do">이벤트</a>
	        <a href="/community.do">커뮤니티</a>
	    </div>
	</nav>
    
    <!-- 사이드바 메뉴 -->
    <div class="sidebar">
        <a href="">부품/주변기기</a>
        <a href="">인터넷/사무용</a>
        <a href="">3D게임/그래픽용</a>
        <a href="">고성능/전문가용</a>
        <a href="">노트북</a>
        <a href="">QNA게시판</a>
    </div>	

 
</body>
</html>




