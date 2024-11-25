<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 작성</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/qna.css" rel="stylesheet">

<script type="text/javascript">
$(function() {

    // 취소 버튼 클릭 시 확인 다이얼로그
    $("#cancelBtn").click(function() {
        if (confirm("작성 중인 내용이 사라질 수 있습니다. 정말 취소하시겠습니까?")) {
            history.back();
        }
    });
});
</script>

</head>
<body>
<div class="qna-container">
        <h2 class="qna-title">
            <i class="fa fa-pencil-square-o"></i> 질문 작성
        </h2>

        <div class="card">
            <div class="card-body">
                <form action="/qna/write.do" method="post" id="writeForm">
				    <!-- 카테고리 선택 -->
				    <div class="form-group">
				        <label for="category" class="required-field">카테고리</label>
				        <select class="form-control" id="category" name="category" required>
				            <option value="">카테고리를 선택하세요</option>
				            <option value="delivery">배송</option>
				            <option value="payment">결제 및 환불</option>
				            <option value="inquiry">단순문의</option>
				        </select>
				        <div class="invalid-feedback">카테고리를 선택해주세요.</div>
				    </div>
				
				    <!-- 제목 입력 -->
				    <div class="form-group">
				        <label for="title" class="required-field">제목</label>
				        <input type="text" class="form-control" id="title" name="title" 
				               required maxlength="100" placeholder="제목을 입력하세요">
				        <div class="invalid-feedback">제목을 입력해주세요.</div>
				    </div>
				
				    <!-- 내용 입력 -->
				    <div class="form-group">
				        <label for="content" class="required-field">내용</label>
				        <textarea class="form-control" id="content" name="content" 
				                rows="10" required placeholder="내용을 입력하세요"></textarea>
				        <div class="invalid-feedback">내용을 입력해주세요.</div>
				    </div>
				
				    <!-- Hidden Fields -->
				    <input type="hidden" name="status" value="waiting">
				    
				    <!-- 버튼 영역 -->
				    <div class="text-right">
				        <button type="button" class="btn btn-qna btn-qna-secondary mr-2" id="cancelBtn">
				            <i class="fa fa-times"></i> 취소
				        </button>
				        <button type="submit" class="btn btn-qna btn-qna-primary">
				            <i class="fa fa-check"></i> 등록
				        </button>
				    </div>
				</form>
            </div>
        </div>
    </div>
</body>
</html>
