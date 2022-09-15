<%@page import="team.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복확인</title>
</head>
<%
	request.setCharacterEncoding("UTF-8"); 
	// open(url...) : url = confirmId.jsp?u_id=값
	String u_id = request.getParameter("u_id");
	// DB 연결해서 사용자가 작성한 id값이 db테이블에 존재하는지 검사 
	UserDAO dao = new UserDAO(); 
	boolean result = dao.confirmId(u_id); // true 이미존재함, false 존재X -> 사용가능 
%>
<body>
<%
	if(result) { // true -> 이미 존재 -> 사용불가  %>
	<br />
	<table>
		<tr>
			<td><%= u_id%>은/는 이미 사용중인 아이디 입니다.</td>
		</tr>
	</table> <br />
	<form action="confirmId.jsp" method="post">
		<table>
			<tr>
				<td> 다른 아이디를 선택하세요. <br />
					<input type="text" name="u_id" /> 
					<input type="submit" value="아이디 중복확인" />
				</td>
			</tr>		
		</table>
	</form>
		
<%	}else { // false -> 존재 X -> 사용 가능 %>
	
	<br />
	<table>
		<tr>
			<td>입력하신 <%= u_id%>은/는 사용 가능합니다. <br />
				<input type="button" value="닫기" onclick="setU_id()" />
			</td>
		</tr>
	</table>
		
<%	}%>

	<script>
		function setU_id() {
			// 팝업을 열어준 원래 페이지의 id input태그의 value를
			// 최종 사용할 id로 변경. 
			opener.document.inputForm.u_id.value = "<%= u_id%>";
			// 현재 팝업 닫기. 
			self.close(); 
		}
	</script>
</body>
</html>