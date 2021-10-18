<%@page import="data.dto.EpartiDto"%>
<%@page import="data.dao.EpartiDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	//인코딩 post방식으로 넘겨받으면 해야함
	request.setCharacterEncoding("utf-8");
	//데이터 읽어서 dto 에 넣기
	EpartiDto dto = new EpartiDto();
	String num = request.getParameter("num");
	String myid = request.getParameter("myid");
	//페이지번호 읽기
	String currentPage = request.getParameter("currentPage");
	
	//db에서 체크
	EpartiDao dao = new EpartiDao();
	boolean check = dao.eCheck(myid,num);
	
	 if(check) {
		 String path="../index.jsp?main=event/eventdetail.jsp?check="+check+"&num="+num+"&currentPage="+currentPage+"&key=list";
 		response.sendRedirect(path);
     }else {
    	//데이터 읽어서 dto 에 넣기
    		dto.setNum(num);
    		dto.setMyid(myid);
    		dao.insertEparti(dto);
    	//다시 보던 목록 페이지로 이동
    		String path="../index.jsp?main=event/eventdetail.jsp?num="+num+"&currentPage="+currentPage+"&key=list";
    		response.sendRedirect(path);
     }
	
    
%>