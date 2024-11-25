<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<link href="${path}/resources/css/communityreply.css" rel="stylesheet">


<script type="text/javascript">
$(function() {
	// 향상된 이미지 미리보기 기능
    
    // 파일 크기 및 형식 검증
    $("#uploadFiles").change(function(e) {
        const maxSize = 5 * 1024 * 1024; // 5MB
        const files = e.target.files;
        
        for(let i = 0; i < files.length; i++) {
            if(files[i].size > maxSize) {
                alert('파일 크기는 5MB를 초과할 수 없습니다.');
                this.value = '';
                return false;
            }
            
            const fileType = files[i].type;
            if(!fileType.match(/^image\/(jpeg|png|gif)$/)) {
                alert('이미지 파일(JPG, PNG, GIF)만 업로드 가능합니다.');
                this.value = '';
                return false;
            }
        }
    });
});
</script>

<script>
	$(document).ready(function() {
		// 모달 초기화
		$('#replyModal').on('hidden.bs.modal', function() {
			$('#replyContent').val('');
			$('#replyRno').val('');
			$('#replyWriteBtn').show();
			$('#replyUpdateBtn').hide();
			$('#replyModalLabel').text('댓글 작성');
		});

		// 댓글 입력 글자수 제한
		$('#replyContent').on('input', function() {
			const maxLength = 1000;
			let content = $(this).val();

			if (content.length > maxLength) {
				$(this).val(content.substring(0, maxLength));
				alert('댓글은 최대 ' + maxLength + '자까지 입력 가능합니다.');
			}
		});

		// 에러 처리를 위한 공통 함수
		function handleError(error) {
			console.error('Error:', error);
			alert('처리 중 오류가 발생했습니다. 다시 시도해 주세요.');
		}
	});
</script>

</head>

<!-- 댓글 영역 전체 컨테이너 -->
<div class="container-fluid reply-container">
    <div class="row">
        <div class="col-12">
            <!-- 댓글 카드 -->
            <div class="card">
                <!-- 댓글 헤더 -->
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">댓글</h5>
                    <c:if test="${!empty login}">
                        <button type="button" class="btn" data-toggle="modal" data-target="#replyModal" id="newReplyBtn">
                            <i class="material-icons">chat_bubble_outline</i>
                        </button>
                    </c:if>
                </div>

                <!-- 댓글 목록 영역 -->
                <div class="card-body p-0">
                    <div class="reply-list-container">
                        <ul class="chat list-unstyled mb-0">
                            <!-- 댓글이 동적으로 추가될 영역 -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 댓글 모달 -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="replyModalLabel">댓글 작성</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="replyRno">
                <form id="replyForm">
                    <div class="form-group">
                        <textarea class="form-control" id="replyContent" rows="4" 
                                placeholder="댓글을 입력해주세요" required></textarea>
                    </div>
                    <div class="form-group mb-0">
                        <label for="uploadFiles" class="btn btn-light btn-sm">
                            <i class="fa fa-image mr-1"></i>사진 첨부
                        </label>
                        <input type="file" id="uploadFiles" name="uploadFiles" 
                               multiple accept="image/*" style="display: none;">
                        <small class="text-muted d-block mt-1">
                            최대 5MB, JPG/PNG/GIF
                        </small>
                    </div>
                    <div id="imagePreviewContainer" class="preview-container"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="replyWriteBtn">등록</button>
                <button type="button" class="btn btn-success" id="replyUpdateBtn" style="display: none;">수정</button>
            </div>
        </div>
    </div>
</div>
