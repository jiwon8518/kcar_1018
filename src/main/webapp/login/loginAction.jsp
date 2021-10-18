<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	System.out.println(email);
	System.out.println(password);
	LoginDao dao = new LoginDao();
	boolean emailConfirm = dao.userInfoCheck(2, email);
	String pwConfirm = dao.getPw(email);
	System.out.println(pwConfirm);
	
	//아이디와 비번이 맞으면 3개의 세션을 저장하고
	//로그인메인으로 이동
	if(emailConfirm){
		if(pwConfirm.equals(password)){
			//세션유지시간 (생략시 기본 30분)
			session.setMaxInactiveInterval(60*5);
			session.setAttribute("loginok", "yes");
			session.setAttribute("myid", email);
			//로그인 메인으로 이동
			System.out.println("이동");
			response.sendRedirect("../index.jsp?main=layout/main.jsp");
		}else{
	/* 	System.out.println("노비밀번호"); */
		%>
			<script type="text/javascript">
				alert("비밀번호를 잘못 입력하셨습니다.");
				history.back();
			</script>
		<%}
		
		
		
	} else {
	/* System.out.println("노이메일"); */
	%>
		<script type="text/javascript">
			alert("존제하지 않는 이메일입니다.");
			history.back();
		</script>
<%}%>