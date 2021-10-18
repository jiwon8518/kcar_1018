<%@page import="data.dao.WinboardDao"%>
<%@page import="data.dto.WinboardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//데이터 읽어서 dto 에 넣기
	WinboardDto dto = new WinboardDto();
	dto.setWriter(request.getParameter("writer"));
	dto.setSubject(request.getParameter("subject"));
	dto.setContent(request.getParameter("content"));
	
	//db insert
	WinboardDao dao = new WinboardDao();
	dao.insertWinboard(dto);
	
	//일단 목록으로 간 다음 나중에 detail 페이지로 가는거로 수정하기
	/*String path="../index.jsp?main=board/boardlist.jsp";
	response.sendRedirect(path);   */
	
	//방금 추가된 num 값 얻기
	String num = dao.getMaxNum();
	String path="../index.jsp?main=event/windetail.jsp?num="+num;
	response.sendRedirect(path);   
	
%>