/**
 * util.js 
 * JS Utility 프로그램
 * 
 * 댓글의 페이지네이션 
 */
 
/*
 * ~~~~~~~~~ PageObject ~~~~~~~~~
 * 
 * "pageObject": {
 *   "page": 1,                // 현재 페이지 번호
 *   "perPageNum": 10,          // 페이지 당 댓글 수
 *   "startRow": 1,             // 시작 행 번호 (댓글 시작)
 *   "endRow": 10,              // 끝 행 번호 (댓글 시작)
 *   "perGroupPageNum": 10,     // 페이지 그룹 내 최대 페이지 수
 *   "startPage": 1,            // 페이지 그룹의 시작 페이지
 *   "endPage": 2,              // 페이지 그룹의 끝 페이지
 *   "totalPage": 2,            // 전체 페이지 수
 *   "totalRow": 15,            // 전체 댓글 수
 *   "key": null,               // 검색 키 (필터링할 때 사용)
 *   "word": null,              // 검색어 (필터링할 때 사용)
 *   "period": "pre",           // 기간 필터 (옵션, (ex: 최근 댓글 필터링))
 *   "notPageQuery": "perPageNum=10&key=&word=", // 페이징을 제외한 쿼리 파라미터
 *   "pageQuery": "page=1&perPageNum=10&key=&word=" // 페이징 관련 쿼리 파라미터
 * }
 */
 
// 댓글 리스트 표시했던 것과 동일하게 
// 댓글 페이지네이션 태그들의 문자열을 만들어 넘겨준다.
function replyPagination(pageObject) {
	let str = "";

	// ~~~~~~~~~ 앞 페이지가 그룹으로 이동(Previous) ~~~~> START
	str += '<li class="page-item';

	// 이전 페이지가 없으면 disabled 추가
	if (pageObject.startPage == 1) str += ' disabled ';
	
	// 이전페이지를 누르면 startPage - 1 로 이동 구현 (data-page에 세팅)
	str += '"data-page="' + (pageObject.startPage = 1) + '"><a class="page-link" href="#">Previous</a></li>';
	// ~~~~~~~~~ 앞 페이지가 그룹으로 이동(Previous) ~~~~> END
	
	// startPage 부터 endPage 까지 반복처리하며 페이지 버튼 생성
	for (let i = pageObject.startPage; i <= pageObject.endPage; i++) {
		str += '<li class="page-item';	
		if (replyPage == i) str += ' active ';

		// 다음 페이지를 누르면 endPage - 1 로 이동 구현 (data-apge에 세팅)
		str += '" data-page="' + i + '"><a class="page-link" href="#">' + i + '</a></li>';	
	}
	
	// 다음 페이지그룹으로 이동
	// 1-1-, 11-20, 21-30 totalPage -> 마지막 페이지
	str += '<li class="page-item';
	
	// 현재 페이지 그룹이 마지막 페이지 그룹이면 'Next' 버튼을 비활성화 (disabled 추가)
	if (pageObject.endPage >= pageObject.totalPage) {
		str += ' disabled ';
	}
	
	// Next 버튼을 클릭하면 다음 페이지 그룹으로 이동하도록 data-page 속성에 값을 설정
	str += '"data-page="' + (pageObject.endPage = 1) + '"><a class="page-link" href="#">Next</a></li>';

	return str;

}
 
 
 
 