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
 <script type="text/javascript">
	$(function() {
		$(document).on("change", "#date", function() {

			var writer2 = "";
			writer2 = $(this).val();
			/* alert(writer2);	 */
			$("#tex1").html(writer2);
		});
	});
	$(function() {
		$(document).on("change", "#carname", function() {

			var writer2 = "";
			writer2 = $(this).val();
			/* alert(writer2);	 */
			$("#tex2").html(writer2);
		});
	});
	

</script>
</head>
<%
String email = (String) session.getAttribute("myid");
LoginDao dao = new LoginDao();
LoginDto dto = dao.getUserInfo(2, email);
System.out.println(dto.getEmail());

ProductDao pdao = new ProductDao();
/* 	String writer = request.getParameter("writer"); */

List<ProductDto> list = pdao.getAllDatas();
%>
<body>


	<!-- <section class="ftco-section"> -->
		<div class="container">
			<div class="row justify-content-center">
	<form action="reservation/reservationaction.jsp" method="post" class="billing-form"
		 onsubmit="return confirm('예약하시겠습니까?');">
				<div class="col-xl-10 ftco-animate">
					<h3 class="mb-4 billing-heading">Reservation</h3>
					<div class="row align-items-end">
						<div class="col-md-6">
							<div class="form-group">
								<label for="firstname">Name</label> 
								<input type="text"
									class="form-control" name="name" required="required"
									placeholder="이름을 입력하세요" value="<%=dto.getName()%>">
							</div>
						</div>
						<div class="w-100"></div>
						<div class="col-md-12">
							<div class="form-group">
								<label for="country">Car Name</label>
								<div class="select-wrap">
									<div class="icon">
										<span class="ion-ios-arrow-down"></span>
									</div>
									<select name="carname" id="carname" required="required"
									 class="form-control">
										<%
										for (ProductDto pdto : list) {
										%>
										<option value="<%=pdto.getSubject()%>"><%=pdto.getSubject()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
						</div>

						<div class="w-100"></div>
						<div class="col-md-12">
							<div class="form-group">
								<label for="country">Date</label>
								<div class="select-wrap">
									<div class="icon">
										<span class="ion-ios-arrow-down"></span>
									</div>
									<input type="text" class="form-control" name="date" required id="date"
										placeholder="날짜를 입력하세요" value="2021-11-12">
								</div>
							</div>
						</div>

						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="streetaddress">Street Address</label> 
								<input
									type="text" class="form-control" value="<%=dto.getAddr1()%>"
									placeholder="House number and street name" name="addr1"
									required style="color: black;">
							</div>
						</div>
						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="towncity">Town / City</label> 
								<input type="text"
									class="form-control" value="<%=dto.getAddr2()%>"
									placeholder="" name="addr2" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="postcodezip">Postcode / ZIP *</label> 
								<input
									type="text" class="form-control"
									value="<%=dto.getPostcode()%>" placeholder="" name="postcode"
									required="required">
							</div>
						</div>
						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="phone">Phone</label> 
								<input type="text"
									class="form-control"
									value="<%=dto.getMobile1()%>-<%=dto.getMobile2()%>-<%=dto.getMobile3()%>"
									placeholder="" name="phone" required="required">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="emailaddress">Email Address</label> 
								<input
									type="text" class="form-control" value="<%=dto.getEmail()%>"
									placeholder="" name="email" required="required">
							</div>
						</div>

						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<input type="hidden" class="form-control"
									value="<%=dto.getPw()%>" placeholder="" name="pw" required="required">
							</div>
						</div>
						<div class="w-100"></div>

					</div>
					<!-- END -->


					<div class="row mt-5 pt-3 d-flex">
						<div class="col-md-6 d-flex">
							<div class="cart-detail cart-total p-3 p-md-4">
								<h3 class="billing-heading mb-4">Total</h3>
								<p class="d-flex">
									<span>Model</span> <span id="tex1"></span>
								</p>
								<p class="d-flex">
									<span>Date</span> <span id="tex2"></span>
								</p>
								<hr>
								<p class="d-flex total-price">
									<span>예약하시겠습니까?</span> <span> </span>
								</p>
								<p>
									<button type="submit" id="btn1" class="btn btn-primary py-3 px-4" 
									>Make
										An Appointment</button>
								</p>
							</div>
						</div>

					</div>
				</div>
				<!-- .col-md-8 -->
 </form>
			</div>
		</div>
		<!--    </section> -->


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