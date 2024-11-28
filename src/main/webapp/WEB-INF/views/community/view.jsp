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
<link href="${path}/resources/css/communityVA.css" rel="stylesheet">
<link href="${path}/resources/css/likedislike.css" rel="stylesheet">


<!-- 1. 필요한 전역변수 선언 -->
<script type="text/javascript">
    let id = "${login.id}"; // 로그인한 사용자 ID
    let post_no = ${vo.community_no}; // 게시글 번호
    let replyPage = 1; // 댓글 페이지 번호
    console.log("전역 변수 - 게시글 번호: " + post_no);
</script>

<!-- 2. 날짜 및 시간 처리 -->
<script type="text/javascript" src="/js/dateTime.js"></script>

<!-- 댓글 페이지네이션 함수 선언 -->
<script type="text/javascript" src="/js/util.js"></script>

<!-- 3. 댓글 객체 (replySerive) 를 선언 : Ajax 처리부분 포함 -->
<script type="text/javascript" src="/js/communityreply.js"></script>

<!-- 4. 댓글 객체(reply.js에서 선언한 replyService)를 호출하여 처리 + 이벤트처리 -->
<script type="text/javascript" src="/js/replyProcess.js"></script>

<!-- 5. 좋아요, 싫어요 : Ajax 처리부분 포함 -->
<script type="text/javascript" src="/js/likedislike.js"></script>

<!-- <script type="text/javascript" src="/js/replytest.js"></script> -->

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
    
 	// 취소
	$("#cancelBtn").click(function() {
		history.back();
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
<div class="container">
        <div class="card">
            <!-- 헤더 영역 -->
            <div class="card-header d-flex justify-content-between align-items-center">
                <h1 class="post-title">${vo.title}</h1>
                <button class="btn btn-primary" id="listBtn">
                    <i class="fa fa-list"></i> 목록
                </button>
            </div>

            <!-- 본문 영역 -->
            <div class="card-body">
                <!-- 메타 정보 -->
                <div class="post-meta">
                    <span><i class="fa fa-user"></i> ${vo.nicname}</span>
                    <span><i class="fa fa-calendar"></i> <fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd" /></span>
                    <span><i class="fa fa-eye"></i> ${vo.hit}</span>
                </div>

                <!-- 컨텐츠 -->
                <div class="content">
                    <pre class="text-break">${vo.content}</pre>
                </div>

                <!-- 이미지 -->
                <c:if test="${!empty vo.image}">
                    <div class="images-list">
                        <c:forEach items="${fn:split(vo.image, ',')}" var="file">
                            <div class="image-item">
                                <img src="${path}/upload/community/${file}" alt="첨부 이미지" />
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- 좋아요/싫어요 -->
                <div class="reaction-buttons">
	                <button id="likeBtn" class="${isLiked ? 'active' : ''}" data-community-no="${vo.community_no}">
	                    <i class="material-icons">thumb_up</i>
	                    <span id="likeCount">${vo.likeCnt}</span>
	                </button>
	                <button id="dislikeBtn" class="${isDisliked ? 'active' : ''}" data-community-no="${vo.community_no}">
	                    <i class="material-icons">thumb_down</i>
	                    <span id="dislikeCount">${vo.dislikeCnt}</span>
	                </button>
	            </div>

                <!-- 작성자 전용 버튼 -->
                <c:if test="${login != null && (login.id == vo.id || login.gradeNo == 9)}">
                    <div class="action-buttons">
                        <button class="btn btn-primary btn-sm" onclick="location.href='writeForm.do'">
                            <i class="fa fa-pencil"></i> 글 작성
                        </button>
                        <button class="btn btn-outline-secondary btn-sm" id="updateBtn">
                            수정
                        </button>
                        <button class="btn btn-outline-secondary btn-sm" id="deleteBtn">
                            삭제
                        </button>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- 댓글 영역 -->
        <div class="reply-section mt-4">
            <jsp:include page="communityreply.jsp"></jsp:include>
        </div>
    </div>

    <!-- 삭제 모달 -->
    <div class="modal fade" id="deleteModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="delete.do" method="post">
                    <input type="hidden" name="community_no" value="${vo.community_no}">
                    <input type="hidden" id="userId" value="${login.id}">
                    <div class="modal-body text-center py-4">
                        <p class="delete-message">삭제하시겠습니까?</p>
                        <p class="delete-warning">삭제된 데이터는 되돌릴 수 없습니다.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">삭제</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
