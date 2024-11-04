<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String productId = request.getParameter("product_Id");
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");

	
	if(cartList != null && productId != null){
			for(int i = 0 ; i < cartList.size() ; i++){
				Product item = cartList.get(i);
			if (item.getProductId().equals(productId)) {
				cartList.remove(item);
			}
				
			}
	}

	response.sendRedirect("cart.jsp");

%>