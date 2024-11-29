<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>
<%--     <link href="${path}/resources/css/communityList.css" rel="stylesheet"> --%>
    
<style>
        :root {
            --primary-color: #4a90e2;
            --secondary-color: #5b9bd5;
            --hover-color: #f5f9ff;
            --border-color: #e1e8f0;
            --text-color: #2c3e50;
            --light-text: #7f8c8d;
            --notice-bg: #f8fbff;
        }

        .board-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        /* 검색 영역을 상단으로 이동 및 스타일 수정 */
        .search-area {
            margin-bottom: 20px;
            padding: 10px;
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            max-width: 800px; /* 가로 크기 제한 */
            margin: 20px auto; /* 가운데 정렬 */
        }

        .search-left {
            display: flex;
            gap: 10px;
            flex: 1;
        }

        .search-select {
            padding: 8px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            color: var(--text-color);
            background-color: white;
            font-size: 0.9rem;
        }

        .search-input {
            min-width: 150px; 
            padding: 8px 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            color: var(--text-color);
            font-size: 0.9rem;
            flex: 1; /* 검색 입력란이 남는 공간을 채우도록 설정 */
        }

        .search-btn, .write-btn {
            padding: 8px 16px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.2s;
            white-space: nowrap; /* Keep the button text on one line */
        }

        .search-btn:hover, .write-btn:hover {
            background: var(--secondary-color);
        }

        .write-btn {
            margin-left: 10px; /* Adjust spacing between search and write buttons */
        }

        .search-right {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .board-title {
            display: flex;
            align-items: center;
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--primary-color);
        }

        .board-title i {
            margin-right: 5px;
            color: var(--primary-color);
        }

        .sort-options {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .sort-options a {
            color: var(--light-text);
            text-decoration: none;
            padding: 5px;
            font-size: 0.9rem;
            transition: color 0.2s;
        }

        .sort-options a:hover {
            color: var(--primary-color);
        }

        .sort-options .active {
            color: var(--primary-color);
            font-weight: bold;
        }

        .board-table {
            width: 100%;
            border-top: 2px solid var(--primary-color);
            background: white;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .board-table th {
            padding: 15px;
            font-size: 0.9rem;
            background: #fafbfc;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
            font-weight: 600;
        }

        .board-table td {
            padding: 15px;
            font-size: 0.9rem;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
        }

        .board-table tr:hover {
            background-color: var(--hover-color);
        }

        .notice {
            background-color: var(--notice-bg);
        }

        .notice-badge {
            display: inline-block;
            padding: 2px 8px;
            background-color: var(--primary-color);
            color: white;
            border-radius: 3px;
            font-size: 0.8rem;
        }

        .count-info {
            color: var(--light-text);
            font-size: 0.85rem;
            margin-left: 5px;
        }

        .reply-count {
            color: var(--primary-color);
            font-weight: bold;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }

        .pagination a {
            padding: 8px 12px;
            border: 1px solid var(--border-color);
            color: var(--text-color);
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.2s;
        }

        .pagination a:hover {
            background: var(--hover-color);
            border-color: var(--primary-color);
            color: var(--primary-color);
        }

        .pagination .active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .search-area {
                flex-direction: column;
            }

            .search-left, .search-right {
                width: 100%;
            }

            .search-input {
                width: 100%;
            }

            .board-table th:nth-child(3),
            .board-table th:nth-child(5),
            .board-table th:nth-child(6),
            .board-table td:nth-child(3),
            .board-table td:nth-child(5),
            .board-table td:nth-child(6) {
                display: none;
            }
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {
            $(".board-table").on("click", ".dataRow", function() {
                let no = $(this).data("no");
                window.location.href = "view.do?post_no=" + no + "&inc=1" + "&${pageObject.pageQuery}";
            });
            
            $(".sort-options a").click(function(e) {
                e.preventDefault();
                $(".sort-options a").removeClass("active");
                $(this).addClass("active");
            });
        });
    </script>
</head>
<body>
<div class="board-container">
    <!-- 검색 영역을 상단으로 이동 -->
     <div class="search-area">
        <div class="search-left">
            <select class="search-select">
                <option>전체기간</option>
                <option>1일</option>
                <option>1주</option>
                <option>1개월</option>
                <option>6개월</option>
                <option>1년</option>
            </select>
            <select class="search-select">
                <option>제목만</option>
                <option>글작성자</option>
                <option>댓글내용</option>
                <option>댓글작성자</option>
            </select>
            <input type="text" class="search-input" placeholder="검색어를 입력해주세요">
            <button class="search-btn btn-sm">검색</button> <!-- 검색 버튼 -->
        </div>
        <div class="search-right">
            <c:if test="${!empty login}">
                <a href="writeForm.do" class="write-btn btn-sm">
                    <i class="fa fa-pencil"></i> 글작성
                </a>
            </c:if>
        </div>
    </div>
   

    <div class="board-header">
        <div class="board-title">
            <i class="fa fa-comments-o"></i>
            자유게시판
        </div>
        <div class="sort-options">
            <a href="#" class="active">최신순</a>
            <a href="#">추천순</a>
            <a href="#">조회순</a>
        </div>
    </div>

    <table class="board-table">
        <thead>
            <tr>
                <th style="width: 8%">번호</th>
                <th style="width: 52%">제목</th>
                <th style="width: 12%">글쓴이</th>
                <th style="width: 12%">작성일</th>
                <th style="width: 8%">조회</th>
                <th style="width: 8%">추천</th>
            </tr>
        </thead>
        <tbody>
                <tr class="notice">
                    <td><span class="notice-badge">공지</span></td>
                    <td>
                        중요 공지사항입니다
                        <span class="count-info">
                            <c:if test="${!empty vo.image}">
				                <i class="reply-count fa fa-file-image-o"></i>
				            </c:if>
                        </span>
                    </td>
                    <td>관리자</td>
                    <td>2024.11.16</td>
                    <td>100</td>
                    <td>10</td>
                </tr>
            
            <c:forEach items="${list}" var="vo">
			    <tr class="dataRow" data-no="${vo.community_no}">
			        <td>${vo.community_no}</td>
			        <td>
			            ${vo.title} 
			            <c:if test="${!empty vo.image}">
			                <i class="reply-count fa fa-file-image-o"></i>
			            </c:if>
			        </td>
			        <td>${vo.nicname}</td>
			        <td><fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd"/></td>
			        <td>${vo.hit}</td>
			        <td>${vo.likeCnt}</td>
			    </tr>
			</c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"></pageNav:pageNav>
    </div>
</div>
</body>
</html>