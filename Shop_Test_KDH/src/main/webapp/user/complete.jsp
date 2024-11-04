<%@page import="shop.dto.User"%>
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
	<% String root = request.getContextPath(); %>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
		<%
		String msg = request.getParameter("msg");
		
		if("0".equals(msg)){
			User user = null;
			user = (User) session.getAttribute("loginUser");
		
			%>	
			
			
			
			<br>
			<h2><%= user.getId() %>님 환영합니다.</h2>
			
			
			<br>
			<a href="<%= request.getContextPath() %>" class="btn btn-lg btn-primary">메인 화면</a>
	<% 
		}
		
		if("1".equals(msg)){
			
			%>	
			<h2>회원 가입이 완료되었습니다.</h2>
			<br>			
			
			<a href="<%= request.getContextPath() %>" class="btn btn-lg btn-primary">메인 화면</a>
	<% 	

		}
	

		if("2".equals(msg)){
			%>	
			<h2>회원 정보가 수정되었습니다.</h2>
			<br>			
			
			<a href="<%= request.getContextPath() %>" class="btn btn-lg btn-primary">메인 화면</a>
	<% 
		}
		if("3".equals(msg)){
			%>	
			<h2>회원 정보가 삭제되었습니다.</h2>
			<br>			
			
			<a href="<%= request.getContextPath() %>" class="btn btn-lg btn-primary">메인 화면</a>
	<% 
		}
		%>
		
		
		
	</div>
	<!-- 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5">
		
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	

</body>
</html>