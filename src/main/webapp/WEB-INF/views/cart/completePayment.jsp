<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 완료</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
	    <div class="card">
		  <div class="card-header">
			<h2>결제 완료</h2>
		  </div>
		  <div class="card-body">
			<p>${message}</p> <!-- 결제 완료 메시지 출력 -->
	        <p>사용자 ID : ${id}</p>
	        <p>주문 번호 : ${orderNumber}</p>
		  </div>
		  <div class="card-footer">
	        <a href="${pageContext.request.contextPath}/cart/list/${id}" class="btn btn-primary">장바구니로 돌아가기</a>
		  </div>
		</div>
        
        
    </div>
</body>
</html>