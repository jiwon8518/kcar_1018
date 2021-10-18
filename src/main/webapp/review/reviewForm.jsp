<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
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
	margin: 100px 150px;
}
th {
	width: 150px;
}
th>b, h5>b {
	color: red;
}
th {
	font-size: 12pt;
}
</style>

<%
	//프로젝트의 경로
	String root=request.getContextPath();
	
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email);
%>

<!-- se2 폴더에서 js 파일 가져오기 -->
<script type="text/javascript" src="<%=root%>/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
	

<script type="text/javascript">
$(function () {
	//취소확인창
	$("#reviewcancel").click(function () {
		let cancel = confirm("변경 사항이 저장되지 않을 수 있습니다.\n글쓰기에서 나가시겠습니까?");
		if(cancel){
			history.back();
		}
	});
});
</script>
</head>

<body>
<div class="bg">
	<h3 style="margin-bottom: 25px;"><b>시승후기 게시판</b></h3>
	<h5 style="text-align: right;"><b>*</b>&nbsp;는 필수 입력 항목입니다.</h5>
	<form action="review/reviewAction.jsp" method="post" class="form-inline" name="reviewfrm" onclick="submitContents(this)">
	<input type="hidden" name="email" value="<%= email %>">
		<table class="table talbe-bordered">
		<tr>
			<th>시승모델&nbsp;<b>*</b></th>
			<td colspan="3">
				<select id="selcar" name="car" class="form-control" style="width: 200px;" required>
					<option value="" selected disabled>선택</option>
					<option value="ev">ev</option>
					<option value="rv">rv</option>
					<option value="seungyoung">seungyoung</option>
					<option value="saungyoung">saungyoung</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td colspan="3">
				<input type="text" name="name" class="form-control" style="width: 200px;" value="<%= Ldto.getName() %>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<th>제목&nbsp;<b>*</b></th>
			<td colspan="3">
				<input type="text" name="subject" class="form-control" style="width: 500px;" required="required">
			</td>
		</tr>
		<tr>
			<th>내용&nbsp;<b>*</b></th>
			<td colspan="3">
				<textarea name="content" id="content" style="width: 100%;height: 300px; display: none;"
				class="form-control" required></textarea>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3" align="right">
				<button type="submit" id="reviewadd" class="btn btn-info">등록</button>
				<button type="button" id="reviewcancel" class="btn btn-danger">취소</button>
			</td>
		</tr>
		</table>
	</form>
</div>




<!-- 스마트게시판에 대한 스크립트 코드 넣기 -->
<script type="text/javascript">
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "content",
    sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
}); 

//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
function submitContents(elClickedObj) {

    // 에디터의 내용이 textarea에 적용된다.
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [ ]);

 

    // 에디터의 내용에 대한 값 검증은 이곳에서
    // document.getElementById("textAreaContent").value를 이용해서 처리한다.
    try {
        elClickedObj.form.submit();
    } catch(e) { 

    }

}

// textArea에 이미지 첨부
function pasteHTML(filepath){
    var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]); 
}
</script>

</body>
</html>