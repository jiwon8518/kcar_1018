<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<title>Kcar</title>
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
<!-- <link rel="stylesheet" href="css/loginMain.css">
<link rel="stylesheet" href="css/joinForm.css"> -->

<!-- <link rel="stylesheet" href="css/login.css"> -->

<style type="text/css">
	
	
	
</style>
</head>
<%

	String mainPage = "layout/main.jsp"; //기본페이지
	String mainPage3 = "layout/maintemp.jsp"; //기본페이지
	String mainPage2 = "login/loginMain.jsp"; //기본페이지
	//여기 dmf xhdgotj main 값을 읽어 메인페이지에 출력한다.
	if(request.getParameter("main") != null ){
		mainPage = request.getParameter("main");
	}
	
%>
<body>
<div>
	<div class = "layout title">
		<jsp:include page="layout/title.jsp"/>
	</div>

	<div class = "layout title">
		<div style="background-color: black; width: 100%; height: 100px;" >
			<jsp:include page="layout/header.jsp"/>
		</div>
	</div>
</div>
		
	<div class = "layout main">
		<jsp:include page="<%=mainPage%>"/>
	</div> 

	
 	<div class = "layout footer">
		<jsp:include page="layout/footer.jsp"/>
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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="js/google-map.js"></script>
<script src="js/main.js"></script>
           
</body>
</html>