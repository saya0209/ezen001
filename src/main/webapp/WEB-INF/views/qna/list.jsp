<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 목록</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/qna.css" rel="stylesheet">
    
</head>
<body>
<div class="qna-container">
        <h2 class="qna-title">
            <i class="fa fa-question-circle"></i> QnA 게시판
        </h2>

        <!-- 이용 정책 안내 -->
        <div class="policy-section">
            <h5><i class="fa fa-info-circle"></i> QnA 이용 안내</h5>
            <ul class="mb-0">
                <li>답변은 영업일 기준 2~3일 내에 등록됩니다.</li>
                <li>욕설, 비방 등 부적절한 내용은 삭제될 수 있습니다.</li>
                <li>개인정보가 포함된 내용은 비공개로 작성해주세요.</li>
            </ul>
        </div>

        <!-- 검색 폼 -->
        <form action="/qna/list.do" method="get" class="mb-4">
            <div class="row">
                <div class="col-md-3">
                    <select name="key" class="form-control">
                        <option value="t" ${param.key == 't' ? 'selected' : ''}>제목</option>
                        <option value="c" ${param.key == 'c' ? 'selected' : ''}>내용</option>
                        <option value="w" ${param.key == 'w' ? 'selected' : ''}>작성자</option>
                    </select>
                </div>
                <div class="col-md-7">
                    <input type="text" name="word" class="form-control" value="${param.word}"
                           placeholder="검색어를 입력하세요">
                </div>
                <div class="col-md-2">
                    <button class="btn btn-qna btn-qna-primary btn-block">
                        <i class="fa fa-search"></i> 검색
                    </button>
                </div>
            </div>
        </form>

        <!-- QnA 목록 테이블 -->
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>답변상태</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="6" class="text-center">게시글이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach items="${list}" var="vo">
                    <tr class="dataRow" data-no="${vo.qna_no}">
                        <td>${vo.qna_no}</td>
                        <td>
                            <span class="qna-category category-${vo.category != null ? vo.category.toLowerCase() : 'default'}">
                                ${vo.category != null ? vo.category : '미분류'}
                            </span>
                        </td>
                        <td>
                            <a href="/qna/view.do?qna_no=${vo.qna_no}&inc=1" class="text-dark">${vo.title}</a>
                        </td>
                        <td>${vo.nicname}</td>
                        <td>
                            <fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/>
                        </td>
<!--                         <td> -->
<%--                             <span class="status-${vo.status != null ? vo.status.toLowerCase() : 'unknown'}"> --%>
<%--                                 ${vo.status == 'waiting' ? '답변대기' : vo.status == 'answered' ? '답변완료' : '미확인'} --%>
<!--                             </span> -->
<!--                         </td> -->
					<td>
					    <span class="status-${vo.status != null ? vo.status.toLowerCase() : 'unknown'}">
					        <c:choose>
					            <c:when test="${vo.status == 'waiting'}">답변대기</c:when>
					            <c:when test="${vo.status == 'completed'}">답변완료</c:when>
					            <c:when test="${vo.status == 'confirmed'}">확인완료</c:when>
					            <c:otherwise>미확인</c:otherwise>
					        </c:choose>
					    </span>
					</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이지네이션 -->
        <nav>
            <ul class="pagination">
                <c:if test="${pageObject.startPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="list.do?page=1&key=${param.key}&word=${param.word}">
                            <i class="fa fa-angle-double-left"></i>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="list.do?page=${pageObject.startPage - 1}&key=${param.key}&word=${param.word}">
                            <i class="fa fa-angle-left"></i>
                        </a>
                    </li>
                </c:if>

                <c:forEach begin="${pageObject.startPage}" end="${pageObject.endPage}" var="cnt">
                    <li class="page-item ${pageObject.page == cnt ? 'active' : ''}">
                        <a class="page-link" href="list.do?page=${cnt}&key=${param.key}&word=${param.word}">
                            ${cnt}
                        </a>
                    </li>
                </c:forEach>

                <c:if test="${pageObject.endPage < pageObject.totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="list.do?page=${pageObject.endPage + 1}&key=${param.key}&word=${param.word}">
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="list.do?page=${pageObject.totalPage}&key=${param.key}&word=${param.word}">
                            <i class="fa fa-angle-double-right"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>

        <!-- 글쓰기 버튼 (로그인한 경우만 표시) -->
        <c:if test="${!empty login}">
            <div class="text-right">
                <a href="/qna/writeForm.do" class="btn btn-qna btn-qna-primary">
                    <i class="fa fa-pencil"></i> 질문하기
                </a>
            </div>
        </c:if>
    </div>
    
    <!-- 메시지 처리 -->
    <c:if test="${!empty msg}">
        <script>
            alert("${msg}");
        </script>
    </c:if>
</body>
</html>
