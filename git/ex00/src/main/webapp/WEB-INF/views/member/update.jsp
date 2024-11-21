<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
	<!-- datepicker -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>

<!-- 2. 라이브러리 등록확인 -->
<script type="text/javascript">
//페이지가 로딩후 세팅한다.
//$(document).ready(function(){~~});
$(function() {
	console.log("jquery loading......");
	
	// 비밀번호와 비밀번호 확인 이벤트
	$("#pw, #pw2").keyup(function(){
		let pw = $("#pw").val();
		let pw2 = $("#pw2").val();
		
		// 비밀번호 길이 체크
		if (pw.length < 3) {
			// 디자인관련 class적용
			$("#pwDiv").removeClass("alert-success alert-danger")
				.addClass("alert-danger");
			// 글자
			$("#pwDiv").text("비밀번호는 필수입력입니다. 3자이상 입력하세요.");
		}
		else {
			// 디자인관련 class적용
			$("#pwDiv").removeClass("alert-success alert-danger")
				.addClass("alert-success");
			// 글자
			$("#pwDiv").text("사용할 수 있는 비밀번호 입니다.");
		}
		
		// 비밀번호 확인 길이 체크
		if (pw2.length < 3) {
			// 디자인관련 class적용
			$("#pw2Div").removeClass("alert-success alert-danger")
				.addClass("alert-danger");
			// 글자
			$("#pw2Div").text("비밀번호확인은 필수입력입니다. 3자이상 입력하세요.");
		}
		else {
			if (pw != pw2) {
				// 디자인관련 class적용
				$("#pw2Div").removeClass("alert-success alert-danger")
					.addClass("alert-danger");
				// 글자
				$("#pw2Div").text("비밀번호와 일치하지 않습니다.");
			}
			else {
				// 디자인관련 class적용
				$("#pw2Div").removeClass("alert-success alert-danger")
					.addClass("alert-success");
				// 글자
				$("#pw2Div").text("비밀번호와 일치합니다.");
			}
		}
		
	});// end of $("#pw, #pw2").keyup()
	
});
</script>

</head>
<body>
<!-- 정규표현식 -->
<!-- 시작:^,끝:$ -->
<!-- []:한글자의 패턴 -->
<!-- ^가 앞에있으면 사용불가표시 -->
<!-- .은 엔터를 제외한 모든문자 -->
<!-- {최소,최대}:앞에쓰여진 패턴이 적용되는 최소와 최대 -->
<!-- 알파벳과한글사용가능한패턴이 3,20자 => ^[a-z가-힣]{3,20}$ -->
<!-- 공백을 제외한 모든가 가능한 3,20자 => ^[^ .]{3,20}$ -->
<div class="container">
	<form action="/member/update.do" method="post">
	<input type="hidden" name="gradeNo" value="${vo.gradeNo }">
	  <div class="form-group">
	    <label for="id">아이디</label>
	    <input type="text" class="form-control" readonly
	     name="id" value="${vo.id }">
	  </div>
	  <div class="form-group">
	  	<label for="nicname">닉네임</label>
	    <input type="text" class="form-control" maxlength="10"
	    	pattern="^[a-zA-Z가-힝]{2,10}$" required
	    	placeholder="이름입력"
	    	title="한글 또는 영문으로 2자이상 10자 이내"
	    	id="nicname" name="nicname" value="${vo.nicname }">
	  </div>
	  
	  <div class="form-group">
	    <label for="email">이메일</label>
	    <input type="email" class="form-control" required
	    	placeholder="id@도메인"
	    	id="email" name="email" value="${vo.email }">
	  </div>
	  
	  <div class="form-group">
	    <label for="tel">연락처</label>
	    <input type="text" class="form-control"
	    	placeholder="xxx-xxxx-xxxx"
	    	id="tel" name="tel" value="${vo.tel }">
	  </div>

	  <div class="form-group">
	    <label for="pw">비밀번호확인</label>
	    <input type="password" class="form-control"
	    	maxlength="20" required
	    	pattern="^.{3,20}$"
	    	placeholder="비밀번호 입력" id="pw" name="pw">
	  </div>
	  <div id="pwDiv" class="alert alert-danger">
	    수정을 위해 비밀번호는 필수 입력입니다. 3글자에서 20자까지 사용합니다.
	  </div>
	  <button type="submit" class="btn btn-primary">수정</button>
	  <button type="reset" class="btn btn-secondary">다시입력</button>
	  <button type="button" onclick="history.back()" class="btn btn-warning">취소</button>
	</form>
</div>
</body>
</html>