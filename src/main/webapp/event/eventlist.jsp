<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dao.EventDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.EventDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<style type="text/css">


.tile
{
  width:700px;
  height:477px;
  margin:10px;
  background-color:#99aeff;
  display:inline-block;
  background-size:cover;
  position:relative;
  cursor:pointer;
  transition: all 0.4s ease-out;
  box-shadow: 0px 35px 77px -17px rgba(0,0,0,0.44);
  overflow:hidden;
  color:white;
  font-family:'Roboto';
  
}
.tile img
{
  height:100%;
  width:100%;
  position:absolute;
  top:0;
  left:0;
  z-index:0;
  transition: all 0.4s ease-out;
}
.tile .text
{
/*   z-index:99; */
  position:absolute;
  padding:30px;
  height:calc(100% - 60px);
  height:calc(100% - 60px);
}
.tile h1
{
 
  font-weight:300;
  margin:0;
  text-shadow: 2px 2px 10px rgba(0,0,0,0.3);
}
.tile h2
{
  font-weight:100;
  margin:20px 0 0 0;
  font-style:italic;
   transform: translateX(200px);
}
.tile p
{
  font-weight:300;
  margin:20px 0 0 0;
  line-height: 25px;
/*   opacity:0; */
  transform: translateX(-200px);
  transition-delay: 0.2s;
}
.animate-text
{
  opacity:0;
  transition: all 0.6s ease-in-out;
}
.tile:hover
{
/*   background-color:#99aeff; */
box-shadow: 0px 35px 77px -17px rgba(0,0,0,0.64);
  transform:scale(1.05);
}
.tile:hover img
{
  opacity: 0.2;
}
.tile:hover .animate-text
{
  transform:translateX(0);
  opacity:1;
}



.tile:hover span
{
  opacity:1;
  transform:translateY(0px);
}






.css3-tab {
  list-style: none;
  margin: 0 auto 40px;
  padding: 38px 0 0 0;
  position: relative;
  width: 90%;
}
.css3-tab input[type='radio'] {
  display: none;
}
.css3-tab .css3-tab-nav {
  display: table;
  table-layout: fixed;
  width: 100%;
}
.css3-tab .css3-tab-nav label {
  display: table-cell;
  background-color: #666666;
  color: #FFFFFF;
  padding: 15px;
  text-align: center;
  transition: all .3s ease 0s;
}
.css3-tab .css3-tab-nav label:hover {
  cursor: pointer;
  background: white;
  color: #666666;
  transition: all .3s ease 0s;
}
@media (max-width: 692px) {
  .css3-tab .css3-tab-nav {
    display: block;
    margin: 0 0 20px;
  }
  .css3-tab .css3-tab-nav label {
    display: block;
    box-sizing: border-box;
    width: 100%;
    padding: 20px;
  }
}
.css3-tab .css3-tab-content {
  overflow: hidden;
  padding: 25px;
  display: none;
  background: #FFF;
  clear: left;
  box-sizing: border-box;
}
.css3-tab input[id='tabOne']:checked ~ .css3-tab-nav label[for='tabOne'] {
  background: #FD415A;
  color: white;
  cursor: default;
}
.css3-tab input[id='tabOne']:checked ~ div.tab-one {
  display: block;
  border-top: solid 3px #FD415A;
}
.css3-tab input[id='tabTwo']:checked ~ .css3-tab-nav label[for='tabTwo'] {
  background: #FD415A;
  color: white;
  cursor: default;
}
.css3-tab input[id='tabTwo']:checked ~ div.tab-two {
  display: block;
  border-top: solid 3px #FD415A;
}
.css3-tab input[id='addNew']:checked ~ .css3-tab-nav label[for='addNew'] {
  background: #FD415A;
  color: white;
  cursor: default;
}
.css3-tab input[id='addNew']:checked ~ div.add-new {
  display: block;
  border-top: solid 3px #FD415A;
}
body {
  background: #e4e4e4;
}


table.tb {
	margin: auto;
	width: 700px;
	height: 300px;
	max-height:200px;
	max-width:800px;
	border-top: solid 1px gray;
	font-family: 'Noto Sans KR', sans-serif;
}
.tb td{
	max-width:560px;
	max-height: 200px;
	overflow: hidden;
	padding-bottom: 15px;
}


button.bt {
	margin-bottom: 100px;
	margin-right: 100px;
	width: 100px;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: white;
	color: gray;
	padding: 10px 20px;
	text-align: center;
	font-size: 12px;
	opacity: 0.6;
	transition: 0.3s;
	cursor: pointer;
	border: solid 1px gray;
}

.pagination{
	display: block;
	text-align: center;
}

.pagination > li > a{
	float: none;
	margin-left: -5px;
}

</style>
</head>
<%
	EventDao dao=new EventDao();
	//페이징 처리에 필요한 변수선언
	int perPage=5;//한페이지에 보여질 글의 갯수
	int totalCount; //총 글의 수
	int currentPage;//현재 페이지번호
	int totalPage;//총 페이지수
	int start;//각페이지에서 불러올 db 의 시작번호
	int perBlock=5;//몇개의 페이지번호씩 표현할것인가
	int startPage; //각 블럭에 표시할 시작페이지
	int endPage; //각 블럭에 표시할 마지막페이지
	//총 갯수
	totalCount=dao.getTotalCount();
	//현재 페이지번호 읽기(단 null 일경우는 1페이지로 설정)
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	//총 페이지 갯수 구하기
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작페이지
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
	if(endPage>totalPage)
		endPage=totalPage;
	//각 페이지에서 불러올 시작번호
	start=(currentPage-1)*perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<EventDto> list=dao.getList(start, perPage);
	if(list.size()==0 && totalCount>0)
	{%>
	<script type="text/javascript">
	 location.href="index.jsp?main=event/eventlist.jsp?currentPage=<%=currentPage-1%>";		
	</script>
	<%}
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월dd일 HH:mm z");
	//각페이지에 출력할 시작번호
	int no=totalCount-(currentPage-1)*perPage;
	
	String myid="";
	LoginDao ldao = new LoginDao();
	LoginDto ldto;
	String name ="";
	String loginok="";
	//로그인 상태 확인후 입력폼 나타내기
	if(session.getAttribute("loginok")!=null){
		loginok = (String)session.getAttribute("loginok");
		
	myid = (String)session.getAttribute("myid");
	ldto = ldao.getUserInfo(2, myid);
	name = ldto.getName();
	}
	
		
	
%>


<body>
<img src="./images/ev1.PNG" style="width:100%;">

<!-- Pure CSS Menu -->
<div class='css3-tab'>
		<input type='radio' name='a' id='tabOne' tabindex="1"checked>
		<input type='radio' name='a' id='tabTwo' tabindex="2">
		<input type='radio' name='a' id='addNew' tabindex="3">

		<div class="css3-tab-nav">
				<label for='tabOne'>진행중인 이벤트</label>
				<label for='tabTwo'>이번달 진행 이벤트</label>
				<label for='addNew'>당첨자 발표</label>
		</div>
		
		
<div class='css3-tab-content tab-one'>
<section style="margin-top:20px; margin-bottom:20px;">
	<div class="container">
	<span style="font-family: 'Noto Sans KR', sans-serif; font-weight:400;
	 font-size:40pt;">이벤트</span>
	 <span style="color:gray; font-size:20pt;">EVENT</span>
	</div>
	
<div style="text-align:right;">

<%
	//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 글쓰기 버튼 보이게한다.
	if(loginok!=null && myid.equals("admin")){%>
	<button type="button" class="btn btn-default pull-right bt"
	onclick="location.href='index.jsp?main=event/eventform.jsp'">
	<span class='fas fa-pencil-alt'></span>&nbsp;글쓰기</button>
<%} %>

</div>

<p style="clear:both;"></p>
	
	<%
	if(totalCount==0)
	{%>
		<p align="center">
			<b style="font-family: 'Noto Sans KR', sans-serif; margin-bottom: 30px;">아직 작성된 글이 없습니다.<br> 이벤트를 등록해주세요!
			</b>
		</p>
	<%}else{
	for(EventDto dto:list)
		{%>
	<table class="tb" style="cursor:pointer;" onclick="location.href='index.jsp?main=event/eventdetail.jsp?num=<%=dto.getNum()%>&currentPage=<%= currentPage%>&key=list'">
		<tr>
			<td rowspan="4" width="200" height="200">
				<img src="/Team/save/<%=dto.getPhotoname()%>"  onerror="this.src='./images/image_4.jpg'" style="margin-right:30px; margin-top:-25px; border-radius:7%" width="230" height="130">
			</td>
			<td style="color:A52A2A; font-weight: 400;">
				<%=sdf.format(dto.getWriteday())%>
				<%
				//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 수정,삭제 보이게한다.
				if(loginok!=null && myid.equals("admin")){
				%>
				<td>
					|&nbsp;<a href="index.jsp?main=event/eventupdateform.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>" 
						style="color: black;"><span class='far fa-edit'></span>&nbsp;수정</a>
					|&nbsp;<a href="" 
					onclick="removeCheck()" style="color: black;" ><span class='far fa-file-excel'></span>&nbsp;삭제</a>
				</td>
<script type="text/javascript">
function removeCheck() {

	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인

		 location.href = "index.jsp?main=event/eventdelete.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>";

	 }else{   //취소

		return;
	 }

	}
</script>
				<%} %>
			</td>
		</tr>
		<tr>
			<td style="font-weight: 700;">
			<%=dto.getSubject()%>
			</td>
		</tr>
		
		<tr>
		<%if(dto.getContent().length() >= 50){%>
			<td style="font-weight: 400;"> 
				<%=dto.getContent().substring(0, 50)%>
			</td>
			<% }else{%>
			<td style="font-weight: 400;">
				<%=dto.getContent()%>
			</td>
			<%} %>
		</tr>
		
		<tr>
			<td style="font-weight: 400;">
			조회수 : <%=dto.getReadcount()%>
			</td>
		</tr>
	</table>
		<%}
	}
	%>
	
	

</section>

<!-- 페이징 -->
<div>
	<ul class="pagination">
	<%
	
	//이전
	if(startPage>1)
	{%>
		<li>
		<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=startPage-1%>"><</a>
		</li>
	<%}
	
	for(int pp = startPage; pp <= endPage;pp++)
	{
		if(pp==currentPage) //현재페이지일때 active
		{%>
			<li class="active">
			<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
		<%}else{%>
			<li>
			<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
			
		<%}
	}
	
	//다음
	if(endPage<totalPage)
	{%>
		<li>
		<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=endPage+1%>">></a>
		</li>
	<%}
	%>
	</ul>
</div>
		
</div>

	
	
<div class='css3-tab-content tab-two'>
			
		
		
<div style="text-align:center;">	
<div class="tile"> 
  <img src="./images/pag1.jpg" style="width:700px; height:477px;">
  <div class="text">
  <h2 class="animate-text">이벤트 기간 21년 10월 ~ 22년 1월</h2>
  <p class="animate-text">단 한번의 기회 기아 럭키 드라이브 투 서울 !  Bacon ipsum dolor amet pork belly tri-tip turducken, pancetta bresaola pork chicken meatloaf.</p>
  </div>
 </div>


<div class="tile"> 
  <img src="./images/pag2.png" style="width:700px; height:477px;">
  <div class="text">
  <h2 class="animate-text">이벤트 기간 21년 10월 ~ 22년 3월</h2>
  <p class="animate-text">모두가 대찬성 NEW QM6 우리가족 취향저격 전국 시승 이벤트!! Flank sirloin strip steak prosciutto kevin turducken. </p>
  </div>
 </div>
</div>
		
		
</div>		
		
		
		

	<div class='css3-tab-content add-new'>
		<div class="container" style="text-align : center; margin-top:100px;margin-bottom:100px;">
			<a href="index.jsp?main=event/winboard.jsp"><img src="./images/win.png"></a>
		</div>
	</div>

</div>





</body>
</html>