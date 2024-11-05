<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- list.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<style type="text/css">
.editDiv {
    display: none;
}
</style>

<script type="text/javascript">
$(function(){
    // 이벤트 처리
    // 대분류 탭 클릭
    $(".bigCateData").click(function(){
        let cate_code1 = $(this).data("cate_code1");
        if (!$(this).hasClass("active")) {
            location="list.do?cate_code1=" + cate_code1;
        }
    });

	// 대분류 등록 버튼 클릭 이벤트
    $(document).on("click", "#writeBigBtn", function() {
        return categoryProcess("대분류 등록", "0", "0", "", "write.do", "등록");
    });
	 
	// 중분류 등록 버튼 클릭 이벤트
    $(document).on("click", "#writeMidBtn", function() {
        let cate_code1 = $(this).data("cate_code1"); // 대분류 코드
        return categoryProcess("중분류 등록", cate_code1, "0", "", "write.do", "등록");
    });

 	// 소분류 등록 버튼 클릭 이벤트
    $(document).on("click", ".writeSmallBtn", function() {
        let cate_code1 = $(this).data("cate_code1");
        let cate_code2 = $(this).data("cate_code2");
        return categoryProcess("소분류 등록", cate_code1, cate_code2, "", "write.do", "등록");
    });
	
 	// 대분류 수정 버튼 클릭 이벤트
    $(document).on("click", ".updateBigBtn", function() {
        let cate_code1 = $(this).closest("li").data("cate_code1");
        let cate_name = $(this).closest("li").find(".cate_name").text();
        return categoryProcess("대분류 수정", cate_code1, "0", cate_name, "update.do", "수정");
    });
 	
 	// 중분류 수정 버튼 클릭 이벤트
    $(document).on("click", ".updateMidBtn", function() {
        let cate_code1 = $(this).closest("li").data("cate_code1");
        let cate_code2 = $(this).closest("li").data("cate_code2");
        let cate_name = $(this).closest("li").find(".midCateName").text();
        return categoryProcess("중분류 수정", cate_code1, cate_code2, cate_name, "update.do", "수정");
    });
    
    // 소분류 수정 버튼 클릭 이벤트
    $(document).on("click", ".updateSmallBtn", function() {
        let cate_code1 = $(this).closest("li").data("cate_code1");
        let cate_code2 = $(this).closest("li").data("cate_code2");
        let cate_code3 = $(this).closest("li").data("cate_code3");
        let cate_name = $(this).closest("li").find(".smallCateName").text();
        return categoryProcess("소분류 수정", cate_code1, cate_code2, cate_name, "update.do", "수정");
    });
	
 	// 대분류 삭제 버튼 클릭 이벤트
    $(document).on("click", ".deleteBigBtn", function() {
        let cate_code1 = $(this).closest("li").data("cate_code1");
        let cate_name = $(this).closest("li").find(".cate_name").text();
        return categoryProcess("대분류 삭제", cate_code1, "0", cate_name, "delete.do", "삭제");
    });
 	
 	// 중분류 삭제 버튼 클릭 이벤트
    $(document).on("click", ".deleteMidBtn", function() {
        let cate_code1 = $(this).closest("li").data("cate_code1");
        let cate_code2 = $(this).closest("li").data("cate_code2");
        let cate_name = $(this).closest("li").find(".midCateName").text();
        return categoryProcess("중분류 삭제", cate_code1, cate_code2, cate_name, "delete.do", "삭제");
    });
    
    // 소분류 삭제 버튼 클릭 이벤트
    $(document).on("click", ".deleteSmallBtn", function() {
        let cate_code1 = $(this).closest("li").data("cate_code1");
        let cate_code2 = $(this).closest("li").data("cate_code2");
        let cate_code3 = $(this).closest("li").data("cate_code3");
        let cate_name = $(this).closest("li").find(".smallCateName").text();
        return categoryProcess("소분류 삭제", cate_code1, cate_code2, cate_name, "delete.do", "삭제");
    });

    // 모달창을 보여주기전 세팅하는 함수
    function categoryProcess(title, cate_code1, cate_code2, cate_name, url, btnName) {
    $("#categoryModal").find(".modal-title").text(title);
    $("#modalCateCode1").val(cate_code1);
    $("#modalCateCode2").val(cate_code2);
    $("#modalCateCode3").val(""); // 소분류 등록 시 초기화
    $("#modalForm").attr("action", url);
    $("#modalCateName").val(cate_name);
    $("#submitBtn").text(btnName);

    $("#submitBtn").removeClass("btn-primary btn-success btn-danger");
    if (btnName === "수정") {
        $("#submitBtn").addClass("btn-success");
    } else if (btnName === "삭제") {
        $("#submitBtn").addClass("btn-danger");
    } else {
        $("#submitBtn").addClass("btn-primary");
    }

    // AJAX 호출
    $("#submitBtn").off('click').on('click', function(e) {
        e.preventDefault(); // 기본 폼 제출 방지
        $.ajax({
            url: url,
            type: 'POST',
            data: {
                cate_code1: cate_code1,
                cate_code2: cate_code2,
                cate_name: $("#modalCateName").val()
            },
            success: function(response) {
                // 성공적으로 처리된 후의 작업
                alert("처리가 완료되었습니다.");
                $("#categoryModal").modal("hide");
                // UI 업데이트 (예: 카테고리 리스트 새로 고침)
                location.reload(); // 페이지 새로 고침 또는 동적으로 리스트 업데이트
            },
            error: function(xhr, status, error) {
                // 오류 처리
                alert("처리 중 오류가 발생했습니다.");
            }
        });
    });

    $("#categoryModal").modal("show");
    return false; 
}
});
</script>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header"><h2>카테고리 관리</h2></div>
            <div class="card-body">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                    <c:forEach items="${listBig}" var="vo">
                        <li class="nav-item">
                            <a class="nav-link bigCateData ${(vo.cate_code1 == cate_code1)?'active':''}"
                            data-toggle="tab" href="#mid_category"
                            data-cate_code1="${vo.cate_code1}">
                                <span class="cate_name">${vo.cate_name}</span>
                                <i class="fa fa-edit cate_edit"></i>
                                <div class="editDiv">
                                    <button class="btn btn-success btn-sm updateBigBtn">수정</button>
                                    <br>
                                    <button class="btn btn-danger btn-sm deleteBigBtn">삭제</button>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#mid_category" id="writeBigBtn"><i class="fa fa-plus"></i></a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div id="mid_category" class="container tab-pane active">
                        <br>
                        <h3>카테고리 중분류
                        <button class="btn btn-primary btn-sm" id="writeMidBtn" data-cate_code1="${vo.cate_code1}">
                            <i class="fa fa-plus"></i>
                        </button>
                        </h3>
                        <ul class="list-group">
                            <c:forEach items="${listMid}" var="vo">
                                <li class="list-group-item" data-cate_code1="${vo.cate_code1}" data-cate_code2="${vo.cate_code2}">
                                    <span class="float-right">
                                        <button class="btn btn-success updateMidBtn">수정</button>
                                        <button class="btn btn-danger deleteMidBtn">삭제</button>
                                    </span>
                                    <span class="midCateName">${vo.cate_name}</span>

                                    <!-- 소분류 리스트 추가 -->
									<ul class="list-group mt-2">
									    <c:forEach items="${listSmall}" var="smallVo">
									        <c:if test="${smallVo.cate_code1 == vo.cate_code1 && smallVo.cate_code2 == vo.cate_code2}">
									            <li class="list-group-item" data-cate_code3="${smallVo.cate_code3}">
									                <span class="float-right">
									                    <button class="btn btn-success updateSmallBtn">수정</button>
									                    <button class="btn btn-danger deleteSmallBtn">삭제</button>
									                </span>
									                <span class="smallCateName">${smallVo.cate_name}</span>
									            </li>
									        </c:if>
									    </c:forEach>
									</ul>
									<!-- 소분류 등록 버튼 -->
									<br>
									<h5>
									소분류 추가
									<button class="btn btn-primary btn-sm writeSmallBtn" data-cate_code1="${vo.cate_code1}" data-cate_code2="${vo.cate_code2}">
									    <i class="fa fa-plus"></i>
									</button>
									</h5>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="card-footer">Footer</div>
        </div>
    </div>

    <!-- The Modal -->
    <div class="modal fade" id="categoryModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Modal Heading</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <form action="" method="post" id="modalForm">
                    <input type="hidden" name="cate_code1" id="modalCateCode1" value="0">
                    <input type="hidden" name="cate_code2" id="modalCateCode2" value="0">
                    <input type="hidden" name="cate_code3" id="modalCateCode3" value="0"> <!-- 추가 -->
                    <!-- Modal body -->
                    <div class="modal-body">
                        <input name="cate_name" class="form-control" id="modalCateName">
                    </div>
    
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button class="btn btn-primary" id="submitBtn">전송</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>


