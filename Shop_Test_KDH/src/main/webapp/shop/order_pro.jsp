<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="shop.dto.User"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dto.Order"%>
<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Ship"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    int result = 0;
    String name = request.getParameter("name");
    String ship = request.getParameter("ship");
    String conutry = request.getParameter("country");
    String addresscode = request.getParameter("address_code");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    String total = request.getParameter("totalprice");
    
    List<Product> cartList = (List<Product>) session.getAttribute("cartList");
    
    Order od = new Order();
    OrderRepository orderrepository = new OrderRepository();
    ProductIORepository pri = new ProductIORepository();
    Product pr = new Product();
    String loginId = (String) session.getAttribute("loginId");
    ProductRepository pre = new ProductRepository();
    
    
   int totalpr = Integer.parseInt(total);
    
    od.setShipName(name);
    od.setDate(ship);
    od.setCountry(conutry);
    od.setZipCode(addresscode);
    od.setAddress(address);
    od.setPhone(phone);
    od.setOrderPw(password);
    od.setTotalPrice(totalpr);
	if(loginId != null){
    	od.setUserId(loginId);
    	}
    
    
    orderrepository.insert(od);
    
    int orderNo = orderrepository.lastOrderNo();
    
       
    for(int i = 0 ; i < cartList.size() ; i++ ){
    	pr = pre.getProductById(cartList.get(i).getProductId());
    	
    	pr.setProductId(cartList.get(i).getProductId());
    	pr.setOrderNo(orderNo);
    	pr.setAmount(cartList.get(i).getQuantity());
    	pr.setType("OUT");
    	
    	if(loginId != null){
    	pr.setUserId(loginId);
    	}
    	
    	pri.insert(pr);
    	
    	pr.setUnitsInStock(pr.getUnitsInStock() - pr.getAmount());
    	pre.update(pr);
    	
    }
   
    
    String encodedAddress = URLEncoder.encode(address, StandardCharsets.UTF_8.toString());
    String location = "complete.jsp?orderNo="+ orderNo +"&address=" + encodedAddress;
    
    session.removeAttribute("cartList");
    
    response.sendRedirect(location);


    
    
    
    
    
    
    %>