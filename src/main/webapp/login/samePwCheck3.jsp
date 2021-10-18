<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>비밀번호 확인</title>
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/login.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); //get 일때는 사용안해도됨
	String key = request.getParameter("key");
	if(key == null){
		//아이디 입력폼
%>
	<form action="samePwCheck3.jsp" method = "post" class = "form-inline">
		<input type = "hidden" name = "key" value = "result">
		<input type="text" name = "pw" id ="nameCheck" placeholder="비밀번호" required >
		<button type = "submit" class = "baseBtn" id = "sameNameCheckBtn" >확인</button>
	</form> 
	<%} else {
		
		String pw = request.getParameter("pw");
		System.out.println(pw);
		String email = (String)session.getAttribute("myid");
		System.out.println(email);
		//dao 선언
		LoginDao dao = new LoginDao();
		LoginDto dto = new LoginDto();
		dto = dao.getUserInfo(2, email);
		String loginPw = dto.getPw();
		//이름이 db 에 존재하는지 체크
		if(!loginPw.equals(pw)){%>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				location.href = "samePwCheck3.jsp";
			</script>
		<%} else {%>
		    <input type="text" name = "name" id ="nameCheck" readonly value = "비밀번호 인증완료" >
			<button type = "submit" class = "baseBtn" id = "btnuse"  >수정하기</button>
		<%}
	}
%>		
<script>
	$("#btnuse").click(function() {
		//부모창에 아이디 보내기
		opener.myPage.pwc.value = "인증확인";
		//현재창 닫기
		window.close();
	})
</script>
</body>
</html>