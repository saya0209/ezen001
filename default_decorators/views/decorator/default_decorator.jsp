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
<%--     <link href="${path}/css/default_decorator.css" rel="stylesheet"> --%>
    <link href="${path}/resources/css/default_decorators.css" rel="stylesheet">
    
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


    <!-- 개발자가 작성한 소스의 head 태그를 여기에 넣게 된다. title은 제외 -->
    <decorator:head/>
</head>

<body>
    <header>
        <nav class="navbar navbar-expand-md bg-dark navbar-dark">
            <a class="navbar-brand" href="/">COMMAKASE</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="collapsibleNavbar">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                    	<a class="nav-link" href="/#/list.do">PC견적</a>
                    	</li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/#/list.do">조립PC</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/notice/list.do">공지사항</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/community/list.do">커뮤니티</a>
                    </li>
                    <li class="nav-item">
                    	<a class="nav-link" href="/shop/list.do">쇼핑몰</a>
                    </li>
                    <c:if test="${(!empty login) && (login.gradeNo == 9) }">
                        <li class="nav-item"><a class="nav-link" href="/goods/list.do">상품관리</a>
                        </li>
                    </c:if>
                </ul>

                <ul class="navbar-nav">
                    <c:if test="${ empty login }">
                        <li class="nav-item">
                        	<a class="nav-link" href="/member/loginForm.do">
                        	<i class="fa fa-sign-in"></i> 로그인/회원가입</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="/cart/list.do"><i class="fa fa-shopping-basket"></i></a></li>
                    </c:if>
                    <c:if test="${ !empty login }">
                        <li class="nav-item">
                            <span class="nav-link">
                                <c:if test="${ empty login.photo }"><i class="fa fa-user-circle-o"></i></c:if>
                                <c:if test="${ !empty login.photo }"><img src="${login.photo}" class="rounded-circle" style="width:30px; height:30px"></c:if>
                                ${login.id}
                            </span>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="/member/logout.do"><i class="fa fa-sign-out"></i> 로그아웃</a></li>
                        <c:if test="${login.gradeNo == 9}">
                            <li class="nav-item"><a class="nav-link" href="/member/list.do">회원리스트 보기</a></li>
                            <li class="nav-item"><a class="nav-link" href="/category/list.do">카테고리 보기</a></li>
                        </c:if>
                        <li class="nav-item"><a class="nav-link" href="/member/view.do">회원정보</a></li>
                        <li class="nav-item"><a class="nav-link" href="/cart/list.do"><i class="fa fa-shopping-basket"></i></a></li>
                    </c:if>
                </ul>
            </div>
        </nav>
    </header>

    <article>
        <decorator:body />
    </article>

    <footer class="container-fluid text-center py-4 bg-dark text-light">
        <div class="container">
            <p class="mb-2">이 홈페이지의 저작권 © COMMAKASE에 있습니다.</p>
            <div>
                <a href="#" class="text-light me-3">개인정보 처리방침</a>
                <a href="#" class="text-light">이용약관</a>
            </div>
        </div>
    </footer>

    <!-- 모달 -->
    <div class="modal fade" id="msgModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">처리 결과 모달 창</h4>
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
        <script type="text/javascript">
            $(function() {
                $("#msgModal").modal("show");
            });
        </script>
    </c:if>

</body>
</html>
