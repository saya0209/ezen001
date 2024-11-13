<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 글수정</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>

    <!-- CSS -->
    <link href="${path}/resources/css/writeAll.css" rel="stylesheet">
	
<script type="text/javascript">
	$(function() {
		// 이미지 미리보기 기능
		$("#imageMain").change(function() {
			const file = this.files[0];
			if (file) {
				// 기존 이미지 숨기기
				$("#currentImage").hide();
				// 새 이미지 미리보기 표시
				const reader = new FileReader();
				reader.onload = function(event) {
					$("#imagePreview").attr("src", event.target.result).show();
				};
				reader.readAsDataURL(file);
			} else {
				// 이미지 선택 안 할 경우 기존 이미지 다시 보이게
				$("#imagePreview").hide();
				$("#currentImage").show();
			}
		});
	});
</script>

<!-- 취소 버튼 -->
<script type="text/javascript">
$(function() {
	$("#cancelBtn").click(function() {
		if (confirm("작성 중인 내용이 사라질 수 있습니다. 정말 취소하시겠습니까?")) {
			history.back();
		}
	});
});
</script>

</head>
<body>
<div class="container">
    <h2>게시글 수정</h2>
    <form action="${path}/community/update.do" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title" value="${vo.title}" required>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" name="content" id="content" rows="7" required>${vo.content}</textarea>
        </div>

        <!-- 기존 이미지가 있으면 미리보기 -->
        <div class="form-group">
            <label>현재 첨부된 이미지</label>
            <div class="card" style="margin-top: 10px;">
                <div class="card-body text-center">
                    <!-- 기존 이미지 보이기 -->
                    <img id="currentImage" src="${path}/upload/community/${vo.image}" alt="현재 첨부된 이미지" style="max-width: 35%;"/>
                    <!-- 새 이미지 미리보기 숨겨짐 -->
                    <img id="imagePreview" alt="새 이미지 미리보기" style="max-width: 35%; display: none;" />
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label for="imageMain">새 이미지 첨부 (선택)</label>
            <input type="file" class="form-control-file" name="file" id="imageMain" accept="image/*" style="max-width: 355px;">
        </div>

        <!-- 등록, 초기화, 취소 버튼 -->
        <input type="hidden" name="community_no" value="${vo.community_no}"/>
        <div class="button-group">
            <button type="submit" class="btn btn-primary">수정</button>
            <button type="reset" class="btn btn-secondary">새로입력</button>
            <button type="button" class="btn btn-outline-secondary" id="cancelBtn">취소</button>
        </div>
    </form>
</div>
</body>
</html>
