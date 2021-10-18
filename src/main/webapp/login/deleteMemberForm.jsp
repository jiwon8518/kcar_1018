<%@page import="data.dao.LoginDao"%>
<%@page import="data.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>회원탈퇴</title>
<link rel="stylesheet" href="css/login.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
</head>
<body>
	<div class = "inner" style = "padding-top: 100px; width: 650px;">
		<div class="sendConfirmEmail">
		       <h1>회원탈퇴시 모든정보는 삭제됩니다</h1>
          <span style = "padding-left:40px;" >회원 정보 확인</span>
         	<form action="index.jsp?main=login/deleteMemberForm.jsp" method = "post" accept-charset="utf-8" style = "padding-left:40px;">
	          <div class="process1 process">
			<%
			request.setCharacterEncoding("utf-8"); //get 일때는 사용안해도됨
			String inputPw = request.getParameter("confirmPw");
			if(inputPw == null){
			%>
	              <input type="password" name="confirmPw" class="getEmail" id = "getPw"placeholder="비밀번호를 입력해주세요" required >
	              <button type="submit"  class="getEmailBtn baseBtn" >확인</button>
	             
	          
			<%} else {
				//dao 선언
				LoginDao dao = new LoginDao();
				//email 읽기
				inputPw = request.getParameter("confirmPw");
				System.out.println(inputPw);
				inputPw=new String(inputPw.getBytes("8859_1"),"UTF-8");
				System.out.println(inputPw);
				String myid = (String)session.getAttribute("myid");
				System.out.println(myid);
				String confirmPw = dao.getPw(myid);
				System.out.println(confirmPw);
				//dto 선언
				LoginDto dto = null;
				if(!confirmPw.equals(inputPw)){%>
					<script type="text/javascript">
						alert("비밀번호가 일치하지 않습니다");
						location.href = "index.jsp?main=login/deleteMemberForm.jsp";
					</script>
				<%} else {%>
					  
		          	  <input type="text" name="confirmPw" class="getEmail" value = "정말로 탈퇴하시겠습니까?"  readonly> 
		              <button type="button"  class="refreshBtn baseBtn"  style = "left: 370px;" onclick = "location.href = 'login/deleteMemberAction.jsp'">탈퇴</button>

				<%}
			}%>
			
			</div>
         	</form>	          
        </div>
		<script>
				$("#getPw").focus();
		</script>
	</div>
</body>
</html>