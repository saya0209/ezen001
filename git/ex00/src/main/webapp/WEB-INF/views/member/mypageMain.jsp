<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu Navigation Page</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* 기본 스타일 설정 */
    #menu {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
    }
    #menu {
        width: 100%;
        background-color: #ffffff; /* 메뉴만 흰색 배경 */
        padding: 10px;
        border-right: 1px solid #ccc;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1); /* 메뉴에 그림자 추가 */
    }
    #menu a {
        display: block;
        padding: 10px;
        color: #333;
        text-decoration: none;
        margin: 5px 0;
        border-radius: 4px;
    }
    #menu a:hover {
        background-color: #ddd;
    }
    #content {
		width: 100%;
        padding: 20px;
        background-color: #f4f4f4; /* 전체 배경색과 통일 */
    }
</style>
<script>
	const loginId = "${login.id}";
    // 메뉴 클릭 시 AJAX로 콘텐츠 로드
    $(document).ready(function() {
        $("#menu a").click(function(event) {
            event.preventDefault(); // 기본 동작 방지
            let pageUrl = "/memberAjax/" + $(this).attr("href")+"?id="+loginId; // 링크에서 URL 가져오기
            console.log(pageUrl);
            $("#content").load(pageUrl); // AJAX로 콘텐츠 로드
        });
        // 일반회원이 수정 후 마이페이지 - mypageMenu3.do 로 이동
        if (${!empty id}) {
	        let pageUrl = "/memberAjax/mypageMenu3.do?id=${id}"; // 링크에서 URL 가져오기
	        console.log(pageUrl);
	        $("#content").load(pageUrl);
        }
        
    });
</script>
</head>
<body>


<div class="row">
  <div class="col-md-2">
<div id="menu">
    <h3>마이페이지</h3>
    <a href="mypageMenu1.do">주문리스트</a>
    <a href="mypageMenu2.do">장바구니</a>
    <a href="mypageMenu3.do">내 정보 보기/수정</a>
</div>
  
  </div>
  <div class="col-md-10">
<div id="content">
    <!-- 기본적으로 표시할 초기 콘텐츠 -->
    <h2>Welcome!</h2>
    <p>Select a menu item to view more details.</p>
</div>
  
  </div>
</div>

</body>
</html>