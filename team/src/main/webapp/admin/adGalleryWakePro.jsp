<%@page import="team.gallery.model.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String pageNum = request.getParameter("pageNum");
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	
	GalleryDAO dao = new GalleryDAO(); 
	dao.wakeArticle(g_bno); 
	
	%>
		<script>
			alert("판매 가능한 상태로 변경됐습니다!!!");
			window.location.href="/team/admin/adBoardManage.jsp?pageNum=<%=pageNum%>";
		</script>

</body>
</html>