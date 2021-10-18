<%@page import="data.dto.WinboardDto"%>
<%@page import="data.dao.WinboardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 body{
 	font-family: 'Noto Sans KR', sans-serif;
 	background-color: WhiteSmoke;
 }
</style>
</head>
<body>
<%
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	if(currentPage==null)
		currentPage="1";
	//key는 목록에서만 값이 넘어오고 그 이외는 null값
	String key = request.getParameter("key");
	
	WinboardDao dao = new WinboardDao();
	//목록에서 들어올 경우에만 조회수 1 증가한다
	if(key!=null)
		dao.updateReadcount(num);
	
	//num 에 해당하는 dto 얻기
	WinboardDto dto = dao.getData(num); 
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	String myid="";
	String name ="";
	String loginok="";
	//로그인 상태 확인후 입력폼 나타내기
	if(session.getAttribute("loginok")!=null){
		loginok = (String)session.getAttribute("loginok");
		
		myid = (String)session.getAttribute("myid");
	}
	
%>
<div class="container">
<h1>당첨자 발표</h1>

<table class="table table-bordered" style="width: 600px; border-radius: 20px;
		-moz-border-radius: 20px;
		-khtml-border-radius: 20px;
		-webkit-border-radius: 20px;
		margin-top:30px;
		margin-bottom:30px;">
	<tr style="background-color: silver;">
		<th>
			<span style="color: black; font-size: 1.7em;"><b><%=dto.getSubject() %></b></span>
		</th>
	</tr>
	<tr>
		<td style="text-align:right;">
			<span style="color: black; font-size: 11pt; margin-left: 30px;">
			운영자 : <%=dto.getWriter() %></span>
			<span style="color: gray; font-size: 10pt; margin-left: 30px;">
			조회 <%=dto.getReadcount() %></span>
			<br>
			<span style="color: gray; font-size: 10pt; margin-left: 30px;">
				당첨자 발표일  <%=sdf.format(dto.getWriteday()) %>
				&nbsp;&nbsp;&nbsp;
			</span>
		</td>
	</tr>
	<tr>
		<td height="400px;">
			<%=dto.getContent() %>
		</td>
	</tr>
	<tr>
		<td align="center">
		<%
			//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 글쓰기 버튼 보이게한다.
			if(loginok!=null && myid.equals("admin")){%>
			<button type="button" class="btn btn-sm btn-info"
			style="width: 80px;"
			onclick="location.href='index.jsp?main=event/winform.jsp'">글쓰기</button>
			
			<button type="button" class="btn btn-sm btn-info"
			style="width: 80px;"
			onclick="location.href='index.jsp?main=event/winupdate.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>'">수정</button>

			<button type="button" class="btn btn-sm btn-info"
			style="width: 80px;"
			onclick="removeCheck()">삭제</button>
			<%} %>
			<button type="button" class="btn btn-sm btn-info"
			style="width: 80px;"
			onclick="location.href='index.jsp?main=event/winboard.jsp?currentPage=<%=currentPage%>'">목록</button>	
					
		</td>
	</tr>
</table>
</div>
<script type="text/javascript">
function removeCheck() {

	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인

		 location.href = 'event/windelete.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>';

	 }else{   //취소

		return;
	 }

	}
</script>
</body>
</html>
































