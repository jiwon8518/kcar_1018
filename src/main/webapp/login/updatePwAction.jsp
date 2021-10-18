<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//계정정보 얻기
	String myid = (String)session.getAttribute("myid");
	String pw = request.getParameter("pw");
	//dao생성
	LoginDao dao = new LoginDao();
	//비밀번호 변경
	dao.updatePw(myid, pw);
%>