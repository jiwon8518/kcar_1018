<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="data.dto.ServiceDto"%>
<%@page import="data.dao.ServiceDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//이미지가 업로드될 실제 경로 구하기
	String realPath = getServletContext().getRealPath("/files");
	/* System.out.println(realPath);  */
	
	//사이즈 제한
	int uploadSize = 1024*1024*4;//4mb
	MultipartRequest multi = null;
	
	try{
		multi = new MultipartRequest(request, realPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		//(주의)request 가 아닌 multi 변수로 모든 폼데이터를 읽어야한다
		String num = multi.getParameter("num");
		String currentPage = multi.getParameter("currentPage");
		//perpage
		int perPage = 10;
		if(multi.getParameter("perPage")!=null){
			perPage = Integer.parseInt(multi.getParameter("perPage"));
		}
		//키워드값
		String keyField = multi.getParameter("keyField");
		String keyWord = multi.getParameter("keyWord");
		keyWord = URLEncoder.encode(keyWord,"UTF-8");
		System.out.println("updatAction.jsp파일");
		System.out.println(keyField +"키필드입니다.");
		System.out.println(keyWord +"키워드입니다.");
		//최종 저장할 파일
		String file = "";
		//기존 파일이름
		ServiceDao dao = new ServiceDao();
		String currentFile = dao.getData(num).getFile();
		//변경할 파일
		String newFile = multi.getFilesystemName("file");
		if(newFile == null){
			file = currentFile;
		}else{
			file = newFile;
			//실제경로
			File removeFile = new File(realPath+"\\"+currentFile);
			//현제파일 삭제
			removeFile.delete();
		}
		
		
		//변경정보
		String category = multi.getParameter("category");
		String open = multi.getParameter("open");
		String mobile = multi.getParameter("mobile");
		if(mobile.equals("")){
			mobile = "미입력";
		}
		String mail = multi.getParameter("mail");
		if(mail.equals("")){
			mail = "미입력";
		}
		String subject = multi.getParameter("subject");
		String contents = multi.getParameter("contents");
		
		//check values
	/* 	System.out.println(num + " 숫자");
		System.out.println(currentPage + " 현제페이지");
		System.out.println(category + " 카태고리");
		System.out.println(open + " 공개여부");
		System.out.println(mobile + " 전화번호");
		System.out.println(mail + " 이메일");
		System.out.println(subject + " 주제");
		System.out.println(contents + " 내용");
		System.out.println(currentFile + " 현재파일");
		System.out.println(newFile + " 새로운파일");
		System.out.println(file + " 최종파일"); */
	
		//dto 에 저장
		ServiceDto dto = new ServiceDto();
		dto.setCategory(category);
		dto.setOpen(open);
		dto.setMobile(mobile);
		dto.setEmail(mail);
		dto.setSubject(subject);
		dto.setContents(contents);
		dto.setFile(file);
		dto.setNum(num);
		
		//수정
		dao.updateDetailInfo(dto); 
		//방명록으로 이동 (수정했던 페이지로 이동)
		response.sendRedirect("../index.jsp?main=service/qnalist.jsp?currentPage="+currentPage+"&perPage="+perPage+"&keyField="+keyField+"&keyWord="+keyWord);
	} catch (Exception e){
		System.out.println("업로드오류:" + e.getMessage());
	}
%>