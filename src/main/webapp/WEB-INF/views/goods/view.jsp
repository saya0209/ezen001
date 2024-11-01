<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>
<style type="text/css">
    #smallImageDiv img{
        width: 80px;
        height: 80px;    
    }
    #smallImageDiv img:hover{
        opacity: 0.7;
        cursor: pointer;    
    }
    #goodsDetailDiv>div{
    	padding: 10px;
    	border-bottom: 1px solid #777;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
    // smallImageDiv 안의 개별 이미지를 클릭할 때마다 실행
    $("#smallImageDiv img").click(function() {
        // 클릭된 이미지의 src 속성을 큰 이미지에 적용
        $("#bigImageDiv img").attr("src", $(this).attr("src"));
    });
    
    $("#listBtn").click(function(){
    	//alert("목록 클릭");
    	location="list.do?page=${param.page}&perPageNum=${param.perPageNum}&${goodsSearchVO.searchQuery}";
    });
    
    $("#updateBtn").click(function(){
    	//alert("수정 클릭");
    	location="updateForm.do?goods_no=${vo.goods_no}&page=${param.page}&perPageNum=${param.perPageNum}&${goodsSearchVO.searchQuery}";
    });
    
});
</script>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">상품 정보</div>
        <div class="card-body">
            <div class="row">
              <div class="col-md-6">
                <div id="smallImageDiv">
                    <img src="${vo.image_name}" class="img-thumbnail">
                    <c:if test="${!empty imageList}">
                        <c:forEach items="${imageList}" var="imageVO">
                            <img src="${imageVO.image_name}" class="img-thumbnail">
                        </c:forEach>
                    </c:if>                    
                </div>
                <div id="bigImageDiv" class="img-thumbnail">
                    <img src="${vo.image_name}" style="width: 100%">
                </div>
              </div>
              <div class="col-md-6" id="goodsDetailDiv">
                  <div> <i class="fa fa-caret-right"></i> 분류명 : ${vo.cate_name }</div>
                  <div> <i class="fa fa-caret-right"></i> 상품번호 : ${vo.goods_no }</div>
                  <div> <i class="fa fa-caret-right"></i> 상품명 : ${vo.goods_name }</div>
                  <div> <i class="fa fa-caret-right"></i> 정가 : <fmt:formatNumber value="${vo.price}" pattern="#,###"/> 원</div>
                  <div> <i class="fa fa-caret-right"></i> 할인가 : <fmt:formatNumber value="${vo.sale_price}" pattern="#,###"/> 원</div>
                  <div> <i class="fa fa-caret-right"></i> 배송료 : ${vo.delivery_charge }</div>
                  <div> <i class="fa fa-caret-right"></i> 적립률 : ${vo.saved_rate }%</div>
                  <div class="form-inline">
                  <form>
				    <!-- 사이즈 선택 -->
				    <div class="input-group mb-3">
				        <div class="input-group-prepend">
				            <span class="input-group-text">사이즈</span>
				        </div>
				        <select class="form-control" id="size_name">
				            <option>사이즈 선택</option>
				            <c:forEach items="${sizeList}" var="sizeVO">
				                <option>${sizeVO.size_name}</option>
				            </c:forEach>
				        </select>
				    </div>
				    
				    <!-- 색상 선택 -->
				    <div class="input-group mb-3">
				        <div class="input-group-prepend">
				            <span class="input-group-text">색상</span>
				        </div>
				        <select class="form-control" id="color_name">
				            <option>색상 선택</option>
				            <c:forEach items="${colorList}" var="colorVO">
				                <option>${colorVO.color_name}</option>
				            </c:forEach>
				        </select>
				    </div>
				</form>

	
	              </div>
	            </div>
	            <div class="row">
		              <div class="col-md-12">
	                  <pre>${vo.content }</pre>
	              </div>
	            </div>
	        </div>
	        <div class="card-footer">
				<button class="btn btn-primary" id="listBtn">목록</button>
				<button class="btn btn-success" id="updateBtn">수정</button>
			</div>
    	</div>
	</div>
</div>

</body>
</html>
