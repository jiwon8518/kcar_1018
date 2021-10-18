<%@page import="data.dto.RcommentDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.RcommentDao"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
div.bg {
	margin: 150px auto;
	width: 940px;
	display: block;
}
div.title{
	margin-bottom: 30px;
}
div.title2{
	margin-bottom: 100px;
}
h3>p {
	font-size: 30px;
	color: #05141f;
	line-height: 30px;
}
.chuImg {
	cursor: pointer;
	color: red;
	font-size: 0px;
}
span.updown {
	display: table-cell;
    width: 150px;
	background-color: #cdd0d2;
	padding: 20px;
    text-transform: uppercase;
    vertical-align: middle;
    font-size: 15px;
    color: #05141f;
    font-weight: bold;
}
div.btns {
	width: 940px;
	margin-bottom: 50px;
	color: #05141f;
}
button.list {
	margin-left: 40px;
	margin-right: 650px;
}
button.del, button.list, button.update {
	background-color: #05141f;
	color: #fff;
	width: 80px;
	height: 40px;
}
button.del:hover,button.list:hover,button.update:hover {
	background-color: #697279;
	color: #fff;
}
a.next,a.pre {
	color: #05141f;
	text-decoration: none;
	line-height: 20px;
	font-size: 13px;
	color: #37434c;
    vertical-align: middle;
}
a.next,a.pre:hover {
	cursor: pointer;
}
div.icon {
	margin-left: 10px;
	margin-bottom: 10px;
	width: 90px;
}
div.icon>img {
	width: 30px;
	height: 100%;
}
div>img,div>span:hover {
	cursor: pointer;
}
/* 댓글폼 */
button.cbtn {
    border-color: #eaeaea;
    border-right-color: transparent;
    border-bottom-color: transparent;
    color: #444;
	height: 90px;
	width: 93px;
	margin-left: 8px;
	margin-bottom: 8px;
}
textarea.text {
	width: 900px;
	height: 90px;
	resize: none;
}
div.textcount {
	width: 880px;
	text-align: right;
}
span.chu>img{
	width: 20px;
	height: 100%;
	cursor: pointer;
}
div.textcount span {
	cursor: default;
}
#topBtnImg{
	width: 30px;
	height: 100%;
	cursor: pointer;
}
#topBtn{
	 margin-left: 1145px;
	 margin-bottom: 100px;
}
img.cdel{
	width: 30px;
	height: 100%;
	color: black;
}
</style>

</head>
<%
	// 번호 읽어오기
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	//System.out.println(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	if(currentPage==null)
		currentPage = "1";
	
	ReviewDao dao = new ReviewDao();
	RcommentDao rdao = new RcommentDao();
	
	//번호에 해당하는 dto 정보 얻기
	ReviewDto dto = dao.getReviewData(num);
	
	String key = request.getParameter("key");
	if(key!=null)
		dao.updateReadcount(num);
	
	String login = (String)session.getAttribute("loginok");
	List<RcommentDto> rlist = rdao.getAllcomment(dto.getNum());
	
	// 아이디,닉네임 얻기
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email);
	//String rname = Ldto.getName();

	// 댓글 수
	int totalComment;
	totalComment = rdao.getCount(num);
	//System.out.println(totalComment);
	
	// 번호에 해당하는 다음,이전글 의 dto 정보 얻기
	ReviewDto dto2 = dao.getReviewNext(num);
	ReviewDto dto3 = dao.getReviewPre(num);
%>

<script type="text/javascript">
$(function () {
	//삭제 확인창
	$("button.del").click(function () {
		let cancel = confirm("후기글을 삭제하시겠습니까?");
		if(cancel)
			// 삭제할 파일 호출
			location.href="review/reviewDel.jsp?num="+<%= dto.getNum() %>;
	});
	
	//추천수 이벤트
	$("span.chu").click(function () {
		let num = $(this).attr("num");
		let tag = $(this);
		
		$.ajax({
			type: "get",
			dataType: "json",
			url: "review/ajaxChu.jsp",
			data: {"num":num},
			success: function (data) {
				//alert(data.chu);
				tag.next().text(data.chu);
			}
		});
	});
	
	//댓글 숨기기
	$("div.commentlist").hide();
	$("div.icon").click(function () {
		$("div.commentlist").toggle();
	});
	
	// 댓글 삭제
	$("span.cdel").click(function () {
		let idx = $(this).attr("idx");
		let tag = $(this);
		//alert(idx);
		
		// 삭제확인창
		let cancel = confirm("댓글을 삭제하시겠습니까?");
		if(cancel){
			$.ajax({
				type:"get",
				dataType:"html",
				url:"review/commentDel.jsp",
				data:{"idx":idx},
				success:function(){
					//새로고침
					location.reload();
				}
			});
		}
	});
	
	// 댓글 500자
	$("textarea.text").keyup(function () {
		let inputlength = $(this).val().length;
		let count = 500-inputlength;
		//alert(count);
		if($(this).val().length>500){
			$(this).val($(this).val().substring(0, 500));
		}
		$("span.textcount").html(inputlength);
	});
	
	// top button controll
	$("#topBtnImg").click(function() {
		$("html, body").animate({scrollTop:0}, "300");
	});
	
});
</script>

<body>
<div class="bg">
	<div class="title">
		<h3><p>시승 후기 게시판</p></h3>
	</div>
	<div class="title2"><p>고객님의 소중한 리뷰가 큰 힘이 됩니다.</p></div>
		
	<!-- 내용 본문 -->
	<table class="table table-bordered" style="width: 800px;">
		<tr>
			<th colspan="2" style="padding: 25px 30px;">
				<span style="font-size: 20pt;"><%= dto.getSubject()%></span><br>
				<span style="line-height: 50px;">시승모델 | <%= dto.getCar() %></span><br>
				<span style="margin-left: 13px; line-height: 20px;">작성일 | <%= sdf.format(dto.getWriteday()) %></span>
				<span style="margin-left: 25px;">작성자 | <%= dto.getName() %></span><br>
				<span style="margin-left: 750px;" class="chu" num="<%= dto.getNum() %>"><img src="images/icon_heart.png"></span>
				<span><%= dto.getChu() %></span>
				<span style="margin-left: 15px;">조회수 | <%= dto.getReadcount() %></span>
			</th>
		</tr>
		<tr>
			<td colspan="2"><%= dto.getContent() %></td>
		</tr>
	</table>
		
		
	<!-- 목록,수정,삭제 버튼 -->
	<div class="btns">
		<button type="button" class="btn btn-default list" onclick="location.href='index.jsp?main=review/reviewMain.jsp?currentPage=<%= currentPage%>'">목록</button>
		<% 	// 로그인시 작성글email=로그인한 email 일 경우
			if(login!=null && dto.getEmail().equals(email)){
		%>
				<button type="button" class="btn update" onclick="location.href='index.jsp?main=review/reviewUpdateForm.jsp?num=<%=dto.getNum()%>'">수정</button>
				<button type="button" class="btn del" onclick="">삭제</button>
		<% }else if(login!=null && email.equals("admin")) {%>
				<button type="button" class="btn del" onclick="">삭제</button>
		<% } %>
	</div>
			
	<!-- 댓글 리스트 -->
	<div class="icon">
		<img src="images/review_comment.png"><span style="margin-left:8px;">댓글</span>
		<span><%= totalComment %></span>
	</div>
	<div class="commentlist">
		<table class="table table-bordered" style="width: 900px;">
		<% 
			if(totalComment==0){
		%>
			<tr style="height: 60px;">
				<td style="padding-top: 20px;">
					<span style="margin-left: 10px;">댓글이 없습니다</span>
				</td>
			</tr>
		<% }else{
				for(RcommentDto rdto:rlist){
		%>
			<tr>
				<td align="left">
					<div style="margin-top: 8px;">
						<span class="glyphicon glyphicon-user" style="font-size: 20px; font-size: 15px; margin-right: 8px; padding-left: 10px;"></span>
						<%
							String rname = rdto.getName();
						%>
						<span><%= rname %></span>
						<% // 후기글email=댓글email 경우 작성자 나오게
							if(dto.getEmail().equals(rdto.getEmail())){
						%>
								<span style="color: red; font-size: 8pt; margin-left: 8px; cursor: text;">작성자</span>
						<% } %><br>
					</div>
					<span style="padding-left: 40px;">
						<%= rdto.getContent().replace("\n", "<br>") %>
					</span><br>
					<span style=" margin-left: 10px; font-size: 8pt; color:gray; padding-left: 30px;">
						<%= sdf.format(rdto.getWriteday()) %>
					</span>
					<%  
					 	// 로그인이면서 로그인한email=댓글작성자email or 관리자
						if(login!=null && rdto.getEmail().equals(email) || login!=null && email.equals("admin")){
					%>
					<span class="cdel" style="font-size: 12pt; cursor: pointer; margin-left: 800px; line-height: 30px;" idx="<%= rdto.getIdx() %>">
						<img src="images/icon_eraser.png" class="cdel">
					</span>
					<% } %>
				</td>
			</tr>
			<% } 
			} 
			// 댓글폼은 로그인한 경우에만 보이게 하기
				if(login!=null){
			%>
				<!-- 댓글 폼 -->
					<div class="commentform">
						<form action="review/commentInsert.jsp" method="post">
							<input type="hidden" name="num" value="<%=dto.getNum()%>">
							<input type="hidden" name="myid" value="<%=Ldto.getEmail()%>">
							<input type="hidden" name="name" value="<%=Ldto.getName()%>">
							<input type="hidden" name="currentPage" value="<%=currentPage%>">
							<table>
								<tr>
									<td>
										<textarea name="content" required="required" class="text" placeholder="더 훈훈해지는 댓글 부탁드립니다"></textarea>
									</td>
									<td>
										<button type="submit" class="btn btn-info cbtn">등록</button>
									</td>
								</tr>
							</table>
							<div class="textcount">
								<span class="textcount">0</span><span> / 500</span>
							</div>
						</form>
					</div>
			<% } %>
		</table>
	</div>

	<!-- 이전, 다음 글 -->
	<table class="table table-bordered" style="width: 940px; margin: 150px auto;">
		<tr>
			<td style="padding: 0px;">
				<span class="glyphicon glyphicon-chevron-up updown">&nbsp;다음글</span>
			</td>
			<td class="next" style="width: 850px; padding-top: 18px; padding-left: 25px;">
			<% 
				if(dto2.getNum()!=null){
			%>
				<a class="next" href="index.jsp?main=review/reviewDetail.jsp?num=<%= dto2.getNum() %>&currentPage=<%=currentPage%>&key=list">
				<%= dto2.getSubject()%></a>
			<% }else{ %>
					<span class="next"><p>다음 글이 없습니다</p></span>
			<% } %>
			</td>
		</tr>
		<tr>
			<td style="padding: 0px;">
				<span class="glyphicon glyphicon-chevron-down updown">&nbsp;이전글</span>
			</td>
			<td class="pre" style="width: 850px; padding-top: 18px; padding-left: 25px;">
			<% 
				if(dto3.getNum()!=null){
			%>
					<a class="pre" style="margin-top: 20px;" href="index.jsp?main=review/reviewDetail.jsp?num=<%= dto3.getNum() %>&currentPage=<%=currentPage%>&key=list">
					<%= dto3.getSubject()%></a>
			<% }else{ %>
					<span class="pre"><p>이전 글이 없습니다</p></span>
			<% } %>
			</td>
		</tr>
	</table>

	<!-- top btn -->
	<div id="topBtn"">
		<img src="images/icon_up_button.png" id="topBtnImg">
	</div>		

</body>
</html>