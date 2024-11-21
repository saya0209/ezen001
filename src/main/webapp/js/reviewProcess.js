/**
 * reviewProcess.js
 * reviewService 객체를 이용한 리뷰 처리 코드 (수정 버전)
 */

// XSS 방지를 위한 HTML 이스케이프 처리 함수
function escapeHtml(text) {
    if (text === undefined || text === null) {
        return '';  // undefined나 null인 경우 빈 문자열을 반환
    }
    return text.replace(/&/g, "&amp;")
               .replace(/</g, "&lt;")
               .replace(/>/g, "&gt;")
               .replace(/"/g, "&quot;")
               .replace(/'/g, "&#039;");
}

// 리뷰 리스트 표시 함수
function showList(page) {
    reviewService.list(page, function (data) {
        let list = data.list;
        let str = "";

        if (!list || list.length === 0) {
            $(".chat").html("<li>리뷰가 없습니다.</li>");
            return;
        }

        for (let i = 0; i < list.length; i++) {
            str += '<li class="left clearfix review-item" data-rno="' + list[i].rno + '">';
            str += '<div class="review-container">';

            // 리뷰 헤더
            str += '<div class="header">';
            str += '<strong class="primary-font">' + escapeHtml(list[i].nicname);
            str += ' (' + escapeHtml(list[i].id) + ')</strong>';
            str += '<small class="pull-right text-muted">' + toDateTime(list[i].writeDate) + '</small>';
            str += '</div>';

            // 리뷰 내용
            str += '<p><pre class="reviewContent">' + escapeHtml(list[i].content) + '</pre></p>';

            // 리뷰 수정, 삭제 버튼 추가
            if (id === list[i].id) {
                str += '<div>';
                str += '<button class="reviewUpdateBtn btn btn-success btn-sm">수정</button>';
                str += '<button class="reviewDeleteBtn btn btn-danger btn-sm">삭제</button>';
                str += '</div>';
            }

            // 리뷰 평가 (Rating) 추가
            str += '<div class="rating">';
            str += '<strong>Rating:</strong> <span>' + list[i].rating + '/5</span>';
            str += '</div>';

            str += '</div>';
            str += '</li>';
        }

        // 리스트 출력
        $(".chat").html(str);
        $(".pagination").html(replyPagination(data.pageObject));
    });
}



// 리뷰 페이지 초기화
showList(1);

$(function () {
    // 리뷰 작성 버튼 클릭 이벤트
    $("#newReviewBtn").click(function () {
        console.log("새 리뷰 버튼 클릭!");
        $("#reviewWriteBtn").show();
        $("#reviewUpdateBtn").hide();
        $("#reviewModal .modal-title").text("리뷰 등록");
        $("#reviewContent").val("");
    });

   // 리뷰 작성 이벤트
	$("#reviewWriteBtn").click(function () {
	    console.log("리뷰작성 이벤트");
	    let $btn = $(this);
	    $btn.prop("disabled", true);
	
	    let content = $("#reviewContent").val().trim();
	    let rating = $("#reviewRating").val(); // 레이팅 값 가져오기
	
	    console.log("Rating: ", rating);  // 콘솔에 rating 값 확인
	
	    if (content.length === 0) {
	        alert("리뷰 내용을 입력해주세요.");
	        $btn.prop("disabled", false);
	        return;
	    }
	
	    if (!goods_no || isNaN(goods_no)) {
	        alert("상품 정보가 유효하지 않습니다.");
	        $btn.prop("disabled", false);
	        return;
	    }
	
	    let review = {
	        goods_no: goods_no,
	        content: escapeHtml(content),
	        rating: rating  // 레이팅 값을 객체에 추가
	    };
	
	    reviewService.write(review, function (result) {
	        $("#reviewModal").modal("hide");
	        $("#msgModal .modal-body").text(result);
	        $("#msgModal").modal("show");
	        showList(1);
	        $btn.prop("disabled", false);
	    }, function () {
	        alert("리뷰 등록에 실패했습니다.");
	        $btn.prop("disabled", false);
	    });
	});


    // 리뷰 수정 버튼 클릭 이벤트 (이벤트 위임)
    $(".chat").on("click", ".reviewUpdateBtn", function () {
        $("#reviewWriteBtn").hide();
        $("#reviewUpdateBtn").show();
        $("#reviewModal .modal-title").text("리뷰 수정");

        let li = $(this).closest("li");
        $("#reviewRno").val(li.data("rno"));
        $("#reviewContent").val(li.find(".reviewContent").text());
        $("#reviewModal").modal("show");
    });

    // 리뷰 수정 이벤트
    $("#reviewUpdateBtn").click(function () {
        let content = $("#reviewContent").val().trim();

        if (content.length === 0) {
            alert("리뷰 내용을 입력해주세요.");
            return;
        }

        let review = { rno: $("#reviewRno").val(), content: content };

        reviewService.update(review, function (result) {
            $("#reviewModal").modal("hide");
            $("#msgModal .modal-body").text(result);
            $("#msgModal").modal("show");
            showList(replyPage);
        });
    });

    // 리뷰 삭제 버튼 클릭 이벤트 (이벤트 위임)
    $(".chat").on("click", ".reviewDeleteBtn", function () {
        let rno = $(this).closest("li").data("rno");

        if (!confirm("정말 삭제하시겠습니까?")) {
            return;
        }

        reviewService.delete(rno, function (result) {
            $("#msgModal .modal-body").text(result);
            $("#msgModal").modal("show");
            showList(1);
        });
    });

    // 리뷰 페이지네이션 버튼 클릭 이벤트
    $(".pagination").on("click", "a", function () {
        let page = $(this).parent().data("page");

        if (replyPage !== page) {
            replyPage = page;
            showList(replyPage);
        }

        return false;
    });
});
