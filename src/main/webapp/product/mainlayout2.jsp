<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.EventDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.EventDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Liquor Store - Free Bootstrap 4 Template by Colorlib</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css2?family=Spectral:ital,wght@0,200;0,300;0,400;0,500;0,700;0,800;1,200;1,300;1,400;1,500;1,700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="css/animate.css">

<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/magnific-popup.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css">

<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/style.css">
</head>
<%

EventDao edao = new EventDao();

List<EventDto> elist = edao.List();

SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월dd일 HH:mm z");



%>
<body>
	<div class="sidebar-box ftco-animate">
		<h3>Event</h3>
		
		<%
		int n = 0;
		for(EventDto edto:elist){
			if(n>=2){break;}%>		
		<div class="block-21 mb-4 d-flex">
			<a class="blog-img mr-4"
				style="background-image: url('/Team/save/<%=edto.getPhotoname()%>'),url('./images/image_4.jpg');"></a>
			<div class="text">
				<h3 class="heading">
					<a href="#"><%=edto.getSubject()%></a>
				</h3>
				<div class="meta">
					<div>
						<a href="#"><span class="fa fa-calendar"></span> <%=sdf.format(edto.getWriteday())%></a>
					</div>
					<div>
						<a href="#"><span class="fa fa-comment"></span> <%=edto.getReadcount()%></a>
					</div>
				</div>
			</div>
		</div>
		<%}
		%>
		<div class="container">
		<div class="row justify-content-center" style="height: 500px;">
			<form action="index.jsp?main=product/productform.jsp?go=searchaction.jsp" method="post"
				class="billing-form" onsubmit="return check(this)">
				<input type="text" placeholder="검색할 차종,모델명을 입력하세요" name="search" style="width: 270px;"
					class="inputInfo" id="pw" required><br>
					<div style="height: 20px;"></div>
 				<p>
					<button type="submit" id="btn1" class="btn btn-primary py-3 px-4" style="width: 270px; height: 50px; text-align: center;">
						검색</button>
				</p> 
<!-- 				<p>
					<a href="index.jsp?main=product/productform.jsp?go=searchaction.jsp" class="btn btn-primary py-3 px-4">Reservation Confirm</a>
				</p> -->
			</form>
		</div>
	</div>
					</div>
					
					
					
						<script src="js/jquery.min.js"></script>
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="js/google-map.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
	<script src="js/main.js"></script>
					
</body>
</html>