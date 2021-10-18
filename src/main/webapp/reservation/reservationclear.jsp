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


%>
<body>

	<div class="container">
		<div class="row justify-content-center">
			<form action="" method="post"
				class="billing-form" onsubmit="return check(this)">
				<div style="height: 50px;"></div>
				<h3 class="mb-4 billing-heading">Reservation complete</h3>

				<div class="cart-detail cart-total p-3 p-md-4" style="width: 650px;">
					<h3 class="billing-heading mb-4">Reservation</h3>
					<p class="d-flex">
						<span>Name :</span><%=dto.getName()%><span id="tex1">님</span>
					</p>
					<p class="d-flex">
						<span>Date :</span><span id="tex2"></span>
					</p>
					<hr>
					<p class="d-flex total-price">
						<span>예약이 완료되었습니다</span> <span> </span>
					</p>
					<p>
					<a href="index.jsp?main=reservation/reservationlist2.jsp"class="btn btn-primary py-3 px-4">Reservation Confirm</a>
					</p>
				</div>
			</form>
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