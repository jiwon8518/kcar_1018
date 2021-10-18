<%@page import="data.dao.EpartiDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");

	EpartiDao dao = new EpartiDao();

	dao.deleteEparti(idx);

%>