<%@page import="data.dao.ReservationDao"%>
<%@page import="data.dto.ReservationDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<style type="text/css">
#fonts, #fontss, #fontss2, #fontss3 {
	font-size: 1.5em;
	color: black;
}
</style>

</head>
<%
String email = (String) session.getAttribute("myid");
LoginDao dao = new LoginDao();
LoginDto dto = dao.getUserInfo(2, email);
System.out.println(dto.getEmail());

String name = dto.getName();
String pass = dto.getPw();


ReservationDao rdao = new ReservationDao();

List<ReservationDto> list = rdao.getList(name, pass);



%>
<body>

	

	<!-- <section class="ftco-section"> -->
	<div style="height: 50px;"></div>
	<div class="container">
		<div class="row justify-content-center">
				<div style="height: 50px;"></div>
				<div class="cart-detail cart-total p-3 p-md-4" style="width: 650px;">
					<h3 class="billing-heading mb-4" style="text-align: center;">Reservation complete</h3>
					<hr>
					<h3 class="billing-heading"  style="text-align: center; font-size: 20px;">
						<span>Name :</span><%=name%><span id="tex1">님</span>
					</h3>
					<hr>
 <%for(ReservationDto rdto:list){%> 
					<p class="d-flex">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;Model :</span><%=rdto.getName()%> <span id="tex2"></span>
					</p>
					<p class="d-flex">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;Address : </span><%=rdto.getAddr1() %><%=rdto.getAddr2() %><span id="tex2"> </span>
					</p>
					<p class="d-flex">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;Date :</span><%=rdto.getWriteday() %><span id="tex2"></span>
					</p>
					<hr>
 <%}
 	if(list.size()>0){%>
 
					<p class="d-flex total-price">
						<span>예약이 완료되었습니다</span> <span> </span>
					</p>
				</div>
		</div>
	</div>
<%} %>

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