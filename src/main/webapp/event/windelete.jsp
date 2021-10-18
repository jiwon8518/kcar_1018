<%@page import="data.dao.WinboardDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//주의 : db 삭제뿐만 아니라 업로드된 파일도 삭제해보자
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	
	//db로부터 저장된 이미지명 얻기
	WinboardDao dao = new WinboardDao();
	
	//db 삭제
	dao.deleteWin(num);
	
	//프로젝트 실제 경로 구하기
	String realPath = getServletContext().getRealPath("/save");
	
	
	//보던 페이지로 이동
	String go="../index.jsp?main=event/winboard.jsp?currentPage="+currentPage;
	response.sendRedirect(go);
	
	
%>