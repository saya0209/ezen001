<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 글쓰기</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- Custom CSS -->
<link href="${path}/resources/css/communityWU.css" rel="stylesheet">

<script type="text/javascript">
$(function() {
	// 파일 선택 시 미리보기 처리 및 삭제 기능 추가
    $("#uploadFiles").change(function(e) {
        const preview = $("#imagePreviewContainer");
        preview.empty();

        const files = e.target.files;

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            if (!file.type.startsWith('image/')) continue;

            const reader = new FileReader();
            reader.onload = function(event) {
                const div = $('<div>').addClass('file-item');
                const img = $('<img>')
                    .attr('src', event.target.result)
                    .addClass('preview-image');
                const span = $('<span>')
                    .addClass('file-name')
                    .text(file.name);
                const deleteBtn = $('<button>')
                    .addClass('btn btn-sm btn-icon delete-preview')
                    .html('<i class="fa fa-times"></i>')
                    .data('index', i); // 파일 인덱스 저장

                div.append(img).append(span).append(deleteBtn);
                preview.append(div);
            };
            reader.readAsDataURL(file);
        }
    });

    // 업로드 시 파일 검증
    $("#uploadFiles").change(function(e) {
        const maxSize = 5 * 1024 * 1024; // 5MB
        const files = e.target.files;

        for (let i = 0; i < files.length; i++) {
            if (files[i].size > maxSize) {
                alert("파일 크기는 5MB를 초과할 수 없습니다.");
                this.value = '';
                return false;
            }

            if (!files[i].type.match(/^image\/(jpeg|png|gif)$/)) {
                alert("이미지 파일(JPG, PNG, GIF)만 업로드 가능합니다.");
                this.value = '';
                return false;
            }
        }
    });
    
	 // 프리뷰 파일 삭제 이벤트
    $("#imagePreviewContainer").on("click", ".delete-preview", function(e) {
        e.preventDefault();

        const index = $(this).data("index");
        const filesInput = $("#uploadFiles")[0];

        // FileList는 수정 불가이므로 새 FileList 생성
        const newFileList = Array.from(filesInput.files).filter((_, i) => i !== index);

        // 새 FileList를 할당
        const dataTransfer = new DataTransfer();
        newFileList.forEach((file) => dataTransfer.items.add(file));

        filesInput.files = dataTransfer.files;

        // 프리뷰 삭제
        $(this).closest(".file-item").remove();
    });

    // 취소 버튼
    $("#cancelBtn").click(function() {
        if (confirm("작성 중인 내용이 사라질 수 있습니다. 정말 취소하시겠습니까?")) {
            history.back();
        }
    });

    // 새로운 기능: 임시저장
    $("#tempSaveBtn").click(function() {
        alert("임시저장 되었습니다.");
    });

    // 새로운 기능: 글자 수 카운터
    $("#content").on('input', function() {
        let length = $(this).val().length;
        $("#charCount").text(length + ' / 2000');
    });
});
</script>
</head>
<body>
<div class="container">
    <div class="write-container">
        <div class="write-header">
            <h2><i class="fa fa-pencil"></i> 게시글 작성</h2>
            <div class="write-info">
                <span><i class="fa fa-user"></i> ${vo.nickname}</span>
                <span><i class="fa fa-calendar"></i> <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"/></span>
            </div>
        </div>

        <form action="${path}/community/write.do" method="post" enctype="multipart/form-data" class="write-form">
            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-header"></i></span>
                    </div>
                    <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요" required>
                </div>
            </div>

            <div class="form-group">
                <div class="content-wrapper">
                    <textarea class="form-control" name="content" id="content" rows="10" 
                              placeholder="내용을 입력하세요" required></textarea>
                    <div class="char-counter" id="charCount">0 / 2000</div>
                </div>
            </div>

            <!-- 파일 선택 및 미리보기 영역 -->
			<div class="form-group file-upload-group">
			    <div class="custom-file">
			        <input type="file" class="custom-file-input" id="uploadFiles" name="uploadFiles"
			               multiple accept="image/jpeg, image/png, image/gif">
			        <label class="custom-file-label" for="uploadFiles">
			            <i class="fa fa-upload"></i> 파일 선택
			        </label>
			    </div>
			    <small class="form-text text-muted">
			        <i class="fa fa-info-circle"></i> 최대 5MB, JPG/PNG/GIF 형식만 가능
			    </small>
			    
			    <!-- 파일 미리보기 컨테이너 -->
			    <div id="imagePreviewContainer" class="preview-container"></div>
			</div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary btn-sm">
                    등록
                </button>
                <button type="button" class="btn btn-outline-info btn-sm" id="tempSaveBtn">
                    임시저장
                </button>
                <button type="reset" class="btn btn-outline-secondary btn-sm">
                    새로입력
                </button>
                <button type="button" class="btn btn-outline-secondary btn-sm" id="cancelBtn">
                    취소
                </button>
<!--                 <button type="submit" class="btn btn-primary"> -->
<!--                     <i class="fa fa-check"></i> 등록 -->
<!--                 </button> -->
<!--                 <button type="button" class="btn btn-info" id="tempSaveBtn"> -->
<!--                     <i class="fa fa-save"></i> 임시저장 -->
<!--                 </button> -->
<!--                 <button type="reset" class="btn btn-secondary"> -->
<!--                     <i class="fa fa-refresh"></i> 새로입력 -->
<!--                 </button> -->
<!--                 <button type="button" class="btn btn-outline-secondary" id="cancelBtn"> -->
<!--                     <i class="fa fa-times"></i> 취소 -->
<!--                 </button> -->
            </div>
        </form>
    </div>
</div>
</body>
</html>
