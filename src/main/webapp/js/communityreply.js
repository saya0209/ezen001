/**
 * communityreply.js
 * 커뮤니티 게시판 댓글 처리 객체
 */

console.log("Community Reply Module ..........................");

// 커뮤니티 게시판 댓글을 처리하는 객체 선언
// jQuery의 ajax를 사용 - ajax(), getJSON(), get(), post()
let replyService = {

    // 댓글 리스트 처리
	"list": function(data, callback, error) {
        console.log("댓글 리스트.......");
        
        let page = data.page || 1;
        let post_no = data.post_no;

        console.log("page : " + page + ", post_no : " + post_no);

        $.getJSON(
            "/communityreply/list.do?page=" + page + "&post_no=" + post_no,
            function(result) {
                if (callback) {
                    callback(result);
                }
            }
        ).fail(function(xhr, status, err) {
            if (error) {
                error();
            }
        });
    },


    // 댓글 등록 처리
    "write": function(reply, callback, error) {
		console.log("댓글 등록 --------------");
		
        $.ajax({
            type: "post",
            url: "/communityreply/write.do",
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                if (callback) callback(result);
                else alert(result);
            },
            error: function(xhr, status, err) {
                console.log("Error:", err);
                if (error) error();
                else alert("댓글이 등록되지 않았습니다.");
            }
        });
    },
    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// 댓글 작성 버튼 클릭 이벤트

    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // 댓글 수정 처리
    "update": function(reply, callback, error) {
        console.log("댓글 수정 ----------------------");

        $.ajax({
            type: "post",
            url: "/communityreply/update.do",
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                if (callback) callback(result);
                else alert(result);
            },
            error: function(xhr, status, err) {
                console.log("xhr : " + xhr);
                console.log("status : " + status);
                console.log("err : " + err);
                if (error) error(err);
                else alert("댓글이 수정되지 않았습니다.");
            }
        });
    },

    // 댓글 삭제 처리
    "delete": function(rno, callback, error) {
        console.log("댓글 삭제 --------------------------");

        $.ajax({
            type: "get",
            url: "/communityreply/delete.do?rno=" + rno,
            success: function(result) {
                alert("댓글이 삭제되었습니다.");
                if (callback) callback(result); // 삭제 후 추가 작업을 위한 callback
            },
            error: function(xhr, status, err) {
                console.log("xhr : " + xhr);
                console.log("status : " + status);
                console.log("err : " + err);
                if (error) error(err); // 삭제 실패시 처리
                else alert("댓글이 삭제되지 않았습니다.");
            }
        });
    }
};


