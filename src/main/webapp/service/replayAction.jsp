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
	
	//사이즈 제한걸기
	int uploadSize = 1024*1024*4;//1mb *4
	MultipartRequest multi = null;
	
	try{
		multi = new MultipartRequest(request, realPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		//(주의)request 가 아닌 multi 변수로 모든 폼데이터를 읽어야한다
		String currentPage=multi.getParameter("currentPage");
		//페이지값
		int perPage = 10;
		if(multi.getParameter("perPage")!=null){
			perPage = Integer.parseInt(multi.getParameter("perPage"));
		}
		//키워드값
		String keyField = multi.getParameter("keyField");
		String keyWord = multi.getParameter("keyWord");
		keyWord = URLEncoder.encode(keyWord,"UTF-8");
		
		System.out.println("replyAction.jsp파일");
		System.out.println(keyField +"키필드입니다.");
		System.out.println(keyWord +"키워드입니다."); 	
		
		String category = multi.getParameter("category");
		String writer = multi.getParameter("writer");
		String open = multi.getParameter("open");
		String subject = multi.getParameter("subject");
		String contents = multi.getParameter("contents");
		String mail = multi.getParameter("mail");
		
		
		//추가
		String jaid = multi.getParameter("passw2");
		
		
		if(mail.equals("")){
			mail = "미입력";
		}
		String mobile = multi.getParameter("mobile");
		if(mobile.equals("")){
			mobile = "미입력";
		}
		int ref = Integer.parseInt(multi.getParameter("ref"));
		int pos = Integer.parseInt(multi.getParameter("pos"));
		int depth = Integer.parseInt(multi.getParameter("depth"));
		String file = multi.getFilesystemName("file");//실제 업로드될 파일명 
		if(file == null){
			file = "미입력";
		}
		
		//받은값검사
		/* System.out.println(currentPage);
		System.out.println(perPage);
		System.out.println(category);
		System.out.println(writer);
		System.out.println(open);
		System.out.println(mail);
		System.out.println(mobile);
		System.out.println(subject);
		System.out.println(contents);
		System.out.println(file);
		System.out.println(pos);
		System.out.println(ref);
		System.out.println(depth);
		System.out.println(myid); */
			
		//dto 에 저장
		ServiceDto dto = new ServiceDto();
		dto.setCategory(category);
		dto.setWriter(writer);
		dto.setOpen(open);
		dto.setSubject(subject);
		dto.setContents(contents);
		dto.setFile(file);
		dto.setPos(pos);
		dto.setRef(ref);
		dto.setDepth(depth);
		dto.setEmail(mail);
		dto.setMobile(mobile);
		dto.setId(myid);
		dto.setJaid(jaid);
		
		//dao 선언
		ServiceDao dao = new ServiceDao();
		
		//이전답글의 위치수정
		dao.replyUpBoard(ref, pos);
		//답글추가
		dao.replyBoard(dto);
		
		//방명록으로 이동
		response.sendRedirect("../index.jsp?main=service/qnalist.jsp?currentPage="+currentPage+"&perPage="+perPage+"&keyField="+keyField+"&keyWord="+keyWord);
	} catch (Exception e){
		System.out.println("업로드오류:" + e.getMessage());
	}
%>
