<%@page import="data.dao.ServiceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>CUSTOMERSERVICE</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <!-- lodash 사용을 위한 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"
    integrity="sha512-WFN04846sdKMIP5LKNphMaWzU7YpMyCU245etK3g/2ARYbPK9Ub18eG+ljU96qKRCWh+quCY7yefSmlkQw1ANQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <!-- throttle사용을 위한 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.7.1/gsap.min.js"
    integrity="sha512-UxP+UhJaGRWuMG2YC6LPWYpFQnsSgnor0VUF3BHdD83PS/pOpN+FYbZmrYN+ISX8jnvgVUciqP/fILOXDjZSwg=="
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style>
body{
    background-color: white;
}
li{
    list-style: none;
}
a{
    text-decoration: none;
    color: #333;
}
.baseBtn {
	width: 250px;
	height: 40px;
	background-color: #333;
	border: 1px solid #333;
	cursor: pointer;
	color: white;
	
}
.baseBtn:hover {
	background-color: rgb(118, 118, 118);
	color: white;
	border: 1px solid rgb(118, 118, 118);
}
.inner{
	padding-top:50px;
	width: 1100px;
	height:600px;
	margin:0 auto;
	position: relative;
}
.inner .container{
	position: absolute;
	top: 20;
	left: 0;
}
.inner .container h1{
	width: 500px;
	text-align: center;
	margin-left: 300px;
	font-size: 30px;
	font-weight: bold;
    color: #05141f;
    line-height: 30px;
}


.inner .container .items a.link:hover{
	cursor: pointer;
}
.inner .container .items tr{
	height: 180px;
	
}
.inner .container .items td{
	border: 1px solid #333;
	width: 250px;
	text-align: center;
	padding-bottom: 20px;
}
.inner .container .hot-container{
    width: 500px;
    height: 250px;
    padding-top: 20px;
    margin-left: 300px ;
    font-size: 18px;
    font-weight: bold;
    
}
.inner .container .hot-container .hotKeyWord{
   
    font-size: 18px;
    color: #333;
    
}
.inner .item-container{
    width: 1100px;
    height: 500px;
    padding-top: 10px;
    position: relative;
}
.inner .item-container .items{
    position: absolute;
    left: 300px;
    top:80px;
    
	border-collapse:collapse;
	border: 1px solid #333;
	background-color: white;
    
}

.inner .item-container .process{
    position: absolute;
    left: 300px;
    top:80px;
    width: 500px;
    height: 360px;
	border: 1px solid #333;
	background-color: white;
    padding-top: 40px;

    
}
.inner .item-container .buttonContainer{
    width: 600px;
    height: 80px;
    margin-left: 265px;
    padding-left: 33px;
    padding-top: 15px;
}
.inner .item-container .buttonContainer .common{
}
.cs{
    width: 400px;
    height: 60px;   
    background-color: #333;
    margin-left: 50px;
    margin-bottom: 10px;
    border: 1px solid #333;
    text-align: left;
    padding-left: 150px;
    font-size: 18px;
    line-height: 60px;
    color: white;
    font-weight: bold;
}
.fade-In {
  opacity: 0;
}
</style>
</head>
<%
	ServiceDao dao = new ServiceDao();
%>
<body>
	<div class = "inner">
		<div class = "container">
			<h1>COSTOMER SERVICE</h1>
           <!--  <div class="hot-container">
                <ul class="hotKeyWord">
                <div>Q&A 조회수 TOP 5 게시물</div> 
                <li>
                    <a href=""><span class="listOrder">1</span></a>
                </li>
            </ul>
            </div> -->
			<div class="item-container">
                <div class="buttonContainer">
                    <button class="baseBtn common">메뉴</button>
                    <button class="baseBtn service-process">진행절차</button>
                </div>
                <div class="process">
                    <div class="cs fade-In" id="cs1"><span class = "glyphicon glyphicon-ok"></span>고객의 소리</div>
                    <div class="cs fade-In" id="cs2"><span class = "glyphicon glyphicon-ok"></span>상담접수</div>
                    <div class="cs fade-In" id="cs3"><span class = "glyphicon glyphicon-ok"></span>신속대응처리</div>
                    <div class="cs fade-In" id="cs4"><span class = "glyphicon glyphicon-ok"></span>해결</div>
                </div>
                <table class = "items">
                    <tr>
                        <td>
                        <a class = "link">
                            <img alt="Q&A" src="images/qna.PNG" class = "images qna"><br>	
                            <span class = "service qna">Q&A	</span> <br>
                        
                        </a>
                        </td>
                        <td>
                        <a  class = "link">
                            <img alt="Q&A" src="images/chat.PNG" class = "images chat" ><br>
                            <span class = "service chat" >채팅상담</span> <br>
                        </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <a>
                            <img alt="Q&A" src="images/call.PNG" class = "images"><br>
                            <span class = "service">콜센터</span> <br>
                            <span class = "service">02-2890-0500</span>
                            
                        </a>
                        </td>
                        <td>
                        <a>
                            <img alt="Q&A" src="images/call.PNG" class = "images"><br>	
                            <span class = "service">시승예약문의</span> <br>
                            <span class = "service">010-7895-0880</span>
                        </a>
                        </td>
                    </tr>
                    
                </table>
            </div>
			
		</div>
	</div>
	<script>
	
	//메뉴보여주기버튼
	$(".process").hide()
	$(".common").click(function() {
		$(".items").show()
		$(".process").hide()
		location.reload();
	});
	//과정 보여주기 버튼
	$(".service-process").click(function() {
		$(".process").show()
		$(".items").hide()
		//요소를 순서대로 보이게하기
		 const fadeEls = document.querySelectorAll(".fade-In");
		 fadeEls.forEach(function (fadeEl, index) { 
		   
		   // gsap.to(요소, 지속시간, 옵션);
		  gsap.to(fadeEl, 1, {
		    delay: (index + 1)*.7, // 0.7, 1.4, 2.1, 2.7
		    opacity: 1,
		  });
		 });
	});
	
	//Q&A게시판으로 이동
	$(".qna").click(function() {
		location.href = "index.jsp?main=service/qnalist.jsp";		
	})
	
	//채팅api실행
	$(".chat").click(function() {
		chat();
		alert("채팅이 활성화 되었습니다 화면 오른쪽 아래부분을 확인해주세요")	
	})
	//채팅api
	function chat() {
		var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
		(function(){
		var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
		s1.async=true;
		s1.src='https://embed.tawk.to/609cdaefb1d5182476b87984/1f5ibedp2';
		s1.charset='UTF-8';
		s1.setAttribute('crossorigin','*');
		s0.parentNode.insertBefore(s1,s0);
		})();
	}	
	</script>
	
</body>
</html>