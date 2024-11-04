<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
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
<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	</div>
	
	<!-- 주문 완료 확인 -->
	<% String orderNo = request.getParameter("orderNo");
	   String address = request.getParameter("address");
	   Order order = new Order();
	   OrderRepository ord = new OrderRepository();
	   
	

		
			%>
	<div class="container order mb-5 p-5">
		
		<h2 class="text-center">주문이 완료되었습니다.</h2>
		<!-- 주문정보 -->
		<div class="ship-box">
			<table class="table ">
				<tr>
					<td>주문번호 :</td>
					<td><%= orderNo %></td>
				</tr>
				<tr>
					<td>배송지 :</td>
					<td><%= address %></td>
				</tr>
			</table>
			
			<div class="btn-box d-flex justify-content-center">
				<a href="../user/order.jsp" class="btn btn-primary btn-lg px-4 gap-3">주문내역</a>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>