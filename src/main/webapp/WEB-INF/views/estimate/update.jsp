<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>견적 요청 수정</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>
    <!-- CSS -->
    <link href="${path}/resources/css/estimate.css" rel="stylesheet">
    <script type="text/javascript">
        $(function() {
            // 취소 버튼 클릭 시 확인 다이얼로그
            $("#cancelBtn").click(function() {
                if (confirm("작성 중인 내용이 사라질 수 있습니다. 정말 취소하시겠습니까?")) {
                    location.href = "view.do?request_no=${request.request_no}";
                }
            });
        });
    </script>
</head>
<body>
<div class="estimate-container">
    <h2 class="page-title">
        <i class="fa fa-pencil-square-o"></i> 견적 요청 수정
    </h2>

    <div class="card">
        <div class="card-body">
            <form class="form-estimate" action="update.do" method="post">
                <!-- 요청 번호 (hidden) -->
                <input type="hidden" name="request_no" value="${request.request_no}">

                <!-- 제목 입력 -->
                <div class="form-group">
                    <label for="title" class="required-field">제목</label>
                    <input type="text" class="form-control" id="title" name="title"
                           value="${request.title}" required maxlength="100" placeholder="견적 요청 제목을 입력하세요">
                    <div class="invalid-feedback">제목을 입력해주세요.</div>
                </div>

                <!-- 카테고리 선택 -->
                <div class="form-group">
                    <label for="category" class="required-field">카테고리</label>
                    <select class="form-control" id="category" name="category" required>
                        <option value="">카테고리 선택</option>
                        <option value="cpu" ${request.category == 'CPU' ? 'selected' : ''}>CPU</option>
                        <option value="motherboard" ${request.category == '메인보드' ? 'selected' : ''}>메인보드</option>
                        <option value="ram" ${request.category == '메모리 (RAM)' ? 'selected' : ''}>메모리 (RAM)</option>
                        <option value="gpu" ${request.category == '그래픽카드' ? 'selected' : ''}>그래픽카드</option>
                        <option value="storage" ${request.category == '저장장치 (SSD/HDD)' ? 'selected' : ''}>저장장치 (SSD/HDD)</option>
                        <option value="case" ${request.category == '케이스' ? 'selected' : ''}>케이스</option>
                        <option value="power" ${request.category == '파워서플라이' ? 'selected' : ''}>파워서플라이</option>
                        <option value="cooling" ${request.category == '쿨링' ? 'selected' : ''}>쿨링</option>
                        <option value="complete" ${request.category == '완성품 PC' ? 'selected' : ''}>완성품 PC</option>
                    </select>
                    <div class="invalid-feedback">카테고리를 선택해주세요.</div>
                </div>

                <!-- 예산 입력 -->
                <div class="form-group">
                    <label for="budget" class="required-field">예산</label>
                    <div class="input-group">
                        <input type="number" class="form-control" id="budget" name="budget"
                               value="${request.budget}" required min="0" step="10000" placeholder="예산을 입력하세요">
                        <div class="input-group-append">
                            <span class="input-group-text">원</span>
                        </div>
                    </div>
                    <div class="invalid-feedback">예산을 입력해주세요.</div>
                </div>

                <!-- 내용 입력 -->
                <div class="form-group">
                    <label for="content" class="required-field">상세 내용</label>
                    <textarea class="form-control" id="content" name="content" rows="10"
                              required placeholder="필요한 사양과 용도 등 상세한 내용을 입력해주세요">${request.content}</textarea>
                    <div class="invalid-feedback">내용을 입력해주세요.</div>
                </div>

                <!-- 버튼 영역 -->
                <div class="text-right">
                    <button type="button" class="btn btn-secondary mr-2" id="cancelBtn">
                        <i class="fa fa-times"></i> 취소
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-check"></i> 수정 완료
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
