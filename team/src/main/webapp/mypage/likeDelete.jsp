<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품삭제</title>
</head>
<form action="likeDeletePro.jsp" method="post"/>
 	<center>
  	관심상품 리스트를 비우시겠습니까?
  	<br /><br />
  	<input type="submit" value="확인" name="check"/>
  	<input type="button" value="취소" name="cancel" onclick="self.close();" />
 	</center>
  	
  	<%
  		String str = "";
  		String [] deleteLike = request.getParameterValues("ulno");
  		for(String l : deleteLike){
  			str += l+",";
  		}
  	%>
  	<input type="hidden" name="deleteLike" value="<%=str %>" />
 	</form>


<body>

</body>
</html>