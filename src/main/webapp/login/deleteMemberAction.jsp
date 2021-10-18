<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//탈퇴 아이디 얻기
	String myid = (String)session.getAttribute("myid");
	
	//계정삭제
	LoginDao dao = new LoginDao();
	dao.deleteMember(myid);
	
	//로그아웃처리
	session.removeAttribute("loginok");
	session.removeAttribute("myid");
	
	//탈퇴페이지로이동
	response.sendRedirect("../index.jsp?main=login/goodBye.jsp");
%>