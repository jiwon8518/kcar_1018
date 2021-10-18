<%@page import="java.net.URLEncoder"%>
<%@page import="data.dto.ServiceDto"%>
<%@page import="data.dao.ServiceDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션으로부터 db에 저장할 아이디 얻기
	String myid = (String)session.getAttribute("myid");
	
	//이미지가 업로드될 실제 경로 구하기
	String realPath = getServletContext().getRealPath("/files");
	System.out.println(realPath); 
	
	//파일 사이즈 제한
	int uploadSize = 1024*1024*4;//1mb *4
	MultipartRequest multi = null;
	
	try{
		multi = new MultipartRequest(request, realPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		//(주의)request 가 아닌 multi 변수로 모든 폼데이터를 읽어야한다
		String currentPage = multi.getParameter("currentPage");
		System.out.println(currentPage + "현제페이지불러온값");
		//페이지당글갯수
		int perPage = 10;
		if(request.getParameter("perPage")!=null){
			perPage = Integer.parseInt(multi.getParameter("perPage"));
		}
		//키워드값
		String keyField = multi.getParameter("keyField");
		String keyWord = multi.getParameter("keyWord");
		keyWord = URLEncoder.encode(keyWord,"UTF-8");
		System.out.println("writeAction.jsp파일");
		System.out.println(keyField +"키필드입니다.");
		System.out.println(keyWord +"키워드입니다.");
		
		String category = multi.getParameter("category");
		String writer = multi.getParameter("writer");
		String open = multi.getParameter("open");
		String mobile = multi.getParameter("mobile");
		String jaid = multi.getParameter("passw");
		if(mobile.equals("")){
			mobile = "미입력";
		}
		String mail = multi.getParameter("mail");
		if(mail.equals("")){
			mail = "미입력";
		}
		String subject = multi.getParameter("subject");
		String contents = multi.getParameter("contents");
		String file = multi.getFilesystemName("file");//실제 업로드될 파일명 
		if(file == null){
			file = "미입력";
		}
		
		//받은값검사
		System.out.println(open);
		/* System.out.println(category);
		System.out.println(writer);
		System.out.println(mobile);
		System.out.println(mail);
		System.out.println(subject);
		System.out.println(contents);
		System.out.println(file);  */
			
		//dto 에 저장
		ServiceDto dto = new ServiceDto(category, writer, open, mobile, mail, subject, contents, file, myid);
		dto.setJaid(jaid);
		System.out.println(myid + "2");
		//dao 선언
		ServiceDao dao = new ServiceDao();
		//insert
		dao.insertContent(dto);
		//방명록으로 이동
		response.sendRedirect("../index.jsp?main=service/qnalist.jsp?currentPage="+currentPage+"&perPage="+perPage+"&keyField="+keyField+"&keyWord="+keyWord);
	} catch (Exception e){
		System.out.println("업로드오류:" + e.getMessage());
	}
%>