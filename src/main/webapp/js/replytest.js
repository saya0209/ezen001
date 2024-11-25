// 댓글 관련 JavaScript
$(document).ready(function() {
    // 댓글 작성
    $('#replyForm').submit(function(e) {
        e.preventDefault();
        
        let formData = new FormData();
        formData.append('content', $('#content').val());
        formData.append('post_no', currentPostNo); // 현재 게시글 번호
        
        // 파일 추가
        let fileInput = $('#uploadFiles')[0];
        for(let i = 0; i < fileInput.files.length; i++) {
            formData.append('uploadFiles', fileInput.files[i]);
        }

        $.ajax({
            url: '/communityreply/write.do',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('댓글이 등록되었습니다.');
                loadReplies(1); // 댓글 목록 새로고침
                $('#content').val('');
                $('#uploadFiles').val('');
            },
            error: function(xhr) {
                alert('댓글 등록에 실패했습니다: ' + xhr.responseText);
            }
        });
    });

    // 대댓글 폼 토글
    $(document).on('click', '.reply-to-reply', function() {
        let parentNo = $(this).data('parent');
        let replyForm = $(this).closest('.card-body').find('.re-reply-form');
        $('.re-reply-form').not(replyForm).hide(); // 다른 폼들은 닫기
        replyForm.toggle();
    });

    // 대댓글 작성
    $(document).on('submit', '.re-reply-write-form', function(e) {
        e.preventDefault();
        
        let parentNo = $(this).data('parent');
        let content = $(this).find('textarea').val();
        
        $.ajax({
            url: '/communityreply/write.do',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                post_no: currentPostNo,
                parent_no: parentNo,
                content: content
            }),
            success: function(response) {
                alert('답글이 등록되었습니다.');
                loadReplies(1);
            },
            error: function(xhr) {
                alert('답글 등록에 실패했습니다: ' + xhr.responseText);
            }
        });
    });

    // 좋아요/싫어요 처리
    $(document).on('click', '.like-btn, .dislike-btn', function() {
        if(!isLoggedIn) {
            alert('로그인이 필요합니다.');
            return;
        }

        let rno = $(this).data('rno');
        let isLike = $(this).hasClass('like-btn');
        let url = isLike ? '/communityreply/like' : '/communityreply/dislike';
        
        $.ajax({
            url: url,
            type: 'POST',
            data: {
                rno: rno,
                amount: 1
            },
            success: function(response) {
                if(response.status === 'success') {
                    let count = isLike ? response.likeCnt : response.dislikeCnt;
                    $(this).find('span').text(count);
                }
            },
            error: function() {
                alert('처리 중 오류가 발생했습니다.');
            }
        });
    });

    // 댓글 수정
    $(document).on('click', '.edit-reply', function() {
        let rno = $(this).data('rno');
        let replyCard = $(`#reply-${rno}`);
        let content = replyCard.find('.card-text').text().trim();
        
        replyCard.find('.card-text').html(`
            <form class="edit-form">
                <div class="form-group">
                    <textarea class="form-control">${content}</textarea>
                </div>
                <button type="submit" class="btn btn-sm btn-primary">수정</button>
                <button type="button" class="btn btn-sm btn-secondary cancel-edit">취소</button>
            </form>
        `);
    });

    // 댓글 삭제
    $(document).on('click', '.delete-reply', function() {
        if(confirm('정말 삭제하시겠습니까?')) {
            let rno = $(this).data('rno');
            
            $.ajax({
                url: '/communityreply/delete.do',
                type: 'GET',
                data: { rno: rno },
                success: function(response) {
                    alert('댓글이 삭제되었습니다.');
                    loadReplies(1);
                },
                error: function() {
                    alert('댓글 삭제에 실패했습니다.');
                }
            });
        }
    });

    // 페이징 처리
    $(document).on('click', '.pagination .page-link', function(e) {
        e.preventDefault();
        let page = $(this).data('page');
        loadReplies(page);
    });
});

// 댓글 목록 로드 함수
function loadReplies(page) {
    $.ajax({
        url: '/communityreply/list.do',
        type: 'GET',
        data: {
            post_no: currentPostNo,
            page: page
        },
        success: function(response) {
            // 댓글 목록 HTML 갱신
            $('#replyList').html(response);
        },
        error: function() {
            alert('댓글 목록을 불러오는데 실패했습니다.');
        }
    });
}