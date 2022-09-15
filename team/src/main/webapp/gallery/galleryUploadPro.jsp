<%@page import="team.gallery.model.GalleryDAO"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 등록 Pro 작업 진행</title>
</head>

<%
		request.setCharacterEncoding("UTF-8");
		GalleryDTO gallery = new GalleryDTO(); 
		
		String path = request.getRealPath("save"); 
		System.out.println(path);
		int max = 1024*1024*20; 
		String enc = "UTF-8"; 
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
		
		// u_id 넣기 (로그인 된상태에서) : 로그인한 사용자의 u_id가 필요해, session에서 꺼내옴
		String u_id = null; 
		if(session.getAttribute("userId") != null){ // 로그인을 했다면 (로그인pro에서 session에 userId라는 이름으로 사용자 id가 저장되었다면)
			u_id = (String)session.getAttribute("userId");
		}
		
		//String u_id2 = (String)session.getAttribute("userId"); // userId로 꺼냈을때 아이디가 있으면(로그인 했으면) id가 나올것이고, 로그인 안했음(userId로 뽑아도 안나온다) null 상태로 남는다.

		gallery.setU_id(u_id);
		gallery.setG_subject(mr.getParameter("g_subject"));
		gallery.setU_email(mr.getParameter("u_email"));
		gallery.setCategory1(Integer.parseInt(mr.getParameter("category1")));
		gallery.setCategory2(Integer.parseInt(mr.getParameter("category2")));
		gallery.setG_price(Integer.parseInt(mr.getParameter("g_price")));
		gallery.setU_sns(mr.getParameter("u_sns"));
		gallery.setG_content(mr.getParameter("g_content"));
		gallery.setG_tag(mr.getParameter("g_tag"));
		gallery.setG_imgLocation(mr.getParameter("g_imglocation"));
		gallery.setG_imgLens(mr.getParameter("g_imgLens"));
		gallery.setG_imgCamera(mr.getParameter("g_imgCamera"));
		gallery.setG_imgQuality(mr.getParameter("g_imgQuality"));
		gallery.setG_img(mr.getParameter("g_img"));
		
		gallery.setG_status(0);
		gallery.setG_like(0);
		gallery.setG_readCount(0);
		
		// 파일 업로드를 했다면 저장된 파일명으로 DTO의 g_img 변수 채워주기.
		if(mr.getFilesystemName("g_img") != null) {
		   gallery.setG_img(mr.getFilesystemName("g_img"));
		}else {	// 파일 업로드를 안 했으면, save폴더에 있는 default 이미지 파일명으로 채우기.
		   gallery.setG_img(mr.getParameter("g_imgEx"));
		}
		
		GalleryDAO dao = new GalleryDAO();
		dao.insertGallery(gallery);
		
		String pageNum = mr.getParameter("pageNum");
		if(pageNum == null) { pageNum = "1"; }
		%>
		
		<script>
			alert("작성 완료!!!");
			window.location.href = "showAll.jsp";
	<%-- window.location.href = "showAll.jsp?pageNum=<%=pageNum%>"; --%>
			
		</script>


<body>

</body>
</html>