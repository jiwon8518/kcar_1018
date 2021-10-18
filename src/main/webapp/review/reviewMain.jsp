<%@page import="javax.swing.text.Document"%>
<%@page import="java.util.ArrayList"%>
<%@page import="data.dao.RcommentDao"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<style type="text/css">
div.bg {
	margin: 0 auto;
	width: 940px;
	display: block;
}
h3>p {
	font-size: 30px;
	color: #05141f;
	line-height: 30px;
}
.no {
	text-align: center;
	font-size: 20pt;
	padding: 8px;
	width: 50px;
}
.subject {
	font-size: 18px;
	cursor: pointer;
	color: #333;
	font-weight: bold;
	padding: 8px;
	text-decoration: none;
}
.subject:hover {
	color: #333;
	text-decoration: none;
}
tr {
	height: 30px;
	width: 500px;
	line-height: 18px;
}
.text {
	font-size: 13px;
}
table.list {
	width: 1000px;
	margin-bottom: 50px;
}
#write {
	margin-top: 30px;
	background-color: #05141f;
	color: #fff;
	width: 80px;
	height: 40px;
}
#write:hover {
	background-color: #697279;
	color: #fff;
}
#topBtnImg{
	width: 30px;
	height: 100%;
	cursor: pointer;
}
#topBtn{
	 margin-left: 850px;
	 margin-bottom: 100px;
}
</style>
</head>
<%
	
	String reviewlist = "reviewList.jsp";
	if(request.getParameter("list") !=null){
		reviewlist = request.getParameter("list");
	}
	
%>
<script type="text/javascript">
$(function () {
	//top button controll
	$("#topBtnImg").click(function() {
		$("html, body").animate({scrollTop:0}, "300");
	});
});
</script>

<body>
<div class="bg">
	<!-- 시승 후기 게시판 -->
	<div class="title" style="margin-bottom: 30px;">
		<h3><p>시승 후기 게시판</p></h3>
	</div>
	<div style="margin-bottom: 50px;">
		<p>고객님의 소중한 리뷰가 큰 힘이 됩니다.</p>
	</div>
	
	<!-- 검색 -->
	<div>
		<jsp:include page="reviewSearch.jsp"/>
	</div>
	
	<!-- 리스트 -->
	<div>
		<jsp:include page="<%= reviewlist %>"/>
	</div>
</div>
</body>
</html>