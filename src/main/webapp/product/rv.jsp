<%@page import="java.util.List"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>Insert title here</title>
</head>
<body>
<%
ProductDao dao = new ProductDao();


//페이징 처리에 필요한 변수선언
int perPage = 6;//한페이지에 보여질 글의 갯수
int totalCount;//총 글의 수
int currentPage;//현재페이지 번호
int totalPage;//총페이지수
int start;//각 페이지에서 불러올 db의 시작번호
int perBlock=5;//몇개의 페이지번호씩 표현할 것인가
int startPage;//각 블럭에 표시할 시작페이지
int endPage;//각 블럭에 표시할 마지막페이지



String writer = "rv"; 

//총 갯수
totalCount = dao.getTotalCount(writer);

/* totalCount = dao.getTotalCount();
 */
//현재 페이지 번호 읽기(단, null일 경우 1page로 설정)
if(request.getParameter("currentPage")==null)
	currentPage = 1;
else
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	//request.getParameter("currentPage")>서버에서 받아온 currentPage를 int로 변환해줘야함

//총 페이지 갯수 구하기
totalPage =totalCount/perPage + (totalCount%perPage==0?0:1); 
	//총 페이지 = 총 글수 / 페이지에 보여질 글 갯수 + (나머지글 총글수%페이지보여질글수)0?0:1;

//각 블럭의 시작페이지
startPage= (currentPage-1)/perBlock * perBlock +1;
endPage = startPage + perBlock-1;
if(endPage>totalPage)
	endPage = totalPage;
start = (currentPage-1) * perPage;

List<ProductDto> list = dao.getList(writer, start, perPage);

//로그인에 관한
String email = (String)session.getAttribute("myid");
//로그인상태 확인
String loginok = (String)session.getAttribute("loginok");
String admin = "admin";


if(list.size()==0 && totalCount>0){%>
	<script type="text/javascript">
	location.href = "index.jsp?main=product/productform.jsp?go=rv.jsp?currentPage=<%=currentPage -1%>"
	</script>
<%}
%>
<%
if(totalCount == 0){%>
	<div>
		<b>등록된 상품이 없습니다</b>
	</div>
<%}else{
for(ProductDto dto:list){
	
	if(dto.getWriter().equals("rv")){
%>
	
	
	<div class="col-md-4 d-flex">
		<div class="product ftco-animate">
			<div class="img d-flex align-items-center justify-content-center"
				style="background-image: url(save/<%=dto.getPhotoname() %>);">\
				<div class="desc">
					<p class="meta-prod d-flex">
						<a href="#"
							class="d-flex align-items-center justify-content-center"><span
							class="flaticon-shopping-bag"></span></a> <a href="../index.jsp?main=product/productform.jsp?go=detail.jsp"
							class="d-flex align-items-center justify-content-center"><span
							class="flaticon-heart">
							</span></a> <a href="index.jsp?main=product/detail.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>&keydsds=list"
							class="d-flex align-items-center justify-content-center"><span
							class="flaticon-visibility"></span></a>
					</a>
					</p>
				</div>
			</div>
			<div class="text text-center">
				<span class="sale">Hot</span> <span class="category"><%=dto.getWriter() %></span>
				<h2><%=dto.getSubject() %></h2>
				<p class="mb-0">

					<span class="price price-sale"></span> <span class="price"></span>
				</p>
			</div>
		</div>
	</div>
<%}
}

}
%>
<div> 
<hr>
</div>
<!-- 페이징 -->
<div class="row mt-5" style="margin-botton: 30px; width: 800px; bottom: 20px;" >
	<div class="col text-center">
		<div class="block-27" style="margin-botton: 30px;">
	<ul>
<%
	for(int pp=startPage;pp<=endPage;pp++)
	{
		if(pp==currentPage)//만약에 현재페이지면 액티브를 주겠다.
		{%>
			<li>
			<a href="index.jsp?main=product/productform.jsp?go=rv.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
		<%}else{ %>
			<li>
			<a href="index.jsp?main=product/productform.jsp?go=rv.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
			
		<%}
	}
	if(startPage>1){%>
	<li>
		<a href="index.jsp?main=product/productform.jsp?go=rv.jsp?currentPage=<%=startPage-1%>">이전</a></li>
	<%}
	//다음
	if(endPage<totalPage){%>
		<li>
			<a href="index.jsp?main=product/productform.jsp?go=rv.jsp?currentPage=<%=endPage+1%>">다음</a></li>
	<%}
	%>
	</ul>
</div> 
</div> 
</div> 
<%
if(admin.equals(email)){%>
	
	<div>

 		<button type="button" class="btn btn-info btn-xs"
		style=" margin-left: 700px; margin-bottom: 20px;"
		onclick="location.href='index.jsp?main=product/smartform.jsp'">
		<span class="glyphicon glyphicon-pencil">상품추가</span></button>
	</div>

<%}
%>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="js/google-map.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
	<script src="js/main.js"></script>

</body>
</html>