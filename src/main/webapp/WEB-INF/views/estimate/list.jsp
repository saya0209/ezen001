<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>견적 요청 목록</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>

    <!-- CSS -->
    <link href="${path}/resources/css/estimate.css" rel="stylesheet">
    
</head>
<body>
    <div class="estimate-container">
        <h2 class="estimate-title">
            PC 견적 요청 목록
        </h2>

        <!-- 이용 정책 안내 -->
        <div class="policy-section">
            <h5><i class="fa fa-info-circle"></i> PC 견적 요청 안내</h5>
            <ul class="mb-0">
                <li>PC 견적 요청은 필요한 부품, 예산, 용도를 상세히 작성해주세요.</li>
                <li>예산 범위와 필수 요구 사항을 명확히 기재하시면 더욱 정확한 견적을 받을 수 있습니다.</li>
                <li>견적 답변은 영업일 기준 2~3일 이내에 제공됩니다.</li>
                <li>부적절한 내용이나 욕설이 포함된 요청은 사전 통보 없이 삭제될 수 있습니다.</li>
                <li>개인정보가 포함되지 않도록 주의해주시기 바랍니다.</li>
                <li>부품 가격은 변동될 수 있으므로 최신 견적 확인이 필요합니다.</li>
            </ul>
        </div>

        <!-- 검색 폼 -->
        <form action="list.do" method="get" class="mb-4">
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
                    <button class="btn btn-primary btn-block">
                        <i class="fa fa-search"></i> 검색
                    </button>
                </div>
            </div>
        </form>
        
        

        <!-- 견적 요청 목록 테이블 -->
        <table class="table table-hover">
            <thead class="thead-light">
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>예산</th>
                    <th>상태</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="7" class="text-center">견적 요청이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach items="${list}" var="estimate">
                    <tr>
                        <td>${estimate.request_no}</td>
                        <td>
                            <span class="category-badge">${estimate.category}</span>
                        </td>
                        <td>
                            <a href="view.do?request_no=${estimate.request_no}" class="text-dark">
                                ${estimate.title}
                            </a>
                        </td>
                        <td>${estimate.nicname}</td>
                        <td>
                            <fmt:formatNumber value="${estimate.budget}" pattern="#,###원"/>
                        </td>
                        <td>
                            <span class="status-${estimate.status}">
                                ${estimate.status == 'waiting' ? '대기중' : '답변완료'}
                            </span>
                        </td>
                        <td>
                            <fmt:formatDate value="${estimate.request_date}" pattern="yyyy-MM-dd"/>
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
            <div class="text-right mt-3">
                <a href="writeForm.do" class="btn btn-success">
                    <i class="fa fa-plus"></i> 견적 요청하기
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
