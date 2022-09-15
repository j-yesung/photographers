<%@page import="team.gallery.model.GalleryDAO"%>
<%@page import="team.mypage.model.UserLikeDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="team.mypage.model.UserCartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% if(session.getAttribute("userId") == null){ // 비로그인시%>
  <script>
  	alert("일반회원님만 이용하실 수 있습니다~");
     window.location="/team/user/loginForm.jsp";
  </script>
<%} %>   
<%
	request.setCharacterEncoding("UTF-8");

	String u_id = (String)session.getAttribute("userId");
	String u_id2 = request.getParameter("u_id2");
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	
	GalleryDAO galleryDao = new GalleryDAO();
	galleryDao.addLikeCount(g_bno);

	UserLikeDAO dao = new UserLikeDAO(); 
	// dao 통해서 해당 g_bno와 u_id가 일치하는 레코드가 있는지 체크 
	if(!dao.confirmLike(g_bno, u_id)){
		// 없으면 아래 인서트 날리기 
		dao.insertLike(u_id, u_id2, g_bno); %>
		
		<script>
			alert("관심상품에 새로 추가되었습니다!!!!!!");
			history.go(-1);
		</script>	
	
<%	}else{ // 있으면 이미 관심상품에 있다...%>
	
	<script>
		alert("관심상품에 이미 추가되었습니다.!");
		history.go(-1);
	</script>

<%} %>

</body>
</html>