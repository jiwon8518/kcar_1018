<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.WinboardDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.WinboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<title>Insert title here</title>
</head>
<%
	WinboardDao dao = new WinboardDao();

	
	//페이징 처리에 필요한 변수선언
	int perPage = 3; //한페이지에 보여질 글의 개수
	int totalCount; //총 글의 수
	int currentPage; //현재 페이지번호
	int totalPage; //총 페이지 수
	int start;// 각페이지에서 불러올 db의 시작번호
	int perBlock = 5; //한 화면에 보여질 페이지번호의 수
	int startPage; //각 블럭에 표시할 시작 페이지
	int endPage; //각 블럭에 표시할 마지막 페이지
	 
	//총 개수
	totalCount = dao.getTotalCount();
	//현재 페이지번호 읽기(단 null일 경우는 1페이지로 설정)
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	
	//총 페이지 개수 구하기
	//totalPage = (int)Math.ceil(totalCount/(double)perPage);
	totalPage = totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작페이지
	startPage = (currentPage-1)/perBlock*perBlock+1;
	endPage = startPage+perBlock-1;
	if(endPage>totalPage)
		endPage = totalPage;
	//각 페이지에서 불러올 시작번호
	start = (currentPage-1)*perPage;
	
	//각 페이지에서 필요한 게시글 가져오기
	List<WinboardDto> list = dao.getList(start, perPage);
	 
	if(list.size()==0 && totalCount > 0)
	{%>
		<script type="text/javascript">
			location.href="index.jsp?main=board/boardlist.jsp?currentPage=<%=currentPage-1%>";
		</script>
	<%}
	 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	//각페이지에 출력할 시작번호
	int no = totalCount-(currentPage-1)*perPage;
	
	String myid="";
	String name ="";
	String loginok="";
	//로그인 상태 확인후 입력폼 나타내기
	if(session.getAttribute("loginok")!=null){
		loginok = (String)session.getAttribute("loginok");
		
		myid = (String)session.getAttribute("myid");
	}
%>

<body>

<div class="page-wrapper">
    <div class="container-fluid">
        <div class="col-lg-8"><!--게시판 넓이 -->
            <div class="col-lg-12">
            	<a href='index.jsp?main=event/eventlist.jsp'><i class='fas fa-angle-left' style='cursor:pointer;'>돌아가기</i></a>
                <h1 class="page-header">이벤트 당첨자 발표</h1>
            </div>
            <div class="row">
                  <div class="col-lg-12">
                  
                  <%
					//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 글쓰기 버튼 보이게한다.
						if(loginok!=null && myid.equals("admin")){%>
                      <button type="button" class="btn btn-outline btn-primary pull-right"
                      onclick="location.href='index.jsp?main=event/winform.jsp'">
                          <i class="fa fa-edit fa-fw"></i> 글작성
                   <%} %>
                      </button>
                  </div>
              </div>
            <div class="panel panel-default">
                <div class="panel-heading">당첨자 발표</div>
                <div class="panel-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="color:black;">No.1</th>
                                <th style="color:black;">제목</th>
                                <th style="color:black;">작성자</th>
                                <th style="color:black;">작성일</th>
                                <th style="color:black;">조회수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
						     <%
							if(totalCount==0)
							{%>
								<tr height="40">
									<td colspan="5" align="center">
										<b>등록된 게시글이 없습니다.</b>
									</td>
								</tr>
							<%}else{
								for(WinboardDto dto:list)
								{%>
									<tr>
										<td align="center"><%=no-- %></td>
										<td>
											<a style="color: black;"
											 href="index.jsp?main=event/windetail.jsp?num=<%=dto.getNum()%>&currentPage=<%= currentPage%>&key=list">
											<%=dto.getSubject() %>
											</a>
										</td>
										<td><%=dto.getWriter() %></td>
										<td><%=sdf.format(dto.getWriteday()) %></td>
										<td><%=dto.getReadcount() %></td>
									</tr>			
								<%}
							}		
							%>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container">
<!-- 페이징 -->
<div style="width: 580px;text-align: center;">
	<ul class="pagination">
	<%
	
	//이전
	if(startPage>1)
	{%>
		<li>
		<a href="index.jsp?main=event/winboard.jsp?currentPage=<%=startPage-1%>">이전</a>
		</li>
	<%}
	
	for(int pp = startPage; pp <= endPage;pp++)
	{
		if(pp==currentPage) //현재페이지일때 active
		{%>
			<li class="active">
			<a href="index.jsp?main=event/winboard.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
		<%}else{%>
			<li>
			<a href="index.jsp?main=event/winboard.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
		<%}
	}
	
	//다음
	if(endPage<totalPage)
	{%>
		<li>
		<a href="index.jsp?main=event/winboard.jsp?currentPage=<%=endPage+1%>">다음</a>
		</li>
	<%}
	%>
	</ul>
</div>
</div>
</body>
</html>