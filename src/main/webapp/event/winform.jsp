<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<%
	//프로젝트의 경로
	String root=request.getContextPath();
	Date nowTime = new Date();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월dd일 HH:mm");
	String myid="";
	String name ="";
	String loginok="";
	//로그인 상태 확인후 입력폼 나타내기
	if(session.getAttribute("loginok")!=null){
		loginok = (String)session.getAttribute("loginok");
		
	myid = (String)session.getAttribute("myid");
	}
%>
<!-- se2 폴더에서 js 파일 가져오기 -->
<script type="text/javascript" src="<%=root%>/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<script type="text/javascript" src="<%=root%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="utf-8"></script>	
</head>
<body>

<div class="row">
 <div class="col-md-2"></div>
 <div class="col-md-8">
  <h2 class="text-center">게시글 작성</h2><p>&nbsp;</p>
  <form action="event/winaction.jsp" method="post">
   <div class="table table-responsive">
       <table class="table table-striped">
    <tr>
     <td class="danger">작성자</td>
     <input type="hidden" id="writer" name="writer" value="<%=myid %>">
     <td><%=myid %></td>
     <td class="danger">작성일</td>
     <td><%= sdf.format(nowTime) %></td>
    </tr>
    <tr>
     <td class="danger">제목</td>
     <td colspan="3"><input type="text"  class="form-control" name="subject" value=""></td>
    </tr>
    
    <tr>
     <td class="danger">글내용</td>
     <td colspan="3"><textarea name="content" id="content"		
					required="required"			
					style="width: 100%;height: 300px;display: none;"></textarea></td>
    </tr>
    
     <tr> 
     <td colspan="4"  class="text-center">
      <input type="hidden" name="num"  value="">
      <input type="submit" value="글입력" onclick="submitContents(this)" class="btn btn-warning">
      <input type="button"  class="btn btn-primary" onclick="location.href='index.jsp?main=event/winboard.jsp'" value="전체글보기">
     </td>
    </tr>
    </table>
  
 
   </div>
  </form> 
 </div>
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






















