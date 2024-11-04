<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />

<%
	String id = request.getParameter("id");   
	
 System.out.println("id : " + id);
	int result = userDAO.delete(id);

	if(result > 0){
		
	response.sendRedirect("complete.jsp?msg=3");
	}
	
	else{
		response.sendRedirect("update.jsp");
	}
	
%>
