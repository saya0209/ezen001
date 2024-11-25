/**
 * replyProcess.js
 * replyService 객체를 이용한 댓글 처리 코드
 */

 
 // 만든이후 잘되는지 확인
 //replyService.list();
 
 // 전역 변수로 deletedFiles 배열 선언
let deletedFiles = [];
 
// replyProcess.js의 showList 함수 수정
function showList(page) {
    replyService.list({
        post_no: post_no,
        page: page
    }, function(data) {
        let list = data.list;
        let gradeNo = data.gradeNo;
        let str = "";

        if (!list || list.length === 0) {
            $(".chat").html('<li class="text-center py-5">첫 번째 댓글을 작성해보세요.</li>');
            return;
        }

        for (let i = 0; i < list.length; i++) {
            str += `
                <li class="chat-item" data-rno="${list[i].rno}">
                    <div class="chat-avatar"></div>
                    <div class="chat-content">
                        <div class="d-flex justify-content-between align-items-baseline">
                            <div>
                                <span class="chat-name">${list[i].nicname}</span>
                                <span class="chat-time ml-2">${toDateTime(list[i].writeDate)}</span>
                            </div>
                            ${data.id && (data.id === list[i].id || gradeNo === 9) ? `
                                <div class="chat-actions">
                                    <button class="replyUpdateBtn btn btn-light btn-sm">
                                        <i class="fa fa-pencil"></i>
                                    </button>
                                    <button class="replyDeleteBtn btn btn-light btn-sm">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </div>
                            ` : ''}
                        </div>
                        <div class="chat-text">
                            <pre class="replyContent">${list[i].content}</pre>
                        </div>
                        ${list[i].image ? `
                            <div class="image-container">
                                ${list[i].image.split(',').map(image => `
                                    <img src="/upload/community/${image}" class="reply-image" 
                                         style="max-width: 200px; margin: 5px;">
                                `).join('')}
                            </div>
                        ` : ''}
                    </div>
                </li>
            `;
        }

        $(".chat").html(str);

        if (data.pageObject) {
            $(".pagination").html(replyPagination(data.pageObject));
        }
    });
}

// 페이지 로드시 댓글 목록 표시
$(document).ready(function() {
    showList(1);
});
 
 // HTML 이 로딩된 후에 처리되도록 합니다.
 $(function() {
 	// -------이벤트 처리----------------
 	// 태그들이 모두 올라온 후에 처리할 수 있어야 합니다. $(function() {  이벤트처리  })
 	// {} 안에 이벤트처리부분이 구현되어야 정상동작 합니다.
 	
 	// 새로운 댓글을 작성하기 위해 new reply 버튼 클릭시 이벤트
 	$("#newReplyBtn").click(function() {
 		// 버튼 처리 - 등록버튼은 보이고, 수정버튼은 안보이도록 처리
 		$("#replyWriteBtn").show();
 		$("#replyUpdateBtn").hide();
 
 		
 		// 모달창에 title을 "댓글 등록"로 보여줍니다.
 		$("#replyModal .modal-title").text("댓글 등록");
 		// 이전에 작성했던 댓글 내용을 지워줍니다.
 		$("#replyContent").val("");
 	});
 
 // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 댓글 등록
$("#replyWriteBtn").click(function() {
    let formData = new FormData();
    
    // 댓글 데이터
    let replyData = {
        post_no: post_no,
        content: $("#replyContent").val()
    };
    
    // JSON 데이터를 Blob으로 변환하여 FormData에 추가
    formData.append("reply", new Blob([JSON.stringify(replyData)], {
        type: "application/json"
    }));
    
    // 파일 데이터 추가
    let fileInput = document.getElementById("uploadFiles");
    if (fileInput.files.length > 0) {
        for (let i = 0; i < fileInput.files.length; i++) {
            formData.append("uploadFiles", fileInput.files[i]);
        }
    }
    
    $.ajax({
        url: '/communityreply/write.do',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(result) {
            $("#replyModal").modal("hide");
            $("#msgModal .modal-body").text(result);
            $("#msgModal").modal("show");
            showList(1);
        },
        error: function(xhr) {
            alert(xhr.responseText);
        }
    });
});

// 댓글 수정
// 댓글 수정 제출 버튼 이벤트 수정
    $("#replyUpdateBtn").click(function() {
        let formData = new FormData();
        
        // 댓글 데이터
        let replyData = {
            rno: $("#replyRno").val(),
            content: $("#replyContent").val()
        };
        
        // JSON 데이터를 Blob으로 변환하여 FormData에 추가
        formData.append("reply", new Blob([JSON.stringify(replyData)], {
            type: "application/json"
        }));
        
        // 파일 데이터 추가
        let fileInput = document.getElementById("uploadFiles");
        if (fileInput.files.length > 0) {
            for (let i = 0; i < fileInput.files.length; i++) {
                formData.append("uploadFiles", fileInput.files[i]);
            }
        }
        
        // 삭제된 파일 정보 추가
        if (deletedFiles.length > 0) {
            formData.append("deletedFiles", deletedFiles.join(","));
        }
        
        $.ajax({
            url: '/communityreply/update.do',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(result) {
                // 수정 성공 후 deletedFiles 배열 초기화
                deletedFiles = [];
                $("#replyModal").modal("hide");
                $("#msgModal .modal-body").text(result);
                $("#msgModal").modal("show");
                showList(replyPage);
            },
            error: function(xhr) {
                alert(xhr.responseText);
            }
        });
    });
    
    // 모달이 닫힐 때 초기화 처리
    $('#replyModal').on('hidden.bs.modal', function () {
        deletedFiles = [];
        $("#imagePreviewContainer").empty();
        $("#uploadFiles").val('');
    });
    
 // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 	
	// 파일 선택 후 미리보기
	$('#uploadFiles').on('change', function(event) {
	    var files = event.target.files;
	    var previewContainer = $('#imagePreviewContainer');
	    previewContainer.empty(); // 기존의 미리보기 이미지를 지웁니다.
	
	    for (var i = 0; i < files.length; i++) {
	        var file = files[i];
	        var reader = new FileReader();
	
	        reader.onload = function(e) {
	            var img = $('<img>').attr('src', e.target.result).addClass('img-thumbnail').css('width', '100px');
	            previewContainer.append(img);
	        };
	        
	        reader.readAsDataURL(file);
	    }
	});
 	
 // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 	
// 댓글 수정 버튼 클릭 이벤트
 $(".chat").on("click", ".replyUpdateBtn", function() {
        // 수정 모달을 열 때 deletedFiles 배열 초기화
        deletedFiles = [];
        
        let li = $(this).closest("li");
        let rno = li.data("rno");
        let content = li.find(".replyContent").text();
        
        // 기존 이미지 미리보기 초기화
        $("#imagePreviewContainer").empty();
        
        // 기존 이미지가 있다면 미리보기에 표시
        let existingImages = li.find(".reply-image");
        if (existingImages.length > 0) {
            existingImages.each(function() {
                let imgSrc = $(this).attr("src");
                let imgName = imgSrc.split('/').pop();
                
                let previewDiv = $('<div>').addClass('existing-image-preview');
                let img = $('<img>')
                    .attr('src', imgSrc)
                    .addClass('img-thumbnail')
                    .css('width', '100px');
                let deleteBtn = $('<button>')
                    .addClass('btn btn-sm btn-danger delete-image')
                    .text('X')
                    .attr('data-image', imgName);
                    
                previewDiv.append(img).append(deleteBtn);
                $("#imagePreviewContainer").append(previewDiv);
            });
        }
        
        $("#replyRno").val(rno);
        $("#replyContent").val(content);
        $("#replyModal").modal("show");
        $("#replyWriteBtn").hide();
        $("#replyUpdateBtn").show();
        $("#replyModal .modal-title").text("댓글 수정");
    });
 	
 	
 // 이미지 삭제 버튼 클릭 이벤트 수정
    $(document).on('click', '.delete-image', function(e) {
        e.preventDefault();
        let imgName = $(this).data('image');
        $(this).closest('.existing-image-preview').remove();
        
        // 삭제된 이미지 이름을 배열에 추가
        if (!deletedFiles.includes(imgName)) {
            deletedFiles.push(imgName);
        }
    });
 	
 // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 	
 	// 4. 댓글 삭제 버튼
 	$(".chat").on("click", ".replyDeleteBtn", function() {
 		//alert("삭제 버튼 클릭");
 		if (!confirm("정말 삭제 하시겠습니까?")) {
 			// 삭제를 안하겠다.
 			return;
 		}
 		// 삭제처리 (yes)
 		// rno 수집
 		let rno = $(this).closest("li").data("rno");
 		
 		// 삭제 서비스 실행
 		replyService.delete(rno,
 			function(result) {
 				$("#msgModal .modal-body").text(result);
 				$("#msgModal").modal("show");
 				// 댓글 삭제 후 리스트를 다시 불러옵니다.
 				// 리스트가 변경되었으므로 1page로 갑니다.
 				showList(1);	
 			}
 		);
 	});

	// 댓글 페이지네이션 이벤트 처리
	$(".pagination").on("click", "a", function() {
		// 1. 이벤트가 적용되는지 확인
		// alert("페이지 버튼 클릭");
		let page = $(this).parent().data("page"); // <li> 태그안에 page값을 가져온다.
		// alert ("이동페이지 : " + page);
		if (replyPage != page) {
			// 현재페이지 이외의 버튼을 클릭했을 때만 처리
			// alert ("이동페이지 : " + page);
			replyPage = page; // 이동할 페이지를 현재 페이지로 세팅
			showList(replyPage);
		
		}
		return false;
	});

 }); // end of  $(function(){}) // 이벤트 처리 끝