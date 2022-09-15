<%@page import="team.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro.jsp</title>
</head>
<%
	String u_id = request.getParameter("u_id");
	String u_pw = request.getParameter("u_pw");
	String u_auto = request.getParameter("u_auto");
	
	// 쿠키를 꺼내서 정보가 나오면 위 변수에 저장
	Cookie[] coos = request.getCookies();
	if(coos != null){
		for(Cookie c : coos){
			if(c.getName().equals("autoU_id")) u_id = c.getValue();
			if(c.getName().equals("autoU_pw")) u_pw = c.getValue();
			if(c.getName().equals("autoU_ch")) u_auto = c.getValue();
				
		}
	}	
	
	// DB에 ID, PW 전달해서 DB상 데이터와 일치하는지 결과받아오기
	UserDAO dao = new UserDAO();
	int result = dao.idPwCheck(u_id, u_pw); // result : 1(OK) 0(비번틀림) -1(미존재) %>
	
<%	if(result == -1){ %>
		<script>
			alert("ID가 존재하지 않습니다. 재입력 또는 회원가입 바랍니다.");
			history.go(-1);
		</script>		
<%	}else if(result == 0){ %>
		<script>
			alert("비밀번호를 틀렸습니다. 재입력 바랍니다.");
			history.go(-1);
		</script>
		
<%	}else if(result == 1){ %>

<%		if(u_auto != null){
			Cookie c1 = new Cookie("autoU_id", u_id);				
			Cookie c2 = new Cookie("autoU_pw", u_pw);				
			Cookie c3 = new Cookie("autoU_ch", u_auto);
			c1.setMaxAge(60*60*24);	// 24시간
			c2.setMaxAge(60*60*24);	// 24시간
			c3.setMaxAge(60*60*24);	// 24시간
			response.addCookie(c1);
			response.addCookie(c2);
			response.addCookie(c3);
			System.out.println("쿠키 생성 성공!");
		}  %>	
		
		<%if(u_id.equals("admin")){  %>
			<%session.setAttribute("adminId", u_id); %>
			<script>
				alert("관리자 계정으로 로그인했습니다.");
				window.location="/team/banner/main.jsp";
			</script>
		<%}else{ %>
			<%session.setAttribute("userId", u_id); //로그인 성공처리 %>
			<script>
				alert("일반회원으로 로그인했습니다.");
				window.location="/team/banner/main.jsp";
			</script>
		<%} %>		
	<%	} %>	
	
<body>

</body>
</html>