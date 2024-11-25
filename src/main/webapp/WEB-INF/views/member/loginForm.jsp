<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>

<!-- CSS -->
<link href="${path}/resources/css/loginForm.css" rel="stylesheet">

<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#writeBtn").click(function() {
            location.href = "writeForm.do";
        });
    });
</script>
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-5">
                <div class="login-box">
                    <h1 class="heading text-center">로그인</h1>
                    <p class="sub-heading text-center">안녕하세요! 로그인 정보를 입력해주세요.</p>
                    
                    <form action="login.do" method="post" class="mt-4">
                        <div class="form-group">
                            <label for="id">아이디</label>
                            <input type="text" class="form-control" name="id" id="id" 
                                   placeholder="아이디를 입력해주세요" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="pw">비밀번호</label>
                            <input type="password" class="form-control" name="pw" id="pw" 
                                   placeholder="비밀번호를 입력해주세요" required>
                        </div>
                        
                        <div class="form-row align-items-center mb-4">
                            <div class="col">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="rememberMe">
                                    <label class="custom-control-label" for="rememberMe">로그인 상태 유지</label>
                                </div>
                            </div>
                            <div class="col-auto">
                                <a href="#" class="forgot-link">비밀번호 찾기</a>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-block">
                            로그인
                        </button>
                        
                        <div class="social-login-divider">
                            <span>또는</span>
                        </div>
                        
                        <button type="button" class="btn btn-kakao btn-block">
                            <i class="fa fa-comment"></i>
                            카카오톡으로 시작하기
                        </button>
                        
                        <button type="button" class="btn btn-naver btn-block">
                            <strong>N</strong>
                            네이버로 시작하기
                        </button>
                        
                        <button type="button" class="btn btn-google btn-block">
                            <i class="fa fa-google"></i>
                            Google로 시작하기
                        </button>
                        
                        <p class="text-center mt-4 signup-text">
                            아직 회원이 아니신가요? <a href="#" id="writeBtn">회원가입</a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
