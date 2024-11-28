$(function() {
     $(".reaction-buttons button").on("click", function() {
        const communityNo = $(this).data("community-no");
        const reactionType = $(this).attr("id") === "likeBtn" ? "like" : "dislike";

        // 로그인 체크 알림 추가
        if (!$("#userId").val()) {
            alert("로그인이 필요합니다.");
            return;
        }

        // AJAX 요청을 통해 데이터 처리
        $.ajax({
            url: "/community/react",
            method: "POST",
            data: {
                community_no: communityNo,
                reaction_type: reactionType
            },
            dataType: "json", 
            success: function(result) {
            	console.log(result);
                if (result.status === "success") {
                    // UI 업데이트
                    if (result.likeCnt !== undefined) {
                        $("#likeCount").text(result.likeCnt);
                    }
                    if (result.dislikeCnt !== undefined) {
                        $("#dislikeCount").text(result.dislikeCnt);
                    }

                    // 버튼 상태 토글
                    $("#likeBtn, #dislikeBtn").removeClass("active");
                    if (result.likeCnt !== undefined) {
                        $("#likeBtn").addClass("active");
                    }
                    if (result.dislikeCnt !== undefined) {
                        $("#dislikeBtn").addClass("active");
                    }

                    // 상태 저장 로직 호출
                    saveLikeDislikeState({
                        isLiked: reactionType === "like",
                        isDisliked: reactionType === "dislike"
                    });
                } else {
                    alert(result.message || "처리 중 오류가 발생했습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                alert("반응 처리에 실패했습니다. 다시 시도해주세요.");
            }
        });
    });

    // 상태 저장 및 가져오기 함수들
    const userInteractionState = {
        community_no: $("#likeBtn").data("community-no"),
        userId: $("#userId").val()
    };

    function getLikeDislikeState() {
        const storageKey = `community_${userInteractionState.community_no}_${userInteractionState.userId}`;
        return JSON.parse(localStorage.getItem(storageKey) || '{"isLiked":false, "isDisliked":false}');
    }

    function saveLikeDislikeState(state) {
        const storageKey = `community_${userInteractionState.community_no}_${userInteractionState.userId}`;
        localStorage.setItem(storageKey, JSON.stringify(state));
    }

    // 초기 로드 시 버튼 상태 설정
    function initializeButtonStates() {
        const state = getLikeDislikeState();

        if (state.isLiked) {
            $("#likeBtn").addClass("active");
        }

        if (state.isDisliked) {
            $("#dislikeBtn").addClass("active");
        }

        // 로그인한 사용자만 클릭 가능하도록 설정
        if (userInteractionState.userId) {
            $("#likeBtn, #dislikeBtn").addClass("clickable");
        }
    }

    initializeButtonStates();
});


// 보조 함수: 좋아요/싫어요 카운트 업데이트
function updateLikeCount(community_no, amount) {
    $.ajax({
        url: "/community/updateLike",
        method: "POST",
        data: { community_no, amount }
    });
}

function updateDislikeCount(community_no, amount) {
    $.ajax({
        url: "/community/updateDislike",
        method: "POST",
        data: { community_no, amount }
    });
}
