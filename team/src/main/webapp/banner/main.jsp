<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@page import="team.admin.model.AdminDAO"%>
<%@page import="team.admin.model.AdminDTO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="stylesheet" type="text/css" href="styleBanner.css">
<link rel="stylesheet" type="text/css" href="styleBannerBtn.css">
</head>
<%
	AdminDAO adminDAO = new AdminDAO();
	AdminDTO main = adminDAO.getImg();
	
	GalleryDAO dao = new GalleryDAO();
	GalleryDTO gallery = dao.getMaxReadCountGallery();
	GalleryDTO gallery2 = dao.getMaxLikeGallery();
%>
<body>

<%-- 상단바 --%>
	<jsp:include page="/layout/top.jsp"/>

<%-- 이미지 --%>
	<div style="width: 2000px; height: 1000px; margin: 20px 0px 10px 20px; ">
		<div><img src="/team/save/<%=main.getSi_MainImg()%>" width="1820" height="1000"/></div>
	</div>
	
	<div style="width: 2200px; height: 400px; margin: 20px;">
		<div class="image">
			<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery2.getG_bno()%>">
			<img src="/team/save/<%=gallery2.getG_img()%>" width=600 height="350">
			<div>좋아요가 가장 높은 이미지</div>
			</a>
		</div>
		
		<div class="image">
			<img src="/team/save/<%=main.getSi_TodayImg()%>" width=600 height="350">
			<div>오늘의 이미지</div>
		</div>	
		
		<div class="image">
			<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>">
			<img src="/team/save/<%=gallery.getG_img()%>" width=600 height="350">
			<div>조회수가 가장 높은 이미지</div>
			</a>
		</div>
	</div>
	
</body>
</html>