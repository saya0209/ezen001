<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 글쓰기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/writeAll.css" rel="stylesheet">

<script type="text/javascript">
$(function() {
    // 이미지 미리 보기 기능
    $("#imageMain").change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                $("#imagePreview").attr("src", event.target.result).show();
            };
            reader.readAsDataURL(file);
        } else {
            $("#imagePreview").hide(); // 이미지 선택 안 하면 미리 보기 숨기기
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
    <h2>게시글 작성</h2>
    <form action="${path}/community/write.do" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title" required>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" name="content" id="content" rows="7" required></textarea>
        </div>
        <!-- 작성자 정보는 세션에서 가져오므로 입력하지 않습니다. -->
        <div class="form-group">
            <label for="file">이미지 첨부 (선택)</label>
            <input type="file" class="form-control-file" name="file" id="imageMain" accept="image/*">
        </div>
        <div class="form-group">
            <div class="card" style="margin-top: 10px;">
                <div class="card-body text-center">
                    <img id="imagePreview" src="#" alt="이미지 미리 보기"
                         style="max-width: 35%; display: none;" />
                </div>
            </div>
        </div>
        <!-- 등록, 초기화, 취소 버튼 -->
        <button type="submit" class="btn btn-primary">등록</button>
        <button type="reset" class="btn btn-secondary">새로입력</button>
        <button type="button" class="btn btn-outline-secondary" id="cancelBtn">취소</button>
    </form>
</div>
</body>
</html>
