<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/login.css">
  <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
  <script  defer src = "js/login.js"> </script>
  <!-- <link rel="stylesheet" href="css/login.css"> -->
  <title>통합가입페이지</title>
</head>
<body>
<section>
  <div class="inner" style = "height: 500px;">
    <div class="title">
      <h6>가입정보 입력</h6>
      <span>가입정보를 입력하세요</span><br>
    </div>
    <div class="inner-inputBox">
      <div class="container">
      
        <div class="sendConfirmEmail">
          <span>1 회원 정보 확인</span>
         	<form action="index.jsp?main=login/findPwForm.jsp" method = "post">
	          <div class="process1 process">
			<%
			request.setCharacterEncoding("utf-8"); //get 일때는 사용안해도됨
			String confirmEmail = request.getParameter("confirmEmail");
			if(confirmEmail == null){
			%>
	              <input type="email" name="confirmEmail" class="getEmail" placeholder="가입시 입력한 이메일 " required = "required">
	              <button type="submit"  class="getEmailBtn baseBtn" >확인</button>
	          
			<%} else {
					
				//email 읽기
				String email = request.getParameter("confirmEmail");
				//dto 선언
				LoginDto dto = null;
				//dao 선언
				LoginDao dao = new LoginDao();
				dto = dao.getUserInfo(2, email);
				boolean SameEmailCheck = dao.userInfoCheck(2,email);
				if(!SameEmailCheck){%>
					<script type="text/javascript">
						alert("존제하지 않는 아이디입니다.");
						location.href = "index.jsp?main=login/findPwForm.jsp";
					</script>
				<%} else {%>
		          	 <input type="text" name="confirmEmail" class="getEmail" placeholder="<%=email%>은 존제하는 아이디입니다." readonly >
		          	 <input type = "hidden" id = "type" value = "findPw" findEmail = "<%=dto.getEmail() %>">
	              	 <button type="button"  class="getEmailBtn baseBtn" id = "sendEmailBtn">인증메일 발송</button>
		             <button type="button"  class="refreshBtn baseBtn"  onclick = "location.href = 'index.jsp?main=login/findPwForm.jsp'">이전</button>
				<%}
			}%>
			
			</div>
         	</form>	          
        </div>

        <div class="confirmEmail">
          <span>2 이메일 인증번호 입력</span>
            <div class="process2 process">
                <input type="email" name="confirmEmail" class="getConfirmNumber" placeholder="인증 번호 입력" id = "timer">
                <button type="button" class="comfirmBtn baseBtn">인증</button>
                <button type="button"  class="refreshBtn2 baseBtn"  onclick = "location.href = 'index.jsp?main=login/findPwForm.jsp'">이전</button>
            </div>
          </div>

        <div class="userInfo">
          <span>3 임시 비밀번호 전송</span>
            <div class="process3 process">
              <div class="">
              	  <h6>가입시 입력하신 이메일로 임시비밀번호를 전송하시려면 버튼을 클릭 해 주세요</h6>
                  <button type="button" id="sendTempPwBtn" class = "baseBtn">전송</button>
              </div>
            </div>
        </div>
       
      </div>
    </div>
   </div> 
  </section>
<script>
	//인증번호 포커스시 전에작성한내용 지우고 글씨 검정색으로 
	$(".getConfirmNumber").focus(function() {
		$(".getConfirmNumber").val("").css("color","black");	
	});
	
	$(".getEmail").focus();
	
  	/* 공통사용 */
  	confirmCode = 0;
 	
  	//인증번호생성
	function createConfirmCode(){
 		var code = ""
 			for(let i=0; i<7; i++){
 				code  += Math.floor(Math.random()*9+1); 
 			}
 		return code;
 	}
  	
  	//인증번호발송
 	$("#sendEmailBtn").click(function () {
 		alert("해당정보의 이메일로 인증번호를 발송했습니다.")
 		
 		confirmCode = createConfirmCode();
 		let email = $("#type").attr("findEmail");
 		let type = $("#type").val();
 		/* alert(type) */
 		$.ajax({
			type : "post",
			url : "index.jsp?main=login/sendConfirmMail.jsp",
			data: {
				"type": type,
				"email":email,
				"confirmCode":confirmCode		
			},
			success : function() {
				$(".process1").hide();
		 		$(".process2").show();
		 		timer(2);
			},
			error:function(request,status,error){
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }

		});
	});
  	
 	//비밀번호찾기
  	
 	/* 인증번호확인 */
 	$(".comfirmBtn").click(function () {
 		$(".getConfirmNumber").val();
 		
 		if($(".getConfirmNumber").val().length < 7){
			/* alert("발송된 7자리 인증번호를 입력해주세요") */
			$(".getConfirmNumber").val("발송된 7자리 인증번호를 입력해주세요").css("color","red");
			return;
		}
		
		if($(".getConfirmNumber").val() == confirmCode){
			alert("인증에 성공하셨습니다.")
			$(".getConfirmNumber").val("");
			let myid = $(".getEmailBtn").attr("myid");
			$("#confirmedEmail").val(myid);
			$("#emailInfo").val(myid);
			
			$(".process2").hide();
	 		$(".process3").show();
		}else{
			$(".getConfirmNumber").val("인증번호가 다릅니다").css("color","red");
		}
	});
 	
 	/* 임시비밀번호생성 */
	function createTempPw(){
 		var code = ""
 			for(let i=0; i<5; i++){
 				code  += Math.floor(Math.random()*9+1); 
 				code  += String.fromCharCode((Math.floor(Math.random()*26+65))); 
 			}
 		return code;
 	}
 	
 	/* 임시비밀번호전송 */
 	$("#sendTempPwBtn").click(function () {
 		tempPw = createTempPw();
 		let email = $("#type").attr("findEmail");
 		/* alert(type) */
 		$.ajax({
			type : "post",
			url : "index.jsp?main=login/sendConfirmMail.jsp",
			data: {
				"type": "sendTempPw",
				"email":email,
				"tempPw":tempPw		
			},
			success : function() {
				alert("해당이메일로 임시비밀번호를 발송했습니다.")
				let email2 = $("#type").attr("findEmail");
				location.href = "index.jsp?main=login/loginMain.jsp?email="+email2;
			},
			error:function(request,status,error){
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }

		});
 	});
  </script>
</body>
</html>