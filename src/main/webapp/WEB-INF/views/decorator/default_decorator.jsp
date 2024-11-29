<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 오진영 -->
<!-- 작성일 : 2024-11-01 -->
<!-- 최종수정일 : 2024-00-00 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMMAKASE:<decorator:title /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="${path}/resources/css/main.css" rel="stylesheet">
    
    <!-- 추가 스크립트 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- css -->
<style type="text/css">
/* 기본 스타일 */
body {
    color: #333;
    background-color: #fff;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* 상단 유틸리티 메뉴 */
.top-utility {
    background: #f8f9fa;
    font-size: 12px;
    border-bottom: 1px solid #eee;
}

.top-utility .container {
    display: flex;
    justify-content: flex-end;
    padding: 8px 16px;
}

.top-utility a {
    color: #666;
    text-decoration: none;
    margin-left: 15px;
}

/* 헤더 스타일 */
.main-header {
    padding: 20px 0;
}

.header-content {
    display: grid;
    grid-template-columns: 200px 1fr 200px;
    align-items: center;
    gap: 20px;
}

.logo img {
    max-width: 150px;
}

/* 검색바 스타일 */
.search-area-default {
    position: relative;
    max-width: 700px;
    margin: 0 auto;
}

/* 상단 검색바 */
.search-box-default {
    display: flex	;
    border: 2px solid #2F87FF;
    border-radius: 4px;
    overflow: hidden;
}

.search-type {
    border: none;
    background: #f8f9fa;
    padding: 0 10px;
    border-right: 1px solid #ddd;
}

.search-input {
    flex: 1;
    padding: 12px;
    border: none;
    outline: none;
    font-size: 14px;
}

.search-button {
    background: #2F87FF;
    color: white;
    border: none;
    padding: 0 25px;
    font-size: 16px;
}

/* 네비게이션 */
.main-nav {
    background: white;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
}

.nav-container {
    display: flex;
    align-items: center;
    height: 48px;
}


/* 카테고리 메뉴 스타일 */
.category-menu {
    position: relative;
    height: 100%;
}

.category-button {
    display: flex;
    align-items: center;
    gap: 8px;
    height: 100%;
    padding: 0 20px;
    background: #2F87FF;
    color: white;
    border: none;
    cursor: pointer;
    font-weight: 500;
}

/* 메인 메뉴 스타일 */
.main-menu {
    display: flex;
    margin: 0;
    padding: 0;
    list-style: none;
    height: 100%;
}

.main-menu li {
    height: 100%;
}

.main-menu a {
    display: flex;
    align-items: center;
    height: 100%;
    padding: 0 20px;
    color: #333;
    text-decoration: none;
    font-weight: 500;
}

.main-menu a:hover {
    color: #2F87FF;
}

/* 사이드 카테고리 스타일 */
.side-category {
    position: absolute;
    top: 100%;
    left: 0;
    width: 220px;
    background: white;
    border: 1px solid #ddd;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    z-index: 1000;
    display: none;
}

.side-category.show {
    display: block;
}

.side-category a {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px 20px;
    color: #333;
    text-decoration: none;
    font-size: 14px;
    border-bottom: 1px solid #eee;
}

.side-category a:hover {
    background: #f8f9fa;
    color: #2F87FF;
}

/* 모달 스타일 */
.modal-header {
    background: #2F87FF;
    color: white;
}

.modal-header .close {
    color: white;
}

/* 푸터 스타일 */
footer {
    background: #333;
    color: #fff;
    padding: 40px 0;
    margin-top: auto;
}

footer a {
    color: #fff;
    text-decoration: none;
}

/* 사용자 메뉴 */
.user-widget {
    display: flex;
    justify-content: flex-end;
    gap: 20px;
}

.user-widget a {
    display: flex;
    flex-direction: column;
    align-items: center;
    color: #333;
    text-decoration: none;
    font-size: 12px;
}

.user-widget i {
    font-size: 20px;
    margin-bottom: 4px;
}

/* 반응형 스타일 */
@media (max-width: 992px) {
    .header-content {
        grid-template-columns: 1fr;
        gap: 15px;
    }
    
    .logo {
        text-align: center;
    }
    
    .user-widget {
        justify-content: center;
    }
    
    .main-nav {
        overflow-x: auto;
    }
}
</style>

<!-- 카테고리 사이드 바 -->
<script type="text/javascript">
$(document).ready(function() {
    // 카테고리 버튼 클릭 이벤트
    $('.category-button').click(function(e) {
        e.stopPropagation();
        $('.side-category').toggleClass('show');
    });

    // 사이드 카테고리 클릭 이벤트 버블링 방지
    $('.side-category').click(function(e) {
        e.stopPropagation();
    });

    // 문서 전체 클릭 시 카테고리 닫기
    $(document).click(function() {
        $('.side-category').removeClass('show');
    });

    // ESC 키 누를 때 카테고리 닫기
    $(document).keyup(function(e) {
        if (e.key === "Escape") {
            $('.side-category').removeClass('show');
        }
    });
});
</script>

<decorator:head/>
</head>
<body>
    <!-- 상단 유틸리티 메뉴 -->
    <div class="top-utility">
        <div class="container">
            <c:if test="${empty login}">
                <a href="/member/loginForm.do">로그인</a>
                <a href="/member/writeForm.do">회원가입</a>
            </c:if>
            <c:if test="${!empty login}">
                <span class="mr-3">${login.id}님</span>
                <a href="/member/logout.do">로그아웃</a>
                <c:if test="${login.gradeNo == 9}">
                    <a href="/member/list.do">회원관리</a>
                </c:if>
                <a href="/member/mypageMain.do">마이페이지</a>
                <a href="/cart/list/${login.id}"><i class="fa fa-shopping-cart"></i> 장바구니</a>
            </c:if>
        </div>
    </div>

    <!-- 메인 헤더 -->
    <header class="main-header">
        <div class="container">
            <div class="header-content">
                <!-- 로고 -->
                <div class="logo">
                    <a href="/">
                        <img src="/images/logo.png" alt="COMMAKASE">
                    </a>
                </div>

                <!-- 검색 영역 -->
                <div class="search-area-default">
                    <div class="search-box-default">
                        <select class="search-type">
                            <option>전체</option>
                            <option>PC부품</option>
                            <option>노트북</option>
                        </select>
                        <input type="text" class="search-input" placeholder="검색어를 입력해 주세요">
                        <button class="search-button">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>

<!--                 <div class="user-widget"> -->
<!--                     <a href="/member/mypageMain.do"> -->
<!--                         <i class="fa fa-user"></i> -->
<!--                         <span>마이페이지</span> -->
<!--                     </a> -->
<%--                     <a href="/cart/list/${login.id}"> --%>
<!--                         <i class="fa fa-shopping-cart"></i> -->
<!--                         <span>장바구니</span> -->
<!--                     </a> -->
<!--                 </div> -->
            </div>
        </div>
    </header>

    <!-- 메인 네비게이션 -->
	<nav class="main-nav">
	    <div class="container">
	        <div class="nav-container position-relative">
	            <!-- 카테고리 버튼 -->
	            <div class="category-menu">
	                <button type="button" class="category-button">
	                    <i class="fa fa-bars"></i>
	                    전체카테고리
	                </button>
	                <!-- 사이드 카테고리 메뉴 -->
	                <div class="side-category">
	                    <a href="${pageContext.request.contextPath}/goods/list.do?category=goods1"><i class="fa fa-microchip"></i> 사무용/가정용</a>
	                    <a href="${pageContext.request.contextPath}/goods/list.do?category=goods2"><i class="fa fa-gamepad"></i> 3D게임/그래픽용</a>
	                    <a href="${pageContext.request.contextPath}/goods/list.do?category=goods3"><i class="fa fa-desktop"></i> 고성능/전문가용</a>
	                    <a href="${pageContext.request.contextPath}/goods/list.do?category=goods4"><i class="fa fa-laptop"></i> 노트북</a>
	                    <a href="${pageContext.request.contextPath}/goods/list.do?category=goods5"><i class="fa fa-keyboard-o"></i> 부품/주변기기</a>
	                    <a href="/qna/list.do"><i class="fa fa-question-circle"></i> QNA게시판</a>
	                </div>
	            </div>
	            
	            <ul class="main-menu">
	                <li><a href="/estimate/list.do">PC견적</a></li>
	                <li><a href="/goods/list.do">컴퓨터</a></li>
	                <li><a href="/weeklyBest.do">주간 BEST</a></li>
	                <li><a href="/event/list.do">이벤트</a></li>
	                <li><a href="/community/list.do">커뮤니티</a></li>
	                <c:if test="${!empty login && login.gradeNo == 9}">
	                    <li><a href="/goods/list.do">상품관리</a></li>
	                </c:if>
	            </ul>
	        </div>
	    </div>
	</nav>

    <!-- 메인 콘텐츠 -->
    <main class="container my-4">
        <decorator:body />
    </main>

    <!-- 푸터 -->
    <footer>
        <div class="container text-center">
            <p>이 홈페이지의 저작권 © COMMAKASE에 있습니다.</p>
            <p>
                <a href="#">개인정보 처리방침</a> | 
                <a href="#">이용약관</a>
            </p>
        </div>
    </footer>
    

    <!-- 모달 -->
    <div class="modal fade" id="msgModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">알림</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">${msg}</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${!empty msg}">
        <script>
            $(function() {
                $("#msgModal").modal("show");
            });
        </script>
    </c:if>
</body>
</html>