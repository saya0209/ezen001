<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 작성</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/writeAll.css" rel="stylesheet">

<script type="text/javascript">
$(function() {
	// 이벤트 처리
    let now = new Date();
    let startYear = now.getFullYear();
    let yearRange = (startYear - 10) + ":" + (startYear + 10);
    
    // 날짜 입력 설정
    $(".datepicker").datepicker({
        // 입력란의 데이터 포맷
        dateFormat : "yy-mm-dd",
        // 월 선택 추가
        changeMonth: true,
        // 년 선택 추가
        changeYear: true,
        // 월 선택 입력(기본:영어->한글)
        monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
        // 달력의 요일 표시 (기본:영어->한글)
        dayNamesMin: ["일","월","화","수","목","금","토"],
        // 선택할 수 있는 년도의 범위
        yearRange : yearRange
    });

	// 이미지 미리 보기 기능
    $("#imageMain").change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                $("#imagePreview").attr("src", event.target.result).show();
            };
            reader.readAsDataURL(file);
        }
    });	
});
</script>

<!-- 취소 버튼 -->
<script type="text/javascript">
$(function() {
	$("#cancelBtn").click(function() {
		history.back();
	});
	
});
</script>

</head>
<body>

<div class="container">
    <h2>새 이벤트 작성</h2>
    <form action="write.do" method="post" enctype="multipart/form-data">
    
         <div class="form-group">
            <label for="title">이벤트 제목</label>
            <input class="form-control" name="title" id="title" required>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" name="content" id="content" rows="7" required></textarea>
        </div>

			<div class="form-group">
				<!-- 파일로 넘어가는 데이터는 GoodsVO 객체 -->
				<label for="imageMain">이미지 등록</label> <input type="file"
					class="form-control" id="imageMain" name="imageMain" required
					accept="image/*" style="max-width: 355px;">
			</div>
			
			<div class="form-group">
				<div class="card" style="margin-top: 10px;">
					<div class="card-body text-center">
						<img id="imagePreview" src="#" alt="이미지 미리 보기"
							style="max-width: 35%;" />
					</div>
				</div>
			</div>

        <div class="form-group row">
            <div class="col-md-4">
                <label for="startDate">이벤트 시작일</label>
                <input type="text" class="form-control datepicker" name="startDate" id="startDate" required>
            </div>
            <div class="col-md-4">
                <label for="endDate">이벤트 종료일</label>
                <input type="text" class="form-control datepicker" name="endDate" id="endDate" required>
            </div>
        </div>

        <button class="btn btn-outline-primary">이벤트 등록</button>
        <button type="reset" class="btn btn-outline-success">새로입력</button>
        <button type="button" class="btn btn-outline-secondary" id="cancelBtn">취소</button>
    </form>
</div>

</body>
</html>
