<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<title>Insert title here</title>
</head>
<%
String login = (String)session.getAttribute("loginok");
String myid = (String)session.getAttribute("myid");
%>
<body>
<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
		id="ftco-navbar" >
		<div class="container">
			<a class="navbar-brand" href="index.jsp">MyCar <span>store</span></a>
			<div class="order-lg-last btn-group">
				<a href="#" class="btn-cart dropdown-toggle dropdown-toggle-split"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				</a>
				 <div class="dropdown-menu dropdown-menu-right">
					<div class="dropdown-item d-flex align-items-start" href="#">

					</div>
					<div class="dropdown-item d-flex align-items-start" href="#">
					</div>
					<div class="dropdown-item d-flex align-items-start" href="#">

					</div>

				</div>
			</div> 

			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#ftco-nav" aria-controls="ftco-nav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a href="index.jsp"
						class="nav-link">Home</a></li>
					<li class="nav-item"><a href="index.jsp?main=about/about.jsp" class="nav-link">About</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="dropdown04"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Products</a>
						<div class="dropdown-menu" aria-labelledby="dropdown04">
							<a class="dropdown-item" href="index.jsp?main=product/productform.jsp">Products</a> 
							<a class="dropdown-item reservation">Reservation</a>
							<a class="dropdown-item reservation2">Reservation Confirm</a>  
 						</div>
					</li>
					<li class="nav-item"><a href="index.jsp?main=event/eventlist.jsp" class="nav-link">Event</a></li>
						<li class="nav-item"><a href="index.jsp?main=review/reviewMain.jsp" class="nav-link">review</a></li>
					<li class="nav-item"><a href="index.jsp?main=service/servicemain.jsp" class="nav-link">CustomerService</a></li>
				</ul>
			</div>
		</div>
	</nav>
<script type="text/javascript">
$(".reservation").click(function() {
	if("<%=login%>" != 'yes'){
		alert("로그인이 필요한 페이지입니다.")
		location.href = 'index.jsp?main=login/loginMain.jsp';
		return;
	}else{
	 location.href = 'index.jsp?main=reservation/reservationform.jsp';
	}
});
$(".reservation2").click(function() {
	if("<%=login%>" != 'yes'){
		alert("로그인이 필요한 페이지입니다.")
		location.href = 'index.jsp?main=login/loginMain.jsp';
		return;
	}else{
	 location.href = 'index.jsp?main=reservation/reservationlist2.jsp';
	}
});
</script>
</body>
</html> 