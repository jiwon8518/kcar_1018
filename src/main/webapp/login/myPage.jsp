<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>마이페이지</title>
<link rel="stylesheet" href="css/login.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<style type="text/css">
#confirmedEmail{
	width: 540px;
	height: 40px;
	font-size: 14px;
	box-sizing: border-box;
}
#invalid-mobile{
	color: red;
}
.itme-title{
	color: rgba(0, 0, 0, 0.87);
    font-size: 0.875rem;
    font-weight: 400;
    font-family: Nanum Gothic,sans-serif,Roboto,Helvetica,Arial;
    line-height: 1.46429em;
}

</style>
</head>
<%	
	String email = (String)session.getAttribute("myid");
	LoginDao dao = new LoginDao();
	LoginDto dto = dao.getUserInfo(2, email);
	System.out.println(dto.getEmail());
%>
<body>
  <div class = "inner" style = "padding-top: 50px;height: 920px; width: 580px;" >
  	<div class = "updateInfo">
		<br>
		<h1><%=dto.getName()%>님의 회원정보</h1><br> 
		<form action="login/updateAction.jsp" name = "myPage" method = "post" onsubmit = "return check(this)">
	         <span class="itme-title">아이디*</span><br> 
	         <input type="text" readonly id="confirmedEmail" name = "id"value ="<%=dto.getEmail()%>"><br> 
	         <input type="hidden" name="email" id="emailInfo">
	         <br>
	         <span class="itme-title">닉네임*</span><br> 
	         <input type="text" id="name-loc" placeholder="중복확인버튼을 클릭해주세요" value ="<%=dto.getName()%>"  name="name" readonly required> 
	         <button type="button" id="sameNameBtn" class="baseBtn">중복확인</button><br><br>
	         
	         <span class="itme-title">전화번호*</span><br> 
	         <input type="tel" name="mobile1" value ="<%=dto.getMobile1()%>"   id="mobile1" required> - 
	         <input type="tel" name="mobile2" value ="<%=dto.getMobile2()%>"   id="mobile2" required> - 
	         <input type="tel" name="mobile3" value ="<%=dto.getMobile3()%>"   id="mobile3" required><br> 
	         <span id="invalid-mobile" class = "invalid-info">*전화번호는 숫자로만 입력해주세요</span><br><br>
	         
	         <span class="itme-title">주소*</span><br> 
	         <input type="text" id="postcode" value ="<%=dto.getPostcode()%>" placeholder="우편번호" name="postcode" readonly required>
	         <button type="button" id="postcodeBtn" class="whiteBtn">우편번호 찾기</button><br>
	         <input type="text" id="addr1"  value ="<%=dto.getAddr1()%>" name="addr1" readonly placeholder="주소" required /><br>
	         <input type="text" id="addr2" value ="<%=dto.getAddr2()%>"  name="addr2" placeholder="상세주소입력" required /><br><br><br> 
	         <span class="itme-title">수정전 비밀번호 확인*</span><br> 
	         <input type="text" class = "passc"id="name-loc" placeholder="수정전 비밀번호를 입력해주세요" name="pwc" required readonly> 
	         <button type="button" id="samePwBtn" class="baseBtn">비밀번호 확인</button><br><br>
	         <button type="submit" id="updateBtn" class="baseBtn">수정하기</button> <br><br><br>  
         </form>
         
         
     		 <button type="button" id="updatePwBtn" class="baseBtn"dd>비밀번호수정</button>&nbsp;  
        	 <button type="button" id="deleteMemberBtn" class="baseBtn">회원탈퇴</button>
        <!--  <div class = "deletConfirm">
	         <input type="text" id="deleteMember" placeholder="비밀번호 재입력" required /><br> 
        	 <button type="button" id="deleteMemberBtn" class="baseBtn">탈퇴</button>
         </div>  -->
  	</div>
  </div>
  <script type="text/javascript">
  	$(".invalid-info").hide();
  	/* $(".deletConfirm").hide(); */
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
	
  	//중복 닉네임 체크
	$("#sameNameBtn").click(function () {
		window.open("login/sameNameCheck2.jsp", "" , "width = 480px, height = 150px, left = 700px, top = 100px");
	})
	
	//중복 비밀번호 체크
	$("#samePwBtn").click(function () {
		window.open("login/samePwCheck3.jsp", "" , "width = 480px, height = 150px, left = 700px, top = 100px");
	})
	
	//비밀번호 변경
	$("#updatePwBtn").click(function () {
		location.href = "index.jsp?main=login/updatePwForm.jsp";
	})
	
	//회원탈퇴
	$("#deleteMemberBtn").click(function () {
		
		location.href = "index.jsp?main=login/deleteMemberForm.jsp";
	})
	//수정전 검사항목 체크
	function check(info) {
		
		let check = true; 
		
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
		//비밀번호인증 확인
		let vals = $(".passc").val();
		if(vals != "인증확인"){
			alert("비밀번호를 인증해주세요")
			check = false;
		}
		
		return check;
	}
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