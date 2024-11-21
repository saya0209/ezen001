<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- review.jsp -->
<div class="row" style="margin : 40px -10px 0 -10px">
	<div class="col-lg-12">
		<!-- card -->
		<div class="card">
			<!-- 리뷰 제목 -->
			<div class="card-header" style="background:#e0e0e0">
				<i class="fa fa-star fa-fw"></i> Review
				<!-- Button to Open the Modal -->
				<button type="button" class="btn btn-primary btn-sm pull-right"
				 data-toggle="modal" data-target="#reviewModal" id="newReviewBtn">
					New Review
				</button>
			</div>

			<!-- 리뷰 리스트 데이터 출력 -->		
			<div class="card-body">
				<ul class="chat">
					<!-- 데이터 한개당 li 태그를 만든다. for or foreach -->
					<!-- 하드코딩 -->
					<li class="left clearfix" data-rno="1">
						<div>
							<div class="header">
								<strong class="primary-font">홍길동(test1)</strong>
								<small class="pull-right text-muted">2024-01-01</small>
							</div>
							<p><pre>Great product! Highly recommend.</pre></p>
							<div class="rating">
								<strong>Rating:</strong> <span>5/5</span>
							</div>
						</div>
					</li>
				</ul>
			</div> <!-- card-body -->
			
			<div class="card-footer">
				<ul class="pagination pagination-sm">
					<li class="page-item"><a class="page-link" href="#">Previous</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">Next</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- The Modal -->
	<!-- id와 Modal여는 버튼의 data-target의 이름을 같게해야 합니다. -->
  <div class="modal fade" id="reviewModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">리뷰 등록</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<input type="hidden" id="reviewRno"> <!-- 리뷰 수정에 사용하기 위해 rno 보관 -->
          <textarea rows="4" class="form-control" id="reviewContent" placeholder="Write your review..."></textarea>
          <div class="form-group mt-2">
          	<label for="reviewRating">Rating (1-5):</label>
          	<select class="form-control" id="reviewRating">
          		<option value="5">5 - Excellent</option>
          		<option value="4">4 - Very Good</option>
          		<option value="3">3 - Average</option>
          		<option value="2">2 - Poor</option>
          		<option value="1">1 - Terrible</option>
          	</select>
          </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        	<button class="btn btn-primary" id="reviewWriteBtn">등록</button>
        	<button class="btn btn-success" id="reviewUpdateBtn">수정</button>
         	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        </div>
        
      </div>
    </div>
  </div>
