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
section.container {
	margin-bottom: 50px;
}
section.container span.model {
	margin-right: 10px;
	font-size: 15pt;
}
#searchCar {
	width: 150px;
	height: 50px;
}
#btn {
	width: 70px;
	height: 50px;
	margin-top: 5px;
}
button.all {
	margin-right: 500px;
	background-color: #05141f;
	color: #fff;

}
button.all:hover {
	background-color: #697279;
	color: #fff;
}
</style>
</head>
<%

	request.setCharacterEncoding("UTF-8");
	String searchCar = request.getParameter("searchCar");

	ReviewDao dao = new ReviewDao();
	//페이징 처리에 필요한 변수선언
	int perPage = 10; // 한페이지에 보여질 글의 갯수
	int totalCount; //총 글의 수
	int currentPage; //현재 페이지번호
	int totalPage; // 총 페이지 수
	int start; // 각페이지에서 불러올 db 의 시작번호
	int perBlock = 5; // 몇개의 페이지번호씩 표현할 것인가
	int startPage; //각 블럭에 표시할 시작 페이지
	int endPage; //각 블럭에 표시할 마지막 페이지

	//총 갯수
	totalCount = dao.getTotalCount();
	//현재 페이지번호 읽기(단 null 일경우는 1페이지로 설정)
	if (request.getParameter("currentPage") == null)
		currentPage = 1;
	else
		currentPage = Integer.parseInt(request.getParameter("currentPage"));

%>

<body>

<div class="bg">
	<!-- 검색 -->
	<section class="container">
		<form action="index.jsp?main=review/reviewMain.jsp?list=reviewList2.jsp" method="post" class="form-inline mt-3" onsubmit="submitContents(this)">
		<button type="button" class="btn btn-default all" onclick="location.href='index.jsp?main=review/reviewMain.jsp?currentPage=<%= currentPage%>'">전체보기</button>
			<span class="model">시승모델</span>
			<select name="searchCar" id="searchCar" class="form-control mx-1 mt-2">
				<option value="ev">ev</option>
				<option value="rv">rv</option>
				<option value="seungyoung">seungyoung</option>
				<option value="saungyoung">saungyoung</option>
			</select>
			<button type="submit" id="btn" class="btn btn-default">검색</button>
		</form>
	</section>
</div>

</body>
</html>