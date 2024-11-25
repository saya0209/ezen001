<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글수정</title>
<jsp:include page="../jsp/webLib.jsp"></jsp:include>

<!-- CSS -->
<link href="${path}/resources/css/event.css" rel="stylesheet">

<script>
// 삭제된 파일들을 저장할 배열
let deletedFilesList = [];

// 기존 파일 삭제 처리
function deleteExistingFile(element, fileName) {
    if (confirm('파일을 삭제하시겠습니까?')) {
        // 삭제된 파일 목록에 추가
        deletedFilesList.push(fileName);
        // hidden input 업데이트
        document.getElementById('deletedFiles').value = deletedFilesList.join(',');
        // UI에서 제거
        element.parentElement.remove();
    }
}

// 파일 드래그 앤 드롭
const dropZone = document.querySelector('.file-upload');

['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    dropZone.addEventListener(eventName, preventDefaults, false);
});

function preventDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
}

['dragenter', 'dragover'].forEach(eventName => {
    dropZone.addEventListener(eventName, highlight, false);
});

['dragleave', 'drop'].forEach(eventName => {
    dropZone.addEventListener(eventName, unhighlight, false);
});

function highlight(e) {
    dropZone.classList.add('border-primary');
}

function unhighlight(e) {
    dropZone.classList.remove('border-primary');
}

dropZone.addEventListener('drop', handleDrop, false);

function handleDrop(e) {
    const dt = e.dataTransfer;
    const files = dt.files;
    handleFiles(files);
}

// 파일 미리보기
function handleFiles(files) {
    const preview = document.getElementById('filePreview');
    preview.innerHTML = '';
    
    [...files].forEach(file => {
        if (file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const div = document.createElement('div');
                div.className = 'file-preview-item';
                div.innerHTML = `
                    <img src="${e.target.result}" class="file-preview-image">
                    <span class="file-delete-btn" onclick="this.parentElement.remove()">×</span>
                `;
                preview.appendChild(div);
            }
            reader.readAsDataURL(file);
        }
    });
}

// 폼 유효성 검사
function validateForm() {
    const startDate = new Date(document.querySelector('input[name="startDate"]').value);
    const endDate = new Date(document.querySelector('input[name="endDate"]').value);
    
    if (endDate < startDate) {
        alert('종료일은 시작일보다 빠를 수 없습니다.');
        return false;
    }
    
    return true;
}
</script>


</head>
<body>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="event-container">
                <div class="form-section">
                    <h2 class="text-center mb-4">
                        <i class="fa fa-edit mr-2 text-primary"></i>이벤트 수정
                    </h2>

                    <form action="/event/update.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                        <input type="hidden" name="event_no" value="${vo.event_no}">
                        <input type="hidden" name="deletedFiles" id="deletedFiles">

                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label>제목 <span class="text-danger">*</span></label>
                                    <input type="text" name="title" class="form-control" required 
                                           maxlength="300" value="${vo.title}">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>시작일 <span class="text-danger">*</span></label>
                                    <input type="date" name="startDate" class="form-control" required 
                                           value="<fmt:formatDate value="${vo.startDate}" pattern="yyyy-MM-dd"/>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>종료일 <span class="text-danger">*</span></label>
                                    <input type="date" name="endDate" class="form-control" required 
                                           value="<fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd"/>">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>카테고리</label>
                                    <select name="category" class="form-control">
                                        <option value="PROMOTION" ${vo.category == 'PROMOTION' ? 'selected' : ''}>프로모션</option>
                                        <option value="EVENT" ${vo.category == 'EVENT' ? 'selected' : ''}>일반 이벤트</option>
                                        <option value="SEMINAR" ${vo.category == 'SEMINAR' ? 'selected' : ''}>세미나</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>상태</label>
                                    <select name="status" class="form-control">
                                        <option value="UPCOMING" ${vo.status == 'UPCOMING' ? 'selected' : ''}>예정</option>
                                        <option value="ONGOING" ${vo.status == 'ONGOING' ? 'selected' : ''}>진행중</option>
                                        <option value="COMPLETED" ${vo.status == 'COMPLETED' ? 'selected' : ''}>종료</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>내용 <span class="text-danger">*</span></label>
                            <textarea name="content" class="form-control" rows="10" required>${vo.content}</textarea>
                        </div>

                        <div class="form-group">
                            <label>기존 첨부 파일</label>
                            <div id="existingFiles" class="file-preview mb-3">
                                <c:if test="${not empty vo.files}">
                                    <c:forEach items="${vo.files.split(',')}" var="fileName">
                                        <div class="file-preview-item">
                                            <img src="/upload/event/${fileName}" class="file-preview-image">
                                            <span class="file-delete-btn" 
                                                  onclick="deleteExistingFile(this, '${fileName}')">×</span>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>새 이미지 첨부</label>
                            <div class="file-upload" onclick="document.getElementById('fileInput').click()">
                                <i class="fa fa-cloud-upload fa-3x text-primary mb-3"></i>
                                <p class="text-muted">클릭하거나 여기로 이미지를 드래그하세요</p>
                                <input type="file" id="fileInput" name="uploadFiles" multiple 
                                       accept="image/*" style="display: none" onchange="handleFiles(this.files)">
                            </div>
                            <div id="filePreview" class="file-preview"></div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12 d-flex justify-content-between">
                                <a href="/event/view.do?event_no=${vo.event_no}" class="btn btn-secondary">
                                    <i class="fa fa-arrow-left mr-1"></i>취소
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fa fa-check mr-1"></i>수정
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
