<%@page import="team.admin.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반려프로</title>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");

	String g_comment = request.getParameter("g_comment");
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	String pageNum = request.getParameter("pageNum");
	
	
	AdminDAO dao = new AdminDAO();
	int result = dao.rejectRequest(g_bno, g_comment);
	System.out.println("Reject result : " + result);
%>

<%	if(result == 1){%>	
		<script>
			alert("반려 처리됐습니다ㅠㅠ");
			window.location.href="adSellRequest.jsp??pageNum=<%=pageNum%>";
		</script>


<%	}else{ %>
		<script>
			alert("오류 발생");
		
		</script>
<%  } %>


</body>
</html>