<%@page import="data.dao.EventDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.EventDto"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
</head>
<%
ReviewDao dao = new ReviewDao();

List<ReviewDto> list = dao.getTotal();

ProductDao dao2= new ProductDao();

List<ProductDto> list2 = dao2.getTotal();

EventDao edao = new EventDao();

List<EventDto> elist = edao.List();

SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월dd일 HH:mm z");

%>

<body>
 
	<div class="hero-wrap"
		style="background-image: url('images/bg_01.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-8 ftco-animate d-flex align-items-end">
					<div class="text w-100 text-center">
						<h1 class="mb-4">
						<span style="font-family: 'Noto Sans KR', sans-serif; font-size:20pt;">나만의 스토리</span>
							<span style="font-family: 'Noto Sans KR', sans-serif;">K-car<br></span>
							<span style="font-family: 'Noto Sans KR', sans-serif; font-size:20pt;">&nbsp;&nbsp;&nbsp;그 이상의 가치</span>
						</h1>
						<p>
							<a href="index.jsp?main=product/productform.jsp" class="btn btn-primary py-2 px-4">Shop Now</a> <a
								href="index.jsp?main=about/about.jsp" class="btn btn-white btn-outline-white py-2 px-4">Learn more</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<section class="ftco-intro">
		<div class="container" style="font-family: 'Noto Sans KR:wght@100', sans-serif;">
			<div class="row no-gutters">
				<div class="col-md-4 d-flex">
					<div class="intro d-lg-flex w-100 ftco-animate">
						<div class="icon">
							<span class="flaticon-support"></span>
						</div>
						<div class="text">
							<h2>온라인 상담</h2>
							<p>평일 오전 8:30 ~ 오후 6:00<br>고객센터 080-700-6000</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 d-flex">
					<div class="intro color-1 d-lg-flex w-100 ftco-animate">
						<div class="icon">
							<span class="flaticon-cashback"></span>
						</div>
						<div class="text">
							<h2>이달의 구매혜택</h2>
							<p>car care+ 1년권 제공<br>5% 캐시백 이벤트</p>
						</div>
					</div>
				</div>
				<div class="col-md-4 d-flex">
					<div class="intro color-2 d-lg-flex w-100 ftco-animate">
						<div class="icon">
							<span class="flaticon-free-delivery"></span>
						</div>
						<div class="text">
							<h2>무료 배송서비스</h2>
							<p>지정 장소로 무료 배달 서비스 이용 가능</p>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-no-pb">
		<div class="container">
			<div class="row">
				<div
					class="col-md-6 img img-3 d-flex justify-content-center align-items-center"
					style="background-image: url(images/mohave.webp);"></div>
				<div class="col-md-6 wrap-about pl-md-5 ftco-animate py-5" style="font-family: 'Noto Sans KR:wght@100', sans-serif;">
					<div class="heading-section">
						<span class="subheading">Since 1905</span>
						<h2 class="mb-4">욕망은 새 차를 만난다</h2>

						<p>"파워풀한 주행성능과<br>
						고객과 교감하는 다양한<br>
						핵심기능을 통해 럭셔리 전기차의<br>
						새로운 기준을 제시합니다"</p>
						<p>
						디자인 정체성인 ‘역동적인 우아함(Athletic Elegance)’을 바탕으로 쿠페형 CUV 스타일의 날렵하고 다이내믹하면서 가장 역동적인 디자인으로 고성능 EV 이미지를 강조했습니다.
						</p>
						
						<p>Gloval Head of K-car brand</p>
						<p class="year">
							<strong class="number" data-number="115">0</strong> <span>년의 비즈니스 경험</span>
						</p>
					</div>

				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-no-pb">
		<div class="container" style="font-family: 'Noto Sans KR:wght@400', sans-serif;">
			<div class="row">
		<%
		int no = 0;
		for(ProductDto sdto:list2){
				if(no>=6)	{break;}	
		%>
				<div class="col-lg-2 col-md-4 ">
					<div class="sort w-100 text-center ftco-animate">
						<div class="img" style="background-image: url(save/<%=sdto.getPhotoname() %>);"></div>
						<h3><%=sdto.getSubject() %></h3>
					</div>
				</div>

		<%no++;}
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
					<div class="carousel-testimony owl-carousel ftco-owl" style="font-family: 'Noto Sans KR:wght@100', sans-serif;">
						<%
						for(ReviewDto dto:list){%>
							
						
						<div class="item">
							<div class="testimony-wrap py-4">
								<div
									class="icon d-flex align-items-center justify-content-center">
									<span class="fa fa-quote-left"></span>
								</div>
								<div class="text">
									<p class="mb-4"><%=dto.getSubject() %>
									</p>
									<div class="d-flex align-items-center">
										<div class="user-img"
											style="background-image: url(images/profile.PNG)"></div>
										<div class="pl-3">
											<p class="name"><%=dto.getName() %></p>
											<span class="position"><%=dto.getCar() %></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<%}
						%>
	
					
					</div>
				</div>
			</div>
		</div>
	</section>



	<section class="ftco-section" style="font-family: 'Noto Sans KR:wght@100', sans-serif;">
		<div class="container">
			<div class="row justify-content-center mb-5">
				<div class="col-md-7 heading-section text-center ftco-animate">
					<span class="subheading">Event</span>
					<h2>시승 이벤트</h2>
			</div>
			</div>
			<div class="row d-flex">
			
			<%
			int n = 0;
			for(EventDto edto: elist){
				if(n>=4){break;}
			%>
				<div class="col-lg-6 d-flex align-items-stretch ftco-animate">
					<div class="blog-entry d-flex">
						<a href="blog-single.jsp" class="block-20 img"
							style="background-image: url('/Team/save/<%=edto.getPhotoname()%>'),url('./images/image_4.jpg');"> </a>
						<div class="text p-4 bg-light">
							<div class="meta">
								<p>
									<span class="fa fa-calendar"></span> <%=sdf.format(edto.getWriteday())%>
								</p>
							</div>
							<h3 class="heading mb-3">
								<a href="index.jsp?main=event/eventdetail.jsp?num=<%=edto.getNum()%>">
								
							<%if(edto.getSubject().length() >= 20){%>
							<%=edto.getSubject().substring(0, 20)%>
							<% }else{%>
							<%=edto.getSubject()%>
							<%} %>
								
								</a>
							</h3>
							<p>
							<%if(edto.getContent().length() >= 70){%>
								<%=edto.getContent().substring(0, 70)%>
							<% }else{%>
							<%=edto.getContent()%>
							<%} %>
							</p>
							<a href="index.jsp?main=event/eventlist.jsp" class="btn-custom">Continue <span
								class="fa fa-long-arrow-right"></span></a>

						</div>
					</div>
				</div>
			<%n++;} %>
				
				
			</div>
		</div>
	</section>
	

</body>
</html>