<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 기록</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include> <!-- 공통 라이브러리 파일 -->
    <style type="text/css">
        .quantity-control { display: flex; align-items: center; }
        .quantity-control input { width: 50px; text-align: center; margin: 0 5px; }
        .quantity-control button { border: none; background: none; cursor: pointer; font-size: 1.5em; padding: 0; }
        .product-image { width: 80px; height: 80px; object-fit: cover; }
        .table th, .table td { vertical-align: middle; }
        .item-total { font-weight: bold; }
        .centered { display: flex; justify-content: center; align-items: center; }
        .no-history-message { color: red; text-align: center; font-weight: bold; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                 <h1>결제 기록</h1>
            </div>
            <div class="card-body">
                <c:forEach items="${paymentHistory}" var="history">
				    <table class="table table-bordered">
				        <thead>
				            <tr>
				                <th>결제 ID</th>
				                <th>결제 날짜</th>
				                <th>총 결제 금액</th>
				                <th>상태</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr>
				                <td>
				                    <a href="/cart/history/detail/${history.orderNumber}">${history.orderNumber}</a>
				                </td>
				                <td>
				                    <fmt:formatDate value="${history.paymentDate}" pattern="yyyy-MM-dd HH:mm:ss" />
				                </td>
				                <td>
				                    <fmt:formatNumber value="${history.totalAmount}" pattern="#,###" />원
				                </td>
				                <td>${history.status}</td>
				            </tr>
				        </tbody>
				    </table>
				</c:forEach>
				<c:if test="${empty paymentHistory}">
				    <p class="no-history-message">결제 내역이 없습니다.</p>
				</c:if>

            </div>
            <div class="card-footer">
            	<div class="total-section">
                	<a href="/main/main.do" class="btn btn-primary">메인으로 돌아가기</a>
			    </div>
			</div>
        </div>
    </div>
</body>
</html>