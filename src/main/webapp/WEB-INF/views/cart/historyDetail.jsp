<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 상세</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>
    <style>
        .table th, .table td { vertical-align: middle; }
        .product-image { width: 80px; height: 80px; object-fit: cover; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1>결제 상세</h1>
                <p>결제 ID: ${history.orderNumber}</p>
                <p>결제 날짜: <fmt:formatDate value="${history.paymentDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                <p>결제 상태: ${history.status}</p>
                <p>결제 아이디: ${history.id}</p>
                <p>총 결제 금액: <fmt:formatNumber value="${history.totalAmount}" pattern="#,###" />원</p>
            </div>
            <div class="card-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>상품명</th>
                            <th>가격</th>
                            <th>수량</th>
                            <th>상품 총 가격</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${paymentDetails}" var="detail">
                            <tr>
                                <td>${detail.goods_name}</td>
                                <td><fmt:formatNumber value="${detail.price}" pattern="#,###" />원</td>
                                <td>${detail.quantity}</td>
                                <td><fmt:formatNumber value="${detail.goods_total_price}" pattern="#,###" />원</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <!-- 돌아가기 버튼에 id 전달 -->
                <a href="/cart/history?id=${history.id}" class="btn btn-secondary">결제 기록으로 돌아가기</a>
            </div>
        </div>
    </div>
</body>
</html>
