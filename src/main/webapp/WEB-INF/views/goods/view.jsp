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
        
        .product-container {
		    background-color: #ffffff;
		    width: 60%;
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
		}

        /* 테이블 셀 스타일 */
		.option-table td {
		    padding: 12px 15px;
		    text-align: center;
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
            width: 50%;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

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
	<script>
	
	$(function() {
	    // 초기 가격 가져오기 (JSP에서 출력된 값을 바탕으로)
	    let cpu_price = parseInt($("#cpu_name").data('price')) || 0;
	    let memory_price = parseInt($("#memory_name").data('price')) || 0;
	    let graphic_Card_price = parseInt($("#graphic_Card_name").data('price')) || 0;
	    let total_price = cpu_price + memory_price + graphic_Card_price;  // 총합을 저장하는 변수

	    // 총합 가격 업데이트 함수
	    
	    
	    function updateTotalPrice() {
	        total_price = cpu_price + memory_price + graphic_Card_price;
	        $(".price_pro").text(total_price + " 원");
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
	});

	
let cpuNoList = [];
let memoryNoList = [];
let graphic_CardNoList = [];
let cpu_nameList = [];	
let memory_nameList = [];	
let graphic_Card_nameList = [];	

$(function() {
	
	$(".deleteBtn").click(function() {
	    var goods_no = $(this).data("goods_no");  // 삭제 버튼에 설정된 data-goods_no 값을 가져옵니다.
	    
	    if (goods_no) {
	        // 모달의 hidden input에 값 설정
	        $("#deleteNo").val(goods_no);
	    
	        // 모달 열기
	        $("#deleteModal").modal('show');
	    } else {
	        console.log("goods_no가 없습니다!");
	    }
	});

	
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
        <img src="${goods.image_main}" alt="이미지" style="width: 300px; height: 300px;">
    </div>

    <!-- 오른쪽 섹션: 상세 정보 -->
    <div class="right-section">
        <div class="product-title">사무용/가정용</div>
        <table class="spec-table">
            <tr>
                <th>CPU</th>
                <td class="cpu_name">${goods.cpu_name}</td>
            </tr>
            <tr>
                <th>메모리</th>
                <td class="memory_name">${goods.memory_name}</td>
            </tr>
            <tr>
                <th>그래픽카드</th>
                <td class="graphic_Card_name">${goods.graphic_Card_name}</td>
            </tr>
        </table>
        
        <div class="price">
		    판매가격: 
		</div><div class="price_pro">${goods.total_price} 원</div>


        <div class="btn-group">
            <button class="btn-buy">바로구매</button>
            <button class="btn-cart">장바구니 담기</button>
            <button class="btn-list" onclick="location.href='list.do?page=${param.page}&perPageNum=${param.perPageNum}&${goodsSearchVO.searchQuery}'">리스트</button>
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
		            <tr>
		                <td>CPU</td>
		                <td class="cpu_name" id="cpu_name" data-price="${goods.cpu_price }">${goods.cpu_name}</td>
<%-- 		                <td><button onclick="openModal('CPU', ${goods.goodsNo})">사양변경하기</button></td> --%>
						<td><button id="cpuChangeGoods">사양변경하기</button></td>
		            </tr>
		            <tr>
		                <td>메모리</td>
		                <td class="memory_name" id="memory_name" data-price="${goods.memory_price }">${goods.memory_name}</td>
		                <td><button id="memoryChangeGoods">사양변경하기</button></td>
		            </tr>
		            <tr>
		                <td>그래픽카드</td>
		                <td class="graphic_Card_name" id="graphic_Card_name" data-price="${goods.graphic_Card_price }">${goods.graphic_Card_name}</td>
		                <td><button id="graphic_CardChangeGoods">사양변경하기</button></td>
		            </tr>
		        </tbody>
            </table>
		        <div class="card-footer">
				<button class="btn btn-danger" id="deleteBtn"
					data-toggle="modal" data-target="#deleteModal">삭제</button>
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

</body>
</html>