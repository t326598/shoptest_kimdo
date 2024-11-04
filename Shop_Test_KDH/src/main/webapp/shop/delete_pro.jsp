<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String productId = request.getParameter("product_id");
ProductRepository pr = new ProductRepository();


String root = request.getContextPath();

int result = pr.delete(productId);


if(result > 0){
	System.out.print("삭제 성공");
response.sendRedirect("products.jsp");

}
else if(result < 0){
	response.sendRedirect("products.jsp?=err");
}



%>