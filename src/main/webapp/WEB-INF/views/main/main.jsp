<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>컴마카세 - 전문가용 컴퓨터 구매</title>
    
    <style type="text/css">
    .row {
	    display: flex;
	    justify-content: center; /* 행의 콘텐츠를 중앙 정렬 */
	    flex-wrap: wrap; /* 아이템들이 여러 줄에 걸쳐 정렬되도록 설정 */
	}
	
	.card {
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    text-align: center; /* 텍스트를 카드 안에서 중앙 정렬 */
	    pointer-events: auto;
	}
	
	.card img {
	    max-width: 100%; /* 이미지가 카드의 너비를 넘지 않도록 */
	    height: auto; /* 이미지 비율을 유지 */
	    margin: 0 auto; /* 이미지를 중앙에 배치 */
	}
    
     /* 버튼 기본 스타일 */
    .category-button1 {
        display: inline-block;
        padding: 10px 20px; /* 여백 조정 */
        margin: 5px; /* 버튼 간 간격 */
        font-size: 16px;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        border-radius: 25px; /* 둥근 모서리 */
        background: linear-gradient(135deg, #007bff, #00d4ff); /* 그라디언트 배경 */
        color: white;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease; /* 부드러운 전환 효과 */
    }

    /* 버튼에 마우스를 올렸을 때 */
    .category-button1:hover {
        background: linear-gradient(135deg, #0056b3, #0099cc); /* 호버 시 그라디언트 색상 변경 */
        transform: scale(1.05); /* 버튼 크기 살짝 커짐 */
    }

    /* 버튼 클릭 시 */
    .category-button1:active {
        transform: scale(0.98); /* 클릭하면 약간 축소되는 효과 */
    }

    /* 버튼을 비활성화할 때 스타일 */
    .category-button1:disabled {
        background: #c7c7c7;
        cursor: not-allowed;
    }
    
    </style>
    
    
        <!-- 추가된 JavaScript -->
    <script type="text/javascript">
        // 캐러셀 자동 재생 설정
        $(document).ready(function() {
            $('#mainCarousel').carousel({
                interval: 5000
            });

            // 배경 이미지 동적 로드
            $('.carousel-item').each(function() {
                var bgImg = $(this).data('bg');
                $(this).css('background-image', 'url(' + bgImg + ')');
            });

            // 알림 배너 marquee 효과
            setInterval(function() {
                $('.marquee-content').animate({marginLeft: '-=1'}, 30, 'linear', function() {
                    if (Math.abs(parseInt($(this).css('margin-left'))) >= $(this).width() / 2) {
                        $(this).css('margin-left', 0);
                    }
                });
            }, 30);
        });
        
        $(document).ready(function() {
            // 페이지가 로드되면 기본적으로 사무용/가정용 데이터 로드
            updateGoodsList('goods1');
            
            
            $('#product-list').on('click', '.cartEvent', function() {
                console.log("click이벤트");

                const category = $(this).data('category');
                const goods_no = $(this).data('goods_no');

                console.log("category:", category);   // category 값 확인
                console.log("goods_no:", goods_no);   // goods_no 값 확인

                // 값이 제대로 존재하는지 확인
                if (!category || !goods_no) {
                    console.log("Error: category 또는 goods_no 값이 없습니다.");
                    return;  // 값이 없으면 URL로 이동하지 않도록 함
                }
                
                

                const url = '/goods/view.do?category=' + category + '&goods_no=' + goods_no;
                console.log("Redirecting to URL:", url);
                window.location.href = url;
            });
        });
        
    	 // 클릭 시 상세 페이지로 이동하는 함수
        //function goToDetailPage(category, goods_no) {
    	function goToDetailPage() {
			const category = "11";    	
			const goods_no = "11";    	
    	
    		 console.log("click이벤트");
            console.log("category:", category);
            console.log("goods_no:", goods_no);
            // URL 구성
            const url = `/goods/view.do?category=${category}&goods_no=${goods_no}`;
            // 해당 URL로 리디렉션
            window.location.href = url;
        }
        
        function updateGoodsList(category) {
            // 카테고리별 상품 목록을 가져오기 위한 fetch 요청
            fetch('/getGoodsByCategory?category=' + category)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('서버에서 오류가 발생했습니다. 상태 코드: ' + response.status);
                    }

                    // 응답이 XML인지 확인
                    const contentType = response.headers.get("Content-Type");
                    if (contentType && contentType.includes("application/xml")) {
                        return response.text(); // XML 형식으로 받기
                    } else {
                        throw new Error('서버 응답이 XML이 아닙니다. 응답 형식: ' + contentType);
                    }
                })
                .then(text => {
                    // XML 파싱하기
                    const parser = new DOMParser();
                    const xmlDoc = parser.parseFromString(text, "application/xml");

                    // XML 데이터를 처리하는 코드 작성
                    const goods = [];
                    const goodsElements = xmlDoc.getElementsByTagName('goods');
                    console.log("goodsElements.length:" + goodsElements.length);
                    for (let i = 0; i < goodsElements.length; i++) {
                        const good = goodsElements[i];
                        goods.push({
                            image_name: good.getElementsByTagName('image_name')[0]?.textContent,
                            cpu_name: good.getElementsByTagName('cpu_name')[0]?.textContent,
                            memory_name: good.getElementsByTagName('memory_name')[0]?.textContent,
                            graphic_Card_name: good.getElementsByTagName('graphic_Card_name')[0]?.textContent,
                            total_price: parseFloat(good.getElementsByTagName('total_price')[0]?.textContent),
                            discount: parseFloat(good.getElementsByTagName('discount')[0]?.textContent),
                            delivery_charge: parseFloat(good.getElementsByTagName('delivery_charge')[0]?.textContent),
                            category: good.getElementsByTagName('category')[0]?.textContent,
                            goods_no: good.getElementsByTagName('goods_no')[0]?.textContent
                        });
                    }

                    // 상품 목록을 HTML로 표시
                    const productListElement = document.getElementById("product-list");
                    productListElement.innerHTML = '';  // 기존 내용 초기화

                    // 상품 목록을 최대 4개만 표시
                    const maxItems = 4;
                    const limitedGoods = goods.slice(0, maxItems);  // 처음 4개 상품만 선택

                    if (limitedGoods.length > 0) {
                        let rowElement = null;
                        limitedGoods.forEach((good, index) => {
                            if (index % 4 === 0) {
                                // 4개마다 새로운 행(row)을 추가
                                rowElement = document.createElement('div');
                                rowElement.classList.add('row');
                                productListElement.appendChild(rowElement);
                            }

                            const productElement = document.createElement('div');
                            productElement.classList.add('col-md-3');  // 부트스트랩 컬럼 4개로 나누기
                            
                            // CPU, 메모리, 그래픽 카드 이름이 존재할 경우만 표시
                            const cpuName = good.cpu_name ? ('<h5 class="title">'+ good.cpu_name +'</h5>') : '';
                            const memoryName = good.memory_name ? ('<h5 class="title">'+ good.memory_name +'</h5>') : '';
                            const graphicCardName = good.graphic_Card_name ? ('<h5 class="title">'+ good.graphic_Card_name +'</h5>') : '';

                            // 총 가격 계산
                            const totalPrice = good.total_price - good.discount + good.delivery_charge;
                            // 가격을 통화 형식으로 포맷
                            const formattedPrice = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(totalPrice);  // 한국 원화(KRW)로 설정

                            console.log("good.category" + good.category);
                            // 카드 HTML 구조 생성
                            productElement.innerHTML = '' +
                                '<div class="card cartEvent" data-category="'+ good.category + '" data-goods_no="'+ good.goods_no +'">' +
                                '<div class="imageDiv">' +
                                '<img src="' + good.image_name +'" alt="이미지">' +
                                '</div>' +
                                '<div class="card-body">' +
                                cpuName + ' ' + memoryName + ' ' + graphicCardName +
                                '<p class="sale-price">' + formattedPrice + '</p>' +
                                '</div>' +
                                '</div>';

                            // 생성된 상품 요소를 현재 행에 추가
                            rowElement.appendChild(productElement);
                        });
                    } else {
                        productListElement.innerHTML = '<p>데이터가 없습니다.</p>';
                    }
                })
                .catch(error => {
                    console.error('상품 데이터를 가져오는 중 오류 발생:', error);
                    document.getElementById("product-list").innerHTML = `<p>오류 발생: ${error.message}</p>`;
                });
        }



    </script>
    <script>
	function submitForm() {
	    // 선택한 카테고리와 예산 범위 값을 가져오기
	    var category = document.getElementById("category").value;
	    var budget = document.getElementById("budget").value;
	
	    // 카테고리와 예산 범위가 선택되지 않았을 경우 경고 메시지
	    if (category == null || category == '용도 선택' || budget == null || budget == '예산 범위') {
	        alert("모든 항목을 선택해 주세요.");
	        return;
	    }
	
	    // URL에 선택한 값들을 쿼리스트링으로 추가하여 이동
	    var url = '../estimate/writeForm.do?category=' + encodeURIComponent(category) + '&budget=' + encodeURIComponent(budget);
	    location.href = url;
	}
	</script>
</head>
<body>
    <!-- 상단 알림 배너 -->
    <div class="notification-banner">
        <div class="container">
            <div class="marquee-content">
                <span><i class="fa fa-info-circle"></i> 신규 회원 가입 시 10만원 할인쿠폰 증정</span>
                <span><i class="fa fa-gift"></i> 이달의 특가 행사 진행중</span>
                <span><i class="fa fa-clock-o"></i> 24/36개월 무이자</span>
            </div>
        </div>
    </div>

    <!-- 메인 슬라이더 -->
    <div id="mainCarousel" class="carousel slide main-carousel" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#mainCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#mainCarousel" data-slide-to="1"></li>
            <li data-target="#mainCarousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active" data-bg="/upload/main/banner1.jpg">
                <div class="carousel-content">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-6">
                                <h1 class="display-4 text-white mb-4">최고급 워크스테이션</h1>
                                <p class="lead text-white mb-4">인텔 13세대 프로세서와 RTX 4090으로 구성된<br>최상의 성능을 경험하세요</p>
                                <div class="spec-tags mb-4">
                                    <span>i9-13900K</span>
                                    <span>RTX 4090</span>
                                    <span>DDR5 128GB</span>
                                </div>
                                <a href="#" class="btn btn-light btn-lg">자세히 보기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item" data-bg="/upload/main/banner2.jpg">
                <!-- Similar structure for banner 2 -->
            </div>
            <div class="carousel-item" data-bg="/upload/main/banner3.jpg">
                <!-- Similar structure for banner 3 -->
            </div>
        </div>
    </div>

    <!-- 빠른 견적 섹션 -->
    <section class="quick-quote-section">
        <div class="container">
            <div class="quick-quote-wrapper">
                <div class="row g-0">
                    <div class="col-lg-3">
                        <div class="quote-intro">
                            <h3>빠른 견적</h3>
                            <p>3단계로 쉽게 견적받기</p>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <form class="quote-form">
						    <div class="row g-3">
						        <div class="col-md-4">
						            <select id="category" class="form-control custom-select">
						                <option selected disabled>용도 선택</option>
						                <option value="office">사무용</option>
						                <option value="gaming">게이밍용</option>
						                <option value="design">디자인</option>
						            </select>
						        </div>
						        <div class="col-md-4">
						            <select id="budget" class="form-control custom-select">
						                <option selected disabled>예산</option>
						                <option value="1000000">100만원</option>
						                <option value="2000000">200만원</option>
						                <option value="2000000">200만원 이상</option>
						            </select>
						        </div>
						        <div class="col-md-4">
						            <button type="button" class="btn btn-primary btn-block" onclick="submitForm()">
						                견적 받기
						            </button>
						        </div>
						    </div>
						</form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 제품 카테고리 -->
    <section class="categories-section">
        <div class="container">
            <div class="section-header">
                <h2>제품 카테고리</h2>
                <p>목적에 맞는 최적의 PC를 찾아보세요</p>
            </div>
            <div class="row">
                <!-- Category cards here (keeping existing structure) -->
            </div>
        </div>
    </section>

    <!-- 추천 상품 섹션 -->
    <!-- 이달의 추천상품 섹션 -->
    <section class="featured-products">
        <div class="container">
            <div class="section-header">
                <h2>이달의 추천 상품</h2>
                <div class="product-filters">
                    <!-- 카테고리 버튼 클릭 시 상품 리스트 갱신 -->
                    <button class="category-button1" onclick="updateGoodsList('goods1')">사무용/가정용</button>
					<button class="category-button1" onclick="updateGoodsList('goods2')">3D게임/그래픽용</button>
					<button class="category-button1" onclick="updateGoodsList('goods3')">고성능용/전문가용</button>
					<button class="category-button1" onclick="updateGoodsList('goods4')">노트북</button>
                </div>
            </div>

            <!-- 상품 목록 표시 부분 -->
            <div id="product-list">
                <!-- 상품 목록이 서버에서 로드되어 여기에 표시됩니다 -->
                <c:if test="${empty goodsList}">
                    <h4>데이터가 존재하지 않습니다.</h4>
                </c:if>

                <c:if test="${!empty goodsList}">
                    <div class="row justify-content-center">
                        <c:forEach var="goods" items="${goodsList}" varStatus="vs">
			                <c:if test="${(vs.index != 0) && (vs.index % 4 == 0)}">
			                    ${"</div><div class='row'>"}
			                </c:if>
			                <div class="col-md-3">
<%--     							<div class="card" onclick="goToDetailPage('${goods.category}', '${goods.goods_no}')"> --%>
								<div class="card cartEvent" data-category="${goods.category}" data-goods_no="${goods.goods_no}">
			                        <div class="imageDiv">
			                            <!-- 여기에 상품 이미지 추가 -->
			                            <img src="${goods.image_name}" alt="이미지">
			                        </div>
			                        <div class="card-body">
			                            <c:if test="${not empty goods.cpu_name and goods.cpu_name != '0'}">
									        <h5 class="title">${goods.cpu_name}</h5>
									    </c:if>
			                            <c:if test="${not empty goods.memory_name and goods.memory_name != '0'}">
									        <h5 class="title">${goods.memory_name}</h5>
									    </c:if>
									    <c:if test="${not empty goods.graphic_Card_name and goods.graphic_Card_name != '0'}">
									        <h5 class="title">${goods.graphic_Card_name}</h5>
									    </c:if>
			                            <p class="sale-price">
			                                <fmt:formatNumber value="${goods.total_price - goods.discount + goods.delivery_charge}" type="currency" />
			                            </p>
			                        </div>
			                    </div>                    
			                </div>
			            </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </section>



</body>
</html>