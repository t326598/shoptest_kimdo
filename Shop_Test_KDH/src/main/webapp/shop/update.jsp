<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% 
    String productId = request.getParameter("product_id");
    ProductRepository pr = new ProductRepository();
    Product pd = new Product();
    
    if(productId != null){
    	pd = pr.getProductById(productId);
    }
    
    %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop - 상품글 수정</title>
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
<%String root = request.getContextPath(); %>
<jsp:include page="/layout/header.jsp" />
<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">상품 수정</h1>
	<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
	</div>
</div>
			<div class="container shop">	
		<form action="update_pro.jsp?product_id=<%= pd.getProductId() %>" enctype="multipart/form-data" method="post" >
		
		<div class="input-group" id="img_input">
    <% if (pd.getFile() != null && !pd.getFile().isEmpty()) { %>
        <img id="uploadedImage" src="<%= request.getContextPath() %>/shop/img?id=<%= pd.getProductId() %>" style="max-width: 400px; height: auto;" />
    <% } else { %>
        <p>이미지가 없습니다.</p>
    <% } %>
		</div>

			
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">상품 이미지</label>
						<input type="file" class="form-control col-md-10" 
							   name="image" id="image" accept="image/*" multiple placeholder="선택된 파일 없음" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="code">상품 코드</label>
						<label type="text" class="form-control col-md-10" 
							   name="code" placeholder="" value=""><%= pd.getProductId() %></label>
							   		<input type="hidden" class="form-control col-md-10" 
							   name="code" placeholder="" value="<%= pd.getProductId() %>" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">상품명</label>
						<input type="text" class="form-control col-md-10" 
							   name="name" value="<%= pd.getName() %>" placeholder="" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">가격 </label>
						<input type="text" class="form-control col-md-10" 
							   name="price" value="<%= pd.getUnitPrice()  %>" placeholder="" />
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="" style="width: 100%;">상세 정보</label>
						<textarea name="content" id="content" cols="30" rows="10" style="width: 100%; height:300px; resize: none; text-align: center;"> <%= pd.getDescription() %></textarea>
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">제조사</label>
						<input type="text" class="form-control col-md-10" 
							   name="make" placeholder="" value="<%= pd.getManufacturer()%> "/>
					</div>
					<div class="input-group mb-3 row">
						<label class="input-group-text col-md-2" id="">분류</label>
						<input type="text" class="form-control col-md-10" 
							   name="category" placeholder="" value="<%= pd.getCategory() %>" />
					</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">재고 수</label> <input
					type="text" class="form-control col-md-10" value="<%= pd.getUnitsInStock() %>" name="units_in_stock"
					placeholder="" />
			</div>
			   <!-- 상태 선택 라디오 버튼 -->
           <div class="input-group mb-3 row">
                <label class="input-group-text col-md-2 label">상태</label> 
                <div class="radio-group col-md-10">
                    <label class="radio-option">
                        <input type="radio" name="status" value="NEW" <%= "NEW".equals(pd.getCondition()) ? "checked" : "" %> /> 신규 제품
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="status" value="USED" <%= "USED".equals(pd.getCondition()) ? "checked" : "" %> /> 중고 제품
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="status" value="REFURBISHED" <%= "REFURBISHED".equals(pd.getCondition()) ? "checked" : "" %> /> 재생 제품
                    </label>
                </div>
            </div>
        
      
        <div class="d-grid gap-2 mt-5 mb-5 d-md-flex justify-content-md-between">
				<a href="<%= root%>/shop/index.jsp" class="btn btn-lg btn-secondary">목록</a>
				<input type="submit" class="btn btn-lg btn-primary" value="수정" />
			</div>	
		</form>
			</div>
  
				
		<jsp:include page="/layout/footer.jsp" />
		
		<script src="../static/js/validation.js"></script>
		
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
    </script>
</body>
</html>