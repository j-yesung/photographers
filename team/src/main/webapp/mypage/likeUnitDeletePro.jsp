<%@page import="team.mypage.model.PaymentDAO"%>
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
   request.setCharacterEncoding("UTF-8");

   String u_id = (String)session.getAttribute("userId");
   int ulno = Integer.parseInt(request.getParameter("ulno"));


   PaymentDAO dao = new PaymentDAO(); 
   dao.likeUnitDelete(ulno);
%>
      
      <script>
         alert("해당상품이 삭제되었습니다! ");
         window.location.href = "likeView.jsp";
      </script>

</body>
</html>