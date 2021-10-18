<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>중복확인</title>
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
	<form action="sameNameCheck2.jsp" method = "post" class = "form-inline">
		<input type = "hidden" name = "key" value = "result">
		<!-- <table class = "table table-bordered">
			<tr height="100">
				<td>
					<img alt="" src="../image2/s5.JPG" width = "70" align="left">
					<br>
					<b>이름을 입력해주세요</b> <br>
					<input type = "text" name = "name" class = "form-control" style = "width: 100px;"
					 autofocus = "autofocus" required="required">
					 <br>
					 <button type = "submit" class = "btn btn-info btn-sm">중복체크</button>
				</td>
			</tr>		
		</table> -->
		<input type="text" name = "name" id ="nameCheck" placeholder="이름" required >
		<button type = "submit" class = "baseBtn" id = "sameNameCheckBtn" >중복확인</button>
	</form> 
	<%} else {
		//이름 db체크
		//이름읽기
		String name = request.getParameter("name");
		//dao 선언
		LoginDao dao = new LoginDao();
		//이름이 db 에 존재하는지 체크
		boolean sameName = dao.userInfoCheck(1, name); 
		if(sameName){%>
			<script type="text/javascript">
				alert("이미 등록된 이름입니다.");
				location.href = "sameNameCheck2.jsp";
			</script>
		<%} else {%>
		    <input type="text" name = "name" id ="nameCheck" placeholder="이름" readonly value = "사용 가능한 이름입니다." >
			<button type = "submit" class = "baseBtn" id = "btnuse" myName = "<%=name%>" >사용하기</button>
		<%}
	}
%>		
<script>
	$("#btnuse").click(function() {
		//아이디얻기
		var myName = $(this).attr("myName");
		//부모창에 아이디 보내기
		opener.myPage.name.value = myName;
		//현재창 닫기
		window.close();
	})
</script>
</body>
</html>