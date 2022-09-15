<%@page import="team.user.model.UserDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="team.user.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userModifyPro.jsp</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	UserDTO user = new UserDTO();
	
	// MultipartRequest 생성
	String path = request.getRealPath("save");
	System.out.println(path);
	int max = 1024*1024*5; 
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	

	String u_id = (String)session.getAttribute("userId");
	user.setU_id(u_id); // modify폼에서 id 안넘어옴
	user.setU_pw(mr.getParameter("u_pw"));
	user.setU_email(mr.getParameter("u_email"));
	user.setU_nick(mr.getParameter("u_nick"));
	if(mr.getFilesystemName("u_photo") != null){	// 사용자가 파일 업로드 올렸을 경우
		user.setU_photo(mr.getFilesystemName("u_photo"));
	}else{
		// 기존에 사진 없고, 지금도 안올렸고 (defaultImg.png)
		// 기존에 사진 있고, 지금은 안올렸고 (기존 이미지 파일명)
		user.setU_photo(mr.getParameter("u_exPhoto")); 		
	}
	user.setU_sns(mr.getParameter("u_sns"));
	user.setU_favorite1(mr.getParameter("u_favorite1"));
	user.setU_favorite2(mr.getParameter("u_favorite2"));	
	
	UserDAO dao = new UserDAO();
	int check = dao.updateUser(user);
	// 수정 잘되면 1, 수정 안되면 0
%>
	
<body>
	<%	if(check == 1){ %>
		<script>
			alert("수정완료");
			window.location.href="/team/mypage/myProfile.jsp";
		</script>		
	<%	}else{ %>
		<script>
			alert("수정실패... 재시도하세요");
			history.go(-1);
		</script>	
	<%	} %>



</body>
</html>