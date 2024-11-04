<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
String root = request.getContextPath();
	// 자동 로그인, 토큰 쿠키 삭제
	Cookie cookieRememberMe = new Cookie("rememberMe","");
	Cookie cookieToken = new Cookie("token","");
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	cookieRememberMe.setMaxAge(0);
	cookieToken.setMaxAge(0);

	
	UserRepository usertoken = new UserRepository();
	String loginId = (String) session.getAttribute("loginId");
	if(loginId != null){
		int deleted= usertoken.deleteToken(loginId);
		if(deleted == 1) System.out.println("인증 토큰 데이터 삭제 성공!");
		else System.out.println("인증 토큰 데이터 삭제 실패!");
	}
	// 세션 무효화
		session.invalidate();
	
	
	// 쿠키 전달
	
		response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	response.sendRedirect(root + "/index.jsp");

%>