<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class="shop.dao.UserRepository" />
<%

	// 회원 정보 수정 처리

	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	String birth = year + "/" + month + "/" + day;
	String email = email1 + "@" + email2;
	
	
	
	System.out.println("name" + name);
	System.out.println("gender" + gender);
	System.out.println("birth" + birth);
	System.out.println("email" + email);
	System.out.println("phone" + phone);
	System.out.println("address" + address);
	
	UserRepository user = new UserRepository();
	

	User user1 = (User) session.getAttribute("loginUser");
	
	
	
	System.out.println("loginUuid" + user1.getId());
	
	User user2 = user.getUserById(user1.getId());
	
	System.out.println("user2" + user2);
	user2.setName(name);
	user2.setGender(gender);
	user2.setBirth(birth);
	user2.setMail(email);
	user2.setPhone(phone);
	user2.setAddress(address);
	
    int result = user.update(user2);
	
	System.out.println("user2" + user2);

 
    
    if (result >0 ){
        response.sendRedirect("complete.jsp?msg=2");
    } else {
        response.sendRedirect("update.jsp");
    }  

%>
