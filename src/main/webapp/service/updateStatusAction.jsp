<%@page import="SendEmail.SendEmail"%>
<%@page import="data.dto.ServiceDto"%>
<%@page import="data.dao.ServiceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("updateStatusAction");
	//진행상태 수정할 게시글번호 얻기
	String num = request.getParameter("num");
	ServiceDao dao = new ServiceDao();
	ServiceDto dto = dao.getData(num);
	dao.updateStatus(num);
	
	//답변등록 완료 이메일 발송
	SendEmail send = new SendEmail();
	String subject = "고객님이 문의하신 질문에 대한 답변이 등록되었습니다.";
	String text = "답변이 완료되었습니다 감사합니다.";
	send.sendEmailToUser(dto.getEmail(), subject, text);
	System.out.println("답변 메일 발송완료");
	
%>