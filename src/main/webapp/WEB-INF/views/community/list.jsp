<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 메인</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>

    <link href="${path}/resources/css/communityList.css" rel="stylesheet">

    <script type="text/javascript">
        $(document).ready(function() {
            $(".board-table").on("click", ".dataRow", function() {
                let no = $(this).data("no");
                window.location.href = "view.do?community_no=" + no + "&inc=1" + "&${pageObject.pageQuery}";
            });
        });
    </script>

</head>
<body>
<div class="container mt-5">
    <h2 class="board-title">커뮤니티 게시판</h2>
    
    <!-- 검색 폼 -->
    <form action="list.do" id="searchForm" class="search-form mb-3 d-flex">
        <input type="text" name="word" placeholder="검색어 입력" class="form-control" value="${pageObject.word}">
        <button type="submit" class="btn btn-dark ml-2" aria-label="검색">
            <i class="fa fa-search"></i>
        </button>
    </form>

    <!-- 글 작성 버튼 (로그인 상태에서만 보임) -->
    <c:if test="${!empty login}">
        <a href="writeForm.do" class="btn btn-dark mb-3" aria-label="글 작성">
            <i class="fa fa-pencil"></i> 글 작성
        </a>
    </c:if>

    <!-- 게시판 리스트 테이블 -->
    <table class="table table-hover board-table">
        <thead>
            <tr>
                <th class="text-center">제목</th>
                <th class="text-center">작성자</th>
                <th class="text-center">작성일</th>
                <th class="text-center">조회수</th>
            </tr>
        </thead>
        <tbody>
            <!-- 게시물 반복 출력 -->
            <c:forEach items="${list}" var="vo">
                <tr class="dataRow" data-no="${vo.community_no}">
                    <td class="post-title">
                        <c:if test="${!empty vo.image}">
                            <i class="fa fa-file-image-o"></i>
                        </c:if>
                        <a href="view.do?community_no=${vo.community_no}&inc=1">${vo.title}</a>
                    </td>
                    <td class="text-center">${vo.nicname}</td>
                    <td class="text-center">
                        <fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" />
                    </td>
                    <td class="text-center">${vo.hit}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination-bar">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav>
    </div>
</div>
</body>
</html>
