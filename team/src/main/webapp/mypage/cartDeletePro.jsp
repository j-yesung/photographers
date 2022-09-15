<%@page import="team.mypage.model.UserCartDAO"%>
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
  		opener.location.href="cartView.jsp";
  		self.close();
  	}
</script>
  	
  	<center>
  	삭제되었습니다.
  	<br/><br/>
  	<input type="button" onclick="check();" value="확인"/>
  	</center>
  	
 <%
  	 UserCartDAO dao = new UserCartDAO();
  	  
  	  	String deleteCart = request.getParameter("deleteCart");
  	  	System.out.println(deleteCart);
  	  	String [] delete = deleteCart.split(",");
  	  	
  	  	
  	  	for(String cart : delete){
  	  		dao.cartDelete(Integer.parseInt(cart));
  	  	}
  	 %>
<body>

</body>
</html>