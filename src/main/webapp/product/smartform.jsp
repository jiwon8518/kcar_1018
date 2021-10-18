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
table tr th{
text-align: center;
}

</style>
<%
	//프로젝트의 경로
	String root=request.getContextPath();
%>
<!-- se2 폴더에서 js 파일 가져오기 -->
<script type="text/javascript" src="<%=root%>/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<script type="text/javascript" src="<%=root%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="utf-8"></script>	
	
	
<script type="text/javascript">
	$(function() {
		$("span.camera").click(function() {
			$("#photo").trigger("click");//이벤트 강제호출
		});
	});
	
	//이미지 미리보기 할 함수
	function readUrl(input) {
		if(input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#showimg").attr("src",e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
	
</head>

<body>

<!-- 이미지 미리보기할 위치 -->
	<div>
	<img id="showimg" style="position: absolute; left: 1000px; top:400px; max-width: 300px;">
	<b style="position: absolute; left: 1000px; top:350px; max-width: 300px;">썸네일 이미지(미리보기)</b>
	</div>
	
	<form action="product/smartaction.jsp" method="post" enctype="multipart/form-data" style="margin-left: 350px; margin-top: 100px;">
		<table style="width: 580px;">

			<tr>
			<th bgcolor="orange" width="100">종 류</th>
			<td>
				<select name="writer" class="form-control"
					required="required" style="width: 500px;">
					<option selected disabled>선택</option>
					<option value="ev">ev</option>
					<option value="rv">rv</option>
					<option value="seungyong">seungyong</option>
					<option value="sangyoung">sangyoung</option>
				</select>
			</td>
		</tr>
		<tr>
			<th bgcolor="orange" width="100">차  종</th>		
			<td>
				<input type="text" name="subject" class="form-control"
					required="required" style="width: 500px;">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="content" id="content"		
					required="required"			
					style="width: 100%;height: 300px;display: none;"></textarea>		
			</td>
		</tr> 
		<tr>
				<td colspan="2">
					<button type="submit" class="btn btn-default" 
					style="width: 100px; margin-left: 450px; height: 100px;"onclick="submitContents(this)"
					>등록</button>
				</td>
		</tr>
		<caption style="margin-bottom: 500px;"><b>썸네일 이미지</b>
		<span class="glyphicon glyphicon-camera camera" style="font-size: 20px;"></span>
		<input type="file" name="photo" id="photo" style="visibility: hidden;"
		onchange="readUrl(this)"><!-- readUrl(this):사진업로드시 미리보기 -->
		</caption>
		</table>
	</form>

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






















