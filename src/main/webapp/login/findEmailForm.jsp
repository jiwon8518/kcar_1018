<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
  <script  defer src = "js/login.js"> </script>
  <link rel="stylesheet" href="css/login.css">
  <title>통합가입페이지</title>
</head>
<body>

  <div class="inner" style="height: 600px">
    <div class="title">
      <h6>가입정보 입력</h6>
      <span>가입 정보를 입력해주세요</span>
    </div>
    <div class="inner-inputBox">
      <div class="container">
      
        <div class="sendConfirmEmail">
          <span>1 회원 정보 확인</span>
         	<form action="index.jsp?main=login/findEmailForm.jsp" method = "post" accept-charset="utf-8">
	          <div class="process1 process">
			<%
			request.setCharacterEncoding("utf-8"); //get 일때는 사용안해도됨
			String confirmEmail = request.getParameter("confirmName");
			if(confirmEmail == null){
			%>
	              <input type="text" name="confirmName" class="getEmail" placeholder="가입시 입력한 이름을 입력해주세요" required >
	              <button type="submit"  class="getEmailBtn baseBtn" >확인</button>
	             
	          
			<%} else {
					
				//email 읽기
				String name = request.getParameter("confirmName");
				System.out.println(name);
				name=new String(name.getBytes("8859_1"),"UTF-8");
				System.out.println(name);
				String email = "";
				//dto 선언
				LoginDto dto = null;
				//dao 선언
				LoginDao dao = new LoginDao();
				boolean SameNameCheck = dao.userInfoCheck(1, name);
				dto = dao.getUserInfo(1, name);
				if(!SameNameCheck){%>
					<script type="text/javascript">
						alert("등록되지 않은 정보입니다.");
						location.href = "index.jsp?main=login/findEmailForm.jsp";
					</script>
				<%} else {%>
		          	  <input type="text" name="confirmName" class="getEmail" placeholder="<%=name%>님에 정보를 확인 하셨습니다."  readonly>
		          	  <input type = "hidden" id = "type" value = "findEmail" findEmail = "<%=dto.getEmail() %>">
	              	  <button type="button"  class="getEmailBtn baseBtn" id = "sendEmailBtn">인증메일 발송</button>
		              <button type="button"  class="refreshBtn baseBtn"  onclick = "location.href = 'index.jsp?main=login/findEmailForm.jsp'">이전</button>

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
                <button type="button"  class="refreshBtn2 baseBtn"  onclick = "location.href = 'index.jsp?main=login/findEmailForm.jsp'">이전</button>
            </div>
          </div>

        <div class="userInfo">
          <span>3 이메일 확인</span>
            <div class="process3 process">
              <div class="">
	              <input type="text"  disabled id ="confirmedEmail" ><br>
                  <button type="button" id="goTologinBtn" class = "baseBtn">로그인</button>
              </div>
            </div>
        </div>
       
      </div>
    </div>
   </div> 
  
  <script>
  	//인증번호 포커스시 전에작성한내용 지우고 글씨 검정색으로 
  	$(".getConfirmNumber").focus(function() {
  		$(".getConfirmNumber").val("").css("color","black");	
	});
  	
  	$(".getEmail").focus();
 	 /* 공통 */
  	confirmCode = 0;
  
   	//인증번호생성
	function createConfirmCode(){
 		var code = ""
 			for(let i=0; i<7; i++){
 				code  += Math.floor(Math.random()*9+1); 
 			}
 		return code;
 	}
   	
 	//인증번호전송
 	$("#sendEmailBtn").click(function () {
 		alert("해당정보의 이메일로 인증번호를 발송했습니다.")//이부분은 성공시 나오는부분으로 이동
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
		 		timer(3);
			},
			error:function(request,status,error){
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }

		});
	});
 	
 	// 인증번호인증
 	$(".comfirmBtn").click(function () {
 		$(".getConfirmNumber").val();
 		
 		if($(".getConfirmNumber").val().length < 7){
			/* alert("발송된 7자리 인증번호를 입력해주세요"); */
			$(".getConfirmNumber").val("발송된 7자리 인증번호를 입력해주세요").css("color","red");

			return;
		}
		
		if($(".getConfirmNumber").val() == confirmCode){
			alert("인증에 성공하셨습니다.")
			$(".getConfirmNumber").val("");
			let myid = $("#type").attr("findEmail");
			$("#confirmedEmail").val(myid);
			
			$(".process2").hide();
	 		$(".process3").show();
		}else{
			/* alert("인증번호가 다릅니다"); */
			$(".getConfirmNumber").val("인증번호가 다릅니다").css("color","red");
		}
	});
 	
 	//로그인페이지로이동
 	$("#goTologinBtn").click(function () {
 		let email = $("#type").attr("findEmail")
 		location.href = "index.jsp?main=login/loginMain.jsp?email="+email;
 		
 	});
 	
 	
	
  </script>
</body>
</html>