<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>가입인사</title>
<link rel="stylesheet" href="css/login.css">
<style type="text/css">
#newMember{
	font-size: 50px;
}
.newMemberForm{
	padding-top: 50px;
	padding-left: 300px;
	postition:absolute;
	width: 1000px;
	height:120px;
	right: 50%;
	margin-right: -500px;
}
.btnGroup{
	padding-left: 50px;
}


</style>
</head>
<body>
	<div class = "inner">
		<div class = "newMemberForm">
			<span id = "newMember">회원가입을 환영합니다</span><br>
			<div class = "btnGroup">
				<button type = "button" class="baseBtn" id = "loginloc" onclick = "location.href = 'index.jsp?main=login/loginMain.jsp'">로그인</button>
				<button type = "button" class="baseBtn" id = "mainloc" onclick = "location.href = 'index.jsp?main=layout/main.jsp'">메인페이지</button>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$("#newMember").focus();
	</script>
</body>
</html>