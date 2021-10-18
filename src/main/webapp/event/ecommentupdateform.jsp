<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String idx = request.getParameter("idx");
String num = request.getParameter("num");
String currentPage = request.getParameter("currentPage");
%>
<body>
<div class="ecommnetform">
	<form action="event/ecommentupdateaction.jsp" method="post">
		<input type="hidden" name="idx" value="<%=idx%>">
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		<input type="hidden" name="num" value="<%=num%>">
		<table>
			 <tr>
				<td width="480">
				<textarea style="width: 730px;height: 70px;"
				name="content" required="required"
				class="form-control"></textarea>
				</td>
				<td>
				<button type="submit" class="btn btn-info"
				style="width: 70px;height:70px;">등록</button>
				</td>
			</tr>
		</table>
	</form>	
</div>
</body>
</html>