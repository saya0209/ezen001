<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- update.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글수정</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/writeAll.css" rel="stylesheet">

<script type="text/javascript">
$(function() {
    // 날짜 입력 설정
    let now = new Date();
    let startYear = now.getFullYear();
    let yearRange = (startYear - 10) + ":" + (startYear + 10);
    
    $(".datepicker").datepicker({
        dateFormat : "yy-mm-dd",
        changeMonth: true,
        changeYear: true,
        monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
        dayNamesMin: ["일","월","화","수","목","금","토"],
        yearRange : yearRange
    });

    // 이미지 미리보기 기능
    $("#uploadFiles").change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                $("#imagePreview").attr("src", event.target.result).show();
            };
            reader.readAsDataURL(file);
        }
    });

    // 이미지 삭제 버튼 클릭 시 처리
    $("#deleteImageBtn").click(function() {
        if (confirm("정말로 이미지를 삭제하시겠습니까?")) {
            $.ajax({
                url: "deleteImage.do",  // 해당 URL이 처리하는 메서드를 컨트롤러에서 구현해야 합니다.
                type: "POST",
                data: { fileName: "${vo.files}" },
                success: function(response) {
                    alert("이미지가 삭제되었습니다.");
                    location.reload(); // 페이지 새로고침
                },
                error: function() {
                    alert("이미지 삭제에 실패했습니다.");
                }
            });
        }
    });
});
</script>

<!-- 취소버튼 -->
<script type="text/javascript">
$(function() {
    $("#cancelBtn").click(function() {
        window.location.href = 'list.do'; // 취소 버튼 클릭 시 리스트 페이지로 리다이렉트
    });
});
</script>

</head>
<body>
<div class="container">
	<h2>공지사항 글수정</h2>
	<form action="update.do" method="post" enctype="multipart/form-data">
		<!-- 수정할 공지사항 번호 -->
	    <input type="hidden" name="notice_no" value="${vo.notice_no}">
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" value="${vo.title }" name="title" id="title" required>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<!-- 내용 수정 가능 -->
			<textarea class="form-control" name="content" id="content" rows="7" required>${vo.content }</textarea>
		</div>
		
		<!-- 기존 이미지 미리보기 -->
		<div class="form-group">
		    <label>기존 이미지</label>
		    <div id="imagePreview" class="d-flex flex-wrap">
		        <!-- 기존 이미지가 있으면 미리보기 -->
		        <c:if test="${!empty vo.files}">
		            <img src="${path}/upload/${vo.files}" alt="기존 이미지" style="width:100px; height:100px; margin-right:10px;">
		            <button type="button" class="btn btn-danger" id="deleteImageBtn">이미지 삭제</button>
		        </c:if>
		        <!-- 이미지가 없으면 텍스트 표시 -->
		        <c:if test="${empty vo.files}">
		            <p>현재 이미지가 없습니다.</p>
		        </c:if>
		    </div>
		</div>

        <!-- 새 이미지 업로드 -->
        <div class="form-group">
            <label for="uploadFiles">새 이미지 선택</label>
            <input type="file" name="uploadFile" id="uploadFiles" class="form-control">
        </div>

		<div class="form-group row">
            <div class="col-md-4">
                <label for="startDate">게시시작일</label>
                <fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd" var="varStartDate"/>
				<!-- 시작일 수정 가능 -->
				<input class="form-control datepicker" value="${varStartDate }" name="startDate" id="startDate" required>
            </div>
            <div class="col-md-4">
                <label for="endDate">게시종료일</label>
                <fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd" var="varEndDate"/>
                <!-- 종료일 수정 가능 -->
				<input class="form-control datepicker" value="${varEndDate }" name="endDate" id="endDate" required>
            </div>
        </div>
        
		<!-- form tag에서 <button>에 type이 없으면 submit -->
		<button class="btn btn-outline-primary">수정사항 등록</button>
		<button type="reset" class="btn btn-outline-success">새로입력</button>
		<button type="button" class="btn btn-outline-secondary" id="cancelBtn">취소</button>
	</form>
</div>
</body>
</html>
