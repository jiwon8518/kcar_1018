<%@page import="data.dto.EcommentDto"%>
<%@page import="data.dao.EcommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	String currentPage = request.getParameter("currentPage");
	String num = request.getParameter("num");

	EcommentDto dto = new EcommentDto();
	
	dto.setIdx(request.getParameter("idx"));
	dto.setContent(request.getParameter("content"));
	
	EcommentDao dao = new EcommentDao();
	
	dao.updateEcomment(dto);
	
	String path="../index.jsp?main=event/eventdetail.jsp?num="+num+"&currentPage="+currentPage+"&key=list";
	response.sendRedirect(path); 

%>