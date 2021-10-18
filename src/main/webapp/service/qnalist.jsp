<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="data.dto.ServiceDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ServiceDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">


<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<title>CUSTOMERSERVICE</title>
<style>
body{
 background-color: white;
 
 }
.baseBtn {
	width: 185px;
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
.searchBtn {
	width: 45px;
	height: 30px;
	background-color: white;
	cursor: pointer;
	color: #333;
	border: none;
	margin-left: -50px;
	
}
.write{
	margin-top: 20px;
	margin-left: 900px;
}
.inner{
    width:1200px;
    margin: 0 auto;
    position: relative;
    padding-top:10px;
	    
}
.inner .title{
	margin-top: 80px;
    width: 982px;
    text-align: center;
    font-size: 30px;
    color: #a23f25;
    line-height: 30px;
    margin-left: 109px;
    box-sizing: border-box;
}
.inner .pageSelector{
	margin-left: 1000px;
	margin-top: 10px;
	width: 150px;
	height: 40px;
}
.inner .search-container{
	background-color: #333;
	padding-left:200px;
	padding-top:30px;
	margin-left: 35px;
	width: 1130px;
	height: 100px;
	border-bottom: 3px solid #333;
	color: white;
}
.inner .search-container .searchOption{
	margin-left:20px;
	width: 150px;
	height: 40px;
	color: #333;
}
.inner .search-container .searchKeyWord{
	margin-left:10px;	
	width: 400px;
	height: 40px;
	color: #333;
}
.inner .search-container .searchTitle{
	font-size: 18px;
	font-weight: bold;
}
.inner .return{
	position: absolute;
	left: 55px;
	top: 250px;
}

.inner .container{
   	margin-top:30px;
    margin-left: 30px;
    font-size: 16px;
    text-align: center;
    box-sizing: border-box;
    border-collapse: collapse;
    background-color: white;
}
.inner .container tr{
    height: 66px;;
}
.inner .container th{
    
    background-color: #333;;
	color: white;
    text-align: center;
}
.inner .container td{
    border-bottom: 1px solid #EEEEEE;
}
.inner .container td a:hover{
	cursor: pointer;
}
.inner .container .col1,.col2,.col4,.col5,.col6, .col7{
    width: 100px;
}
.inner .container .col3{
    width: 470px;;
}
.inner .page{
	margin-top:30px;
	margin-left:450px;
	width: 350px;
/* 	background-color: pink; */
	margin-bottom: 20px;
	
}
.inner .page li a{
	margin: 0 5px; 
	border: 1px solid #333;
	color: #333;
}
.inner .page li a{
	margin: 0 5px; 
	border: 1px solid #333;
	color: #333;
}
.inner .page .pagination .active a {
    background-color: #333;
    color: white;
}

</style>
</head>
<%	
	//한글
	request.setCharacterEncoding("UTF-8");
	//로그인정보얻기
	String login = (String)session.getAttribute("loginok");
	String myid = (String)session.getAttribute("myid");
	ServiceDao dao = new ServiceDao();
	


	
	//페이징 처리에 필요한 변수선언
	//한페이지에 나타낼 글의수
	int perPage = 10; //한페이지에 보여질 글의 갯수
	int start; //각페이지에서 불러올 db의 시작번호
	int totalCount; // 총 글의 수
	
	//페이지 목록 숫자
	int totalPage; //총 페이지수
	int currentPage; //현재 페이지 번호
	int perBlock = 5; //페이지 블럭 갯수 ex) perBlock = 5 일경우 < 1 2 3 4 5 > 10일경우 <1 2 3 4 5 6 7 8 9 10>  
	int startPage; //각 블럭에 표시할 시작페이지
	int endPage; //각 블럭에 표시할 마지막페이지
	
	//검색에 필요한 변수
	String keyField = "", keyWord = "";
	if(request.getParameter("keyWord")!=null){
	
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
		if(request.getParameter("method")!=null&&request.getParameter("method").equals("post")){
			keyWord = new String(keyWord.getBytes("8859_1"),"UTF-8");
		}
		
		System.out.println("메인리스트");
		System.out.println(keyField +"키필드입니다.");
		System.out.println(keyWord +"키워드입니다."); 
	} 

	
	//검색 후에 다시 처음 리스트 요청
	if(request.getParameter("reload")!=null&&
			request.getParameter("reload").equals("true")){
		keyField =""; keyWord = ""; 
	}
	/* int totalRecord = dao.getTotalCount(keyField, keyWord); */
	
	//총 갯수
	totalCount = dao.getTotalCount(keyField, keyWord);
	
	//요청된 PerPage 처리
	if(request.getParameter("perPage")!=null){
		//Integer.parseInt(request.getParameter(name));
		perPage = Integer.parseInt(request.getParameter("perPage"));
	}
	
	//현재 페이지 번호 읽기 (단 null 일 경우 1페이지로 설정)
	if(request.getParameter("currentPage") == null){
		currentPage = 1;
	}else {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//총페이지 갯수 구하기
	totalPage = totalCount/perPage + (totalCount%perPage == 0 ? 0 : 1);
	
	//각 블럭의 시작페이지
	startPage = (currentPage-1)/perBlock*perBlock+1;
	endPage = startPage+perBlock-1;
	
	if(endPage>totalPage){
		endPage = totalPage;
	}
	
	//각 페이지에서 불러올 시작번호
	start = (currentPage-1)*perPage; //오라클은 첫번이1이라 1더해야함
	
	//각페이지에서 필요한 게시글 가져오기
	List<ServiceDto> list = dao.getList(keyField, keyWord, start, perPage);
	
	if(list.size()==0 && totalCount>0){
		//현재페이지의 list가 더이상없을 경우 이전페이지의 데이터를 가져온다
	%>
		<script>
		location.href="index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage-1%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>"
		</script>
	<%}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//각페이지에 출력할 시작번호
	int no = totalCount-(currentPage-1)*perPage;
%>
<body>

<div class = "inner">
  <div class="title">
    <h1>K-CAR</h1>
  </div>
  	<!-- 검색 -->
  	<div class = search-container>
  		<form  name="searchFrm"  method = "post" action = "index.jsp?main=service/qnalist.jsp"   accept-charset="utf-8">
  			<span class = "searchTitle">Q&A검색</span>
			<select name="keyField" size="1" class ="searchOption">
				<option value="writer"> 작성자</option>
				<option value="subject"> 제 목</option>
				<option value="contents"> 내 용</option>
			</select>
			<input  name="keyWord" class = "searchKeyWord" maxlength="16">
			<button type="button"  value="찾기" class = "searchBtn" onClick="javascript:check()">
				<span class = "glyphicon glyphicon-search"></span>
			</button>
			<input type="hidden" name="currrentPage" value="1">
			<input type="hidden" name="method" value="post">

		</form>
  	</div>
  	<div class = "select-container">
		<div class ="return">
			<form name="listFrm" method="post" action = "index.jsp?main=service/qnalist.jsp">
				<input type="hidden" name="reload" value="true">
				<input type="hidden" name="currentPage" value="1">
				<button type = "submit" class = "baseBtn">전체목록</button>
			</form>
		</div>
  		
 		<form name="npFrm" method="post" >
			<select name="perPage" size="1" onchange="changePerPage(this.form.perPage.value)" class="pageSelector">
   				<option value="5">5개씩 보기</option>
   				<option value="10" selected>10개씩 보기</option>
   				<option value="15">15개씩 보기</option>
   				<option value="30">30개씩 보기</option>
  				</select>
  				<script>document.npFrm.perPage.value=<%=perPage%>;</script>
		</form>
		
  	</div>
	<table class = "container">
		
		<tr>
			<th class="col1">번호</th>
			<th class="col2">카테고리</th>
			<th class="col3">제목</th>
			<th class="col4">진행상태</th>
			<th class="col5">작성자</th>
			<th class="col6">등록일</th>
			<th class="col7">조회수</th>
		</tr>
		<%
		int listSize = list.size();
		if(listSize == 0){%>
		<tr>
			<td colspan = '7' style = "text-align: center">
				<h1>등록된 글이 없습니다</h1>
			</td>
		</tr>
		<%}else{ 
		for(int i=0;i<perPage;i++){
			if(i==listSize) break;
			ServiceDto dto = list.get(i);
			int num = Integer.parseInt(dto.getNum());//게시물 번호
			String subject = dto.getSubject();//제목
			String name = dto.getWriter();//작성자
			String status = dto.getStatus();//진행상황
			Timestamp writeday = dto.getWriteday();//날짜
			int depth = dto.getDepth();//답변의 깊이
			int view = dto.getViews();//조회수
			String file = dto.getFile();//첨부파일
			String id = dto.getId();//아이디
			//댓글 count 추가하기!!!
			/* int bcount = cmgr.getBCommentCount(num); */
		%>
		<tr align="center">
			<td><%=no--%></td>
			<td><%=dto.getCategory()%></td>
			<td align="left" style = "padding-left: 20px;">
				<%for(int j=0;j<depth;j++){
					/* System.out.println(depth +"깊이"); */
					out.println("&nbsp;&nbsp;");
				}%>
				<a class = "detail" num = <%=dto.getNum()%>>
				<%if(dto.getOpen().equals("no")){%>	
					<span class = "glyphicon glyphicon-lock lock2" >
						<input type = "hidden" value = "<%=dto.getId()%>" name = "lock" class = "lock">
						<input type = "hidden" value = "<%=dto.getJaid()%>" name = "lock2" class = "lock2">
    		<%
    		//추가
    		if(login == "yes"){
    			
    			LoginDao ldao = new LoginDao();
    			LoginDto ldto = ldao.getUserInfo(2, myid);
    			String nick = ldto.getName();%>
    			<input type = "hidden" value = "<%=nick%>" name = "lock3" class = "lock3">
    			
    		<%}
    		%>
					
					</span>	
				<%}%> 
				<%=subject%>
				</a>
			</td>
			<td><%=dto.getStatus()%></td>
    		<td><%=dto.getWriter()%></td>
    		<td><%=sdf.format(dto.getWriteday())%></td>
    		<td><%=dto.getViews()%></td>
		</tr>
		<%}
		}%>
		
	</table>
		
	<div class = "write">
		
		<button type="button" class="baseBtn writeBtn">작성하기</button>
	</div>
	<!-- 페이징 -->
<div class = "page">
	<ul class="pagination">
	<%
	//이전
	if(startPage>1)
	{%>
		<li>
			<a href="index.jsp?main=service/qnalist.jsp?currentPage=<%=startPage-1%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">
				<span class = "glyphicon glyphicon-chevron-left"></span>
			</a>
		</li>
	<%}
	  
	for(int pp=startPage; pp<=endPage; pp++)
	{
		if(pp==currentPage)//현재페이지일때 active
		{%>
			<li class="active">
				<a href="index.jsp?main=service/qnalist.jsp?currentPage=<%=pp%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>"><%=pp%></a>
			</li>
		<%}else{%>
			<li>
				<a href="index.jsp?main=service/qnalist.jsp?currentPage=<%=pp%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>"><%=pp%></a>
			</li>
		<%}
	}
	
	//다음
	if(endPage<totalPage)
	{%>
		<li>
			<a href="index.jsp?main=service/qnalist.jsp?currentPage=<%=endPage+1%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=URLEncoder.encode(keyWord, "UTF-8") %>"><span class = "glyphicon glyphicon-chevron-right"></span></a>
		</li>
	<%}
	%>  
	</ul>
</div>
	<form name="readFrm" method = "post" action = "index.jsp?main=service/qnalist.jsp" >
		<input type="hidden" name="currentPage" value="<%=currentPage%>">
		<input type="hidden" name="perPage" value="<%=perPage%>">
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="method" value="post">
		<input type="hidden" name="num">
	</form>
	
	
</div>
<script>
		//현제 페이지의 글갯수조절
		function changePerPage(num) {
			document.readFrm.perPage.value=num;
			document.readFrm.submit();
		}
		
		//상세페이지로이동
		$(".detail").click(function(){
			let num = $(this).attr("num")
			if($(this).children().find(".lock").attr("name") === "lock"){
				if("<%=myid%>" === $(this).children().find(".lock").val() || $(this).children().find(".lock3").val() === $(this).children().find(".lock2").val() || "<%=myid%>" === "admin" ){
					location.href = "index.jsp?main=service/detail.jsp?num="+num+"&currentPage=<%=currentPage%>&key=list&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
				}else{
					alert("작성자와 관리자만 접근이 가능합니다.")
					return;
				}
			}else{
				location.href = "index.jsp?main=service/detail.jsp?num="+num+"&currentPage=<%=currentPage%>&key=list&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
			}
		});
		
		//글작성
		$(".writeBtn").click(function() {
			if("<%=login%>" != 'yes'){
				alert("로그인이 필요한 페이지입니다.")
				location.href = 'index.jsp?main=login/loginMain.jsp';
				return;
			}else{
			 location.href = 'index.jsp?main=service/writeqna.jsp?&currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>';
			}
		})
		
		//글검색
		function check() {
			if(document.searchFrm.keyWord.value==""){
				alert("검색어를 입력하세요.");
				document.searchFrm.keyWord.focus();
				return;
			}
			document.searchFrm.submit();
		}
		
		
</script>

</body>
</html>