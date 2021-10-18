<%@page import="data.dao.LoginDao"%>
<%@page import="data.dto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//회원정보
	String name = request.getParameter("name");
	name=new String(name.getBytes("8859_1"),"UTF-8");
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	String postcode = request.getParameter("postcode");
	String addr1 = request.getParameter("addr1");
	addr1=new String(addr1.getBytes("8859_1"),"UTF-8");
	String addr2 = request.getParameter("addr2");
	addr2=new String(addr2.getBytes("8859_1"),"UTF-8");
	String mobile1 = request.getParameter("mobile1");
	String mobile2 = request.getParameter("mobile2");
	String mobile3 = request.getParameter("mobile3");
	//값이 넘어오는지 체크
	System.out.println(name);
	System.out.println(email);
	System.out.println(pw);
	System.out.println(postcode);
	System.out.println(addr1 + " " + addr2);
	System.out.println(mobile1 + mobile2 + mobile3);
	
	//저장할 회원정보 생성
	LoginDto dto = new LoginDto(pw, email, name, postcode, addr1, addr2, mobile1, mobile2, mobile3);
	LoginDao dao = new LoginDao();
	dao.insertUser(dto); 
	response.sendRedirect("../index.jsp?main=login/newMember.jsp");
%>