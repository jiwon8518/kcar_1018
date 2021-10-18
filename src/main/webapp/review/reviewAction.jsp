<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dto.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% // reviewform action
	
	request.setCharacterEncoding("utf-8");
	
	// 세션으로 부터 db에 저장할 닉네임 얻기
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email); // email 로 유저정보 얻기

	// 데이터 읽기
	ReviewDto dto = new ReviewDto();
	dto.setCar(request.getParameter("car"));
	dto.setName(request.getParameter("name"));
	dto.setEmail(request.getParameter("email"));
	dto.setSubject(request.getParameter("subject"));
	dto.setContent(request.getParameter("content"));
	
	// db insert  하기
	ReviewDao dao = new ReviewDao();
	dao.insertReview(dto);
	
	// 디테일 페이지 이동
	String num = dao.getMaxNum();
	String path = "../index.jsp?main=review/reviewDetail.jsp?num="+num;
	response.sendRedirect(path);
	
%>