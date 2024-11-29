<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>컴퓨터 상품 리스트</title>
    <style type="text/css">
        /* 상품 카드 스타일 */
        .card {
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .imageDiv {
            height: 180px; /* 이미지 영역 고정 높이 */
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f7f7f7;
        }

        .imageDiv img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain; /* 이미지 비율 유지 */
        }

        .title {
            font-weight: bold;
        }

        .card-body {
            text-align: center;
        }

        .sale-price {
            color: #ff5722;
            font-weight: bold;
            font-size: 1.2em;
        }

        /* 검색 및 필터 영역 스타일 */
        .search-container {
            display: flex;
            justify-content: flex-end; /* 오른쪽으로 정렬 */
        }

        .sort-dropdown {
            width: 150px;
        }

        .footer {
            text-align: right;
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript">
    $(function(){
        console.log("jQuery Loaded");

        
        // 상품 클릭 시 상세 페이지로 이동
        $(".dataRow").click(function() {
        	let category = $(this).data("category");
            let goods_no = $(this).data("goods_no");
            console.log("goods_no =", goods_no);
            let pageQuery = $(this).data("page_query");
            let searchQuery = $(this).data("search_query");

            location = "view.do?category=" + category + "&goods_no=" + goods_no + "&" + pageQuery + "&" + searchQuery;
        });

        // Sort 옵션 변경 시 자동으로 폼 제출
        $("select[name='sort']").change(function() {
            $("#searchForm").submit(); // sort가 변경되면 자동으로 폼 제출
        });
    });
    </script>
</head>
<body>

<div class="container p-3 my-3">
    <h1>
        <c:if test="${category == 'goods1' }">
            사무용/가정용
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
        <c:if test="${category == 'goods5' }">
            부품/주변기기
        </c:if>
    </h1>

    <form action="list.do" method="get" id="searchForm">
        <!-- 현재 페이지, 카테고리, 검색 조건을 유지하면서 폼 제출 -->
        <input type="hidden" name="page" value="${pageObject.page}">
        <input type="hidden" name="category" value="${category}">

        <!-- 검색 및 정렬 필터 -->
        <div class="search-container d-flex justify-content-end">
            <div class="sort-dropdown">
                <select name="sort" class="form-control">
                    <!-- sort 값에 따라 정렬 조건을 지정 -->
                    <option value="hit" ${sort == 'hit' ? 'selected' : ''}>조회수순</option>
                    <option value="priceAsc" ${sort == 'priceAsc' ? 'selected' : ''}>최저가순</option>
                    <option value="priceDesc" ${sort == 'priceDesc' ? 'selected' : ''}>최고가순</option>
                </select>
            </div>
        </div>
    </form>

    <c:if test="${empty goodsList}">
        <h4>데이터가 존재하지 않습니다.</h4>
    </c:if>

    <c:if test="${!empty goodsList}">
        <div class="row">
            <c:forEach var="goods" items="${goodsList}" varStatus="vs">
                <c:if test="${(vs.index != 0) && (vs.index % 4 == 0)}">
                    ${"</div><div class='row'>"}
                </c:if>
                <div class="col-md-3 dataRow" data-category="${goods.category }" data-goods_no="${goods.goods_no}"
                     data-page_query="${pageObject.pageQuery}" data-search_query="${goodsSearchVO.searchQuery}">
                    <div class="card">
					    <div class="imageDiv">
					        <img src="${goods.image_name}" alt="상품 이미지" class="card-img-top">
					    </div>
					    <div class="card-body">
					        <div class="product-info">
					            <c:if test="${not empty goods.cpu_name and goods.cpu_name != '0'}">
					                <h5 class="title">${goods.cpu_name}</h5>
					            </c:if>
					            <c:if test="${not empty goods.memory_name and goods.memory_name != '0'}">
					                <h5 class="title">${goods.memory_name}</h5>
					            </c:if>
					            <c:if test="${not empty goods.graphic_Card_name and goods.graphic_Card_name != '0'}">
					                <h5 class="title">${goods.graphic_Card_name}</h5>
					            </c:if>
					        </div>
					        <div class="price-container">
					            <p class="sale-price">
					                <fmt:formatNumber value="${goods.total_price - goods.discount + goods.delivery_charge}" type="currency" />
					            </p>
					        </div>
					    </div>
					</div>

                </div>
            </c:forEach>
        </div>

        <!-- 페이지 네비게이션 -->
        <div>
            <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav>
        </div>
    </c:if>

    <div class="footer">
    	<c:if test="${login.gradeNo == 9 }">
	        <form action="writeForm.do" method="get">
	            <input type="hidden" name="category" value="${category}">
	            <button type="submit" class="btn btn-primary">등록</button>
	        </form>
	    </c:if>
    </div>
</div>

</body>
</html>
