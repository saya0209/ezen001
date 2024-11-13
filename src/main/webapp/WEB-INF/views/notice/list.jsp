<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이벤트 리스트</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/noticeList.css" rel="stylesheet">

<script type="text/javascript">
    $(function() {
        // 이벤트 클릭 시 상세보기 페이지로 이동
        $(".dataRow").click(function() {
            let no = $(this).data("no");
            location = "view.do?no=" + no + "&inc=1" + "&${pageObject.pageQuery}";
        });
       
        // 페이지당 게시물 수 변경 시
        $("#perPageNum").change(function() {
            $("#searchForm").submit();
        });

        // 검색키워드 및 perPageNum 초기 설정
        $("#key").val("${(empty pageObject.key)?'t':pageObject.key}")
        $("#perPageNum").val("${(empty pageObject.perPageNum)?'10':pageObject.perPageNum}")
    });
</script>

</head>
<body>
<div class="container">
    <section class="notice">
        <!-- 페이지 타이틀 -->
        <div class="page-title">
            <div class="container">
                <h3>이벤트</h3>
            </div>
        </div>
   
        <!-- 검색창 -->
		<div id="board-search">
		    <div class="container">
		        <div class="search-wrap">
		            <form action="list.do" id="searchForm">
		                <input id="word" type="search" name="word" placeholder="검색어를 입력해주세요." value="${pageObject.word}">
		                <button type="submit" class="btn btn-outline-primary">검색</button>
		            </form>
			        <c:if test="${login.gradeNo == 9 }">
			            <!-- 이벤트등록 버튼은 오른쪽 끝으로 배치 -->
			            <a href="writeForm.do" class="btn btn-outline-primary">이벤트 등록</a>
			        </c:if>
		        </div>
		    </div>
		</div>

   
        <!-- 이벤트 리스트 테이블 -->
        <div id="board-list">
            <div class="container">
                <div class="row">
                    <c:forEach items="${list}" var="vo">
                        <div class="col-md-4 mb-4">
                            <div class="card dataRow" data-no="${vo.notice_no}">
					            <!-- 이미지가 없으면 아이콘을 표시 -->
                                <c:if test="${empty vo.files}">
                                    <div class="card-img-placeholder">
                                        <i class="fa fa-bell icon-fa"></i>
                                        <i class="material-icons">image</i>
                                    </div>
                                </c:if>
                                <c:if test="${not empty vo.files}">
                                    <img src="${path}/upload/noticeFiles/${vo.files}" class="card-img-top" alt="Notice Image">
                                </c:if>
                                <div class="card-body">
								    <h5 class="card-title">${vo.title}</h5>
								
								    <!-- 날짜 출력 부분 -->
								    <p class="card-text">
								        <fmt:formatDate value="${vo.startDate}" pattern="yyyy-MM-dd" /> ~
								        <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd" />
								    </p>
								</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
   
        <!-- 페이지네이션 -->
<!--         <div class="page-nav"> -->
<%--             <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav> --%>
<!--         </div> -->
    </section>
</div>
</body>
</html>
