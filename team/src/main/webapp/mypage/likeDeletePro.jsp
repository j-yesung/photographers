<%@page import="team.mypage.model.UserLikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("UTF-8");
%>
</head>
<script>
  	function check(){
  		opener.location.href="likeView.jsp";
  		self.close();
  	}
</script>
  	
  	<center>
  	삭제되었습니다.
  	<br/><br/>
  	<input type="button" onclick="check();" value="확인"/>
  	</center>
  	
 <%
  	 UserLikeDAO dao = new UserLikeDAO();
  	  
  	  	String deleteLike = request.getParameter("deleteLike");
  	  	System.out.println(deleteLike);
  	  	String [] delete = deleteLike.split(",");
  	  	
  	  	
  	  	for(String like : delete){
  	  		dao.likeDelete(Integer.parseInt(like));
  	  	}
  	 %>
<body>

</body>
</html>