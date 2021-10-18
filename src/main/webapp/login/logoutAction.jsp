<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//loginok 라는 세션을 제거한다.
	session.removeAttribute("loginok");
	session.removeAttribute("myid");

	//loginmain 으로 이동
	response.sendRedirect("../index.jsp?main=layout/main.jsp");
%>