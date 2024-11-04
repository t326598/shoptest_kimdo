<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
<style>
    .radio-group {
      display: flex;
      align-items: center;
      justify-content: space-around;
      width: 100%; /* 부모 요소의 너비에 맞게 버튼이 양쪽 끝에 배치됨 */
      max-width: 400px; /* 원하는 너비 설정 */
      margin: 0 auto; /* 가운데 정렬 */
    }
    .label {
      font-weight: bold;
      padding-right: 10px;
    }
    .radio-option {
      display: flex;
      align-items: center;
    }
     #img_input {
            display: flex;
            justify-content: center; /* 부모 요소에서 중앙 정렬 */
            margin-bottom: 20px;
        }
  </style>
  
  
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
	

	
	
</head>
<body>
 <script src="../static/js/validation.js"></script>
 
<%String root = request.getContextPath(); %>

<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">상품 등록</h1>
	<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
	</div>
</div>
		<div class="container shop">	
		<form action="add_pro.jsp" enctype="multipart/form-data" method="post" onsubmit="return checkProduct1()" >
		   <div class="input-group" id="img_input">
                        <img id="uploadedImage" src="" style="  max-width: 400px; height: auto;" />
                    </div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">상품 이미지</label>
						<input type="file" class="form-control col-md-10" 
							   name="image" id="image" accept="image/*" multiple placeholder="선택된 파일 없음" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="code">상품 코드</label>
						<input type="text" class="form-control col-md-10" 
							   name="code" placeholder="" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">상품명</label>
						<input type="text" class="form-control col-md-10" 
							   name="name" placeholder="" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">가격</label>
						<input type="text" class="form-control col-md-10" 
							   name="price" placeholder="" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="" style="width: 100%;">상세 정보</label>
						<textarea name="content" id="content" cols="30" rows="10" style="width: 100%; height:300px; resize: none; text-align: center;"></textarea>
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">제조사</label>
						<input type="text" class="form-control col-md-10" 
							   name="make" placeholder="" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">분류</label>
						<input type="text" class="form-control col-md-10" 
							   name="category" placeholder="" />
					</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label> <input
					type="text" class="form-control col-md-10" name="units_in_stock"
					placeholder="" />
			</div>
			   <!-- 상태 선택 라디오 버튼 -->
           <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2 label">상태</label> 
                <div class="radio-group col-md-10">
                    <label class="radio-option">
                        <input type="radio" name="status" value="NEW" /> 신규 제품
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="status" value="USED" /> 중고 제품
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="status" value="REFURBISHED" /> 재생 제품
                    </label>
                </div>
            </div>
      
      
        <div class="d-grid gap-2 mt-5 mb-5 d-md-flex justify-content-md-between">
				<a href="products.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-primary" value="등록" />
					</div>	
					 
				</form>
		 
			 </div>

		 

				
		<jsp:include page="/layout/footer.jsp" />
		
		<script>
        document.getElementById('image').addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('uploadedImage').src = e.target.result;
                }
                reader.readAsDataURL(file); // 파일을 읽어 미리보기로 표시
            }
        });
        
        
        function checkProduct1() {
            const productCode = document.querySelector('input[name="code"]').value;
            const codePattern = /^p\d{6}$/; // p로 시작하고 뒤에 6자리 숫자

            if (!codePattern.test(productCode)) {
                alert("상품 코드는 'p'로 시작하고 6자리 숫자로 구성되어야 합니다. 예: p123456");
                return false; // 폼 제출 중단
            }

            // 다른 검사가 필요하다면 추가

            return true; // 모든 검사가 통과되면 폼 제출
        }
        
    </script>
    
   
    
</body>
</html>