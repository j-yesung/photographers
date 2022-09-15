<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>main.jsp</title>

</head>
<body>
	<br />
	<h1 align="left"> 기능구현 테스트용 메인페이지  </h1>
	
	<% if(session.getAttribute("userId") == null){ %>
	<table>
		<tr>
			<td><button onclick="window.location='loginForm.jsp'">로그인</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='signupForm.jsp'">회원가입</button></td>
		</tr>
	</table>
	<%}else {%>
	
	<table>
		<tr>
			<td><button onclick="window.location='logout.jsp'">로그아웃</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='mypage.jsp'">마이페이지</button></td>
		</tr>
		
		
		<tr>
			<td><button onclick="window.location='userModifyForm.jsp'">회원정보 수정하기</button></td>
		</tr>
		<tr>
			<td><button onclick="window.location='userDeleteForm.jsp'">회원정보 탈퇴하기</button></td>
		</tr>
		<tr>
       		<td><button onclick="window.location='/team/gallery/showAll.jsp'">갤러리 전체보기</button></td>
		</tr>


	</table>
	<%} %>
	<br /><br />
	<div align="center">
		<img src="img/login.jpg" width="300px" />
	</div>
	
</body>
</html>