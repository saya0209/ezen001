<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 작성</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/qna.css" rel="stylesheet">

<script>
$(document).ready(function() {

    // 취소 버튼 클릭 시 확인
    $('#cancelBtn').click(function() {
        if (confirm("작성 중인 답변이 사라집니다. 정말 취소하시겠습니까?")) {
            history.back();
        }
    });
});
</script>
</head>
<body>
    <div class="answer-container">
        <h2 class="answer-title">
            <i class="fa fa-comments-o"></i> 답변 작성
        </h2>

        <!-- 원본 질문 표시 -->
        <div class="original-question">
            <h5 class="mb-3">[${qna.category}] ${qna.title}</h5>
            <p class="mb-2">${qna.content}</p>
            <small class="text-muted">
                작성자: ${qna.nicname} | 
                작성일: <fmt:formatDate value="${qna.writeDate}" pattern="yyyy-MM-dd HH:mm"/>
            </small>
        </div>

        <!-- 답변 작성 폼 -->
        <div class="card">
            <div class="card-body">
                <form action="/qna/writeAnswer.do" method="post" id="answerForm">
                    <!-- 원본 글 번호 (hidden) -->
                    <input type="hidden" name="parentNo" value="${qna.qna_no}">

                    <!-- 답변 제목 -->
                    <div class="form-group">
                        <label for="answer_title" class="required-field">답변 제목</label>
                        <input type="text" class="form-control" id="answer_title" 
                               name="answer_title" required maxlength="100"
                               placeholder="답변 제목을 입력하세요">
                        <div class="invalid-feedback">답변 제목을 입력해주세요.</div>
                    </div>

                    <!-- 답변 내용 -->
                    <div class="form-group">
                        <label for="answer_content" class="required-field">답변 내용</label>
                        <textarea class="form-control" id="answer_content" 
                                name="answer_content" rows="10" required
                                placeholder="답변 내용을 입력하세요"></textarea>
                        <div class="invalid-feedback">답변 내용을 입력해주세요.</div>
                    </div>

                    <!-- 버튼 영역 -->
                    <div class="text-right">
                        <button type="button" id="cancelBtn" 
                                class="btn btn-answer btn-answer-secondary mr-2">
                            <i class="fa fa-times"></i> 취소
                        </button>
                        <button type="submit" class="btn btn-answer btn-answer-primary">
                            <i class="fa fa-paper-plane"></i> 답변 등록
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>