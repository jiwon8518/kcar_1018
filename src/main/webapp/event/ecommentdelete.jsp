<%@page import="data.dao.EcommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String idx = request.getParameter("idx");
	
	EcommentDao dao = new EcommentDao();
	
	dao.deleteEcomment(idx);

%>