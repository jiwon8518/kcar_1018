<%@page import="java.util.ArrayList"%>
<%@page import="data.dao.RcommentDao"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<style type="text/css">
div.bg {
	margin: 0 auto;
	width: 940px;
	display: block;
}
h3>p {
	font-size: 30px;
	color: #05141f;
	line-height: 30px;
}
.no {
	text-align: center;
	font-size: 20pt;
	padding: 8px;
	width: 50px;
}
.subject {
	font-size: 18px;
	cursor: pointer;
	color: #333;
	font-weight: bold;
	padding: 8px;
	text-decoration: none;
}
.subject:hover {
	color: #333;
	text-decoration: none;
}
tr {
	height: 30px;
	width: 500px;
	line-height: 18px;
}
.text {
	font-size: 13px;
}
table.list {
	width: 1000px;
	margin-bottom: 50px;
}
#write {
	margin-top: 30px;
	background-color: #05141f;
	color: #fff;
	width: 80px;
	height: 40px;
}
#write:hover {
	background-color: #697279;
	color: #fff;
}
</style>

</head>

<%
	request.setCharacterEncoding("UTF-8");

	ReviewDao dao = new ReviewDao();
	// 페이징 처리에 필요한 변수선언
	int perPage = 10; // 한페이지에 보여질 글의 갯수
	int totalCount; //총 글의 수
	int currentPage; //현재 페이지번호
	int totalPage; // 총 페이지 수
	int start; // 각페이지에서 불러올 db 의 시작번호
	int perBlock = 5; // 몇개의 페이지번호씩 표현할 것인가
	int startPage; //각 블럭에 표시할 시작 페이지
	int endPage; //각 블럭에 표시할 마지막 페이지

	// 총 갯수
	totalCount = dao.getTotalCount();
	//현재 페이지번호 읽기(단 null 일경우는 1페이지로 설정)
	if (request.getParameter("currentPage") == null)
		currentPage = 1;
	else
		currentPage = Integer.parseInt(request.getParameter("currentPage"));

	// 총 페이지 갯수 구하기
	totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
	//
	startPage = (currentPage - 1) / perBlock * perBlock + 1;
	endPage = startPage + perBlock - 1;

	if (endPage > totalPage)
		endPage = totalPage;

	// 각 페이지에서 불러올 시작번호
	start = (currentPage - 1) * perPage;
	// 각 페이지에서 필요한 게시글 가져오기
	List<ReviewDto> list = dao.getReviewlist(start, perPage);

	if (list.size() == 0 && totalCount > 0) // 주의하기!!
	{%>
	<script type="text/javascript">
		location.href = "index.jsp?main=review/reviewMain.jsp?list=reviewList.jsp?currentPage=<%=currentPage-1%>";
	</script>
	<%}
		
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	int no=totalCount-(currentPage-1)*perPage;
	
	RcommentDao rdao = new RcommentDao();
	// 번호 읽어오기
	String num = request.getParameter("num");
%>

<body>
<div class="bg">
	<table class="list">
	<% 
	if(totalCount==0){
	%>
		<tr>
			<td style="text-align: center; font-size: 15pt;"><b>등록된 후기글이 없습니다</b></td>
		</tr>
	<%}else{
		for(ReviewDto dto:list)
		{%>
			<tr>
			<td rowspan="2" class="no"><%= no-- %></td>
			<td colspan="3"><a class="subject" href="index.jsp?main=review/reviewDetail.jsp?num=<%= dto.getNum() %>&currentPage=<%=currentPage%>&key=list"><%= dto.getSubject() %></a>
			<% 
			if(rdao.getCount(dto.getNum())==0){
			%>
			<span></span><!-- 댓글수0 일때 아무것도X -->
		<%}else {%>
				<span style="color:red; font-size: 10pt;">[<%= rdao.getCount(dto.getNum())%>]</span>
		<% } %>
			</td>
		</tr>
		<tr>
			<td class="text" width="80">작성일 | <%=sdf.format(dto.getWriteday())%></td>
			<td class="text" width="100">작성자 | <%=dto.getName()%></td>
			<td class="text" width="100">모델 | <%= dto.getCar() %></td>
			<td class="text" width="100">조회수 | <%=dto.getReadcount()%></td>
		</tr>
		<tr>
	 		<%}
		}%>
			<td colspan="3"></td>
			<td>
			</td>
		</tr>
	</table>
			<button type="button" id="write" class="btn write" style="margin-left: 700px;" onclick="location.href='index.jsp?main=review/reviewLoginChk.jsp'">글쓰기</button>
	
	
	<!-- 페이징 -->
	<div style="width: 900px;text-align: center; margin-bottom: 50px;">
		<ul class="pagination">
		<%
		//이전
		if(startPage>1)
		{%>
			<li><a href="index.jsp?main=review/reviewMain.jsp?list=reviewList.jsp?currentPage=<%=startPage-1%>">이전</a></li>
		<%}
		  for(int pp=startPage;pp<=endPage;pp++)
		{
			if(pp==currentPage)//현재페이지일때 active
			{%>
				<li class="active"><a href="index.jsp?main=review/reviewMain.jsp?list=reviewList.jsp?currentPage=<%=pp%>"><%=pp%></a></li>
			<%}else{%>
				<li><a href="index.jsp?main=review/reviewMain.jsp?list=reviewList.jsp?currentPage=<%=pp%>"><%=pp%></a></li>
			<%}
		}
		
		//다음
		if(endPage<totalPage)
		{%>
			<li><a href="index.jsp?main=review/reviewMain.jsp?list=reviewList.jsp?currentPage=<%=endPage+1%>">다음</a></li>
		<%}%>  
		</ul>
	</div>
	
	<!-- top btn -->
	<div id="topBtn">
		<img src="images/icon_up_button.png" id="topBtnImg">
	</div>
</div>

</body>
</html>