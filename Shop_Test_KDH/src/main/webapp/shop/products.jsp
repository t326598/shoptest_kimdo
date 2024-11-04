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
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
	
<style>
	.card p{
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 2;
		line-height: 1.5;
		max-height: 3em;
	}
	
	.card .title {
		white-space: nowrap; /* 텍스트를 한 줄로 고정 */
	    overflow: hidden;    /* 넘치는 텍스트 숨김 */
	    text-overflow: ellipsis; /* 줄임표 추가 */
	}
	
</style>

</head>
<body>
<jsp:include page="/layout/header.jsp" />



<div class="px-4 py-5 my-5 text-center">

	<h1 class="display-5 fw-bold text-body-emphasis">상품 목록</h1>
	
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">쇼핑몰 상품 목록 입니다.</p>


	<a href="add.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품 등록</a>
	<a href="editProducts.jsp" class="btn btn-success btn-lg px-4 gap-3">상품 편집</a>
	<a href="cart.jsp" class="btn btn-warning btn-lg px-4 gap-3">장바구니</a>

	<br><br><br><br>
	


		<div class="row gy-4">
		    <%
		        ProductRepository pr = new ProductRepository();
		        String keyword = request.getParameter("keyword");
		        keyword = (keyword == null || keyword.trim().isEmpty()) ? "" : keyword;
		        List<Product> prList = pr.list(keyword);

		        if (prList.isEmpty()) {
		    %>
		            <p class="text-center">검색된 상품이 없습니다.</p>
		    <%
		        } else {
		        	
		        	
		            for (int i = 0; i < prList.size(); i++) {
		    %>
		        <div class="col-md-6 col-xl-3">
		            <div class="card p-3" style="height: 380px;">
		                <!-- 이미지 영역 -->
		                <div class="img-content">
		                    <img src="<%= request.getContextPath() %>/shop/img?id=<%= prList.get(i).getProductId() %>" class="w-100 p-2" style="height: 130px; object-fit:cover;">
		                </div>
		                <!-- 컨텐츠 영역 -->
		                <div class="content">
		                    <h3 class="text-left title"><%= prList.get(i).getName() %></h3>
		                    
		                    <p style="min-height: 43px;"><%= prList.get(i).getDescription() %></p>
		                    <p class="text-end price">₩ <%= prList.get(i).getUnitPrice() %></p>
		                   
		                    <p class="d-flex justify-content-between" >
		                        <a href="cart_pro.jsp?id=<%= prList.get(i).getProductId() %>"  class="btn btn-outline-primary">
		                            <i class="material-symbols-outlined">shopping_bag</i>
		                        </a>
		                        <a href="product.jsp?product_id=<%= prList.get(i).getProductId() %>" class="btn btn-outline-primary">상세 정보</a>
		                    </p>
		                   
		                </div>                        
		            </div>
		        </div>
		    <%
		            }
		        }
		    %>
		</div>
	</div>
</div>
<jsp:include page="/layout/footer.jsp" />

</body>
</html>