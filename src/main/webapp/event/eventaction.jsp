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
	
	String a = request.getParameter("ct");
	
	System.out.println("1"+a);
	
	EventDto dto = new EventDto();
	dto.setWriter(request.getParameter("writer"));
	dto.setSubject(request.getParameter("subject"));
	dto.setContent(request.getParameter("ct"));
	dto.setPhotoname(request.getParameter("img"));
	
	
	
	//db insert
	EventDao dao = new EventDao();
	dao.insertEvent(dto);
	
	//방금 추가된 num 값 얻기
	String num = dao.getMaxNum();
	String path="../index.jsp?main=event/eventlist.jsp?num="+num;
	response.sendRedirect(path);   
	
%>