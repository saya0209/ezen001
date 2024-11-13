<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 글보기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/communityView.css" rel="stylesheet">
<link href="${path}/resources/css/msg.css" rel="stylesheet">


<!-- 1. 필요한 전역변수 선언 -->
<script type="text/javascript">
    let id = "user1"; // 로그인한 사용자 ID
//     let id = "${login.id}"; // 로그인한 사용자 ID
    let no = ${vo.community_no}; // 게시글 번호
    let replyPage = 1; // 댓글 페이지 번호
    console.log("전역 변수 - 게시글 번호: " + community_no);
</script>

<!-- 2. 날짜 및 시간 처리 -->
<script type="text/javascript" src="/js/dateTime.js"></script>

<!-- 댓글 페이지네이션 함수 선언 -->
<script type="text/javascript" src="/js/util.js"></script>

<!-- 3. 댓글 객체 (replySerive) 를 선언 : Ajax 처리부분 포함 -->
<!-- 댓글 처리하는 모든 곳에 사용하는 부분을 코딩 -->
<script type="text/javascript" src="/js/reply.js"></script>

<!-- 4. 댓글 객체(reply.js에서 선언한 replyService)를 호출하여 처리 + 이벤트처리 -->
<!-- 일반 게시판 댓글에 사용되는 부분을 코딩 -->
<script type="text/javascript" src="/js/replyProcess.js"></script>

<script type="text/javascript">
$(function() {
    // 글 수정 버튼 클릭 시
    $("#updateBtn").click(function() {
        location = "updateForm.do?community_no=${vo.community_no}";
    });
    
    // 삭제 버튼 클릭 시 모달 띄우기
    $("#deleteBtn").click(function() {
        $('#deleteModal').modal('show'); // 모달 띄우기
    });

    // 목록 버튼 클릭 시
    $("#listBtn").click(function() {
        location = "list.do?page=${param.page}" 
                   + "&perPageNum=${param.perPageNum}" 
                   + "&key=${param.key}" 
                   + "&word=${param.word}";
    });
});
</script>

</head>
<body>
<div class="container mt-4">
    <div class="card shadow-sm border-0">
        <!-- 카드 헤더 -->
        <div class="card-header bg-light d-flex justify-content-between align-items-center">
            <h3 class="post-title mb-0">${vo.title}</h3>  <!-- 제목 -->
            
            <!-- 수정, 삭제, 목록 버튼 -->
            <div class="card-header-buttons">
                <button class="btn btn-primary btn-sm" id="listBtn">목록</button>
            </div>
        </div>

        <!-- 카드 본문 -->
        <div class="card-body">
            <!-- 게시글 메타 정보 -->
            <div class="post-meta mb-3 text-muted">
                <span class="nickname">${vo.nicname}</span>  <!-- 닉네임 -->
                <span class="write-date ml-3">작성일: <fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" /></span>  <!-- 작성일 -->
                <span class="hit ml-3">조회수: ${vo.hit}</span>  <!-- 조회수 -->
            </div>

            <!-- 게시글 내용 -->
            <div class="content mb-3">
                <pre class="text-break">${vo.content}</pre>  <!-- 내용 -->
            </div>

            <!-- 이미지가 있을 경우 표시 -->
            <c:if test="${not empty vo.image}">
                <img src="${pageContext.request.contextPath}${vo.image}" class="img-fluid mb-3" alt="게시글 이미지">
            </c:if>

            <!-- 좋아요, 싫어요 아이콘 -->
            <div class="likes-dislikes mb-3">
                <span class="like-btn mr-3">
                    <i class="fa fa-thumbs-up"></i> ${vo.likeCnt}
                </span>
                <span class="dislike-btn">
                    <i class="fa fa-thumbs-down"></i> ${vo.dislikeCnt}
                </span>
            </div>
            
            <!-- 수정, 삭제, 글 작성 버튼 (왼쪽 정렬) -->
            <div class="d-flex justify-content-start mt-3">
                <c:if test="${login != null && (login.id == vo.id || login.gradeNo == 9)}">
                <button class="btn btn-outline-secondary btn-sm mr-2" onclick="location.href='writeForm.do'">
                    <i class="fa fa-pencil"></i> 글 작성
                </button>
                    <button class="btn btn-outline-secondary btn-sm mr-2" id="updateBtn">수정</button>
                    <button class="btn btn-outline-secondary btn-sm mr-2" id="deleteBtn">삭제</button>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- 댓글 영역 (communityreply.jsp를 포함) -->
    <div class="mt-4">
        <jsp:include page="communityreply.jsp"></jsp:include>
    </div>
    
		<!-- The Modal -->
		<div class="modal fade" id="deleteModal">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <form action="delete.do" method="post">
		                <input type="hidden" name="notice_no" value="${vo.community_no}">
		                <div class="modal-body d-flex justify-content-center align-items-center">
		                    <div class="text-center">
		                        <!-- 삭제 확인 메시지 (bold) -->
		                        <p class="delete-message">삭제하시겠습니까?</p>
		                        <!-- 삭제된 데이터는 되돌릴 수 없다는 메시지 (기본) -->
		                        <p class="delete-warning">삭제된 데이터는 되돌릴 수 없습니다.</p>
		                    </div>
		                </div>
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
		                    <button type="submit" class="btn btn-primary">삭제</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
    
	</div>
</body>
</html>
