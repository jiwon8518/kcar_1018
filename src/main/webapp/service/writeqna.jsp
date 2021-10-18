<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>CUSTOMERSERVICE</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<style>
/* COMMON */
body{
    font-size: 14px;
    line-height: 24px;
    color: #37434c;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: 700;
    background-color: white;
    
}

.ast{
    color: red;
}
.baseBtn {
	width: 185px;
	height: 40px;
	background-color: #333;
	color: white;
	border: 1px solid #333;
	cursor: pointer;
}
.baseBtn:hover {
	background-color: rgb(118, 118, 118);
	border: 1px solid rgb(118, 118, 118);
	color: white;
}
.inner{
    width:1100px;
    margin: 0 auto;
    margin-bottom: 30px;
    height: 880px;
    position: relative;
    background-color: white;
}
/* TABLE */
.inner .container{
    width: 1048px;
    height: 800px;
    position: absolute;
    top: 60px;
    left: 29px;
}
.inner .container form{
    width: 982px;
    height: 800px;
    margin-left: 30px;
    
}
.inner .container .btnContainer {
    position: absolute;
    width: 600px;
    height: 50px;
    margin-top: 20px;
    left: 450px;
}
.inner .container .qnaFrm {
    border-collapse: collapse;
    margin-top: 5px;
    
}
.inner .container .qnaFrm tr {
    height: 60px;
    background-color: white;
}
.inner .container .qnaFrm td {
    width: 880px;
    border-bottom: 1px solid rgb(118, 118, 118);
}
.inner .container .qnaFrm td:nth-child(2) {
    padding-left: 10px;
}
.inner .container .qnaFrm td #file {
    margin-left: 10px;
}
.inner .container .qnaFrm td .open {
    margin-left: 5px;
}

.inner .container .qnaFrm .subj{
    width: 200px;
   	background-color: #333;
	color: white;
    border-right: 1px solid rgb(118, 118, 118);
    text-align: center;
}
.inner .container .qnaFrm .contentfrm{
    margin-top: 10px;
    margin-bottom: 10px;
    margin-left: 5px;
    width: 840px;
    height: 150px;
    font-size: 14px;
    line-height: 24px;
    color: #37434c;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: 700;
    border: 1px solid rgb(118, 118, 118);
}
.inner .container .qnaFrm .getInfo{
    width: 400px;
    height: 40px;
    border: 1px solid rgb(118, 118, 118);
    box-sizing: border-box;
    margin-left: 5px;
}
.inner .container .qnaFrm #category{
    width: 200px;
    height: 40px;
    border: 1px solid rgb(118, 118, 118);
    margin-left: 5px;
}


/* TITLE */
.inner .container h1{
    width: 200px;
    height: 40px;
    text-align: center;
    margin-left: 380px;
    margin-bottom: 50px;
    color: #a23f25;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: bold;
}
</style>
</head>
<%
	
	String myid = (String)session.getAttribute("myid");
	String currentPage = request.getParameter("currentPage");
	//perpage
	int perPage = 10;
	if(request.getParameter("perPage")!=null){
		perPage = Integer.parseInt(request.getParameter("perPage"));
	}
	
	//키워드값
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	System.out.println("writeqna.jsp파일");
	System.out.println(keyField +"키필드입니다.");
	System.out.println(keyWord +"키워드입니다.");
	
	LoginDao dao = new LoginDao();
	LoginDto dto = dao.getUserInfo(2, myid);
	
%>
<body>
    <div class="inner">
        <div class="container">
            <h1>Q&A</h1>
            <form action="service/writeAction.jsp" method = "post" enctype="multipart/form-data"  >
                &nbsp;<span><span class="ast"> * </span>표시는 필수 입력사항입니다.</span>
                <table class="qnaFrm">
                    <tr>
                        <td class="subj">카테고리<span class="ast"> * </span></td>
                        <td>
                            <select name="category" id="category">
                                <option value="서비스">서비스</option>
                                <option value="이용방법">이용방법</option>
                                <option value="개인정보">개인정보</option>
                                <option value="기타">기타</option>
                                
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="subj">작성자</td>
                        <td>
                            <input type="text" value = "<%=dto.getName()%>"class="getInfo" name = "writer" readonly required>
                        </td>
                    </tr>
                    <tr>
                        <td class="subj">공개여부<span class="ast"> * </span></td>
                        <td>
                            <label>
                               <input class = "open" type="radio" name="open" checked value = "yes">공개
                            </label>
                            <label>
                                <input class = "open"  type="radio" name="open" value = "no" >비공개
                            </label>

                        </td>
                    </tr>
                    <tr>
                        <td class="subj">전화번호</td>
                        <td>
                            <input type="text" name = "mobile" class="getInfo" placeholder="전화번호">
                        </td>
                    </tr>
                    <tr>
                        <td class="subj">E-mail</td>
                        <td>
                            <input type="email" name = "mail" class="getInfo" placeholder="E-mail">
                        </td>
                    </tr>
                    <tr>
                        <td class="subj">제목<span class="ast"> * </span></td>
                        <td>
                            <input type="text" name = "subject" class="getInfo subject" placeholder="졔목" required>
                        </td>
                    </tr>
                    <tr>
                        <td class="subj">내용<span class="ast"> * </span></td>
                        <td>
                            <textarea  name="contents" class="contentfrm" required class = "form-control" ></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="subj">첨부파일</td>
                        <td><input type = "file" name = "file" id ="file" onchange = "readUrl(this)"></td>
                    </tr>
                </table>
				<input type = "hidden" name = "currentPage" value=<%=currentPage%>>
				<input type = "hidden" name = "perPage" value=<%=perPage%>>
				<input type="hidden" name="keyField" value="<%=keyField%>">
			    <input type="hidden" name="keyWord" value="<%=keyWord%>">
			    <input type="hidden" name="passw" value="<%=dto.getName()%>">
                <div class="btnContainer">
                    <button type = "submit" class="baseBtn write">작성</button>
                    <button type = "reset"  class="baseBtn rewrite">재작성</button>
                    <button type = "button"  class="baseBtn back"  onclick="location.href = 'index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>'">목록</button>
                </div>
            
            </form>
        </div>
    </div>
	<script>
		//제목에 포커스
		$(".subject").focus();
	</script>
</body>
</html>