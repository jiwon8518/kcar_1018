<%@page import="data.dao.EventDao"%>
<%@page import="data.dto.EventDto"%>
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
	
	
	EventDto dto = new EventDto();
	dto.setSubject(request.getParameter("subject"));
	dto.setContent(request.getParameter("ct"));
	dto.setPhotoname(request.getParameter("img"));
	dto.setNum(request.getParameter("num"));
	
	
	//db update
	EventDao dao = new EventDao();
	dao.updateEvent(dto);
	
	//방금 추가된 num 값 얻기
	String num = dao.getMaxNum();
	String path="../index.jsp?main=event/eventlist.jsp?num="+num;
	response.sendRedirect(path);   
	
%>