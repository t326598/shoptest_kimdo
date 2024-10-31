<!-- 로그인 처리 -->
<%@page import="shop.dto.PersistentLogin"%>
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");

UserRepository userDAO = new UserRepository();
User loginUser = userDAO.login(id, pw);

// 로그인 실패
if (loginUser == null) {
	response.sendRedirect("complete.jsp?msg=0");
	return;
}

// 로그인 성공
session.setAttribute("loginId", loginUser.getId());
session.setAttribute("username", loginUser);

// 아이디 저장
String rememberId = request.getParameter("remember-id");
Cookie cookieRememberId = new Cookie("rememberId", "");
Cookie cookieUsername = new Cookie("username", "");

// 아이디 저장 체크 시
if (rememberId != null && rememberId.equals("on")) {
	cookieRememberId.setValue(URLEncoder.encode(rememberId, "UTF-8"));
	cookieUsername.setValue(URLEncoder.encode(id, "UTF-8"));
} else {
	// 아이디 저장 체크 해제 시
	cookieRememberId.setMaxAge(0);
	cookieUsername.setMaxAge(0);
}

// 쿠키 설정
String rememberMe = request.getParameter("remember-me");
Cookie cookieRememberMe = new Cookie("rememberMe", "");
Cookie cookieToken = new Cookie("token", "");

cookieRememberMe.setPath("/");
cookieToken.setPath("/");

// 쿠키 만료시간
cookieRememberId.setMaxAge(60 * 60 * 24 * 7); // 7일 동안 유지
cookieUsername.setMaxAge(60 * 60 * 24 * 7);
cookieRememberMe.setMaxAge(60 * 60 * 24 * 7);
cookieToken.setMaxAge(60 * 60 * 24 * 7);

// 자동 로그인
if (rememberMe != null && rememberMe.equals("on")) {
    UserRepository userrepository = new UserRepository();
    PersistentLogin persistentLogin = userrepository.refreshToken(id); // 수정된 부분
    if (persistentLogin != null) {
        String token = persistentLogin.getToken();
        cookieToken.setValue(token);
    } else {
        cookieRememberMe.setMaxAge(0);
        cookieRememberId.setMaxAge(0);
    }
}

// 쿠키를 클라이언트에 저장
response.addCookie(cookieRememberId);
response.addCookie(cookieUsername);	
response.addCookie(cookieRememberMe);
response.addCookie(cookieToken);

// 로그인 성공 페이지로 이동
response.sendRedirect("complete.jsp?msg=0");
%>
