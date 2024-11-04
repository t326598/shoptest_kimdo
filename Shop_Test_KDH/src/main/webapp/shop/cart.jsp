<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
<jsp:include page="/layout/header.jsp" />
<%
	
	ProductRepository pr = new ProductRepository();
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");


%>

<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
	<div class="col-lg-6 mx-auto">
		<p class="lead mb-4">장바구니 목록 입니다.</p>
	</div>
</div>
<div class="container order">
	<!-- 장바구니 목록 -->
	<table class="table table-striped table-hover table-bordered text-center align-middle">
		<thead>
			<tr class="table-primary">
				<th>상품</th>
				<th>가격</th>
				<th>수량</th>
				<th>소계</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
	<%if(cartList != null){ %>
<% 
	int sum = 0;	
	for(int i = 0; i < cartList.size(); i++){ %>
			<tr>
				<td><%= cartList.get(i).getName() %></td>
				<td><%= cartList.get(i).getUnitPrice() %></td>
				<td><%= cartList.get(i).getQuantity() %></td>
				<td><%= cartList.get(i).getUnitPrice() * cartList.get(i).getQuantity() %></td>
				<td><a href="cart_delete_pro.jsp?product_Id=<%= cartList.get(i).getProductId() %>" class="btn btn-lg btn-danger">삭제</a></td>
			</tr>
<%		sum += cartList.get(i).getUnitPrice() * cartList.get(i).getQuantity();
	} 
	
%>
		</tbody>
		<tfoot>
			<tr>
				<td></td>
				<td></td>
				<td>총액</td>
				<td id="cart-sum"><%= sum %></td>
				<td></td>
			</tr>
		</tfoot>
<%	} else	{	%>
			<tr>
				<td colspan="5" style="text-align: center">등록된 상품이 없습니다.</td>
			</tr>
<%	} %>
		
		
	</table>

   <div class="d-grid gap-2 mt-5 mb-5 d-md-flex justify-content-md-between">
				<a href="cart_delete_all.jsp" class="btn btn-lg btn-danger">전체삭제</a>
				<a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()" >주문하기</a>
					</div>	
</div>


<jsp:include page="/layout/footer.jsp" />

	<script>
		let cartId = 'CC1E52294CAF673D775BF52A76F7FB27'
		let cartCount = <%= cartList != null ? cartList.size() : 0 %>
		let cartSum = document.getElementById('cart-sum')
		
		function order() {
			if( cartCount == 0 ) {
				alert('장바구니에 담긴 상품이 없습니다.')
				return
			}
			let msg = '총 ' + cartCount + '개의 상품을 주문합니다. \n총 주문금액 : ' + cartSum.textContent
			let check = confirm(msg)
			
			if( check ) {
				location.href = 'ship.jsp'
			}
			
		}
		
		
	
	</script>

</body>
</html>