<%@page import="shop.dto.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.OrderRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String root = request.getContextPath();
    String phone = request.getParameter("phone");
    String pw = request.getParameter("orderPw");
    
    OrderRepository orderRepo = new OrderRepository();
    List<Product> orderList = orderRepo.list(phone, pw);
    	
	// 비회원 주문 내역 세션에 등록 처리
    if (orderList != null && !orderList.isEmpty()) {
        session.setAttribute("orderList", orderList);
    } else {
        session.setAttribute("errorMessage", "주문 내역이 없습니다.");
    }

    response.sendRedirect(root + "/user/order.jsp");
%>
