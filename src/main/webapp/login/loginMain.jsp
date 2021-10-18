<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8 ">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/login.css">
	<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
	<title>통합가입페이지</title>
	<script defer src = ""></script>
</head>
<%
	//포커스를 비밀번호로할지 아디로할지 정해주는 변수 check
	boolean check = false;
	//비밀번호 찾기 클릭시 바로 로그인 창에 이메일 입력해주는기능
	String email = request.getParameter("email");
	System.out.println(email);
	if(email==null){
		email = "";
	}else{
		check = true;
	}
%>
<body>
	<section>
	  <div class="inner" >
	    <div class="inner-box">
	     
	        <form action="login/loginAction.jsp" method = "post">
	          <div class="items">로그인</div>
		          <input type="text" value = "<%=email%>" placeholder="이메일" name = "email" class="inputInfo" id = "id"required><br>
		          <input type="password" placeholder="비밀번호" name = "password" class="inputInfo" id = "pw" required><br>
		          <button type="submit" id = "loginBtn">로그인</button>
	        </form>
	        <div class="findInfo-container">
	          <a href="index.jsp?main=login/findEmailForm.jsp">이메일 찾기</a>
	          | 
	          <a href="index.jsp?main=login/findPwForm.jsp">비밀번호 찾기</a>
	          <br>
	          &nbsp;
	          아직 회원 가입을 하지 않으셨나요?
	          &nbsp;
	          <a href="index.jsp?main=login/joinForm.jsp">회원가입</a>
	          &nbsp; ▶
	        </div>
	    </div>
	  </div>
  </section>
	<script type="text/javascript">
		
		if(!<%=check%>){
			$("#id").focus();
		}else{
			$("#pw").focus();
		}			
		
	</script>
</body>
</html>