<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록</title>

    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Arial', sans-serif;
        }

        .container {
            margin-top: 30px;
        }

        .card {
            border: none;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #007bff;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
            padding: 15px;
        }

        .form-group label {
            font-size: 1rem;
            font-weight: 600;
        }

        .form-control {
            border-radius: 5px;
            box-shadow: none;
            border: 1px solid #ccc;
            padding: 12px;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .btn {
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group .form-control {
            border-radius: 5px 0 0 5px;
        }

        .input-group .input-group-append .btn {
            border-radius: 0 5px 5px 0;
            background-color: #dc3545;
            color: white;
        }

        .imageForm {
            margin-top: 20px;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .imageForm .input-group {
            margin-bottom: 15px;
        }

        .imageForm button {
            font-size: 1rem;
        }

        .imageForm .removeImageBtn {
            background-color: #dc3545;
            border: none;
            color: white;
            padding: 5px 10px;
        }

        .imageForm .removeImageBtn:hover {
            background-color: #c82333;
        }

        .form-check-inline {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 18%;
            margin-bottom: 20px;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
        }

        .footer a {
            color: #007bff;
            text-decoration: none;
        }

        .footer a:hover {
            color: #0056b3;
        }

        @media (max-width: 768px) {
            .d-flex {
                flex-direction: column;
            }

            .form-check-inline {
                width: 100%;
                margin-bottom: 15px;
            }

            .imageForm {
                padding: 15px;
            }
        }
    </style>
	


</head>

<body>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h3>상품 등록</h3>
            </div>
            <form action="write.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="category" value="${category}">
                <div class="card-body">
                	<div class="form-group">
			            <label for="discount">할인가</label>
			            <input class="form-control" name="discount" id="discount" type="number">
			        </div>
			        <div class="form-group">
			            <label for="delivery_charge">배송비</label>
			            <input class="form-control" name="delivery_charge" id="delivery_charge" type="number">
			        </div>
                    <!-- CPU 선택 -->
                    <div class="form-group">
                        <label for="cpu_id">CPU</label>
                        <select name="cpu_id" id="cpu_id" class="form-control" required>
                            <option value="">선택하세요</option>
                            <c:forEach items="${cpuList}" var="cpu">
                                <option value="${cpu.cpu_id}">${cpu.cpu_name} - ${cpu.cpu_price}원</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Memory 선택 -->
                    <div class="form-group">
                        <label for="memory_id">Memory</label>
                        <select name="memory_id" id="memory_id" class="form-control" required>
                            <option value="">선택하세요</option>
                            <c:forEach items="${memoryList}" var="memory">
                                <option value="${memory.memory_id}">${memory.memory_name} - ${memory.memory_price}원</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Graphic Card 선택 -->
                    <div class="form-group">
                        <label for="graphic_Card_id">Graphic Card</label>
                        <select name="graphic_Card_id" id="graphic_Card_id" class="form-control" required>
                            <option value="">선택하세요</option>
                            <c:forEach items="${graphic_CardList}" var="graphic_Card">
                                <option value="${graphic_Card.graphic_Card_id}">${graphic_Card.graphic_Card_name} - ${graphic_Card.graphic_Card_price}원</option>
                            </c:forEach>
                        </select>
                    </div>


                    <!-- 대표 이미지 -->
                    <div class="form-group">
                        <label for="image_name">대표이미지</label>
                        <input type="file" class="form-control" id="image_name" name="image_name" required>
                    </div>


                    <!-- 추가 이미지 -->
                    <fieldset class="imageForm">
                        <legend>추가 이미지</legend>
                        <button class="btn btn-primary" id="appendImageBtn" type="button">
                            <i class="fas fa-plus-circle"></i> 이미지 추가
                        </button>
                        <div class="input-group mb-3">
                            <input type="file" class="form-control" name="imageFiles">
                        </div>
                    </fieldset>

                </div>

                <div class="card-footer">
                    <button class="btn btn-primary btn-block">상품 등록</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        $(function () {
            let imageTagCnt = 1;

            // 이미지 추가
            $("#appendImageBtn").click(function () {
                if (imageTagCnt >= 5) return;

                let addImageTag = `
                    <div class="input-group mb-3">
                        <input type="file" class="form-control" name="imageFiles">
                        <div class="input-group-append">
                            <button class="btn btn-danger removeImageBtn" type="button">
                                <i class="fa fa-times"></i>
                            </button>
                        </div>
                    </div>`;
                $(".imageForm").append(addImageTag);
                imageTagCnt++;
            });

            // 이미지 제거
            $(".imageForm").on("click", ".removeImageBtn", function () {
                $(this).closest(".input-group").remove();
                imageTagCnt--;
            });
        });
    </script>

</body>

</html>