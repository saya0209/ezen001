<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#writeFormBtn").click(function() {
            location.href = "writeForm.do";
        });
    });
</script>
</head>
<body>
<div class="container">
	<h2>마이페이지</h2>
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link" href="#">주문리스트</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#">장바구니</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#">회원정보 수정</a>
		</li>
	</ul>

</div>



</body>
</html>
