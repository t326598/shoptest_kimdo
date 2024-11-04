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
</head>
<body>
<jsp:include page="/layout/header.jsp" />

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">상품 편집</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">쇼핑몰 상품 목록 입니다.</p>


	<a href="add.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품 등록</a>
	<a href="Products.jsp" class="btn btn-success btn-lg px-4 gap-3">상품 목록</a>


	<br><br><br><br>
	

<div class="row gy-4">
    <% 
        ProductRepository pr = new ProductRepository();
        List<Product> prList = pr.list();

        for (int i = 0; i < prList.size(); i++) {
    %>
        <div class="col-md-6 col-xl-4 col-xxl-3">
            <div class="card p-3">
                <!-- 이미지 영역 -->
                <div class="img-content">
                    <img src="<%= request.getContextPath() %>/shop/img?id=<%= prList.get(i).getProductId() %>" class="w-100 p-2">
                </div>
                <!-- 컨텐츠 영역 -->
                <div class="content">
                    <h3 class="text-center"><%= prList.get(i).getName() %></h3>
                    <p><%= prList.get(i).getDescription() %></p>
                    <p class="text-end price">₩ <%= prList.get(i).getUnitPrice() %></p>
                    <p class="d-flex justify-content-between">
                        <a href="update.jsp?product_id=<%=prList.get(i).getProductId() %>" class="btn btn-primary">수정</a>
					<a href="delete_pro.jsp?product_id=<%=prList.get(i).getProductId() %>" class="btn btn-danger">삭제</a>
                    </p>
                </div>                        
            </div>
        </div>
    <% 
        } 
    %>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	
	

</body>
</html>