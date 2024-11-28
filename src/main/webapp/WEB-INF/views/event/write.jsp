<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트 작성</title>
    <jsp:include page="../jsp/webLib.jsp"></jsp:include>

    <!-- CSS -->
    <link href="${path}/resources/css/event.css" rel="stylesheet">

    <script>
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

    <!-- 취소 버튼 -->
    <script type="text/javascript">
    $(function() {
        $("#cancelBtn").click(function() {
            history.back();
        });
    });
    </script>

</head>
<body>
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="event-container">
                    <div class="form-section">
                        <h2 class="text-center mb-4">
                            <i class="fa fa-calendar-plus-o mr-2 text-primary"></i>새 이벤트 등록
                        </h2>

                        <form action="/event/write.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label>제목 <span class="text-danger">*</span></label>
                                        <input type="text" name="title" class="form-control" required maxlength="300" placeholder="이벤트 제목을 입력하세요">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>시작일 <span class="text-danger">*</span></label>
                                        <input type="date" name="startDate" class="form-control" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>종료일 <span class="text-danger">*</span></label>
                                        <input type="date" name="endDate" class="form-control" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>카테고리</label>
                                        <select name="category" class="form-control">
                                            <option value="PROMOTION">프로모션</option>
                                            <option value="EVENT">일반 이벤트</option>
                                            <option value="SEMINAR">세미나</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>상태</label>
                                        <select name="status" class="form-control">
                                            <option value="UPCOMING">예정</option>
                                            <option value="ONGOING">진행중</option>
                                            <option value="COMPLETED">종료</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>내용 <span class="text-danger">*</span></label>
                                <textarea name="content" class="form-control" rows="10" required placeholder="이벤트 상세 내용을 입력하세요"></textarea>
                            </div>

                            <div class="form-group">
                                <label>이미지 첨부</label>
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
                                    <a href="/event/list.do" class="btn btn-outline-secondary">
                                        취소
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        등록
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
