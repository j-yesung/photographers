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
<title>갤러리 수정 Pro 작업 진행</title>
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
		
		gallery.setG_bno(Integer.parseInt(mr.getParameter("g_bno")));
		gallery.setG_subject(mr.getParameter("g_subject"));
		gallery.setG_content(mr.getParameter("g_content"));
		gallery.setU_email(mr.getParameter("u_email"));
		gallery.setU_sns(mr.getParameter("u_sns"));
		gallery.setG_price(Integer.parseInt(mr.getParameter("g_price")));
		gallery.setG_imgLocation(mr.getParameter("g_imglocation"));
		gallery.setG_imgLens(mr.getParameter("g_imgLens"));
		gallery.setG_imgCamera(mr.getParameter("g_imgCamera"));
		gallery.setG_imgQuality(mr.getParameter("g_imgQuality"));
		gallery.setG_tag(mr.getParameter("g_tag"));
		gallery.setCategory1(Integer.parseInt(mr.getParameter("category1")));
		gallery.setCategory2(Integer.parseInt(mr.getParameter("category2")));
		
		// 파일 업로드를 했다면 저장된 파일명으로 DTO의 g_img 변수 채워주기.
		if(mr.getFilesystemName("g_img") != null) {
			gallery.setG_img(mr.getFilesystemName("g_img"));
		}else {	// 파일 업로드를 안 했으면, save폴더에 있는 default 이미지 파일명으로 채우기.
			gallery.setG_img(mr.getParameter("g_imgEx"));
		}

		String pageNum = mr.getParameter("pageNum");
		
		GalleryDAO dao = new GalleryDAO(); 
		int result = dao.updateArticle(gallery);
		
		if(result !=0){ %>
			<script>
					alert("수정 완료!!!");
					window.location.href = "/team/mypage/boardManage.jsp"; 
			</script>

<%		} %>
<body>

</body>
</html>