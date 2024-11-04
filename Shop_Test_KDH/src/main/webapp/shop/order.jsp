<%@page import="shop.dto.User"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%
    String name = request.getParameter("name");
    String ship = request.getParameter("ship");
    String conutry = request.getParameter("country");
    String addresscode = request.getParameter("address_code");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    int sum = 0;
    User user = (User)session.getAttribute("loginUser");
	
	ProductRepository pr = new ProductRepository();
	List<Product> cartList = (List<Product>)session.getAttribute("cartList");

   	%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Shop</title>
</head>
<body>
<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
<jsp:include page="/layout/header.jsp" />
<div class="px-4 py-5 my-5 text-center">
	<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
	
		<div class="container shop">	
			<form action="order_pro.jsp" method="post">
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">성명</label>
					<input type="text" class="form-control col-md-10" 
						   name="name" placeholder="" value="<%= name %>" readonly="readonly" />
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">배송일</label>
					<input type="text" class="form-control col-md-10" 
						   name="ship" placeholder="" value="<%= ship %>" readonly="readonly" />
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">국가명</label>
					<input type="text" class="form-control col-md-10" 
						   name="country" placeholder="" value="<%= conutry %>" readonly="readonly" />
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">우편번호</label>
					<input type="text" class="form-control col-md-10" 
						   name="address_code" placeholder="" value="<%= addresscode %>" readonly="readonly" />
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">주소</label>
					<input type="text" class="form-control col-md-10" 
						   name="address" placeholder="" value="<%= address %>" readonly="readonly"/>
				</div>
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">전화번호</label>
					<input type="text" class="form-control col-md-10" 
						   name="phone" placeholder="" value="<%=phone %>" readonly="readonly" />
				</div>
				
				<div class="input-group mb-3 row">
					<label class="input-group-text col-md-2" id="code">주문 비밀번호</label>
					<input type="password" class="form-control col-md-10" 
						   name="password" placeholder="비회원일시 입력" 
						   <%= user != null ? "readonly" : "" %>/>
				</div>
				
	
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
	
	for(int i = 0; i < cartList.size(); i++){ %>
			<tr>
				<td><%= cartList.get(i).getName() %></td>
				<td><%= cartList.get(i).getUnitPrice() %></td>
				<td><%= cartList.get(i).getQuantity() %></td>
				<td><%= cartList.get(i).getUnitPrice() * cartList.get(i).getQuantity() %></td>
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
					<input type="hidden" class="form-control col-md-10" 
						   name="totalprice" value="<%= sum %>"/>
			
				<td></td>
			</tr>
		</tfoot>
<%	} else	{	%>
			<tr>
				<td colspan="5" style="text-align: center">등록된 상품이 없습니다.</td>
			</tr>
<%	} %>
		
		
			</table>
			
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="item">
					<a href="cart.jsp" class="btn btn-lg btn-success">이전</a>
					<!-- 취소 프로세스는 이어서... -->				
					<a href="/" class="btn btn-lg btn-danger">취소</a>				
				</div>
				<div class="item">
					<input type="submit" class="btn btn-lg btn-primary" value="주문완료" />
				</div>
			</div>
		</form>
	</div>	
</div>	
				
<jsp:include page="/layout/footer.jsp" />
</body>
</html>