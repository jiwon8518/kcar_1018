<%@page import="java.io.File"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	
	ProductDao dao = new ProductDao();
	String photoname = dao.getData(num).getPhotoname();
	
	//db delete
	dao.deleteProduct(num);
	
	
	
	//*********이미지 파일의 경로 찾아서 구하기*****************
	
	//파일삭제   ??????
	String realPath = getServletContext().getRealPath("/save");
	//getServletContext():getRealPath()라는 메서드를 포함하고 있는 대표적인 메서드?반환타입
			//톰캣 경로 위치를 구하는 방법
	
	//파일 객체 생성      ???????
	File file = new File(realPath + "\\" + photoname);
	// file=  /save\\car1-1.JPG(이미지가 저장된 경로)
	
	
	
	
	//파일삭제 
	file.delete();
	
	 String go = "../index.jsp?main=product/productform.jsp?go=ev.jsp";
	response.sendRedirect(go); 
	//지정한 페이지로 이동
%>