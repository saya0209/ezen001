<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>커뮤니티 글수정</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- Custom CSS -->
<link href="${path}/resources/css/communityWU.css" rel="stylesheet">

<script type="text/javascript">
$(function() {
    // 기존 파일 관리 로직 유지
    let deletedFiles = [];

    $(".delete-file").click(function(e) {
        e.preventDefault();
        const fileName = $(this).data('filename');
        const fileDiv = $(this).closest('.existing-file');
        
        if (confirm('이 파일을 삭제하시겠습니까?')) {
            deletedFiles.push(fileName);
            $('#deletedFiles').val(deletedFiles.join(','));
            fileDiv.remove();
        }
    });

    // 새 파일 프리뷰
    $("#uploadFiles").change(function(e) {
        const preview = $("#imagePreviewContainer");
        preview.empty();

        const files = e.target.files;
        
        for(let i = 0; i < files.length; i++) {
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
                    .html('<i class="fa fa-times"></i>');
                
                div.append(img).append(span).append(deleteBtn);
                preview.append(div);
            };
            reader.readAsDataURL(file);
        }
    });

    // 글자 수 카운터
    $("#content").on('input', function() {
        let length = $(this).val().length;
        $("#charCount").text(length + ' / 2000');
    }).trigger('input');

    // 취소 버튼
    $("#cancelBtn").click(function() {
        if (confirm("수정 중인 내용이 사라질 수 있습니다. 정말 취소하시겠습니까?")) {
            history.back();
        }
    });
});
</script>
</head>
<body>
<div class="container">
    <div class="write-container">
        <div class="write-header">
            <h2><i class="fa fa-edit"></i> 게시글 수정</h2>
            <div class="write-info">
                <span><i class="fa fa-user"></i> ${vo.nicname}</span>
                <span><i class="fa fa-calendar"></i> <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"/></span>
            </div>
        </div>

        <form action="update.do" method="post" enctype="multipart/form-data" class="write-form">
            <input type="hidden" name="community_no" value="${vo.community_no}"/>
            <input type="hidden" name="deletedFiles" id="deletedFiles"/>

            <div class="form-group">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fa fa-header"></i></span>
                    </div>
                    <input type="text" class="form-control" name="title" id="title" 
                           value="${vo.title}" required>
                </div>
            </div>

            <div class="form-group">
                <div class="content-wrapper">
                    <textarea class="form-control" name="content" id="content" 
                              rows="10" required>${vo.content}</textarea>
                    <div class="char-counter" id="charCount">0 / 2000</div>
                </div>
            </div>

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

                <!-- 기존 파일 목록 -->
                <c:if test="${!empty vo.image}">
                    <div class="existing-files">
                        <h6><i class="fa fa-paperclip"></i> 첨부된 파일</h6>
                        <c:forEach items="${fn:split(vo.image, ',')}" var="file">
                            <div class="existing-file">
                                <img src="${pageContext.request.contextPath}/upload/community/${file}"
                                     alt="첨부 이미지" class="preview-image">
                                <span class="file-name">${file}</span>
                                <button type="button" class="btn btn-sm btn-icon delete-file"
                                        data-filename="${file}">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <div id="imagePreviewContainer" class="preview-container"></div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    <i class="fa fa-check"></i> 수정
                </button>
                <button type="reset" class="btn btn-secondary">
                    <i class="fa fa-refresh"></i> 새로입력
                </button>
                <button type="button" class="btn btn-outline-secondary" id="cancelBtn">
                    <i class="fa fa-times"></i> 취소
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
