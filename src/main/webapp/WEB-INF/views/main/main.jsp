<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>컴마카세 - 전문가용 컴퓨터 구매</title>
    
    
        <!-- 추가된 JavaScript -->
    <script>
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
						                <option value="workstation">워크스테이션</option>
						            </select>
						        </div>
						        <div class="col-md-4">
						            <select id="budget" class="form-control custom-select">
						                <option selected disabled>예산 범위</option>
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
    <section class="featured-products">
        <div class="container">
            <div class="section-header">
                <h2>이달의 추천 상품</h2>
                <div class="product-filters">
                    <button class="filter-btn active">전체</button>
                    <button class="filter-btn">사무용</button>
                    <button class="filter-btn">게이밍</button>
                    <button class="filter-btn">워크스테이션</button>
                </div>
            </div>
            <div class="row">
                <!-- Product cards here (keeping existing structure) -->
            </div>
        </div>
    </section>


</body>
</html>