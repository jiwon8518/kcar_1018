<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// 로그인x 로그인메인 페이지로 이동, 로그인o 글쓰기폼 이동
	String login = "";
	if((String)session.getAttribute("loginok") != null){
		login = (String)session.getAttribute("loginok");
	}
	//System.out.println(login);
	
	if(login.equals("yes")){
		
	%>
		<script type="text/javascript">
			location.href = "index.jsp?main=review/reviewForm.jsp";
		</script>
	<% 
		
	}else{
	%>
		<script type="text/javascript">
			alert("로그인이 필요합니다.");
			location.href = "index.jsp?main=login/loginMain.jsp";
		</script>
	<% 
	}
	
%>
