<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 상세보기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/msg.css" rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	color: #333;
	line-height: 1.6;
}

.event-container {
	max-width: 800px;
	margin: 0 auto;
	padding: 2rem 1rem;
}

.event-title {
	font-size: 2rem;
	font-weight: bold;
	color: #2c3e50;
	margin-bottom: 2rem;
	text-align: center;
}

.event-content {
    /* 기본 스타일 유지 */
    border: 1px solid #e1e1e1;
    padding: 1.5rem;
    border-radius: 10px;
    margin-bottom: 2rem;
    background: #fff;
}

.content-area {
    /* 줄바꿈 및 여백 처리 */
    white-space: pre-line;
    line-height: 1.8;
    font-size: 1.1rem;
    color: #333;
    word-break: keep-all;
    overflow-wrap: break-word;
}

/* 단락 간격 조정 */
.content-area p {
    margin-bottom: 1.2rem;
}



.main-image {
    width: 100%;
    border-radius: 10px;
    margin-bottom: 2rem;  /* 이미지 간 간격 */
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    display: block;  /* 이미지를 블록 레벨 요소로 만들어 세로로 쌓이게 함 */
}

.datetime-info {
	border: 1px solid #e1e1e1;
	padding: 1.5rem;
	border-radius: 10px;
	margin-bottom: 2rem;
	color: #666;
	background: #fafafa;
}

.datetime-info div {
	margin-bottom: 0.5rem;
}

.datetime-info div:last-child {
	margin-bottom: 0;
}

.warning-section {
	border: 1px solid #e1e1e1;
	padding: 1.5rem;
	border-radius: 10px;
	margin-bottom: 2rem;
	background: #fff;
}

.warning-title {
	color: #3498db;
	font-size: 1.2rem;
	font-weight: bold;
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
}

.warning-title:before {
	content: "⚠️";
	margin-right: 0.5rem;
}

.warning-list {
	list-style: none;
	padding: 0;
	margin: 0;
	color: #555;
}

.warning-list li {
	margin-bottom: 0.8rem;
	padding-left: 1.2rem;
	position: relative;
}

.warning-list li:before {
	content: "•";
	position: absolute;
	left: 0;
	color: #3498db;
}

.warning-list li:last-child {
	margin-bottom: 0;
}

.action-buttons {
	display: flex;
	gap: 1rem;
	justify-content: center;
	margin-top: 2rem;
}

.btn {
	padding: 0.8rem 1.8rem;
	border-radius: 8px;
	font-weight: 500;
	text-transform: uppercase;
	border: none;
	transition: all 0.2s ease;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.btn-primary {
	background: #3498db;
	color: white;
}

.btn-primary:hover {
	background: #2980b9;
}

.btn-secondary {
	background: #f1f1f1;
	color: #666;
}

.btn-secondary:hover {
	background: #e1e1e1;
}

@media ( max-width : 768px) {
	.event-container {
		padding: 1rem;
	}
	.event-title {
		font-size: 1.5rem;
	}
	.content-area {
        font-size: 1rem;
        line-height: 1.6;
    }
	.btn {
		padding: 0.7rem 1.4rem;
	}
}
</style>

<style type="text/css">

</style>
<!-- JavaScript 전역 변수 설정 -->
<script type="text/javascript">
	let id = "${login.id}"; // 로그인된 사용자 ID
	let no = $
	{
		vo.event_no
	}; // 현재 이벤트 번호
	console.log("전역 변수 - 이벤트 번호: " + no);
</script>

<!-- 날짜 및 시간 처리 함수 -->
<script type="text/javascript" src="${path}/js/dateTime.js"></script>
<script>
	function confirmDelete() {
		if (confirm('정말 이 이벤트를 삭제하시겠습니까?')) {
			document.getElementById('deleteForm').submit();
		}
	}

	// 성공 메시지 표시
	<c:if test="${!empty msg}">
	alert("${msg}");
	</c:if>
</script>



</head>
<body>
<div class="event-container">
        <h1 class="event-title">${vo.title}</h1>
        
        <!-- 메인 이미지 -->
<%--         <c:if test="${!empty vo.files}"> --%>
<%--             <img src="/upload/event/${vo.files.split(',')[0]}" class="main-image" alt="Event main image"> --%>
<%--         </c:if> --%>
        
        <!-- 이미지들 -->
		<c:if test="${!empty vo.files}">
		    <c:forEach items="${fn:split(vo.files, ',')}" var="file">
		        <img src="/upload/event/${file}" class="main-image" alt="Event image">
		    </c:forEach>
		</c:if>
        
        <!-- 날짜 정보 -->
        <div class="datetime-info">
            <div>이벤트 기간: <fmt:formatDate value="${vo.startDate}" pattern="yyyy.MM.dd"/> ~ 
                <fmt:formatDate value="${vo.endDate}" pattern="yyyy.MM.dd"/></div>
            <div>작성일: <fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd"/></div>
            <c:if test="${vo.updateDate != null}">
                <div>수정일: <fmt:formatDate value="${vo.updateDate}" pattern="yyyy.MM.dd"/></div>
            </c:if>
        </div>
        
        <!-- 이벤트 내용 -->
		<div class="warning-section event-content">
		    <div class="content-area">
		        ${vo.content}
		    </div>
		</div>
        
        <!-- 주의사항 -->
        <div class="warning-section">
            <div class="warning-title">이벤트 참여 주의사항</div>
            <ul class="warning-list">
                <li>본 이벤트는 프로그램 또는 매크로를 이용한 자동 응모 시 당첨이 취소됩니다.</li>
                <li>1인당 1회만 참여 가능합니다.</li>
                <li>부정한 방법으로 참여시 당첨이 취소되며, 관련 법적 조치가 진행될 수 있습니다.</li>
            </ul>
        </div>
        
        <!-- 버튼 영역 -->
        <div class="action-buttons">
            <a href="/event/list.do" class="btn btn-secondary">
                목록으로
            </a>
            
            <c:if test="${login.gradeNo == 9}">
                <a href="/event/updateForm.do?event_no=${vo.event_no}" class="btn btn-primary">
                    수정
                </a>
                <button type="button" class="btn btn-secondary" onclick="confirmDelete()">
                    삭제
                </button>
            </c:if>
        </div>
    </div>

    <!-- 삭제 폼 -->
    <form id="deleteForm" action="/event/delete.do" method="post" style="display: none;">
        <input type="hidden" name="event_no" value="${vo.event_no}">
    </form>

</body>
</html>