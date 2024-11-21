<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
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
<body>
<div class="container">
    <h3>로그인 폼</h3>
    <form action="login.do" method="post">
        <div class="form-group">
            <label for="id">ID</label>
            <input type="text" class="form-control" name="id" id="id" placeHolder="ID입력" required>
        </div>
        <div class="form-group">
            <label for="pw">Password</label>
            <input type="password" class="form-control" name="pw" id="pw" required placeHolder="password 입력">
        </div>
        
        <!-- 오류 메시지 출력 영역 -->
        <div class="form-group" style="color: red; margin-top: 10px;">
            ${msg} <!-- rttr.addFlashAttribute로 전달된 msg 출력 -->
        </div>
        
        <button type="submit" class="btn btn-primary">로그인</button>
        <button type="button" class="btn btn-success" id="writeBtn">회원가입</button>
    </form>

</div>
</body>
</html>
