<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 수정</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/estimate.css" rel="stylesheet">

<script>
$(document).ready(function() {
    // 취소 버튼 클릭 시 확인
    $('#cancelBtn').click(function() {
        if (confirm("작성 중인 수정 내용이 사라집니다. 정말 취소하시겠습니까?")) {
            history.back();
        }
    });
});
</script>

</head>
<body>
    <div class="answer-container">
        <h2 class="answer-title">
            <i class="fa fa-comments-o"></i> 견적 답변 수정
        </h2>

		<!-- 원본 질문 표시 -->
		<div class="original-question">
		    <h5 class="mb-3">[${request.category}] ${request.title}</h5>
		    <p class="mb-2">${request.content}</p>
		    <div class="estimate-price-badge mb-2">
		        예산: <fmt:formatNumber value="${request.budget}" type="number" pattern="#,###원"/>
		    </div>
		    <small class="text-muted">
		        작성자: ${request.nicname} | 
		        작성일: <fmt:formatDate value="${request.request_date}" pattern="yyyy-MM-dd HH:mm"/>
		    </small>
		</div>

        <!-- 답변 수정 폼 -->
        <div class="card">
            <div class="card-body">
                <form action="updateAnswer.do" method="post">
                    <!-- 답변 번호 및 요청 번호 (hidden) -->
                    <input type="hidden" name="answer_no" value="${answer.answer_no}">
                    <input type="hidden" name="request_no" value="${request_no}">
                    <input type="hidden" name="parentNo" value="${request_no}">

                    <!-- 답변 제목 -->
                    <div class="form-group">
                        <label for="answer-title" class="required-field">제목</label>
                        <input type="text" class="form-control" id="answer-title" 
                               name="title" value="${answer.title}" required maxlength="100"
                               placeholder="답변 제목을 입력하세요">
                        <div class="invalid-feedback">답변 제목을 입력해주세요.</div>
                    </div>

                    <!-- 답변 내용 -->
                    <div class="form-group">
                        <label for="answer-content" class="required-field">답변 내용</label>
                        <textarea class="form-control" id="answer-content" name="content" 
                                  rows="5" required placeholder="견적 답변 내용을 작성해주세요">${answer.content}</textarea>
                        <div class="invalid-feedback">답변 내용을 입력해주세요.</div>
                    </div>

                    <!-- 견적 금액 -->
                    <div class="form-group">
                        <label for="total-price" class="required-field">견적 금액</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="total-price" 
                                   name="total_price" value="${answer.total_price}" required min="0" step="10000" 
                                   placeholder="견적 금액을 입력하세요">
                            <div class="input-group-append">
                                <span class="input-group-text">원</span>
                            </div>
                        </div>
                        <div class="invalid-feedback">견적 금액을 입력해주세요.</div>
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="text-right">
                        <button type="button" id="cancelBtn" class="btn btn-answer btn-answer-secondary mr-2">
                            <i class="fa fa-times"></i> 취소
                        </button>
                        <button type="submit" class="btn btn-answer btn-answer-primary">
                            <i class="fa fa-save"></i> 수정 완료
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
