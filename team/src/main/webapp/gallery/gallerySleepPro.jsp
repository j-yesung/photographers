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
   dao.sleepArticle(g_bno); 
   
   %>
      <script>
         alert("숨김 완료!!!");
      window.location.href="/team/mypage/boardManage.jsp";
      </script>
   

</body>
</html>