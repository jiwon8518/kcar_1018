<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
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

<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/style.css">
</head>
<%
ReviewDao dao = new ReviewDao();

List<ReviewDto> list = dao.getTotal();

ProductDao dao2 = new ProductDao();

List<ProductDto> list2 = dao2.getTotal();
%>

<body>

	<section class="ftco-section ftco-no-pb">
		<div class="container">
			<div class="row">
				<div
					class="col-md-6 img img-3 d-flex justify-content-center align-items-center"
					style="background-image: url(images/222.JPG);"></div>
				<div class="col-md-6 wrap-about pl-md-5 ftco-animate py-5">
					<div class="heading-section">
						<span class="subheading">Since 1944</span>
						<h2 class="mb-4">Movement that inspires</h2>

						<p>
							기아는 자동차 제조의 긴 역사를 가지고 있습니다.<br> 보다 정확하게는 1944년에 자전거를 만드는 것으로
							시작하여<br> 이후 75년이 넘는 시간동안 사람들에게 이동 수단을 제공해 왔습니다.<br> 이를
							통해 도시와 도시, 사람과 사람을 연결하며<br> 물리적, 감정적 거리에서 자유로워지도록 노력해왔습니다.<br>


							사람들을 움직이게 하는 것은 우리 업(業)의 중심이었으며<br> 이는 미래 자동차 산업 변화에도 변치 않을
							것입니다.
						</p>
						<p class="year">
							<strong class="number" data-number="75">0</strong> <span>Years
								Of History.</span>
						</p>
					</div>

				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section">
		<div class="container">
			<div class="row">
				<%
				ProductDto pdto = new ProductDto();

				for (int i = 0; i < 6; i++) {
					ProductDto sdto = list2.get(i);
				%>
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img"
							style="background-image: url(save/<%=sdto.getPhotoname()%>);"></div>
						<h3><%=sdto.getSubject()%></h3>
					</div>
				</div>

				<%
				}
				%>
			</div>
		</div>
	</section>


	<section class="ftco-section testimony-section img"
		style="background-image: url(images/bg_02.jpg);">
		<div class="overlay"></div>
		<div class="container">
			<div class="row justify-content-center mb-5">
				<div
					class="col-md-7 text-center heading-section heading-section-white ftco-animate">
					<span class="subheading">k-car</span>
					<h2 class="mb-3">review</h2>
				</div>
			</div>
			<div class="row ftco-animate">
				<div class="col-md-12">
					<div class="carousel-testimony owl-carousel ftco-owl"
						style="font-family: 'Noto Sans KR:wght@100', sans-serif;">
						<%
						for (ReviewDto dto : list) {
						%>


						<div class="item">
							<div class="testimony-wrap py-4">
								<div
									class="icon d-flex align-items-center justify-content-center">
									<span class="fa fa-quote-left"></span>
								</div>
								<div class="text">
									<p class="mb-4"><%=dto.getSubject()%>
									</p>
									<div class="d-flex align-items-center">
										<div class="user-img"
											style="background-image: url(images/person_1.jpg)"></div>
										<div class="pl-3">
											<p class="name"><%=dto.getName()%></p>
											<span class="position"><%=dto.getCar()%></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<%
						}
						%>


					</div>
				</div>
			</div>
		</div>
	</section>



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
	<script src="js/main.js"></script>

</body>
</html>