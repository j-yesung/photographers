<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>logout.jsp</title>
</head>
<%
	// 세션 전부삭제
	session.invalidate();

	// 쿠키 있으면 쿠키도 삭제
	Cookie[] cs = request.getCookies();
	if(cs != null){ // 쿠키가 있으면 실행
		for(Cookie c : cs){
			if(c.getName().equals("autoU_id") 
					|| c.getName().equals("autoU_pw") 
					|| c.getName().equals("autoU_ch")){
				
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	System.out.println("쿠키 삭제!!");
	}

	// 메인으로 이동
	response.sendRedirect("/team/banner/main.jsp");

%>
<body>

</body>
</html>