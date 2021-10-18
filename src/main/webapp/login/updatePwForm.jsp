<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>비밀번호변경</title>
<link rel="stylesheet" href="css/login.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
</head>
<body>
<div class = "inner" style = "padding-top: 100px; width: 700px;">
		<div class="sendConfirmEmail">
				<h5>비밀번호 수정시 자동으로 로그아웃 처리됩니다.</h5>
          <span>회원 정보 확인</span>
         	<form action="index.jsp?main=login/updatePwForm.jsp" method = "post" accept-charset="utf-8">
	          <div class="process1 process">
			<%
			request.setCharacterEncoding("utf-8"); //get 일때는 사용안해도됨
			String inputPw = request.getParameter("confirmPw");
			if(inputPw == null){
			%>
	              <input type="password" name="confirmPw" class="getEmail" id = "getPw2"placeholder="비밀번호를 입력해주세요" required >
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
						location.href = "index.jsp?main=login/updatePwForm.jsp";
					</script>
				<%} else {%>
		          	  <input style ="width: 450px;" type="password" name="confirmPw" class="getEmail" id = "updatePw" placeholder = "수정비밀번호는 8자 이상 숫자,대문자,소문자,특수문자를 모두 포함해야 합니다." > <br><br>
		          	  <input style ="width: 450px;" type="password" name="confirmPw" class="getEmail" id = "updatePwCheck" placeholder = "비밀번호확인" >
		              <button type="button"  class="refreshBtn baseBtn"  style = "left: 480px;" id ="updatePwBtn" >수정</button>
						<!-- onclick = "location.href = 'login/updatePwAction.jsp'" -->
				<%}
			}%>
			
			</div>
         	</form>	          
        </div>
	
	</div>
	<script>
		$("#getPw2").focus();
		//비밀번호 변경
		$("#updatePwBtn").click(function() {
			let pw1 = $("#updatePw").val()
			let pw2 = $("#updatePwCheck").val()
			if(pw1 == "" || pw2 =="" ){
				alert("수정할 비밀번호를 입력해주세요")
				return;
			}
			
			//비밀번호 검사 정규식
			var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
			var pw = $("#updatePw").val();

			if(false === reg.test(pw)) {
				alert("비밀번호를 형식에 맞게 입력해주세요")
				$("#updatePw").val("")
				$("#updatePwCheck").val("")
				return
			}
			
			if(pw1 != pw2){
				alert("비밀번호가 일치하지 않습니다")
				$("#updatePw").val("")
				$("#updatePwCheck").val("")
				return;
			}else{
					$.ajax({
						type: "post",
						url: "login/updatePwAction.jsp",
						data: {"pw": pw1},
						dataType:"html",
						success: function (data) {
							location.href = 'login/pagemove.jsp'
						}
					});
			}
		})
	</script>
</body>
</html>