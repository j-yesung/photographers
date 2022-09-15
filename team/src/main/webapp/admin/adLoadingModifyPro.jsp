<%@page import="team.admin.model.AdminDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="team.admin.model.AdminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	AdminDTO loading = new AdminDTO(); 
	
	String path = request.getRealPath("save"); 
	System.out.println(path);
	int max = 1024*1024*400; 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	System.out.println("1" );
	
	loading.setSi_Loading(mr.getParameter("si_Loading"));

	if(mr.getFilesystemName("si_Loading") != null) {
		loading.setSi_Loading(mr.getFilesystemName("si_Loading"));
	}else {	// 파일 업로드를 안 했으면, save폴더에 있는 default 이미지 파일명으로 채우기.
		loading.setSi_Loading(mr.getParameter("si_LoadingEx"));
	}
	System.out.println("2" );
		
	AdminDAO dao = new AdminDAO(); 
	int result = dao.updateLoading(loading);
	System.out.println("3" );
	System.out.println(result);
	if(result !=0){
%>
	<script>
		alert("수정 완료!!!");
		window.location.href = "adBoard.jsp"; 
	</script>
<%}%>
<body>

</body>
</html>