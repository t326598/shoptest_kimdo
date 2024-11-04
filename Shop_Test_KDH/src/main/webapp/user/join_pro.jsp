<!-- 
	회원 가입 처리
 -->
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int result = 0;
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pwconfirm = request.getParameter("pw_confirm");
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
			
	
	if(!pw.equals(pwconfirm)){
		%>
		 <script>
        alert("비밀번호와 확인 비밀번호가 일치하지 않습니다.");
        history.back(); // 이전 페이지로 돌아감
 		   </script>
		<% 

	}
	
	User user = new User();
	
	
	
	
	user.setId(id);
	user.setPassword(pw);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(email);
	user.setPhone(phone);
	user.setAddress(address);
	
	UserRepository userrepository = new UserRepository();
	
	  // 회원 등록
   
    int check = 0;
    int insert = 0;
   
    check = userrepository.checkId(id);
   
    if ( check > 0 ) {
%>
<script>
        alert('이미 사용 중인 아이디입니다.');
       location.href="join.jsp?error";
</script>
<%
    }
    else if ( check == 0 ) {
      insert = userrepository.insert(user);
    }
   
    if ( insert > 0 ) {
       response.sendRedirect("complete.jsp?msg=1");
    }
%>



    

    
    
    
    
    
    