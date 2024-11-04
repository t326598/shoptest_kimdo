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
	//로그인 요청
	UserRepository userlogin = new UserRepository();
	User loginUser = userlogin.login(id, pw);


	// 로그인 실패
	if (loginUser == null) {
		
%>
	<script>
	alert("아이디 또는 비밀번호가 잘못 입력되었습니다.");
	window.location.href = "login.jsp?err=1";
	</script>
<%
	}


	// 아이디 저장
	String rememberId = request.getParameter("remember-id");
	Cookie cookieRememberId = new Cookie("rememberId", "");
	Cookie cookieUsername = new Cookie("id", "");

	// 아이디 저장 체크 시
	if (rememberId != null && rememberId.equals("on")) {
		out.println("rememberId : " + rememberId);
		cookieRememberId.setValue(URLEncoder.encode("on", "UTF-8"));
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
	
	cookieRememberId.setPath("/");
	cookieUsername.setPath("/");
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
	    String token = userrepository.refreshToken(id); // 토큰 생성 또는 갱신
	    // 쿠키 생성
	    cookieRememberMe.setValue(URLEncoder.encode(rememberMe, "UTF-8"));
	    cookieToken.setValue(URLEncoder.encode(token, "UTF-8"));
	} else {
	    // 로그인 미체크시
	    cookieRememberMe.setMaxAge(0);
	    cookieToken.setMaxAge(0);
	}


	// 쿠키를 클라이언트에 저장
	response.addCookie(cookieRememberId);
	response.addCookie(cookieUsername);	
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);


	//로그인 성공
	if(loginUser != null){
		//세션에 사용자 정보 등록
		session.setAttribute("loginId",loginUser.getId());
		session.setAttribute("loginUser",loginUser);
		
		// 리다이렉트 -> 메인 화면
		// 로그인 성공 페이지로 이동
		response.sendRedirect("complete.jsp?msg=0");
	}


%>


