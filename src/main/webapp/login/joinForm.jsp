<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
  <script  defer src = "js/login.js"> </script>
  <!-- <link rel="stylesheet" href="css/login.css"> -->
  <title>통합가입페이지</title>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <link rel="stylesheet" href="css/login.css">
</head>
<%
	
	String login = "";
	if((String)session.getAttribute("loginok") != null){
		login = (String)session.getAttribute("loginok");
	}
	System.out.println(login);
	
	if(login.equals("yes")){
		%>
		<script type="text/javascript">
		
			alert("이미로그인되었습니다.")
			history.back();
		</script>
		
		<% 
		
	}else{
		System.out.println(login);
	}
%>

<body>

  <div class="inner" style = "height: 1100px">
    <div class="title">
      <h6>가입정보 입력</h6>
      <span>로그인 정보 및 가입정보를 입력하세요</span>
    </div>
    <div class="inner-inputBox">
      <div class="container">
      
        <div class="sendConfirmEmail">
          <span>1 이메일 주소 중복 확인 및 인증</span>
         	<form action="index.jsp?main=login/joinForm.jsp" method = "post">
	          <div class="process1 process">
			<%
			request.setCharacterEncoding("utf-8"); //get 일때는 사용안해도됨
			String confirmEmail = request.getParameter("confirmEmail");
			if(confirmEmail == null){
			%>
	              <input type="email" name="confirmEmail" class="getEmail" placeholder="인증 이메일 주소" required = "required">
	              <button type="submit"  class="getEmailBtn baseBtn" >중복확인</button>
			<%} else {
					
				//email 읽기
				String email = request.getParameter("confirmEmail");
				//dao 선언
				LoginDao dao = new LoginDao();
				boolean SameEmailCheck = dao.userInfoCheck(2 ,email);
				if(SameEmailCheck){%>
					<script type="text/javascript">
						alert("이미 등록된 아이디입니다.");
						location.href = "index.jsp?main=login/joinForm.jsp";
					</script>
				<%} else {%>
		          	  <input type="text" name="available" value = " <%=email%>은 사용 가능한 이메일입니다."  class="getEmail" readonly>
		              <input type = "hidden" id = "type" value = "join">
		              <button type="button"  class="getEmailBtn baseBtn" id= "sendEmailBtn" myid = "<%=email%>" >인증메일 발송</button>
		              <button type="button"  class="refreshBtn baseBtn"  onclick = "location.href = 'index.jsp?main=login/joinForm.jsp'">이전</button>


				<%}
			}%>
			
			</div>
         	</form>	          
        </div>

        <div class="confirmEmail">
          <span>2 이메일 인증번호 입력</span>
            <div class="process2 process">
                <input type="email" name="confirmEmail" class="getConfirmNumber" id = "timer" placeholder="인증 번호 입력" >
                <button type="button" class="comfirmBtn baseBtn">확인 </button>
                <button type="button"  class="refreshBtn2 baseBtn"  onclick = "location.href = 'index.jsp?main=login/joinForm.jsp'">이전</button>
            </div>
          </div>

        <div class="userInfo">
          <span>3 회원 정보 입력</span>
            <div class="process3 process">
              <div class="userDetails">
                <form action="login/joinAction.jsp" onsubmit = "return check(this)" name="joinForm" class="joinForm" method = "post">
	                <span class="itme-title">아이디*</span>
	                <input type="text" readonly id="confirmedEmail"><br> 
	                <input type="hidden" name="email" id="emailInfo">
	                
	                <span class="itme-title">닉네임*</span>
	                <input type="text" id="name-loc" placeholder="중복확인버튼을 클릭해주세요" name="name" readonly required>
	                <button type="button" id="sameIdCheckBtn" class="baseBtn">중복확인</button><br>
	                <span id="invalid-name" class = "invalid-info">*닉네임을 입력해주세요</span>
	                
	                <span class="itme-title">비밀번호*</span>
	                <input type="password" id="pw" placeholder="비밀번호는 8자 이상 숫자,대문자,소문자,특수문자를 모두 포함해야 합니다." name="pw" required="required"><br>
	                <span id="invalid-pw" class = "invalid-info">*비밀번호를 형식에 맞게 입력해주세요</span>
	                
	                <span class="itme-title">비밀번호 확인*</span>
	                <input type="password" id="pwConfirm" placeholder="비밀번호 확인" name="pwCheck" required="required"><br>
	                <span id="invalid-pwConfirm" class = "invalid-info">*비밀번호가 일치하지 않습니다</span>
	                
	                <span class="itme-title">전화번호*</span>
	                <input type="tel" name="mobile1"  id="mobile1" required> - 
	                <input type="tel" name="mobile2"  id="mobile2" required> - 
	                <input type="tel" name="mobile3"  id="mobile3" required>
	                <span id="invalid-mobile" class = "invalid-info">*전화번호는 숫자로만 입력해주세요</span>
	                
	                <span class="itme-title">주소*</span>
	                <input type="text" id="postcode" placeholder="우편번호" name="postcode" readonly required>
	                <button type="button" id="postcodeBtn" class="whiteBtn">우편번호 찾기</button><br>
	                <input type="text" id="addr1" name="addr1" readonly placeholder="주소" required /><br>
	                <input type="text" id="addr2" name="addr2" placeholder="상세주소입력" required />
	                <span id="invalid-addr" class = "invalid-info">*주소를 입력해주세요</span><br>
	
	                <button type="submit" id="joinBtn" class="baseBtn">가입하기</button>
                </form>
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
	$(".invalid-info").hide();
/* 	$(".process3").show();   */
 	/* 공동 */
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
 		confirmCode = createConfirmCode();
 		let email = $(".getEmailBtn").attr("myid");
 		let type = $("#type").val()
 		$.ajax({
			type : "post",
			url : "index.jsp?main=login/sendConfirmMail.jsp",
			data: {
				"type" : type,
				"email":email,
				"confirmCode":confirmCode		
			},
			success : function() {
				alert("해당 이메일로 인증번호를 발송했습니다.")
				$(".process1").hide();
		 		$(".process2").show();
		 		timer(1);
			},
			error:function(request,status,error){
			      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }

		});
	});
 	
 	//회원가입
 	//인증번호확인
 	$(".comfirmBtn").click(function () {
 		$(".getConfirmNumber").val();
 		
 		if($(".getConfirmNumber").val().length < 5){
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
 	
	
	//비밀번호 정규식
	function validPwCheck(){

		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

		var pw = $("#pw").val();

		if(false === reg.test(pw)) {
			$("#invalid-pw").show();
			$("#pw").val("");
			$("#pwConfirm").val("");
			return false;
		}else{
			$("#invalid-pw").hide();
			return true;
		}

	}
	//가입정보 유효성확인
	function check(info) {
		
		let check = true; 
		//check 가 false 값 발생시 action이 호출되지 않는다
		
 		//비밀번호 유효성 검사
 		
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

		var pw = $("#pw").val();

		if(false === reg.test(pw)) {
			$("#invalid-pw").show();
			$("#pw").val("");
			$("#pwConfirm").val("");
			check =  false;
		}else{
			$("#invalid-pw").hide();
		}
 		//비밀번호 일치 확인
		if(info.pw.value != info.pwCheck.value){
			$("#invalid-pwConfirm").show();
			info.pw.value = "";
			info.pwCheck.value = "";
			check = false;
		}else{
			$("#invalid-pwConfirm").hide();
		}
 		
		//이름 미입력 검사
		if(info.name.value == ""){
			$("#invalid-name").show();
			check = false;
		}else{
			$("#invalid-name").hide();
		}
		
 		//우편번호 미입력 검사
		if(info.postcode.value == ""){
			$("#invalid-addr").show();
			check = false;
		} else {
			$("#invalid-addr").hide();
		}
		//주소 미입력 검사
		if(info.addr1.value == ""){
			$("#invalid-addr").show();
			check = false;
		} else {
			$("#invalid-addr").hide();
		}
		//전화번호 유효값 검사
		if(isNaN($("#mobile1").val()) || isNaN($("#mobile2").val()) || isNaN($("#mobile3").val())){
			$("#invalid-mobile").show();
			$("#mobile1").val("")
			$("#mobile2").val("")
			$("#mobile3").val("")
			$("#mobile1").focus();
			check = false;
		} else {
			$("#invalid-mobile").hide();
		}	
		
		return check;
	}
 	
	//이름 중복검사
	$("#sameIdCheckBtn").click(function() {
		window.open("login/sameNameCheck.jsp", "" , "width = 480px, height = 150px, left = 700px, top = 100px");
	})
 	
 	
	//주소입력
	document.getElementById("postcodeBtn").addEventListener("click", function() { //주소입력칸을 클릭하면
		//카카오 주소창 발생
		new daum.Postcode({
			oncomplete: function(data) { //선택시 입력값 세팅
				document.getElementById("addr1").value = data.address; // 주소 넣기
				document.getElementById("postcode").value = data.zonecode; // 우편번호 넣기
				document.querySelector("#addr2").focus(); //상세입력 포커싱
			}
		}).open();
	});
	
	//전화번호입력시 다음칸으로 자동넘김
	$("#mobile1").keyup(function() {
		if($("#mobile1").val().length > 2)
			$("#mobile2").focus();
			$("#mobile2").val(null);
	});
	$("#mobile2").keyup(function() {
		if($("#mobile2").val().length >3)
			$("#mobile3").focus();
			$("#mobile3").val(null);
	});
	
  </script>

</body>
</html>