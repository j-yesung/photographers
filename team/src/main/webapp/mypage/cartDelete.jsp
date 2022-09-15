<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품삭제</title>
</head>
<form action="cartDeletePro.jsp" method="post"/>
 	<center>
  	상품을 장바구니에서 지우시겠습니까?
  	<br /><br />
  	<input type="submit" value="확인" name="check"/>
  	<input type="button" value="취소" name="cancel" onclick="self.close();" />
 	</center>
  	
  	<%
  		String str = "";
  		String [] deleteCart = request.getParameterValues("ucno");
  		for(String c : deleteCart){
  			str += c+",";
  		}
  	%>
  	<input type="hidden" name="deleteCart" value="<%=str %>" />
 	</form>


<body>

</body>
</html>