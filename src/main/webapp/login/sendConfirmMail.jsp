<%@page import="data.dao.LoginDao"%>
<%@page import="SendEmail.SendEmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//이메일 전송에 필요한 정보 선언
	String tempPw = "";
	String title = "";
	String text = "";
	String confirmCode = "";
	
	//이메일 전송에 필요한 정보 초기화
	String type = request.getParameter("type");
	String email = request.getParameter("email");
	if(type.equals("sendTempPw")){
		System.out.println("임시번호발송");
		tempPw = request.getParameter("tempPw");
		//기존회원 비밀번호를 임시비밀번호로 변경
		LoginDao dao = new LoginDao();
		dao.updatePw(email, tempPw);
		
	}else{
		confirmCode = request.getParameter("confirmCode");
	}
	
	
	//정보가 넘어오는지 확인용 불필요시 주석처리!
	System.out.println(type);
	System.out.println(email);
	System.out.println(confirmCode);
	System.out.println(tempPw);
	
	//타입에 따라 전송할 이메일 제목과 내용
	switch(type) {
    case "join": 
    	title = "회원가입 본인 인증메일입니다";
    	text = "회원가입을 하기 위한 인증 인증 번호는" + confirmCode + "입니다.";
         break;
    case "findEmail": 
    	title = "아이디찾기 본인 인증메일입니다";
    	text = "아이디를 찾기 위한 이메일 인증 번호는" + confirmCode + "입니다.";
         break;
    case "findPw": 
    	title = "비밀번호찾기 본인 인증메일입니다";
    	text = "비밀번호를 찾기 위한 이메일 인증 번호는" + confirmCode + "입니다.";
         break;
    case "sendTempPw": 
    	title = "임시비밀번호 발급";
    	text = "임시비밀번는 " + tempPw + " 입니다. \n가능한 빨리 비밀번호를 변경해주세요";
    	System.out.println("내용선택");
         break;
	}
	
	//이메일 전송
	SendEmail send = new SendEmail();
	//실제이메일 발송을 원하면 아래내용 주석해제 
	/* send.sendEmailToUser(email, title, text); */
	
	//타입에 따라 수행을 마치고 이동될 페이지
	switch(type) {
    case "join": 
		 response.sendRedirect("index.jsp?main=login/joinForm.jsp");
         break;
    case "findEmail": 
    	 response.sendRedirect("index.jsp?main=login/findEmailForm.jsp");
         break;
    case "findPw": case "sendTempPw":
    	 response.sendRedirect("index.jsp?main=login/findPwForm.jsp");
         break;
	}
%>

	
	
	

