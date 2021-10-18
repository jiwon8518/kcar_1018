<%@page import="data.dao.WinboardDao"%>
<%@page import="data.dto.WinboardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//데이터 읽어서 dto 에 넣기
	
	//String content = request.getParameter("content");
	
	//int a = content.indexOf("<");
	//int b = content.indexOf(">");

	//StringBuffer contentdelete = new StringBuffer(content);
	
	//String contentA = ""+contentdelete.replace(a,b+1,"");
	
	
	WinboardDto dto = new WinboardDto();
	dto.setSubject(request.getParameter("subject"));
	dto.setContent(request.getParameter("content"));
	dto.setNum(request.getParameter("num"));
	
	
	//db update
	WinboardDao dao = new WinboardDao();
	dao.updateWin(dto);
	
	//방금 추가된 num 값 얻기
	String num = dao.getMaxNum();
	String path="../index.jsp?main=event/winboard.jsp?num="+num;
	response.sendRedirect(path);   
	
%>