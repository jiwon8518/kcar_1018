<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	// 읽기
	String num = request.getParameter("num");
	String car = request.getParameter("car");
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");

	// dto에 넣기
	ReviewDto dto = new ReviewDto();
	dto.setNum(num);
	dto.setCar(car);
	dto.setName(name);
	dto.setSubject(subject);
	dto.setContent(content);

	// db update 메서드 호출
	ReviewDao dao = new ReviewDao();
	dao.updateReview(dto);

	// 디테일 페이지 이동
	String path = "../index.jsp?main=review/reviewDetail.jsp?num=" + num;
	response.sendRedirect(path);
%>