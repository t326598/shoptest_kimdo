<%@page import="shop.dto.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 상품아이디 가져오기
	String productId = request.getParameter("id");
	// 상품id로 상품 정보 조회	
	ProductRepository pr = new ProductRepository();
	Product pd = new Product();
	pd = pr.getProductById(productId);

	// cartList 라는 이름의 세션 정보를 가져옴
	List<Product> cartList = (List<Product>) session.getAttribute("cartList");
	
	// 한 번도 장바구니를 추가한 적이 없으면, 새로운 리스트 생성
	if( cartList == null || cartList.isEmpty() ) {
		cartList = new ArrayList<Product>();
	}
	
	// 장바구니에 상품정보 추가
		
	 boolean productExists = false;

    // 장바구니에 상품 정보 추가
    for (int i = 0; i < cartList.size(); i++) {
        if (cartList.get(i).getProductId().equals(productId)) {
            // 동일한 product_id인 경우, 수량 업데이트
            cartList.get(i).setQuantity(cartList.get(i).getQuantity() + 1);
            productExists = true;
            break; // 상품을 찾았으므로 루프 종료
        }
    }

    // 동일한 상품이 없는 경우 장바구니에 새 상품 추가
    if (!productExists) {
        pd.setQuantity(1); // 초기 수량 설정
        cartList.add(pd);
    }
	
	session.setAttribute("cartList", cartList);
	
	
	
	response.sendRedirect("products.jsp");

%>