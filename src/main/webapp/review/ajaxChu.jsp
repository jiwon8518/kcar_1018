<%@page import="org.json.simple.JSONObject"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	String num = request.getParameter("num");
	ReviewDao dao = new ReviewDao();
	
	// 추천수 +1
	dao.updateChu(num);
	
	// chu 값 json 형식으로 반환
	int chu = dao.getReviewData(num).getChu();
	JSONObject ob = new JSONObject();
	ob.put("chu", chu);
	
%>
<%= ob.toString() %>