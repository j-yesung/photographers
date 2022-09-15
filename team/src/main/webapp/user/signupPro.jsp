<%@page import="team.user.model.UserDTO"%>
<%@page import="team.user.model.UserDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 Pro</title>

</head>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="team.user.model.UserDTO" />
<%


   String path = request.getRealPath("save");
   System.out.println(path);
   int max = 1024*1024*5;
   String enc = "UTF-8"; 
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
   MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); 
   
   user.setU_id(mr.getParameter("u_id"));
   user.setU_pw(mr.getParameter("u_pw"));
   user.setU_nick(mr.getParameter("u_nick"));
   user.setU_email(mr.getParameter("u_email"));
   if(mr.getFilesystemName("u_photo") != null){ 
      user.setU_photo(mr.getFilesystemName("u_photo"));
   }else {
      user.setU_photo("default_image.png");
   }
   if(mr.getParameter("u_sns") == null || mr.getParameter("u_sns").equals("")){

      user.setU_sns("none");
   }else{
      user.setU_sns(mr.getParameter("u_sns"));
   }
   user.setU_favorite1(mr.getParameter("u_favorite1"));
   user.setU_favorite2(mr.getParameter("u_favorite2"));
   
   UserDAO dao = new UserDAO(); 
   dao.insertUser(user);   
%>
	<script>
		alert("<b><%=user.getU_id()%></b>님! 가족이 되신것을 환영합니다!");
		window.location="/team/banner/main.jsp";
	</script> 




<body>

</body>
</html>