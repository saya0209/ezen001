<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 정보</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
          	margin: 0;
            
        }
	        /* 리뷰 항목 구분 스타일 */
		.review-item {
		    border-bottom: 1px solid #ccc; /* 각 리뷰 항목에 구분선 추가 */
		    padding-bottom: 20px;
		    margin-bottom: 20px;
		}
		
		.review-container {
		    background-color: #f9f9f9; /* 배경색 추가 */
		    padding: 10px;
		    border-radius: 5px;
		}
        
        .product-container {
		    background-color: #ffffff;
		    width: 80%;
		    padding: 20px;
		    border-radius: 10px;
		    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		    margin: 0 auto; /* 가로 중앙 정렬 */
		    top: 50%;
		    display: flex; /* Flexbox 적용 */
   			flex-direction: row; /* 가로 방향 정렬 */
		}
        
        .left-section {
		    flex: 1.5; /* 사진 칸을 더 크게 */
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    padding: 10px;
		}
		
		.right-section {
		    flex: 1.5; /* 상세 설명 칸을 더 작게 */
		    padding-left: 20px;
		}
        .product-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .spec-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 0.95em;
        }

        .spec-table th, .spec-table td {
            padding: 12px 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .spec-table th {
            width: 30%;
            color: #666;
            font-weight: normal;
            background-color: #f9f9f9;
        }

        .spec-table td {
            color: #333;
        }
        .option-section {
		    background-color: #ffffff;
		    width: 80%;
		    max-width: 1140px;
		    padding: 30px;
		    border-radius: 15px;
		    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
		    margin: 20px auto;
		    font-size: 1em;
		    font-family: 'Arial', sans-serif;
		    
		     /* Flexbox로 콘텐츠 중앙 정렬 */
		}

        .option-table {
            width: 100%;
            border-collapse: collapse;
            
        }

        /* 테이블 헤더 스타일 */
		.option-table th {
		    background-color: #f0f0f0;
		    color: #333;
		    padding: 14px;
		    font-weight: 600;
		    text-transform: uppercase;
		    letter-spacing: 1px;
		    border-bottom: 2px solid #ddd;
		    text-align: center; /* 가로 중앙 정렬 */
		}

        /* 테이블 셀 스타일 */
		.option-table td {
		    padding: 12px 15px;
		    text-align: center; /* 가로 중앙 정렬 */
   			vertical-align: middle; /* 세로 중앙 정렬 */
		    border-bottom: 1px solid #eee;
		    color: #555;
		}
		/* 테이블의 홀수 줄에 배경색 추가 */
		.option-table tr:nth-child(odd) {
		    background-color: #fafafa;
		}
        
        /* 버튼 스타일 */
		.option-table button {
		    padding: 8px 16px;
		    font-size: 1em;
		    border: none;
		    border-radius: 8px;
		    background-color: #007BFF;
		    color: white;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		/* 각 행의 셀 클릭 시 커서 포인터로 변경 */
		.option-table td button {
		    cursor: pointer;
		}
		
		.option-table button:hover {
		    background-color: #0056b3;
		    transform: translateY(-2px);
		}
		
		.option-table button:active {
		    background-color: #004085;
		    transform: translateY(2px);
		}
        
        .price {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
            margin-top: 10px;
        }
        
        .price_pro {
            font-size: 1.5em;
            font-weight: bold;
            color: #df3663;
            margin-top: 10px;
        }

        .btn-group {
            display: flex;
            justify-content: flex-start; /* 왼쪽 정렬 */
    		gap: 10px; /* 버튼 사이 간격 */
        }

        .btn-group button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-buy {
            background-color: #ff4d4d;
            color: white;
        }

        .btn-buy:hover {
            background-color: #e63939;
        }

        .btn-cart {
            background-color: #4d94ff;
            color: white;
        }

        .btn-cart:hover {
            background-color: #337ab7;
        }

        .btn-list {
            background-color: #cccccc;
            color: #333;
        }

        .btn-list:hover {
            background-color: #b3b3b3;
        }
        /* 모달 창 스타일 */
        .modal {
            display: none;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
		    background-color: #fefefe;
		    margin: 10% auto;
		    padding: 20px;
		    border: 1px solid #888;
		    width: 40%; /* 가로 사이즈를 조금 줄였습니다 */
		    border-radius: 10px;
		    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
		    text-align: center; /* 글씨를 가운데 정렬 */

        .close {
            color: #aaa;
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

		/* 모달 내 선택 버튼 스타일 */
		.cpuChangeBtn {
		    padding: 5px 10px;
		    font-size: 1em;
		    background-color: #007bff; /* 파란색 버튼 */
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.cpuChangeBtn:hover {
		    background-color: #0056b3; /* hover 시 색상 */
		    transform: translateY(-2px); /* hover 시 살짝 올라가는 효과 */
		}
		
		.cpuChangeBtn:active {
		    background-color: #004085; /* 클릭 시 색상 */
		    transform: translateY(2px); /* 클릭 시 살짝 내려가는 효과 */
		}
		
		.cpuChangeBtn {
		    padding: 5px 10px;
		    font-size: 1em;
		    background-color: #007bff; /* 파란색 버튼 */
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.cpuChangeBtn:hover {
		    background-color: #0056b3; /* hover 시 색상 */
		    transform: translateY(-2px); /* hover 시 살짝 올라가는 효과 */
		}
		
		.cpuChangeBtn:active {
		    background-color: #004085; /* 클릭 시 색상 */
		    transform: translateY(2px); /* 클릭 시 살짝 내려가는 효과 */
		}
		
		.memoryChangeBtn {
		    padding: 5px 10px;
		    font-size: 1em;
		    background-color: #007bff; /* 파란색 버튼 */
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.memoryChangeBtn:hover {
		    background-color: #0056b3; /* hover 시 색상 */
		    transform: translateY(-2px); /* hover 시 살짝 올라가는 효과 */
		}
		
		.memoryChangeBtn:active {
		    background-color: #004085; /* 클릭 시 색상 */
		    transform: translateY(2px); /* 클릭 시 살짝 내려가는 효과 */
		}
		
		.graphic_CardChangeBtn {
		    padding: 5px 10px;
		    font-size: 1em;
		    background-color: #007bff; /* 파란색 버튼 */
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.graphic_CardChangeBtn:hover {
		    background-color: #0056b3; /* hover 시 색상 */
		    transform: translateY(-2px); /* hover 시 살짝 올라가는 효과 */
		}
		
		.graphic_CardChangeBtn:active {
		    background-color: #004085; /* 클릭 시 색상 */
		    transform: translateY(2px); /* 클릭 시 살짝 내려가는 효과 */
		}
		


    </style>
	<script type="text/javascript">
		// 보고 있는 일반 게시판 글번호
		let id = "test1";// id를 하드코딩 - member table에 등록된 id중 - 로그인 id
		let goods_no = ${goods.goods_no};
		let replyPage = 1; // 댓글의 현재 페이지
		console.log("전역변수 goods_no : " + goods_no);
	</script>
    <!-- 2. 날짜 및 시간 처리함수 선언 -->
	<script type="text/javascript" src="/js/dateTime.js"></script>
	
	<!-- 댓글 페이지네이션 함수 선언 -->
	<script type="text/javascript" src="/js/util.js"></script>
	
	<!-- 3. 댓글 객체 (replySerive) 를 선언 : Ajax 처리부분 포함 -->
	<!-- 댓글 처리하는 모든 곳에 사용하는 부분을 코딩 -->
	<script type="text/javascript" src="/js/review.js"></script>

	<!-- 4. 댓글 객체(reply.js에서 선언한 replyService)를 호출하여 처리 + 이벤트처리 -->
	<!-- 일반 게시판 댓글에 사용되는 부분을 코딩 -->
	<script type="text/javascript" src="/js/reviewProcess.js"></script>
	
	<script>
	
	$(function() {
		
		// 초기 가격 가져오기 (JSP에서 출력된 값을 바탕으로)
	    let cpu_price = parseInt($("#cpu_name").data('price')) || 0;
	    let memory_price = parseInt($("#memory_name").data('price')) || 0;
	    let graphic_Card_price = parseInt($("#graphic_Card_name").data('price')) || 0;
	    let delivery_charge = parseInt($("#delivery_charge").data('price')) || 0;
	    let discount = parseInt($("#discount").data('price')) || 0;

        console.log(discount);
        console.log(delivery_charge);
	    let total_price = cpu_price + memory_price + graphic_Card_price + delivery_charge - discount; 
	    

	    updateTotalPrice();
	    // 총합 가격 업데이트 함수
	    
	    
	    function updateTotalPrice() {
	    	price = cpu_price + memory_price + graphic_Card_price
	        total_price = cpu_price + memory_price + graphic_Card_price + delivery_charge - discount;
	        $(".price_pro").text(total_price);

	    }

	    
	    // CPU 변경 시
	    $("#cpu-table").on("click", ".cpuChangeBtn", function() {
	        let newcpu_price = $(this).data('price');  // 선택된 CPU 가격
	        let cpu_name = $(this).closest('tr').find('td').first().text();  // 선택된 CPU 이름
	        
	        // 기존 가격에서 변경된 가격만큼 더하거나 빼기
	        cpu_price = newcpu_price;  // CPU 가격 업데이트
	        $(".cpu_name").text(cpu_name).data('price', newcpu_price);  // CPU 이름과 가격 업데이트
	        
	        updateTotalPrice();  // 가격 업데이트
	        closeModal();  // 모달 닫기
	    });

	    // Memory 변경 시
	    $("#memory-table").on("click", ".memoryChangeBtn", function() {
	        let newmemory_price = $(this).data('price');  // 선택된 Memory 가격
	        let memory_name = $(this).closest('tr').find('td').first().text();  // 선택된 Memory 이름
	        
	        // 기존 가격에서 변경된 가격만큼 더하거나 빼기
	        memory_price = newmemory_price;  // Memory 가격 업데이트
	        $(".memory_name").text(memory_name).data('price', newmemory_price);  // Memory 이름과 가격 업데이트
	        
	        updateTotalPrice();  // 가격 업데이트
	        closeModal();  // 모달 닫기
	    });

	    // Graphic Card 변경 시
	    $("#graphic_Card-table").on("click", ".graphic_CardChangeBtn", function() {
	        let newgraphic_Card_price = $(this).data('price');  // 선택된 Graphic Card 가격
	        let graphic_Card_name = $(this).closest('tr').find('td').first().text();  // 선택된 Graphic Card 이름
	        
	        // 기존 가격에서 변경된 가격만큼 더하거나 빼기
	        graphic_Card_price = newgraphic_Card_price;  // Graphic Card 가격 업데이트
	        $(".graphic_Card_name").text(graphic_Card_name).data('price', newgraphic_Card_price);  // Graphic Card 이름과 가격 업데이트
	        
	        updateTotalPrice();  // 가격 업데이트
	        closeModal();  // 모달 닫기
	    });

	    // 모달 닫기 함수
	    function closeModal() {
	        $(".modal").css("display", "none");  // 모든 모달 닫기
	    }

	    // 모달 닫기 버튼 클릭 시
	    $(".close").click(function () {
	        closeModal();
	    });

	    // 배경 클릭 시 모달 닫기
	    $(window).click(function (event) {
	        if ($(event.target).hasClass('modal')) {
	            closeModal();
	        }
	    });
		 // Esc 키 눌렀을 때 모달 닫기
	    $(document).keydown(function (event) {
	        // Esc 키 (keyCode 27 또는 event.key === 'Escape') 눌렀을 때
	        if (event.key === "Escape" || event.keyCode === 27) {
	            closeModal();
	        }
	    });
	    
	});

let cpuNoList = [];
let memoryNoList = [];
let graphic_CardNoList = [];
let cpu_nameList = [];	
let memory_nameList = [];	
let graphic_Card_nameList = [];	

$(function() {
	
	$(".deleteBtn").click(function() {
	    var goods_no = $(this).data("goods_no");  // 	 버튼에 설정된 data-goods_no 값을 가져옵니다.
	    
	    if (goods_no) {
	        // 모달의 hidden input에 값 설정
	        $("#deleteNo").val(goods_no);
	    
	        // 모달 열기
	        $("#deleteModal").modal('show');
	    } else {
	        console.log("goods_no가 없습니다!");
	    }
	});

	$("#addCartButton").click(function () {
	    console.log("addCartButton");

	    // 필요한 데이터 수집
	    const id = document.getElementById("id").value; // 로그인한 사용자 ID
	    <input type="hidden" id="deleteNo" name="goods_no" value="${goods.goods_no }">
	    let goodsno = document.getElementById("deleteNo").value;
	    let goods_name = "";
	    const image_name = document.getElementById("image_name").src; // 이미지 URL
	    let price = parseFloat(document.getElementById("price").textContent || document.getElementById("price").innerText);
	    const quantity = 1; // 예시로 1개로 고정, 실제로는 UI에서 수량을 입력받을 수 있음
	    const goods_total_price = price * quantity;// + parseFloat(document.getElementById("delivery_charge").textContent || document.getElementById("delivery_charge").innerText);
	    const selected_goods_price = goods_total_price; // 선택된 상품 총 가격 (예시로 상품 가격만 계산)
	    const delivery_charge = parseFloat(document.getElementById("delivery_charge").textContent || document.getElementById("delivery_charge").innerText);
	    const discount = parseFloat(document.getElementById("discount").textContent || document.getElementById("discount").innerText || 0);
	    const total_discount = discount; // 전체 할인 (예시로 개별 할인과 동일하게 설정)
	    const selected = 0; // 상품 선택 여부 (예시로 선택된 상태로 설정)
	    const totalAmount = goods_total_price - discount; // 최종 가격 (예시로 총 가격에서 할인액을 뺀 값)
		 // category와 goods 정보를 기반으로 JavaScript 변수에 값을 설정
	    const category = "${category}";  // 카테고리 값
	    const cpu_name = "${goods.cpu_name}";
	    const memory_name = "${goods.memory_name}";
	    const graphic_card_name = "${goods.graphic_Card_name}";
	    price = ${goods.price};
		
	    console.log("goods_no"+goods_no);
	 // category 값에 따라 goods_name 설정
	    if (category == 'goods1') {
	        goods_name = "인터넷/사무용";
	    } else if (category == 'goods2') {
	        goods_name = "3D게임/그래픽용";
	    } else if (category == 'goods3') {
	        goods_name = "고성능/전문가용";
	    } else if (category == 'goods4') {
	        goods_name = "노트북";
	    } else if (category == 'goods5') {
	        // goods5 카테고리에서 CPU, 메모리, 그래픽카드 값에 따라 설정
	        if (cpu_name != '0' && cpu_name != '') {
	            goods_name = "CPU: " + cpu_name;
	        } else if (memory_name != '0' && memory_name != '') {
	            goods_name = "메모리: " + memory_name;
	        } else if (graphic_card_name != '0' && graphic_card_name != '') {
	            goods_name = "그래픽카드: " + graphic_card_name;
	        }
	    }
	    
	    // JSON 객체 생성
	    const data = {
	        id: id,
	        goods_no: goodsno,
	        goods_name: goods_name,
	        image_name: image_name,
	        price: price,
	        quantity: quantity,
	        goods_total_price: goods_total_price,
	        selected_goods_price: selected_goods_price,
	        delivery_charge: delivery_charge,
	        discount: discount,
	        total_discount: total_discount,
	        selected: selected,
	        totalAmount: totalAmount,
	        purchase_date: new Date().toISOString(), // 현재 날짜를 ISO 형식으로 전송
	        category: category // 예시로 카테고리 설정
	    };

	    // jQuery AJAX 요청
	    $.ajax({
	        url: "/cart/add", // 서버 URL
	        type: "POST", // HTTP 메소드
	        contentType: "application/json", // JSON 형식으로 보냄
	        data: JSON.stringify(data), // JSON 데이터로 변환
	        success: function (response) {
	            // 서버에서 성공적으로 응답을 받으면
	            if (response === "success") {
	                showModal("장바구니에 담았습니다!");
	            } else {
	                showModal("장바구니 담기 실패!");
	            }
	        },
	        error: function (xhr, status, error) {
	            // 오류가 발생했을 때
	            console.error("Error:", error);
	            showModal("로그인이 필요합니다.");
	        }
	    });
	});
	
	$("#addBuyButton").click(function () {
	    console.log("addBuyButton");

	    // 필요한 데이터 수집
	    const id = document.getElementById("id").value;  // 로그인한 사용자 ID
	    let goodsno = document.getElementById("deleteNo").value;
	    let goods_name = "";  // 예시로 상품 이름을 설정
	    const image_name = document.getElementById("image_name").src;  // 이미지 URL
	    const price = parseFloat(document.getElementById("price").textContent || document.getElementById("price").innerText);
	    const quantity = 1;  // 예시로 1개로 고정, 실제로는 UI에서 수량을 입력받을 수 있음
	    const goods_total_price = price;
	    const selected_goods_price = goods_total_price;  // 선택된 상품 총 가격 (예시로 상품 가격만 계산)
	    const delivery_charge = parseFloat(document.getElementById("delivery_charge").textContent || document.getElementById("delivery_charge").innerText);
	    const discount = parseFloat(document.getElementById("discount").textContent || document.getElementById("discount").innerText || 0);
	    const total_discount = discount;  // 전체 할인 (예시로 개별 할인과 동일하게 설정)
	    const selected = 0;  // 상품 선택 여부 (예시로 선택된 상태로 설정)
	    const totalAmount = goods_total_price - discount;  // 최종 가격 (예시로 총 가격에서 할인액을 뺀 값)

	    const category = "${category}";  // 카테고리 값
	    const cpu_name = "${goods.cpu_name}";
	    const memory_name = "${goods.memory_name}";
	    const graphic_card_name = "${goods.graphic_Card_name}";
		 // category 값에 따라 goods_name 설정
	    if (category == 'goods1') {
	        goods_name = "인터넷/사무용";
	    } else if (category == 'goods2') {
	        goods_name = "3D게임/그래픽용";
	    } else if (category == 'goods3') {
	        goods_name = "고성능/전문가용";
	    } else if (category == 'goods4') {
	        goods_name = "노트북";
	    } else if (category == 'goods5') {
	        // goods5 카테고리에서 CPU, 메모리, 그래픽카드 값에 따라 설정
	        if (cpu_name != '0' && cpu_name != '') {
	            goods_name = "CPU: " + cpu_name;
	        } else if (memory_name != '0' && memory_name != '') {
	            goods_name = "메모리: " + memory_name;
	        } else if (graphic_card_name != '0' && graphic_card_name != '') {
	            goods_name = "그래픽카드: " + graphic_card_name;
	        }
	    }
	    
	    // JSON 객체 생성
	    const data = {
	        id: id,
	        goods_no: goodsno,
	        goods_name: goods_name,
	        image_name: image_name,
	        price: price,
	        quantity: quantity,
	        goods_total_price: goods_total_price,
	        selected_goods_price: selected_goods_price,
	        delivery_charge: delivery_charge,
	        discount: discount,
	        total_discount: total_discount,
	        selected: selected,
	        totalAmount: totalAmount,
	        purchase_date: new Date().toISOString(),  // 현재 날짜를 ISO 형식으로 전송
	        category: "사무용"  // 예시로 카테고리 설정
	    };

	    // jQuery AJAX 요청
	    $.ajax({
	        url: "/cart/addbuy",  // 서버 URL
	        type: "POST",  // HTTP 메소드
	        contentType: "application/json",  // JSON 형식으로 보냄
	        data: JSON.stringify(data),  // JSON 데이터로 변환
	        success: function(response) {
	            // 서버에서 URL을 응답으로 받으면 그 URL로 리디렉션
	            if (response) {
	                window.location.href = response;  // 받은 URL로 리디렉션
	            } else {
	                showModal("바로결재 실패!");
	            }
	        },
	        error: function (xhr, status, error) {
	            // 오류가 발생했을 때
	            console.error("Error:", error);
	            showModal("로그인이 필요합니다.");
	        }
	    });
	});


	
	 // 페이지가 로드될 때 체크박스를 모두 선택 해제 (selected = 0으로 초기화)
    
    
	function showModal(message) {
	    document.getElementById("modalMessage").innerText = message;
	    $('#myModal').modal('show');  // Bootstrap 모달
	}
	
	function openModal(optionType) {
	    // 모달을 열고, 제목을 동적으로 설정

	    if (optionType === 'CPU') {
	    	document.getElementById("cpu-modal").style.display = "block";
		    document.getElementById("modal-title").textContent = optionType + " 선택";
	    	
	        $.ajax({
	            url: '/goods/cpu_id',
	            method: 'GET',
	            success: function(data) {
	                console.log("data :", data);  // 서버 응답 확인
	                let tableBody = $('#cpu-table tbody');
	                tableBody.empty();

	                // 만약 data가 배열이면 그대로 사용하고, 객체일 경우 cpuOptions 배열을 사용
	                console.log (data.cpu_id);
	                let cpuList = Array.isArray(data.cpu_id) ? data.cpu_id : [];
	                
	                console.log(cpuList);

	                let i = 0;
	                // 배열일 경우에만 forEach 사용
	                cpuList.forEach(function(cpu) {
	                	console.log("cpu_name :", cpu.cpu_name);
	                	console.log("cpu_price :", cpu.cpu_price);
	                	console.log("cpu_id :", cpu.cpu_id);
	                	cpuNoList.push(cpu.cpu_id);
	                	cpu_nameList.push(cpu.cpu_name);
	                	const cpu_name = cpu.cpu_name;
	                    tableBody.append(''+
	                    	'<tr>'+
                                '<td>'+ cpu.cpu_name +'</td>'+  <!-- cpu_name이 없으면 '정보 없음' 표시 -->
                                '<td>'+ cpu.cpu_price +'</td>'+  <!-- cpu_price가 없으면 '정보 없음' 표시 -->
                                '<td><button class="cpuChangeBtn" data-id="' + cpu.cpu_id + '" data-price="' + cpu.cpu_price + '">선택</button></td>' +  <!-- cpu_id가 없으면 오류 발생 가능 -->
                            '</tr>'
	                    );
	                });

	                $('#cpu-modal').show();
	            },
	            error: function() {
	                alert('CPU 데이터를 가져오는 중 오류가 발생했습니다.');
	            }
	        });
	    }
	    
	    if (optionType === 'Memory') {
	    	document.getElementById("memory-modal").style.display = "block";
		    document.getElementById("modal-title").textContent = optionType + " 선택";
	    	
	        $.ajax({
	            url: '/goods/memory_id',
	            method: 'GET',
	            success: function(data) {
	                console.log("data :", data);  // 서버 응답 확인
	                let tableBody = $('#memory-table tbody');
	                tableBody.empty();

	                // 만약 data가 배열이면 그대로 사용하고, 객체일 경우 cpuOptions 배열을 사용
	                console.log (data.memory_id);
	                let memoryList = Array.isArray(data.memory_id) ? data.memory_id : [];
	                
	                console.log(memoryList);

	                // 배열일 경우에만 forEach 사용
	                memoryList.forEach(function(memory) {
	                	console.log("memory_name :", memory.memory_name);
	                	console.log("memory_price :", memory.memory_price);
	                	console.log("memory_id :", memory.memory_id);
	                	memoryNoList.push(memory.memory_id);
	                	memory_nameList.push(memory.memory_name);
	                	const memory_name = memory.memory_name;
	                    tableBody.append(''+
	                    	'<tr>'+
                                '<td>'+ memory.memory_name +'</td>'+  <!-- cpu_name이 없으면 '정보 없음' 표시 -->
                                '<td>'+ memory.memory_price +'</td>'+  <!-- cpu_price가 없으면 '정보 없음' 표시 -->
                                '<td><button class="memoryChangeBtn" data-id="' + memory.memory_id + '" data-price="' + memory.memory_price + '">선택</button></td>' +  <!-- cpu_id가 없으면 오류 발생 가능 -->
                            '</tr>'
	                    );
	                });

	                $('#memory-modal').show();
	            },
	            error: function() {
	                alert('Memory 데이터를 가져오는 중 오류가 발생했습니다.');
	            }
	        });
	    }
	    
	    if (optionType === 'Graphic_Card') {
	    	document.getElementById("graphic_Card-modal").style.display = "block";
		    document.getElementById("modal-title").textContent = optionType + " 선택";
	    	
	        $.ajax({
	            url: '/goods/graphic_Card_id',
	            method: 'GET',
	            success: function(data) {
	                let tableBody = $('#graphic_Card-table tbody');
	                tableBody.empty();

	                // 만약 data가 배열이면 그대로 사용하고, 객체일 경우 cpuOptions 배열을 사용
	                let graphic_CardList = Array.isArray(data.graphic_Card_id) ? data.graphic_Card_id : [];
	                
	                console.log(graphic_CardList);

	                // 배열일 경우에만 forEach 사용
	                graphic_CardList.forEach(function(graphic_Card) {
	                	console.log("graphic_Card_name :", graphic_Card.graphic_Card_name);
	                	console.log("graphic_Card_price :", graphic_Card.graphic_Card_price);
	                	console.log("graphic_Card_id :", graphic_Card.graphic_Card_id);
	                	graphic_CardNoList.push(graphic_Card.graphic_Card_id);
	                	graphic_Card_nameList.push(graphic_Card.graphic_Card_name);
	                	const graphic_Card_name = graphic_Card.graphic_Card_name;
	                    tableBody.append(''+
	                    	'<tr>'+
                                '<td>'+ graphic_Card.graphic_Card_name +'</td>'+  <!-- cpu_name이 없으면 '정보 없음' 표시 -->
                                '<td>'+ graphic_Card.graphic_Card_price +'</td>'+  <!-- cpu_price가 없으면 '정보 없음' 표시 -->
                                '<td><button class="graphic_CardChangeBtn" data-id="' + graphic_Card.graphic_Card_id + '" data-price="' + graphic_Card.graphic_Card_price + '">선택</button></td>' +  <!-- cpu_id가 없으면 오류 발생 가능 -->
                            '</tr>'
	                    );
	                });

	                $('#graphic_Card-modal').show();
	            },
	            error: function() {
	                alert('Graphic_Card 데이터를 가져오는 중 오류가 발생했습니다.');
	            }	
	        });
	    }
	}
	
	
	// 모달 요소와 버튼
	const modal = document.getElementById('cpuModal');	
	const closeModalBtn = document.getElementById('closeModal');


    // 모달 창 닫기
    function closeModal() {
        document.getElementById("cpu-modal").style.display = "none";
        document.getElementById("memory-modal").style.display = "none";
        document.getElementById("graphic_Card-modal").style.display = "none";
    }

    
    $("#cpuChangeGoods").click(function() {
    	//alert("cpuChange");
	   	openModal('CPU');
    });
    
    
	$("#cpu-table").on("click", ".cpuChangeBtn", function() {
		id = $(this).data('id');
		let cpu_name = '';
		console.log('selectCpu - id: ', id);
		
		for(let i = 0 ; i < cpuNoList.length ; i++) {
			if (cpuNoList[i] == id) {
				cpu_name = cpu_nameList[i];
				break;
			}
		}
		
		$(".cpu_name").text(cpu_name);
		
		closeModal();
		
	});
	
    $("#memoryChangeGoods").click(function() {
    	//alert("cpuChange");
	   	openModal('Memory');
    });
    
    
	$("#memory-table").on("click", ".memoryChangeBtn", function() {
		id = $(this).data('id');
		let memory_name = '';
		console.log('selectMemory - id: ', id);
		
		for(let i = 0 ; i < memoryNoList.length ; i++) {
			if (memoryNoList[i] == id) {
				memory_name = memory_nameList[i];
				break;
			}
		}
		
		$(".memory_name").text(memory_name);
		
		closeModal();
		
	});
    $("#graphic_CardChangeGoods").click(function() {
    	//alert("cpuChange");
	   	openModal('Graphic_Card');
    });
    
    
	$("#graphic_Card-table").on("click", ".graphic_CardChangeBtn", function() {
		id = $(this).data('id');
		let memory_name = '';
		console.log('selectGraphic_Card - id: ', id);
		
		for(let i = 0 ; i < graphic_CardNoList.length ; i++) {
			if (graphic_CardNoList[i] == id) {
				graphic_Card_name = graphic_Card_nameList[i];
				break;
			}
		}
		
		$(".graphic_Card_name").text(graphic_Card_name);
		
		closeModal();
		
	});
	

	
    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
	    const modal = document.getElementById("cpu-modal");
	    if (event.target === modal) {
	        modal.style.display = "none";
	    }
	    const memoryModal = document.getElementById("memory-modal");
	    if (event.target === memoryModal) {
	        memoryModal.style.display = "none";
	    }
	    const graphic_CardModal = document.getElementById("graphic_Card-modal");
	    if (event.target === graphic_CardModal) {
	        graphic_CardModal.style.display = "none";
	    }
	}
    
});
	</script>
</head>
<body>
  <div class="product-container">
    <!-- 왼쪽 섹션: 이미지 -->
    <div class="left-section">
        <img src="${goods.image_name}" id="image_name" alt="이미지" style="width: 300px; height: 300px;">
    </div>

    <!-- 오른쪽 섹션: 상세 정보 -->
    <div class="right-section">
        <div class="product-title">
        <c:if test="${category == 'goods1' }">
            인터넷/사무용
        </c:if>
        <c:if test="${category == 'goods2' }">
            3D게임/그래픽용
        </c:if>
        <c:if test="${category == 'goods3' }">
            고성능/전문가용
        </c:if>
        <c:if test="${category == 'goods4' }">
            노트북
        </c:if>
        <c:if test="${category == 'goods5' and goods.cpu_name != '0' and not empty goods.cpu_name}">
            <p>CPU</p>
        </c:if>
        
        <c:if test="${category == 'goods5' and goods.memory_name != '0' and not empty goods.memory_name}">
            <p>메모리</p>
        </c:if>
        
        <c:if test="${category == 'goods5' and goods.graphic_Card_name != '0' and not empty goods.graphic_Card_name}">
            <p>그래픽카드</p>
        </c:if>
        </div>
        <table class="spec-table">
		    <!-- CPU 이름이 null 또는 '0'일 경우 출력하지 않도록 처리 -->
		    <c:if test="${not empty goods.cpu_name and goods.cpu_name != '0'}">
		        <tr>
		            <th>CPU</th>
		            <td class="cpu_name">${goods.cpu_name}</td>
		        </tr>
		    </c:if>
		
		    <!-- 메모리 이름이 null 또는 '0'일 경우 출력하지 않도록 처리 -->
		    <c:if test="${not empty goods.memory_name and goods.memory_name != '0'}">
		        <tr>
		            <th>메모리</th>
		            <td class="memory_name">${goods.memory_name}</td>
		        </tr>
		    </c:if>
		
		    <!-- 그래픽카드 이름이 null 또는 '0'일 경우 출력하지 않도록 처리 -->
		    <c:if test="${not empty goods.graphic_Card_name and goods.graphic_Card_name != '0'}">
		        <tr>
		            <th>그래픽카드</th>
		            <td class="graphic_Card_name">${goods.graphic_Card_name}</td>
		        </tr>
		    </c:if>
		
		    <!-- 할인가 출력 -->
		    <tr>
		        <th>할인가</th>
		        <td class="discount" id="discount" data-price="${goods.discount}">${goods.discount}</td>
		    </tr>
		
		    <!-- 배송비 출력 -->
		    <tr>
		        <th>배송비</th>
		        <td class="delivery_charge" id="delivery_charge" data-price="${goods.delivery_charge}">${goods.delivery_charge}</td>
		    </tr>
		</table>

        
       
        
        
        <div class="price" >
		    판매가격: 
		</div> <span class="price_pro" id="price">${goods.total_price}</span><span> 원</span>



        <div class="btn-group">
			<input type="hidden" name="id" id="id" value="${login.id}">
			<button class="btn-buy" id="addBuyButton">바로구매</button>
            <button class="btn-cart" id="addCartButton">장바구니 담기</button>
			<button class="btn-list" onclick="location.href='list.do?category=${category}&page=${param.page}&perPageNum=${param.perPageNum}&${goodsSearchVO.searchQuery}'">리스트</button>
        </div>
     </div>
    
  </div>
        <!-- 옵션 변경 섹션 -->
        <div class="option-section">
            <table class="option-table">
                <thead>
                    <tr>
                        <th>분류</th>
                        <th>기본사양</th>
                        <th>추가하기</th>
                    </tr>
                </thead>
                <tbody>
		            <c:if test="${not empty goods.cpu_name and goods.cpu_name != '0'}">
					    <tr>
					        <td>CPU</td>
					        <td class="cpu_name" id="cpu_name" data-price="${goods.cpu_price}">${goods.cpu_name}</td>
					        <td><button id="cpuChangeGoods">사양변경하기</button></td>
					    </tr>
					</c:if>
		            <c:if test="${not empty goods.memory_price and goods.memory_price != '0'}">
					    <tr>
					        <td>메모리</td>
					        <td class="memory_name" id="memory_name" data-price="${goods.memory_price}">${goods.memory_price}</td>
					        <td><button id="memoryChangeGoods">사양변경하기</button></td>
					    </tr>
					</c:if>
		            <c:if test="${not empty goods.graphic_Card_price and goods.graphic_Card_price != '0'}">
					    <tr>
					        <td>그래픽</td>
					        <td class="graphic_Card_name" id="graphic_Card_name" data-price="${goods.graphic_Card_price}">${goods.graphic_Card_price}</td>
					        <td><button id="graphic_CardChangeGoods">사양변경하기</button></td>
					    </tr>
					</c:if>
		        </tbody>
            </table>
		        
			<!-- 리뷰 -->
			<div>
				<jsp:include page="goodsReview.jsp"></jsp:include>
			</div>
       		 <div class="card-footer">
       		 <c:if test="${login.gradeNo == 9 }">
				<button class="btn btn-danger" id="deleteBtn"
					data-toggle="modal" data-target="#deleteModal">삭제</button>	
			</c:if>
			</div>
        </div>
	   <!-- 모달 창 -->
		<div id="cpu-modal" class="modal">
		    <div class="modal-content">
		        <span class="close" onclick="closeModal()">&times;</span>
		        <!-- 이 부분에 id="modal-title"를 추가 -->
		        <h2 id="modal-title">CPU 선택</h2> 
		        <table id="cpu-table">
		            <thead>
		                <tr>
		                    <th>이름</th>
		                    <th>가격</th>
		                    <th>선택</th>
		                </tr>
		            </thead>
		            <tbody>
		                <!-- CPU 데이터가 여기에 로드됨 -->
		            </tbody>
		        </table>
		    </div>
		</div>
		<div id="memory-modal" class="modal">
		    <div class="modal-content">
		        <span class="close" onclick="closeModal()">&times;</span>
		        <!-- 이 부분에 id="modal-title"를 추가 -->
		        <h2 id="modal-title">메모리 선택</h2> 
		        <table id="memory-table">
		            <thead>
		                <tr>
		                    <th>이름</th>
		                    <th>가격</th>
		                    <th>선택</th>
		                </tr>
		            </thead>
		            <tbody>
		                <!-- CPU 데이터가 여기에 로드됨 -->
		            </tbody>
		        </table>
		    </div>
		</div>
		<div id="graphic_Card-modal" class="modal">
		    <div class="modal-content">
		        <span class="close" onclick="closeModal()">&times;</span>
		        <!-- 이 부분에 id="modal-title"를 추가 -->
		        <h2 id="modal-title">그래픽 선택</h2> 
		        <table id="graphic_Card-table">
		            <thead>
		                <tr>
		                    <th>이름</th>
		                    <th>가격</th>
		                    <th>선택</th>
		                </tr>
		            </thead>
		            <tbody>
		                <!-- CPU 데이터가 여기에 로드됨 -->
		            </tbody>
		        </table>
		    </div>
	</div>
		<!-- The Modal -->
	  <div class="modal fade" id="deleteModal">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">삭제하시겠습니까?</h4>
	          <button class="close" data-dismiss="modal">&times;</button>
	        </div>
	        <!-- deleto.do 로 이동시 no, pw 가 필요합니다. -->
	        <!-- no : hidden으로, pw: 사용자입력으로 세팅 -->
		        <form action="delete.do" method="get">
				    <input type="hidden" id="deleteNo" name="goods_no" value="${goods.goods_no }">
				    <div class="modal-footer">
				        <button class="btn btn-danger">삭제</button>
				        <button class="btn btn-secondary" data-dismiss="modal">취소</button>
				    </div>
				</form>

	      </div>
	    </div>
	  </div>

	<!-- Modal 구조 -->
	<div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog" style="max-width: 60%;">  <!-- 여기에서 width 조정 -->
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">알림</h4>
	      </div>
	      <div class="modal-body" style="font-size: 18px;">
	        <p id="modalMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>