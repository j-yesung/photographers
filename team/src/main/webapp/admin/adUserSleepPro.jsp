<%@page import="team.user.model.UserDAO"%>
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
	//int u_userno = Integer.parseInt(request.getParameter("u_userno"));
	String u_id = request.getParameter("u_id");
	
	UserDAO dao = new UserDAO(); 
	dao.sleepUser(u_id); 
	
	%>
		<script>
			alert("휴면계정 전환 완료!!!");
			window.location.href="/team/admin/adUserSearch.jsp?pageNum=<%=pageNum%>";
		</script>
	

</body>
</html>