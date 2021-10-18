<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.EventDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.EpartiDao"%>
<%@page import="data.dto.EpartiDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<title>Insert title here</title>
<style type="text/css">
.container{
	text-align: center;
}

.listbox{
	display: inline-block;
	width: 600px;
	height: 100%;
	border-radius: 20px;
	-moz-border-radius: 20px;
	-khtml-border-radius: 20px;
	-webkit-border-radius: 20px;
	background-color: white;
	margin-top: 40px;
	margin-bottom: 40px;
	text-align:left;
	padding: 30px 30px 30px 30px;
}
body{
	font-family: 'Noto Sans KR', sans-serif;
 	background-color: WhiteSmoke;
}
.box{
	float:left;
}

</style>
<script type="text/javascript">
$(function(){
	$("span.epdel").click(function(){
		var idx=$(this).attr("idx");
		let cancel = confirm("삭제하시겠습니까?");
		if(cancel){
			$.ajax({
				type:"get",
				dataType:"html",
				url:"event/epartidelete.jsp",
				data:{"idx":idx},
				success:function(data){
					//새로고침
					location.reload();
				}
			});
		});
	}
		
});
</script>
<%
String num = request.getParameter("num");

EventDto dto = new EventDto();
EpartiDto pdto = new EpartiDto();
EpartiDao pdao = new EpartiDao();
List<EpartiDto> plist=pdao.getAllEparti(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String myid="";
String loginok="";
if(session.getAttribute("loginok")!=null){
loginok = (String)session.getAttribute("loginok");
myid = (String)session.getAttribute("myid");
}
%>
</head>
<body>

<div class="container">
	<div class="listbox">
		<a href='index.jsp?main=event/eventlist.jsp'><i class='fas fa-angle-left' style='cursor:pointer;font-size:36px'></i></a>
		<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		참석자 리스트</span>
		
	
	<br>
	<span style="font-size:20pt;" num="<%=pdto.getIdx()%>">참석자(총&nbsp;<%=plist.size()%>명)<br></span>
	<%
   	for(EpartiDto eptdto: plist)
	{%>
	<hr>
		<div class="continer">
			<img style="border-radius: 70px;
					-moz-border-radius: 70px;
					-khtml-border-radius: 70px;
					-webkit-border-radius: 70px;
					overflow: hidden;
					width: 60px;
					height: 60px;"
					align="left"
					src="images/profile.PNG"/>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b><%=eptdto.getMyid() %></b>
			<%
			//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 수정,삭제 보이게한다.
			if(loginok!=null && myid.equals("admin")){
			%>
			<span class='far fa-file-excel epdel'idx="<%=eptdto.getIdx()%>"
			style="color:margenta;cursor: pointer;margin-left: 10px;margin-right:10px;">삭제&nbsp;</span>
			
			<%} %>
			<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=sdf.format(eptdto.getWriteday()) %></p>
		</div>
	<%}%>
		
	</div>
</div>

</body>
</html>