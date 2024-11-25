$(function() {
    // 좋아요 버튼 클릭 이벤트
    $("#likeBtn").on("click", function() {
        let community_no = $(this).data("community-no");
        let userId = $("#userId").val(); // hidden input으로 전달된 사용자 ID
        
        // 로컬스토리지에서 상태 확인
        const storageKey = `community_${community_no}_${userId}`;
        let state = JSON.parse(localStorage.getItem(storageKey) || '{"isLiked":false,"isDisliked":false}');
        
        // 이미 싫어요를 눌렀다면 싫어요 취소
        if(state.isDisliked) {
            updateDislike(community_no, -1, state);
        }
        
        // 좋아요 처리
        $.ajax({
            url: "/community/updateLike",
            method: "POST",
            data: { 
                community_no: community_no, 
                amount: state.isLiked ? -1 : 1 
            },
            success: function(result) {
                if(result.status === "success") {
                    // UI 업데이트
                    $("#likeCount").text(result.likeCnt);
                    state.isLiked = !state.isLiked;
                    localStorage.setItem(storageKey, JSON.stringify(state));
                    
                    // 버튼 스타일 변경
                    $("#likeBtn").toggleClass("active");
                    if(state.isDisliked) {
                        $("#dislikeBtn").removeClass("active");
                        state.isDisliked = false;
                    }
                }
            },
            error: function() {
                alert("좋아요 처리에 실패했습니다.");
            }
        });
    });

    // 싫어요 버튼 클릭 이벤트
    $("#dislikeBtn").on("click", function() {
        let community_no = $(this).data("community-no");
        let userId = $("#userId").val();
        
        // 로컬스토리지에서 상태 확인
        const storageKey = `community_${community_no}_${userId}`;
        let state = JSON.parse(localStorage.getItem(storageKey) || '{"isLiked":false,"isDisliked":false}');
        
        // 이미 좋아요를 눌렀다면 좋아요 취소
        if(state.isLiked) {
            updateLike(community_no, -1, state);
        }
        
        // 싫어요 처리
        updateDislike(community_no, state.isDisliked ? -1 : 1, state);
    });

    // 좋아요 업데이트 함수
    function updateLike(community_no, amount, state) {
        $.ajax({
            url: "/community/updateLike",
            method: "POST",
            data: { community_no, amount },
            success: function(result) {
                if(result.status === "success") {
                    $("#likeCount").text(result.likeCnt);
                    state.isLiked = amount > 0;
                    localStorage.setItem(`community_${community_no}_${userId}`, JSON.stringify(state));
                    $("#likeBtn").toggleClass("active");
                }
            }
        });
    }

    // 싫어요 업데이트 함수
    function updateDislike(community_no, amount, state) {
        $.ajax({
            url: "/community/updateDislike",
            method: "POST",
            data: { community_no, amount },
            success: function(result) {
                if(result.status === "success") {
                    $("#dislikeCount").text(result.dislikeCnt);
                    state.isDisliked = amount > 0;
                    localStorage.setItem(`community_${community_no}_${userId}`, JSON.stringify(state));
                    $("#dislikeBtn").toggleClass("active");
                }
            },
            error: function() {
                alert("싫어요 처리에 실패했습니다.");
            }
        });
    }
});