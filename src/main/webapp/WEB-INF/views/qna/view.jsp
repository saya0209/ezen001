<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/qna.css" rel="stylesheet">

<script>
        $(function() {
            // 목록 버튼 클릭 처리
            $("#listBtn").click(function() {
                location.href = "list.do";
            });
            
            // 삭제 버튼 클릭 시 확인
            $(".delete-btn").click(function(e) {
                if (!confirm("정말 삭제하시겠습니까?")) {
                    e.preventDefault();
                }
            });
            
            // 상태에 따른 배지 색상 변경
            $('.status-badge').each(function() {
                const status = $(this).data('status');
                if (status === 'waiting') {
                    $(this).addClass('badge-warning');
                } else {
                    $(this).addClass('badge-success');
                }
            });
        });
        
        // 답변 등록 성공 메시지
//         <c:if test="${!empty msg}">
//             alert("${msg}");
//         </c:if>
    </script>
</head>
<body>
    <div class="qna-container">
        <h2 class="qna-title">
            <i class="fa fa-file-text-o"></i> QnA 상세보기
        </h2>

        <!-- 질문 내용 -->
        <div class="card mb-4">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <div>
                    <span class="qna-category category-${fn:toLowerCase(qna.category)}">
                        ${qna.category}
                    </span>
                    <span class="ml-2 status-${qna.status}">
                        <i class="fa fa-circle mr-1"></i>
                        ${qna.status == 'waiting' ? '답변대기' : '답변완료'}
                    </span>
                </div>
                <small class="text-muted">
                    <i class="fa fa-clock-o"></i> 
                    <fmt:formatDate value="${qna.writeDate}" pattern="yyyy-MM-dd HH:mm"/>
                </small>
            </div>
            <div class="card-body">
                <h5 class="card-title">${qna.title}</h5>
                <h6 class="card-subtitle mb-3 text-muted">
                    <i class="fa fa-user-o"></i> ${qna.nicname}
                </h6>
                <p class="card-text">${qna.content}</p>
            </div>
        </div>

        <!-- 답변 목록 -->
        <div class="answers-container">
            <c:forEach items="${answers}" var="answer">
                <div class="answer-section mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">
                            <i class="fa fa-comment-o"></i> 관리자 답변
                        </h6>
                        <small class="text-muted">
                            <i class="fa fa-clock-o"></i>
                            <fmt:formatDate value="${answer.answerDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </small>
                    </div>
                    <p class="mb-3">${answer.answer_content}</p>
                    
                    <!-- 관리자만 답변 삭제 가능 -->
                    <c:if test="${login.gradeNo == 9}">
                        <form action="/qna/deleteAnswer.do" method="post" class="d-inline">
                            <input type="hidden" name="answer_no" value="${answer.answer_no}">
                            <input type="hidden" name="qna_no" value="${qna.qna_no}">
                            <button type="submit" class="btn btn-sm btn-outline-secondary delete-btn">
                                <i class="fa fa-trash"></i>
                            </button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        
        <!-- 관리자용 답변 작성 폼 -->
        <c:if test="${login.gradeNo == 9 && qna.status == 'waiting'}">
            <div class="mt-4">
                <jsp:include page="writeAnswer.jsp"></jsp:include>
            </div>
        </c:if>

        <!-- 하단 버튼 -->
        <div class="d-flex justify-content-between mt-4">
            <button type="button" id="listBtn" class="btn btn-qna btn-qna-secondary">
                <i class="fa fa-list"></i> 목록
            </button>
            
            <!-- 작성자 본인만 삭제 가능 -->
<%--             <c:if test="${login.id == qna.id}"> --%>
            <c:if test="${!empty login && (login.id == qna.id || login.gradeNo == 9)}">
                <form action="/qna/delete.do" method="post" class="d-inline">
                    <input type="hidden" name="qna_no" value="${qna.qna_no}">
                    <button type="submit" class="btn btn-qna btn-qna-light delete-btn">
                        <i class="fa fa-trash"></i> 삭제
                    </button>
                </form>
            </c:if>
        </div>
    </div>
</body>
</html>