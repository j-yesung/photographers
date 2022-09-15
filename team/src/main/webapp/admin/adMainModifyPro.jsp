<%@page import="team.admin.model.AdminDAO"%>
<%@page import="team.admin.model.AdminDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지-메인 이미지 수정 Pro</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	AdminDTO img = new AdminDTO(); 
	
	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*20; 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	img.setSi_MainImg(mr.getParameter("si_MainImg"));
	img.setSi_TodayImg(mr.getParameter("si_TodayImg"));
	
	if(mr.getFilesystemName("si_MainImg") != null) { img.setSi_MainImg(mr.getFilesystemName("si_MainImg")); }
	else { img.setSi_MainImg(mr.getParameter("si_MainImgEx")); }
	
	if(mr.getFilesystemName("si_TodayImg") != null) { img.setSi_TodayImg(mr.getFilesystemName("si_TodayImg")); }
	else { img.setSi_TodayImg(mr.getParameter("si_TodayImgEx")); }
	
	
	AdminDAO dao = new AdminDAO(); 
	int result = dao.updateImg(img);
	
	if(result != 0) { %>
		<script>
			alert("수정완료!!!");
			window.location.href="/team/banner/main.jsp";
		</script>
<%	}%>
		
		
<body>
	
</body>
</html>