<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> 
	<jsp:include page="/layout/link.jsp" />
	<style>
		.product_main {
			display: flex;
			justify-content: space-between;
			align-items: flex-start;
			gap: 20px;
		}
		.img {
			flex: 1;
			text-align: right; /* 이미지가 오른쪽에 붙도록 설정 */
		}
		.img img {
			width: 100%;
			height: auto;
			max-width: 400px;
		}
		.product_details {
			flex: 1;
			text-align: left; /* 텍스트가 왼쪽에 붙도록 설정 */
			margin-right: auto;
		}
		.product_details h3 {
			margin-top: 0;
		}
	</style>
</head>
<body>
<jsp:include page="/layout/header.jsp" />

<% 
    String productId = request.getParameter("product_id");
    ProductRepository pr = new ProductRepository();
    Product pd = new Product();
    
    if(productId != null){
    	pd = pr.getProductById(productId);
    }
%>

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">상품 정보</h1>
	<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
	</div>

		<a href="products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
	</div>

<div class="container shop">	
	<div class="product_main">
		<section class="img">
			<% if (pd.getFile() != null && !pd.getFile().isEmpty()) { %>
				<img id="uploadedImage" src="<%= request.getContextPath() %>/shop/img?id=<%= pd.getProductId() %>" />
			<% } else { %>
				<p>이미지가 없습니다.</p>
			<% } %>
		</section>
		
		<section class="product_details">
			<h3><%= pd.getName() %></h3>
			<br><br>
			<p class="product_page">상품ID: &nbsp;&nbsp; <%= pd.getProductId() %> </p>
			<hr>
			<p class="product_page">제조사: &nbsp;&nbsp; <%= pd.getManufacturer() %> </p>
			<hr>
			<p class="product_page">분류: &nbsp;&nbsp;<%= pd.getCategory() %> </p>
			<hr>
			<p class="product_page">상태: &nbsp;&nbsp;<%= pd.getCondition() %> </p>
			<hr>
			<p class="product_page">재고수:&nbsp;&nbsp; <%= pd.getAmount() %> </p>
			<hr>
			<p class="product_page">가격:&nbsp;&nbsp; <%= pd.getUnitPrice() %> </p>
			<hr>
			<div class="btn-center" style="text-align: center;">
			<a href="cart_pro.jsp" class="btn btn-warning btn-lg px-4 gap-3" style="margin-right: 50px;">장바구니</a>
			<a href="order.jsp" class="btn btn-success btn-lg px-4 gap-3">주문하기</a>
			</div>
		</section>
		</div>
	</div>
</div>

<jsp:include page="/layout/footer.jsp" />

</body>
</html>
