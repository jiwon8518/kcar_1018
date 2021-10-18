<%@page import="java.io.File"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String num = request.getParameter("num");
	
	ReviewDao dao = new ReviewDao();
	// 글번호에 대한 포토네임
	String photoname = dao.getReviewData(num).getPhotoname();
	// 글번호에 대한 게시글 삭제
	dao.reviewdel(num);
	
	// 프로젝트 실제 경로 구하기
	String realPath = getServletContext().getRealPath("/save");
	// 파일 객체 생성
	File file = new File(realPath+"\\"+photoname);
	// 파일 삭제
	file.delete();
	
	// 페이지 이동
	String move = "../index.jsp?main=review/reviewMain.jsp?";
	response.sendRedirect(move);
	
%>