<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- main.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>

<!-- CSS 스타일 추가 -->
<style type="text/css">
.category-section {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin: 20px 0;
}

.category-item {
    flex: 1 1 23%; 
    margin: 10px;
    text-align: center;
}

.category-item img {
    max-width: 100%;
    border-radius: 8px;
}

.category-item h3 {
    margin-top: 10px;
    font-size: 1.2em;
}
</style>

</head>
<body>
<div class="container">
    <div class="category-section">
        <div class="category-item">
            <img src="webapp/upload/goods/man01.jsp" alt="사무용/가정용">
            <h3>사무용/가정용</h3>
        </div>
        <div class="category-item">
            <img src="webapp/upload/goods/man02.jsp" alt="고성능/전문가용">
            <h3>고성능/전문가용</h3>
        </div>
        <div class="category-item">
            <img src="webapp/upload/goods/man03.jsp" alt="3D게임/그래픽용">
            <h3>3D게임/그래픽용</h3>
        </div>
        <div class="category-item">
            <img src="webapp/upload/goods/man01.jsp" alt="노트북">
            <h3>노트북</h3>
        </div>
    </div>
</div>
</body>
</html>