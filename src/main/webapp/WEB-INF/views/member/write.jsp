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
		
	<!-- CSS -->
	<link href="${path}/resources/css/signUp.css" rel="stylesheet">
	
    <script>
        $(function() {
            // 아이디 중복 체크
            $("#id").keyup(function() {
                let id = $(this).val();
                if(id.length < 3) {
                    $("#checkId")
                        .removeClass("alert-success")
                        .addClass("alert-danger")
                        .html('<i class="fa fa-info-circle"></i> 아이디는 3자 이상 입력해주세요.');
                } else {
                    $("#checkId").load("/member/checkId.do?id=" + id, function(result) {
                        if(result.indexOf("중복") >= 0) {
                            $(this)
                                .removeClass("alert-success")
                                .addClass("alert-danger");
                        } else {
                            $(this)
                                .removeClass("alert-danger")
                                .addClass("alert-success");
                        }
                    });
                }
            });

            // 비밀번호 확인
            $("#pw, #pw2").keyup(function() {
                let pw = $("#pw").val();
                let pw2 = $("#pw2").val();

                // 비밀번호 검증
                if(pw.length < 3) {
                    $("#pwDiv")
                        .removeClass("alert-success")
                        .addClass("alert-danger")
                        .html('<i class="fa fa-info-circle"></i> 비밀번호는 3자 이상 입력해주세요.');
                } else {
                    $("#pwDiv")
                        .removeClass("alert-danger")
                        .addClass("alert-success")
                        .html('<i class="fa fa-check-circle"></i> 사용 가능한 비밀번호입니다.');
                }

                // 비밀번호 확인 검증
                if(pw2.length < 3) {
                    $("#pw2Div")
                        .removeClass("alert-success")
                        .addClass("alert-danger")
                        .html('<i class="fa fa-info-circle"></i> 비밀번호 확인을 입력해주세요.');
                } else if(pw !== pw2) {
                    $("#pw2Div")
                        .removeClass("alert-success")
                        .addClass("alert-danger")
                        .html('<i class="fa fa-times-circle"></i> 비밀번호가 일치하지 않습니다.');
                } else {
                    $("#pw2Div")
                        .removeClass("alert-danger")
                        .addClass("alert-success")
                        .html('<i class="fa fa-check-circle"></i> 비밀번호가 일치합니다.');
                }
            });
        });
    </script>

</head>
<body>
    <div class="container signup-container">
        <h2 class="form-title text-center">
            <i class="fa fa-user-plus"></i> 회원가입
        </h2>
        
        <form action="/member/write.do" method="post" enctype="multipart/form-data">
            <!-- 아이디 -->
            <div class="form-group">
                <label for="id">
                    아이디 <span class="required-mark">*</span>
                </label>
                <input type="text" class="form-control" id="id" name="id"
                    pattern="^[a-zA-Z][a-zA-Z0-9]{2,19}$" required
                    placeholder="영문으로 시작하는 3~20자의 영문/숫자 조합">
                <div id="checkId" class="alert alert-danger">
                    <i class="fa fa-info-circle"></i> 아이디는 필수 입력입니다. 3글자 이상 입력해주세요.
                </div>
            </div>

            <!-- 닉네임 -->
            <div class="form-group">
                <label for="nicname">
                    닉네임 <span class="required-mark">*</span>
                </label>
                <input type="text" class="form-control" id="nicname" name="nicname"
                    pattern="^[a-zA-Z가-힣]{2,10}$" required
                    placeholder="한글 또는 영문으로 2~10자">
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
                <label for="pw">
                    비밀번호 <span class="required-mark">*</span>
                </label>
                <input type="password" class="form-control" id="pw" name="pw"
                    pattern="^.{3,20}$" required
                    placeholder="3자 이상의 비밀번호를 입력해주세요">
                <div id="pwDiv" class="alert alert-danger">
                    <i class="fa fa-info-circle"></i> 비밀번호는 필수 입력입니다.
                </div>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group">
                <label for="pw2">
                    비밀번호 확인 <span class="required-mark">*</span>
                </label>
                <input type="password" class="form-control" id="pw2" required
                    pattern="^.{3,20}$"
                    placeholder="비밀번호를 한번 더 입력해주세요">
                <div id="pw2Div" class="alert alert-danger">
                    <i class="fa fa-info-circle"></i> 비밀번호 확인이 필요합니다.
                </div>
            </div>

            <!-- 연락처 -->
            <div class="form-group">
                <label for="tel">연락처</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fa fa-phone"></i>
                        </span>
                    </div>
                    <input type="tel" class="form-control" id="tel" name="tel"
                        placeholder="예) 010-1234-5678">
                </div>
            </div>

            <!-- 이메일 -->
            <div class="form-group">
                <label for="email">
                    이메일 <span class="required-mark">*</span>
                </label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fa fa-envelope"></i>
                        </span>
                    </div>
                    <input type="email" class="form-control" id="email" name="email"
                        required placeholder="예) example@domain.com">
                </div>
            </div>

            <!-- 주소 -->
            <div class="form-group">
                <label for="address">
                    주소 <span class="required-mark">*</span>
                </label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">
                            <i class="fa fa-home"></i>
                        </span>
                    </div>
                    <input type="text" class="form-control" id="address" name="address"
                        required placeholder="배송받을 주소를 상세히 입력해주세요">
                </div>
            </div>

            <!-- 버튼 그룹 -->
			<div class="btn-group">
			    <button type="submit" class="btn btn-primary btn-sm">
			        <i class="fa fa-check-circle"></i>
			        가입하기
			    </button>
			    <button type="reset" class="btn btn-outline-secondary btn-sm">
			        다시입력
			    </button>
			    <button type="button" onclick="history.back()" class="btn btn-outline-secondary btn-sm">
			        취소
			    </button>
			</div>
        </form>
    </div>

</body>
</html>