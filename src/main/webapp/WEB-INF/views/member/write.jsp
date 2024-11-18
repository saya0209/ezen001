<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>

<script type="text/javascript">
//페이지가 로딩후 세팅한다.
//$(document).ready(function(){~~});
$(function() {
	console.log("jquery loading......");
		
	$("#id").keyup(function() {
		console.log("id keyup event----");
		var id = $("#id").val();
		if(id.length < 3) {
			$("#checkId").removeClass("alert-success alert-danger")
				.addClass("alert-danger");
			// 글자 변경
			$("#checkId").text("아이디는 필수 입력입니다. 3자이상 입력하세요");
		}
		else{
			$.ajax({
        		url : './ConfirmId',
        		data : {
        			id : id
        		},
        		type : 'POST',
        		dataType : 'json',
        		success : function(result) {
        			if (result == true) {
        				$("#checkId").removeClass("alert-success alert-danger")
        				.addClass("alert-success");
        				// 글자 변경
        				$("#checkId").text("(중복검사 실행) 사용 가능한 아이디입니다.");
        			} else{
          				$("#checkId").removeClass("alert-success alert-danger")
        				.addClass("alert-danger");
        				// 글자 변경
        				$("#checkId").text("(중복검사 실행) 중복된 아이디입니다.");
        			}
        		}
        	}); //End Ajax
		}// end of if~else
	});// end of $("#id").keyup()
	
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
	<form action="/member/write.do" method="post" enctype="multipart/form-data">
	  <div class="form-group">
	    <label for="id">아이디</label>
	    <input type="text" class="form-control" maxlength="20"
	    	pattern="^[a-zA-Z][a-zA-Z0-9]{2,19}$" required
	    	placeholder="맨앞글자는 영문자 뒤에는 영문자 또는 숫자 입력, 3~20자"
	    	id="id" name="id" autofocus>
	  </div>
<!-- 아이디 중복 체크 -->	  
	  <div id="checkId" class="alert alert-danger">
	    아이디는 필수 입력입니다. 3글자에서 20자까지 사용합니다.
	  </div>
	  <div class="form-group">
	    <label for="nicname">닉네임</label>
	    <input type="text" class="form-control" maxlength="10"
	    	pattern="^[a-zA-Z가-힝]{2,10}$" required
	    	placeholder="닉네임입력"
	    	title="한글 또는 영문으로 2자이상 10자 이내"
	    	id="nicname" name="nicname">
	  </div>
	  <div class="form-group">
	    <label for="pw">비밀번호</label>
	    <input type="password" class="form-control"
	    	maxlength="20" required
	    	pattern="^.{3,20}$"
	    	placeholder="비밀번호 입력" id="pw" name="pw">
	  </div>
	  <div id="pwDiv" class="alert alert-danger">
	    비밀번호는 필수 입력입니다. 3글자에서 20자까지 사용합니다.
	  </div>
	  <div class="form-group">
	    <label for="pw2">비밀번호확인</label>
	    <input type="password" class="form-control"
	    	maxlength="20" required
	    	pattern="^.{3,20}$"
	    	placeholder="비밀번호 입력" id="pw2">
	  </div>
	  <div id="pw2Div" class="alert alert-danger">
	    비밀번호확인은 필수 입력입니다. 3글자에서 20자까지 사용합니다.
	  </div>
	  <div class="form-group">
	    <label for="tel">연락처</label>
	    <input type="text" class="form-control"
	    	placeholder="xxx-xxxx-xxxx"
	    	id="tel" name="tel">
	  </div>
	  <div class="form-group">
	    <label for="email">이메일</label>
	    <input type="email" class="form-control" required
	    	placeholder="id@도메인"
	    	id="email" name="email">
	  </div>
	  <div class="form-group">
	    <label for="address">주소</label>
	    <input type="text" class="form-control" required
	    	placeholder="배송받을 주소를 상세히 써주세요."
	    	id="address" name="address">
	  </div>
	  <button type="submit" class="btn btn-primary">가입</button>
	  <button type="reset" class="btn btn-secondary">다시입력</button>
	  <button type="button" onclick="history.back()" class="btn btn-warning">취소</button>
	</form>
</div>
</body>
</html>