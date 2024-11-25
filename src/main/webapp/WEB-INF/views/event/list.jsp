<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 리스트</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- Custom CSS -->
<link href="${path}/resources/css/event.css" rel="stylesheet">

<script type="text/javascript">
	$(function() {
		// 이벤트 카드 클릭 시 상세보기
		$(".card event-card").click(function() {
			let event_no = $(this).data("no");
			location = "view.do?event_no=" + event_no;
		});

		// 검색 폼 제출
		$("#searchForm").submit(function(e) {
			if ($("#word").val().trim() === "") {
				e.preventDefault();
				alert("검색어를 입력해주세요.");
				$("#word").focus();
			}
		});

		// 기간 필터링
		$(".period-filter").click(function(e) {
			e.preventDefault();
			let period = $(this).data("period");
			let category = getUrlParameter("category") || "all";
			let word = $("#word").val();

			let url = "list.do?period=" + period + "&category=" + category;
			if (word)
				url += "&word=" + encodeURIComponent(word);

			location = url;
		});

		// 카테고리 필터링 추가
		$(".category-filter").click(function(e) {
			e.preventDefault();
			let category = $(this).data("category");
			let period = getUrlParameter("period") || "all";
			let word = $("#word").val();

			let url = "list.do?category=" + category + "&period=" + period;
			if (word)
				url += "&word=" + encodeURIComponent(word);

			location = url;
		});

		// URL 파라미터 가져오는 함수
		function getUrlParameter(name) {
			name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
			var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
			var results = regex.exec(location.search);
			return results === null ? '' : decodeURIComponent(results[1]
					.replace(/\+/g, ' '));
		}

		// 현재 선택된 필터 표시
		let currentPeriod = getUrlParameter("period") || "all";
		let currentCategory = getUrlParameter("category") || "all";

		$(".period-filter[data-period='" + currentPeriod + "']").addClass(
				"active");
		$(".category-filter[data-category='" + currentCategory + "']")
				.addClass("active");
	});
</script>

<script>
    $(function() {
        // 검색 초기화 버튼
        $("#resetFilterBtn").click(function() {
            $("#searchForm")[0].reset();
            location.href = "/event/list.do";
        });
    });
</script>

</head>
<body>
<div class="event-container">
    <!-- 검색 필터 -->
	<div class="search-filter">
	    <form id="searchForm" action="/event/list.do" method="get" class="row align-items-end">
	        <div class="col-md-3 mb-3">
	            <label>검색어</label>
	            <input type="text" name="word" id="word" class="form-control" value="${param.word}" placeholder="제목 또는 내용">
	        </div>
	        <div class="col-md-3 mb-3">
	            <label>기간</label>
	            <select name="period" class="form-control">
	                <option value="all" ${param.period == 'all' ? 'selected' : ''}>전체</option>
	                <option value="pre" ${param.period == 'pre' ? 'selected' : ''}>진행중</option>
	                <option value="res" ${param.period == 'res' ? 'selected' : ''}>예정</option>
	                <option value="old" ${param.period == 'old' ? 'selected' : ''}>종료</option>
	            </select>
	        </div>
	        <div class="col-md-3 mb-3">
	            <label>카테고리</label>
	            <select name="category" class="form-control">
	                <option value="all">전체</option>
	                <option value="PROMOTION" ${param.category == 'PROMOTION' ? 'selected' : ''}>프로모션</option>
	                <option value="EVENT" ${param.category == 'EVENT' ? 'selected' : ''}>일반 이벤트</option>
	                <option value="SEMINAR" ${param.category == 'SEMINAR' ? 'selected' : ''}>세미나</option>
	            </select>
	        </div>
	        <div class="col-md-3 mb-3 d-flex align-items-end">
	            <button type="submit" class="btn btn-primary">
	                <i class="fa fa-search"></i> 검색
	            </button>
	            <button type="button" id="resetFilterBtn" class="btn reset-filter-btn ml-2">
	                <i class="fa fa-refresh"></i> 초기화
	            </button>
	        </div>
	    </form>
	</div>

    <!-- 이벤트 목록 -->
<div class="row">
        <c:forEach items="${list}" var="vo">
            <div class="col-md-4 mb-4">
                <div class="card event-card" onclick="location.href='/event/view.do?event_no=${vo.event_no}'">
                    <c:if test="${not empty vo.files}">
                        <img src="/upload/event/${vo.files.split(',')[0]}" class="event-thumbnail" alt="Event image">
                    </c:if>
                    <c:if test="${empty vo.files}">
                        <div class="event-thumbnail bg-light">
                            <i class="fa fa-calendar fa-3x text-muted"></i>
                        </div>
                    </c:if>
                    <div class="card-body">
                        <div class="card-header-info">
                            <span class="status-badge ${vo.status == 'UPCOMING' ? 'status-upcoming' : 
                                                       vo.status == 'ONGOING' ? 'status-ongoing' : 'status-completed'}">
                                ${vo.status == 'UPCOMING' ? '예정' : 
                                  vo.status == 'ONGOING' ? '진행중' : '종료'}
                            </span>
                            <p class="card-category">
                                <i class="fa fa-tag"></i> ${vo.category}
                            </p>
                        </div>
                        <h5 class="card-title">${vo.title}</h5>
                        <p class="card-date">
                            <i class="fa fa-calendar"></i> 
                            <fmt:formatDate value="${vo.startDate}" pattern="yyyy.MM.dd"/> ~ 
                            <fmt:formatDate value="${vo.endDate}" pattern="yyyy.MM.dd"/>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 페이지네이션 -->
    <div class="event-pagination">
        <nav>
            <ul class="pagination justify-content-center">
                <c:if test="${pageObject.startPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="/event/list.do?page=${pageObject.startPage - 1}">
                            <i class="fa fa-chevron-left"></i>
                        </a>
                    </li>
                </c:if>
               
                <c:forEach begin="${pageObject.startPage}" end="${pageObject.endPage}" var="num">
                    <li class="page-item ${pageObject.page == num ? 'active' : ''}">
                        <a class="page-link" href="/event/list.do?page=${num}">${num}</a>
                    </li>
                </c:forEach>
               
                <c:if test="${pageObject.endPage < pageObject.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="/event/list.do?page=${pageObject.endPage + 1}">
                            <i class="fa fa-chevron-right"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>

    <!-- 관리자 전용 글쓰기 버튼 -->
    <c:if test="${login.gradeNo == 9}">
        <div class="text-right mt-3">
            <a href="/event/writeForm.do" class="btn btn-primary">
                <i class="fa fa-plus"></i> 이벤트 등록
            </a>
        </div>
    </c:if>
</div>

<!-- Bootstrap 4 JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- 성공 메시지 표시 -->
<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>
</body>
</html>