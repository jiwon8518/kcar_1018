<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//admin
String email = (String)session.getAttribute("myid");
//로그인상태 확인
String loginok = (String)session.getAttribute("loginok");
String admin = "admin";



	
 	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	if(currentPage == null)
		currentPage = "1";
	
	
	//key는 목록에서만 값이 넘어오고 그 이외는 null값
	String key = request.getParameter("keydsds");
	
	ProductDao dao = new ProductDao();
	
	//목록에서 올 경우 조회수 1 증가
	if(key != null)
		dao.updateReadcount(num);
	
	//num해당 dto
	ProductDto dto = dao.getData(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<div style="background-color: white; height: 100px;">

</div>
<table style="margin-left: 80px; top: 200px;">
	<caption><b>TestPage</b></caption>
	<tr>
		<td>
			<%=dto.getContent() %>
			<%=dto.getNum() %>
		</td>
	</tr>
</table>
	
	<%
if(admin.equals(email)){%>
	
	<div>

 		<button type="button" class="btn btn-info btn-xs"
		style="margin-right: 20px;"
		onclick="location.href='index.jsp?main=product/updataform.jsp?num=<%=dto.getNum()%>'">
		<span class="glyphicon glyphicon-pencil">수정</span></button>

 		<button type="button" class="btn btn-info btn-xs" style="margin-right: 20px;"
 		onclick="removeCheck()"
		>
		<span class="glyphicon glyphicon-pencil"
		>삭제</span></button>
	</div>

<%}
%>
<script type="text/javascript">
function removeCheck() {

	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인

		 location.href = 'product/delete.jsp?num=<%=dto.getNum()%>';

	 }else{   //취소

		return;
	 }

	}
</script>
</body>
</html>