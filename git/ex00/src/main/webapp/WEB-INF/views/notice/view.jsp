<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 글보기</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>

    <!-- CSS -->
    <link href="${path}/resources/css/noticeView.css" rel="stylesheet">
    <link href="${path}/resources/css/msg.css" rel="stylesheet">

    <!-- JavaScript 전역 변수 설정 -->
    <script type="text/javascript">
        let id = "${login.id}"; // 로그인된 사용자 ID
        let no = ${vo.notice_no}; // 현재 글 번호
        let replyPage = 1; // 댓글 페이지
        console.log("전역 변수 - 게시글 번호: " + no);
    </script>

    <!-- 날짜 및 시간 처리 함수 -->
    <script type="text/javascript" src="${path}/js/dateTime.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            // 수정 버튼
            $("#updateBtn").click(function() {
                location.href = "updateForm.do?no=${vo.notice_no}";
            });

         // 삭제 버튼 클릭 시 모달 띄우기
            $("#deleteBtn").click(function() {
                $('#deleteModal').modal('show'); // 모달 띄우기
            });

            // 목록 버튼
            $("#listBtn").click(function() {
                location.href = "list.do?page=${param.page}"
                    + "&perPageNum=${param.perPageNum}"
                    + "&key=${param.key}"
                    + "&word=${param.word}";
            });

        });
    </script>
</head>
<body>
    <div class="container">
        <section class="notice-view">
            <!-- 공지사항 제목 -->
            <div class="notice-title">
                <h1>${vo.title}</h1>
            </div>

            <!-- 날짜 출력 -->
	        <div class="notice-dates">
	            <span><fmt:formatDate value="${vo.startDate}" pattern="yyyy-MM-dd" /></span>
	            <span> ~ </span>
	            <span><fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd" /></span>
	        </div>

            <!-- 공지사항 내용 -->
            <div class="notice-content">
                <pre>${vo.content}</pre>
            </div>

            <!-- 파일 섹션 -->
	        <div class="file-container">
	            <c:if test="${empty vo.files}">
	                <p class="no-file">첨부된 파일이 없습니다.</p>
	            </c:if>
	            <c:if test="${not empty vo.files}">
	                <img src="${path}/upload/noticeFiles/${vo.files}" alt="첨부 이미지">
	            </c:if>
	        </div>

            <!-- 버튼 섹션 -->
            <div class="notice-buttons">
                <button class="btn btn-primary" id="listBtn">목록</button>
                <c:if test="${login.gradeNo == 9}">
                    <button class="btn btn-secondary" id="updateBtn">수정</button>
                    <button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">삭제</button>
                </c:if>
            </div>
        </section>
        
	    <!-- The Modal -->
		<div class="modal fade" id="deleteModal">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content">
		            <form action="delete.do" method="post">
		                <input type="hidden" name="notice_no" value="${vo.notice_no}">
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
