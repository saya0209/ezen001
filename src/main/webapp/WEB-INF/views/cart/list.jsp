<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include> <!-- 공통 라이브러리 파일 -->
    <style type="text/css">
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-control input {
            width: 50px;
            text-align: center;
            margin: 0 5px;
        }
        .quantity-control button {
            border: none;
            background: none;
            cursor: pointer;
            font-size: 1.5em;
            padding: 0;
        }
        .product-image {
            width: 80px; /* 이미지 크기 조정 */
            height: 80px; /* 이미지 크기 조정 */
            object-fit: cover; /* 이미지 비율 유지 */
        }
        .table th, .table td {
            vertical-align: middle; /* 세로 정렬 중앙 */
        }
        .item-total {
            font-weight: bold; /* 총 가격을 굵게 표시 */
        }
        .centered {
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
    <script>
	    function updateQuantity(goods_no, change) {
	        var input = document.getElementById('quantity-' + goods_no);
	        var currentValue = parseInt(input.value);
	        var newValue = currentValue + change;
	        if (newValue < 1) {
	            newValue = 1; // 최소 수량 1
	        }
	        if (newValue > 99) {
	            newValue = 99; // 최대 수량 99
	        }
	        input.value = newValue;
	
	        // 가격 계산
	        var delivery_charge = parseInt(document.getElementById('delivery_charge-' + goods_no).value); // 배송비 가져오기
	        var price = parseInt(document.getElementById('price-' + goods_no).value); // 상품 가격
	        var discount = parseInt(document.getElementById('discount-' + goods_no).value); // 상품 할인가
	        var totalCell = document.getElementById('total-' + goods_no); // 총 가격 셀
	        var total = (newValue * (price-discount)) + delivery_charge; // 총 가격 계산
	        totalCell.innerHTML = new Intl.NumberFormat().format(total) + ' 원'; // 총 가격 업데이트
	        // 전체 결제 금액 업데이트
	        updateTotalAmount();
	
	        // 서버에 수량 업데이트 요청
	        updateDatabaseQuantity(goods_no, newValue, total); // 총 가격 업데이트 추가
	    }

        // 전체 결제 금액 업데이트 함수
        function updateTotalAmount() {
		    var totalAmount = 0;
		    var items = document.querySelectorAll('.item-total'); // 각 상품 총 가격 요소를 NodeList로 가져오기
		
		    items.forEach(function(item) {
		        var goods_no = item.id.split('-')[1]; // goods_no 추출
		        var itemTotal = parseInt(item.innerHTML.replace(/ 원/g, '').replace(/,/g, '')); // 총 가격 추출
		        var checkbox = document.querySelector('input[type="checkbox"].form-check-input[value="' + goods_no + '"]'); // 해당 상품의 체크박스 찾기
		
		        // 체크박스가 체크된 상태일 때만 해당 상품의 가격을 더함
		        if (checkbox && checkbox.checked) {
		            totalAmount += itemTotal;
		        }
		    });
		
		    // 최종 금액 업데이트
		    document.getElementById('finalTotal').innerHTML = new Intl.NumberFormat().format(totalAmount) + ' 원';
		}

        

        // 페이지 로딩 시 전체 금액 계산
        window.onload = function() {
            updateTotalAmount(); // 초기 로딩 시 전체 금액 업데이트
        }

        // 데이터베이스 업데이트
        function updateDatabaseQuantity(goods_no, quantity, goods_total_price) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/cart/updateCartItem", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        console.log("상품 수량 및 가격 업데이트 완료: " + quantity);
                    } else {
                        console.error("상품 수량 및 가격 업데이트 실패: " + xhr.status);
                    }
                }
            };
            xhr.send("goods_no=" + encodeURIComponent(goods_no) + 
                     "&quantity=" + encodeURIComponent(quantity) + 
                     "&goods_total_price=" + encodeURIComponent(goods_total_price) +
                     "&selected=" + encodeURIComponent(selected ? 1 : 0) +
                     "&id=" + encodeURIComponent('${id}'));
        }

		function submitPaymentForm() {
            document.getElementById("paymentForm").action = `${pageContext.request.contextPath}/cart/paymentForm.do`; // POST 요청을 보낼 URL
            document.getElementById("paymentForm").submit(); // 폼 전송
        }
		
        // 선택 여부 업데이트 함수
        function updateSelection(goods_no, selected) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/cart/updateSelection", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        console.log("상품 선택 여부 업데이트 완료: " + selected);
                    } else {
                        console.error("상품 선택 여부 업데이트 실패: " + xhr.status);
                    }
                }
            };
            xhr.send("goods_no=" + encodeURIComponent(goods_no) + 
                     "&selected=" + encodeURIComponent(selected ? 1 : 0) + 
                     "&id=" + encodeURIComponent('${id}'));
        }

        // 체크박스 클릭 시 선택 여부 업데이트
        function handleCheckboxClick(checkbox, goods_no) {
            var selected = checkbox.checked;
            updateSelection(goods_no, selected); // 서버에 선택 여부 전달
            updateTotalAmount(); // 체크박스 클릭 시 총 결제 금액 업데이트
        }
        
        // 리스트 전체 선택
        function toggleSelectAll(selectAllCheckbox) {
            var checkboxes = document.querySelectorAll('input[type="checkbox"].form-check-input');
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
                handleCheckboxClick(checkbox, checkbox.value); // 선택 상태 업데이트
            });
            updateTotalAmount(); // 전체 결제 금액 업데이트
        }
   
    </script>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h3>장바구니</h3>
            </div>
            <div class="card-body">
                <p>User ID: ${id}</p> <!-- id를 User ID로 사용 -->
            	<c:if test="${!empty cartItems}">
                <span><input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)">전체 선택</span>
                </c:if>
                <c:choose>
                    <c:when test="${empty cartItems}">
                        <p>장바구니에 담긴 상품이 없습니다.</p>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>상품 이미지</th> <!-- 이미지 컬럼 추가 -->
                                    <th>상품명</th>
                                    <th>수량</th>
                                    <th>가격</th>
                                    <th>할인가</th>
                                    <th>배송비</th>
                                    <th>합계</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartItems}">
                                    <tr>
                                        <!-- 선택여부 -->
                                        <td>
										    <div class="form-check centered">
										        <label class="form-check-label">
										            <input type="hidden" name="goods_no" value="${item.goods_no}">
										            <input type="hidden" name="quantity-${item.goods_no}" value="${item.quantity}">
										            <input type="hidden" name="price-${item.goods_no}" value="${item.price}">
										            <input type="hidden" name="delivery_charge-${item.goods_no}" value="${item.delivery_charge}">
										            <!-- 선택 상태(checked)가 1이면 체크박스가 선택됨 -->
										            <input type="checkbox" class="form-check-input" value="${item.goods_no}" 
										                   <c:if test="${item.selected == 1}">checked</c:if>
										                   onclick="handleCheckboxClick(this, ${item.goods_no})">
										        </label>
										    </div>
										</td>
                                        <!-- 상품 이미지 -->
                                        <td>
										    <img src="${item.image_name}" alt="${item.goods_name}" class="product-image"/>
										</td>
                                        <!-- 상품명 -->
                                        <td>${item.goods_name}</td> <!-- 상품명 -->
                                        <!-- 상품 수량 -->
                                        <td>
                                            <div class="quantity-control">
                                                <input type="number" id="quantity-${item.goods_no}" name="quantity" value="${item.quantity}" min="1" max="99" onchange="updateQuantity(${item.goods_no}, 0)"> <!-- 상품 수량 -->
                                            </div>
                                        </td>
                                        <!-- 상품 가격 -->
                                        <td><fmt:formatNumber value="${item.price}" pattern="#,###"/> 원</td> <!-- 상품 가격 -->
                                        <!-- 상품 할인가 -->
                                        <td><fmt:formatNumber value="${item.discount}" pattern="#,###"/> 원</td> <!-- 상품 할인가 -->
                                        <!-- 배송비  -->
                                        <td>${item.delivery_charge}
                                            <input type="hidden" id="delivery_charge-${item.goods_no}" value="${item.delivery_charge}" > 원									
                                        </td>
                                        <!-- 상품 총 가격  -->
                                        <td>
                                            <input type="hidden" id="discount-${item.goods_no}" value="${item.discount}"/> <!-- 상품 할인가 -->
                                            <input type="hidden" id="price-${item.goods_no}" value="${item.price}"/> <!-- 상품 가격 -->
                                            <span id="total-${item.goods_no}" class="item-total">
                                            	<c:set var="goods_total_price" value="${(item.price-item.discount) * item.quantity + item.delivery_charge}" />
                                                <fmt:formatNumber value="${goods_total_price}" pattern="#,###"/> 원
                                            </span>
                                        </td>
                                        <!-- 상품 삭제 -->
                                        <td>
                                            <form action="${pageContext.request.contextPath}/cart/removeCartItem" method="post">
                                                <input type="hidden" name="goods_no" value="${item.goods_no}"> <!-- 상품 번호 -->
                                                <input type="submit" value="삭제" class="btn btn-danger"> <!-- Bootstrap 버튼 -->
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="card-footer">
            	<div class="total-section">
            	<c:if test="${!empty cartItems}">
                	총 결제 금액: <strong id="finalTotal"><fmt:formatNumber value="${totalAmount}" pattern="#,###"/> 원</strong>
				    <form id="paymentForm" class="float-right" method="get">
					    <input type="hidden" name="id" value="${id}">
					    <input type="button" value="결제하기" class="btn btn-success" onclick="submitPaymentForm()">                
					</form>
                </c:if>
                <c:if test="${empty cartItems}">
                	<a href="/main/main.do" class="btn btn-primary">메인으로 돌아가기</a>
                </c:if>
			    </div>
			</div>
        </div>
    </div>
</body>
</html>