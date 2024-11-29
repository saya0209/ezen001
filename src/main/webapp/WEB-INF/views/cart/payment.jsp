<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 페이지</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include> <!-- 공통 라이브러리 파일 -->
    <style type="text/css">
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .centered {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2>결제 페이지</h2>
            </div>
            <div class="card-body">
                <p>사용자 ID: ${id}</p>
                
                <c:set var="selectedItemExists" value="false" />
				<c:forEach var="item" items="${cartItems}">
					<c:if test="${item.selected != 0}">
						<c:set var="selectedItemExists" value="true" />
					</c:if>
				</c:forEach>
                
                <c:choose>
                    <c:when test="${not selectedItemExists}">
                        <p>결제할 상품이 없습니다.</p>
                        <a href="/main/main.do" class="btn btn-primary">메인으로 돌아가기</a>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>상품 이미지</th>
                                    <th>상품명</th>
                                    <th>수량</th>
                                    <th>합계</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <c:set var="totalAmount" value="0" />
                                <c:forEach var="item" items="${cartItems}">
								    <c:if test="${item.selected != 0}">
								        <tr>
								            <td><img src="${item.image_name}" alt="${item.goods_name}" class="product-image"/></td>
								            <td>${item.goods_name}</td>
								            <td>${item.quantity} 개</td>
								            <td><fmt:formatNumber value="${item.goods_total_price}" pattern="#,###"/> 원</td>
								        </tr>
								        <c:set var="totalAmount" value="${totalAmount + item.goods_total_price}" />
								    </c:if>
								</c:forEach>

								<!-- 바로 구매한 상품 출력 -->
	                            <c:forEach var="item" items="${buyItems}">
	                                <tr>
	                                    <td><img src="${item.image_name}" alt="${item.goods_name}" class="product-image"/></td>
	                                    <td>${item.goods_name}</td>
	                                    <td>${item.quantity} 개</td>
	                                    <td><fmt:formatNumber value="${item.goods_total_price}" pattern="#,###"/> 원</td>
	                                </tr>
	                                <c:set var="totalAmount" value="${totalAmount + item.goods_total_price}" />
	                            </c:forEach>
                            </tbody>
                        </table>
                <!-- 결제 정보 입력 폼 -->
                <form action="${pageContext.request.contextPath}/cart/completePayment/${id}" method="post" >
                    <div class="form-group">
                        <label for="postalCode">우편번호:</label>
                        <input type="text" id="postalCode" name="postalCode" class="form-control" placeholder="우편번호를 입력하세요" required>
                    </div>
                    <!-- 주소 -->
				    <div class="form-group">
				        <label for="address">주소:</label>
				        <input type="text" id="address" name="address" class="form-control" 
				               value="${login.address}" placeholder="주소를 입력하세요" required>
				    </div>
				
				    <!-- 연락처 -->
				    <div class="form-group">
				        <label for="contactNumber">연락처:</label>
				        <input type="tel" id="contactNumber" name="contactNumber" class="form-control" 
				               value="${login.tel}" placeholder="연락처를 입력하세요" required>
				    </div>
				
				    <!-- 이메일 -->
				    <div class="form-group">
				        <label for="email">이메일:</label>
				        <input type="email" id="email" name="email" class="form-control" 
				               value="${login.email}" placeholder="이메일을 입력하세요" required>
				    </div>
                    <!-- 총 결제 금액 표시 및 결제 버튼 -->
                    <div class="total-section">
                        총 결제 금액: <strong id="final-total"><fmt:formatNumber value="${totalAmount}" pattern="#,###"/> 원</strong>
                    </div>
                    <input type="hidden" name="id" value="${id}">
                    <input type="submit" value="결제 확인" class="btn btn-primary float-right mt-3">
                </form>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>  
    </div>
</body>
</html>
