<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ServiceDto"%>
<%@page import="data.dao.ServiceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<title>CUSTOMERSERVICE</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
/* COMMON */
body{
    font-size: 14px;
    line-height: 24px;
    color: #37434c;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: 700;
    background-color:white;
}
a{
cursor: pointer;
}
.ast{
color: red;
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
.inner{
    width:1100px;
    margin: 0 auto;
    height: 900px;
    position: relative;
}
/* TITLE */
.inner .container h1{
    width: 200px;
    height: 40px;
    text-align: center;
    margin-left: 380px;
    margin-top:20px;
    margin-bottom:40px;
    color: #a23f25;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: bold;
}
/* TABLE */
.inner .container{
    width: 1048px;
    height: 690px;
    position: absolute;
    top: 40px;
    left: 29px;
 
}
.inner .container .detail{
    width: 982;
    box-sizing: border-box;
    border-collapse: collapse;
    margin-left: 16px;
    margin-top: 10px;
    background-color: white;
}
.inner .container .detail tr{
    height: 60px;
}
.inner .container .detail td.col1{
    width: 200px;
    background-color: #333;
	color: white;
    text-align: center;
}
.inner .container .detail td.col2{
    width: 292px;
}
.inner .container .detail td{
    border: 1px solid rgb(118, 118, 118);
    text-align: center;
    
}
.inner .container .detail td.contents{
    width:980px;
    height: 150px;
    border: none;   
    box-sizing: border-box;
}
.inner .container .detail .img{
   	background-color: #333;
	color: white;
}
.inner .container .detail td.contents #content{
    width:982px;
    height: 130px;
    border: none;
    
}
.inner .container .btnContainer {
    position: absolute;
    width: 600px;
    height: 50px;
    margin-top: 20px;
    left: 455px;
}
#getFile:hover {
	cursor: pointer;
}
.buttonContainer{
	margin-left: 16px;
	margin-bottom: 16px;
	
}
.adminFunc{
	margin-left: 287px;
	margin-right: 20px;
}


</style>
<%	
	//로그인정보, 게시글숫자, 현제페이지 얻기
	String login = (String)session.getAttribute("loginok");
	String id = (String)session.getAttribute("myid");
	String num=request.getParameter("num");
	String currentPage=request.getParameter("currentPage");
	//키워드 받기
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	System.out.println("detail.jsp파일");
	System.out.println(keyField +"키필드입니다.");
	System.out.println(keyWord +"키워드입니다."); 
	
	int perPage = 10;
	if(request.getParameter("perPage")!=null){
		perPage = Integer.parseInt(request.getParameter("perPage"));
	}
	if(currentPage==null)
		currentPage="1";
	//key는 목록에서만 값이 넘어오고 그 이외는 null값
	String key=request.getParameter("key");
	
	ServiceDao dao=new ServiceDao();
	//목록에서 올경우에만 조회수 1 증가한다
	if(key!=null)
	dao.updateViewsCount(num);
	
	//num 에 해당하는 dto 얻기
	ServiceDto dto=dao.getData(num);
	
	//이전글에 해당하는 num얻기
	String prevNum = dao.getPrevContent(num);
	System.out.println(prevNum +"이전숫자");
	//이전글에 해당하는 dto 얻기
	ServiceDto prevDto = dao.getData(prevNum);
	//이전글에 해당하는 id얻기
	String prevId = prevDto.getId();
	
	//다음글에 해당하는 num 얻기
	String nextNum = dao.getNextContent(num);
	System.out.println(nextNum +"다음");
	//다음글에 해당하는 dto얻기
	ServiceDto nextDto = dao.getData(nextNum);
	//다음글에 해당하는 id얻기
	String nextId = prevDto.getId();
	
	//날짜 형식
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<body>
    <div class="inner">
        <div class="container">
            <h1>Q&A</h1>
            <div class = "buttonContainer">
	            <button class="baseBtn reply" onclick = "location.href = './index.jsp?main=service/replyForm.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>'">답글</button>
	            <span class ="adminFunc">관리자전용 기능<span class = "ast"> * </span></span>
	            <button class="baseBtn complete">답변완료</button>
	            <button class="baseBtn completeAndSendMail">답변완료+알림메일발송</button>
            </div>
            <table class="detail">
                <tr>
                    <td class="col1 ">제목</td>
                    <td colspan="3" id="subject"><%=dto.getSubject()%></td>
                </tr>    
                <tr>
                    <td class="col1">작성자</td>
                    <td colspan="3" id="writer"><%=dto.getWriter()%></td>
                </tr>    
                <tr>
                    <td class="col1" id="writeday">작성일</td>
                    <td class="col2"><%=sdf.format(dto.getWriteday())%></td>
                    <td class="col1" id="views">조회수</td>
                    <td class="col2"><%=dto.getViews()%></td>
                </tr>    
                <tr>
                    <td class="col1">이메일</td>
                    <td class="col2" id="email"><%=dto.getEmail()%></td>
                    <td class="col1">전화번호</td>
                    <td class="col2" id="mobile"><%=dto.getMobile()%></td>
                </tr>    
                <tr>
                    <td class="img">첨부파일</td>
                    <td colspan="3" class="">
                        <a id ="getFile" ><%=dto.getFile()%></a>
                    </td>
                </tr>    
                <tr>
                    <td colspan="4" class="contents">
                        <textarea id="content" readonly><%=dto.getContents()%></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="img">다음글</td>
                    <td colspan="3" class="">
                    	<%if(nextNum.equals("-1")){%>
                    			<span>다음글이 없습니다</span>
                    		<%}else{
                        		if(nextDto.getOpen().equals("yes")){
                        			System.out.println(nextDto.getOpen() +"다음글");%>
    		                    	<a class="nextContent" num = "<%=nextDto.getNum()%>"><%=nextDto.getSubject()%></a>
    		                    	
                        		<%}else{System.out.println(nextDto.getOpen() +"다음글");%>
    		                    	<a class="nextContent" num = "<%=nextDto.getNum()%>"><span class ="glyphicon glyphicon-lock lock2"></span><%=nextDto.getSubject()%></a>
    		                    	<input type = "hidden" name = "lock" value="<%=nextId%>" >
                        		<%}
                    		}
                        	%>
                    </td>
                </tr>    
                <tr>
                    <td class="img">이전글</td>
                    <td colspan="3" class="">
                    	<%if(prevNum.equals("-1")){%>
                    			<span>이전글이 없습니다</span>
                    		<%}else{
                        		if(prevDto.getOpen().equals("yes")){
                        			System.out.println(prevDto.getOpen() +"이전글");%>
    		                    	<a class="prevContent" num = "<%=prevDto.getNum()%>"><%=prevDto.getSubject()%></a>
    		                    	
                        		<%}else{System.out.println(prevDto.getOpen() +"이전글");%>
    		                    	<a class="prevContent" num = "<%=prevDto.getNum()%>"><span class ="glyphicon glyphicon-lock lock2" ></span><%=prevDto.getSubject()%></a>
    		                    	<input type = "hidden" name = "lock" value="<%=prevId %>" >
                        		<%}
                    		}
                        	%>
                    </td>
                </tr>    
                    
            </table>
            <div class="btnContainer">
                <button class="baseBtn update">수정</button>
                <button class="baseBtn delete">삭제</button>
                <button class="baseBtn back" onclick="location.href = 'index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>'">목록</button>
            </div>
        </div>
    </div>
	<script>
		//숨김목록
		$(".update").hide();
		$(".delete").hide();
		$(".reply").hide();
		$(".complete").hide();
		$(".completeAndSendMail").hide();
		$(".completeAndSendMail").hide();
		$(".adminFunc").hide();
		
		//작성자와 로그인유저 일치 혹은 관리자일경우 보이는 메뉴
		if('<%=id%>' === '<%=dto.getId()%>' || '<%=id%>' === "admin"){
			$(".update").show();
			$(".delete").show();
			
		}
		//로그인유저,마스터만 답글버튼보이기
		if('<%=login%>' === 'yes' || '<%=id%>' === "admin"){
			$(".reply").show();
			$(".reply").show();
			//버튼위치
			$(".buttonContainer").css("marginLeft", "17px")
		}else{
			$(".btnContainer").css("marginLeft", "378px")
		}
		
		//마스터만 답변완료버튼 보이기
		if('<%=id%>' === "admin"){
			$(".complete").show();
			$(".completeAndSendMail").show();
			$(".adminFunc").show();
		}
		//글수정 
		$(".update").click(function () {
			location.href = "index.jsp?main=service/updateqna.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
		})
		//글삭제
		$(".delete").click(function () {
			let num = <%=dto.getNum()%>;
			let currentPage = <%=currentPage%>;
			let perPage = <%=perPage%>
			let cancel = confirm("삭제하시겠습니까?");
			if(cancel){
				$.ajax({
					type : "post",
					url : "service/deleteAction.jsp",
					data: {
						"num": num,
						"currentPage":currentPage,
						"perPage" : perPage
						
					},
					success : function() {
						alert("삭제완료")
						location.href = "index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
						
					},
					error:function(request,status,error){
					      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				    }
				});
			}
		});
		
		//파일 다운로드
		 $("#getFile").click(function() {
			 if($("#getFile").text() =="미입력"){
				alert("등록된 파일이 없습니다.")
				return;
			 }else{
				location.href="service/filedown.jsp?name=<%=dto.getFile()%>";
			 }
			
		});
		//진행중에서 답변완료로 답변상태변경
		$(".complete").click(function () {
			let num = <%=dto.getNum()%>;
			let currentPage = <%=currentPage%>;
			let perPage = <%=perPage%>
			$.ajax({
				type : "post",
				url : "service/updateStatusAction.jsp",
				data: {
					"num": num,
				},
				success : function() {
					//move page
					location.href = "index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
					
				},
				error:function(request,status,error){
				      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
			
		});
		//진행중에서 답변완료로 답변상태변경 후 이메일 등록시 알림발송
		$(".completeAndSendMail").click(function () {
			if($("#email").text() == "미입력"){
				alert("이메일을 입력하지 않았습니다.")
				return;
			}
			let num = <%=dto.getNum()%>;
			let currentPage = <%=currentPage%>;
			let perPage = <%=perPage%>
			$.ajax({
				type : "post",
				url : "service/updateStatusAction.jsp",
				data: {
					"num": num,
					"mail":"yes",
				},
				success : function() {
					//move page
					location.href = "index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
					
				},
				error:function(request,status,error){
				      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
			
		});
		//이전글
		$(".prevContent").click(function(){
			let num = $(this).attr("num")
			if($(this).next().attr("name") === "lock"){
				if("<%=id%>" === $(this).next().val() || "<%=id%>" === "admin" ){
					location.href = "index.jsp?main=service/detail.jsp?num="+num+"&currentPage=<%=currentPage%>&key=list&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
				}else{
					alert("작성자와 관리자만 접근이 가능합니다.")
					return;
				}
			}else{
				location.href = "index.jsp?main=service/detail.jsp?num="+num+"&currentPage=<%=currentPage%>&key=list&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
			}
		});
		//다음글
		$(".nextContent").click(function(){
			let num = $(this).attr("num")
			if($(this).next().attr("name") === "lock"){
				if("<%=id%>" === $(this).next().val() || "<%=id%>" === "admin" ){
					location.href = "index.jsp?main=service/detail.jsp?num="+num+"&currentPage=<%=currentPage%>&key=list&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
				}else{
					alert("작성자와 관리자만 접근이 가능합니다.")
					return;
				}
			}else{
				location.href = "index.jsp?main=service/detail.jsp?num="+num+"&currentPage=<%=currentPage%>&key=list&perPage=<%=perPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
			}
		});
	</script>
</body>
</html>