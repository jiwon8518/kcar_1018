<%@page import="data.dao.RcommentDao"%>
<%@page import="data.dto.RcommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

	request.setCharacterEncoding("UTF-8");
	
	// 데이터 읽기
	String num = request.getParameter("num");
	String email = request.getParameter("myid");
	String name = request.getParameter("name");
	String content = request.getParameter("content");

	// dto 선언
	RcommentDto dto = new RcommentDto();
	
	// dto에 넣어주기
	dto.setNum(num);
	dto.setEmail(email);
	dto.setName(name);
	dto.setContent(content);
	
	// insert 메서드 호출해서 db에 저장
	RcommentDao dao = new RcommentDao();
	dao.insertComment(dto);
	
	// detail 페이지로 이동
	String path = "../index.jsp?main=review/reviewDetail.jsp?num="+num;
	response.sendRedirect(path);
	
%>