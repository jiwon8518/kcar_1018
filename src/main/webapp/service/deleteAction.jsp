<%@page import="data.dto.ServiceDto"%>
<%@page import="java.io.File"%>
<%@page import="data.dao.ServiceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("deleteAction");
	//필요값얻기
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	
	//dao선언
	ServiceDao dao = new ServiceDao();
	//dto선언
	ServiceDto dto = dao.getData(num);
	//파일삭제
	String filename = dao.getData(num).getFile();
	if(!filename.equals("no")){
		//파일실제경로
		String realPath = getServletContext().getRealPath("/files");
		File file = new File(realPath+"\\"+filename);
		//파일삭제
		System.out.println(realPath+"\\"+filename);
		file.delete();
		System.out.println("파일삭제");
	}
	System.out.println(filename);
	
	//글삭제
	boolean isOriginal = dao.isOriginal(dto);
	dao.deleteContent(num, dto.getRef(), isOriginal);
	
%>