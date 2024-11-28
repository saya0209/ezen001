<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>견적 요청 상세</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>
    <!-- CSS -->
    <link href="${path}/resources/css/estimate.css" rel="stylesheet">

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
    <div class="estimate-container">
        <h2 class="estimate-title">
            <i class="fa fa-file-text-o"></i> 견적 요청 상세
        </h2>

        <!-- 견적 요청 상세 정보 -->
        <div class="card mb-4">
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <div>
                    <span class="category-badge category-${fn:toLowerCase(request.category)}">
                        ${request.category}
                    </span>
                    <span class="ml-2 status-${request.status}">
                        <i class="fa fa-circle mr-1"></i>
                        ${request.status == 'waiting' ? '대기중' : '답변완료'}
                    </span>
                </div>
                <small class="text-muted">
                    <i class="fa fa-clock-o"></i> 
                    <fmt:formatDate value="${request.request_date}" pattern="yyyy-MM-dd HH:mm"/>
                </small>
            </div>
            <div class="card-body">
                <h5 class="card-title">${request.title}</h5>
                <h6 class="card-subtitle mb-3 text-muted">
                    <i class="fa fa-user-o"></i> ${request.nicname}
                </h6>
                <p class="card-text">${request.content}</p>
            </div>
        </div>

        <!-- 답변 목록 -->
        <div class="answers-container">
            <c:forEach items="${answers}" var="answer">
                <div class="answer-section mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h6 class="mb-1">
                                <i class="fa fa-comment-o"></i> 관리자 답변: ${answer.title}
                            </h6>
                        </div>
                        <small class="text-muted">
                            <i class="fa fa-clock-o"></i>
                            <fmt:formatDate value="${answer.answer_date}" pattern="yyyy-MM-dd HH:mm"/>
                        </small>
                    </div>
                    <p class="mb-3">${answer.content}</p>
                    
                    <!-- 관리자만 답변 삭제 및 수정 가능 -->
                    <c:if test="${login.gradeNo == 9}">
                        <form action="/estimate/deleteAnswer.do" method="post" class="d-inline">
                            <input type="hidden" name="answer_no" value="${answer.answer_no}">
                            <input type="hidden" name="request_no" value="${request.request_no}">
                            <button type="submit" class="btn btn-sm btn-outline-secondary delete-btn">
                                <i class="fa fa-trash"></i>
                            </button>
                        </form>
                        <form action="/estimate/updateAnswerForm.do" method="get" class="d-inline">
                            <input type="hidden" name="answer_no" value="${answer.answer_no}">
                            <input type="hidden" name="request_no" value="${request.request_no}">
                            <button type="submit" class="btn btn-sm btn-outline-secondary ml-2">
                                <i class="fa fa-pencil"></i>
                            </button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <!-- 관리자용 답변 작성 폼 -->
        <c:if test="${login.gradeNo == 9 && request.status == 'waiting'}">
            <div class="mt-4">
                <jsp:include page="writeAnswer.jsp"></jsp:include>
            </div>
        </c:if>

        <!-- 하단 버튼 -->
        <div class="d-flex justify-content-between mt-4">
            <button type="button" id="listBtn" class="btn btn-outline-secondary">
                <i class="fa fa-list"></i> 목록
            </button>

            <!-- 작성자 본인, 관리자만 삭제 및 수정 가능 -->
            <c:if test="${login != null && (login.id == vo.id || login.gradeNo == 9)}">
                <div>
                    <form action="/estimate/delete.do" method="post" class="d-inline">
                        <input type="hidden" name="request_no" value="${request.request_no}">
                        <button type="submit" class="btn btn-outline-secondary delete-btn">
                            <i class="fa fa-trash"></i> 삭제
                        </button>
                    </form>
                    <form action="/estimate/updateForm.do" method="get" class="d-inline ml-2">
                        <input type="hidden" name="request_no" value="${request.request_no}">
                        <button type="submit" class="btn btn-outline-secondary">
                            <i class="fa fa-pencil"></i> 수정
                        </button>
                    </form>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
