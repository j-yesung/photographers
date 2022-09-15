<%@page import="team.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userDeletePro.jsp</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	// 로그인 세션값 있을경우 삭제할 수 있게
	String u_id = (String)session.getAttribute("userId");
	String u_pw = request.getParameter("u_pw");
	
	UserDAO dao = new UserDAO();
	int check = dao.idPwCheck(u_id, u_pw);
	if(check == 1){ // id, pw맞다
		dao.sleepUser(u_id);	// DB에서 삭제
		session.invalidate();	// 탈퇴시 로그아웃 처리 %>
		<script>
		  <%response.sendRedirect("/team/banner/main.jsp"); %>
		    alert("회원탈퇴 처리가 완료됐습니다.");
		</script>
		 
<%	}else{ %>
		<script>
			alert("잘못된 비밀번호를 입력하셨습니다. 재입력 바랍니다.");
			history.go(-1);
		</script>
  <%} %>
	
<body>

</body>
</html>