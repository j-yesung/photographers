<%@page import="team.user.model.UserDAO"%>
<%@page import="team.user.model.UserDTO"%>
<%@page import="team.admin.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자페이지</title>
	<link href="team.css" rel="stylesheet" type="text/css"/>
	<link href="admin_btn.css" rel="stylesheet" type="text/css"/>
	
	
</head>
<% 
	String u_id = request.getParameter("u_id");
	int u_userno = Integer.parseInt(request.getParameter("u_userno"));
	String pageNum = request.getParameter("pageNum");
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
	
	AdminDAO adao = new AdminDAO();
	UserDAO dao = new UserDAO();
	
	UserDTO user = adao.adGetUser(u_id); 
	
%>

<body>
	<% if(session.getAttribute("adminId") == null){ // 비로그인시%>
      <script>
         alert("관리자로그인시 이용가능한 페이지입니다.");
         window.location="/team/user/loginForm.jsp";
      </script>
   	<%} %>


	<div id="box">
	<div id="top">
		<div>
			<a href="/team/banner/main.jsp"><b style="font-size: 50px;">PHOTOGRAPERS</b></a>&emsp;&emsp;&emsp;
<%  		if(session.getAttribute("adminId") != null) { %>   
				<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
				<a href="/team/admin/adBoard.jsp" class="btn"> 관리자페이지</a>
<%  		} else{ %>
				<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
				<a href="/team/mypage/myProfile.jsp" class="btn2">마이페이지</a>
				<a href="/team/mypage/userCart.jsp" class="btn2">장바구니</a>
				<a href="/team/mypage/userLike.jsp" class="btn2">좋아요</a>
<%  		} %>
			&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
<%         if(session.getAttribute("userId") == null && session.getAttribute("adminId") == null) { %>
				<a href="/team/user/loginForm.jsp" class="btn">로그인</a>
				<a href="/team/user/signupForm.jsp" class="btn">회원가입</a>
<%         } else { %>
				<a href="/team/user/logout.jsp" class="btn">로그아웃</a>
<%         } %>
		</div>
		<div>
			<form action="/team/gallery/showView.jsp?sel=<%=sel%>&search=<%=search%>">
				<select name="sel">
					<option value="u_id" selected>판매자</option>
					<option value="g_subject">제목</option>
					<option value="g_content">내용</option>
					<option value="g_tag">태그</option>
					<option value="g_imgLocation">촬영 지역</option>
					<option value="g_imgLens">카메라 렌즈</option>
					<option value="g_imgCamera">카메라 기종</option>
				</select>
				<input type="text" name="search" placeholder="검색어를 입력하세요" style="width: 240px;"/>
				<input class="btn3" type="submit" value="검색"/>
			</form>
		</div>
	</div> <%-- top div의 끝 --%>
	
	
	<div id="topLine"></div>
	
	
	<div id="left">
		<h1> 관리자 페이지 </h1>
		<br /><br />
		<h4><a href="adBoard.jsp"> 관리자 대시보드 </a></h4>
		<h4><a href="adBoardManage.jsp"> 게시물 조회 </a></h4>
		<h4><a href="adUserSearch.jsp"> 회원정보 조회 </a></h4> 
		<h4><a href="adSalesManage.jsp"> 관리자 매출조회 페이지</a></h4> 
		<h4><a href="adModifyBoard.jsp"> 홈페이지 수정 대시보드 </a></h4> 
		<h4><a href="adSellRequest.jsp"> 판매승인요청 조회페이지 </a></h4>
	</div> <%-- left div의 끝 --%>
	
	<div id="leftLine"></div>
	
	<div id="main" align="center">
		<h2 align="left"> 회원고유번호 : <%=u_userno%></h2>
		<table>
			<tr>
				<td rowspan="7" width="100">
					<%
					if(user.getU_photo() == null){ // DB에 photo가 없는경우 %>
						<img src="/team/save/defaultImg.png" width="80" />
						<%-- 히든으로는 default 이미지 파일명 숨겨서 보내기 --%>
						<input type="hidden" name="u_exPhoto" value="defaultImg.png" />
				<%	}else{ // DB에 Photo가 있을경우 %>
						<img src="/team/save/<%=user.getU_photo()%>" width="80" />
						<%-- 히든으로는 기존에 사용자가 등록했던 이미지 파일명 숨겨서 보내기 --%>
						<input type="hidden" name="u_exPhoto" value="<%=user.getU_photo()%>" />	
				<%  }%>
				</td>
			</tr>
			<tr>	
				<td>아이디 : </td>
				<td><%= user.getU_id()%></td>
			</tr>
				<tr>	
				<td>비밀번호 : </td>
				<td><%= user.getU_pw()%></td>
			</tr>
			<tr>	
				<td>닉네임 : </td>
				<td><%= user.getU_nick()%></td>
			</tr>
				<tr>	
				<td>이메일 주소 : </td>
				<td><%= user.getU_email()%></td>
			</tr>
			<tr>	
				<td>블로그 : </td>
				<td><%= user.getU_sns()%></td>
			</tr>
			<tr>	
				<td>관심사 : </td>
				<td><%= user.getU_favorite1()%>, 
					<%= user.getU_favorite2()%></td>
			</tr>
			<tr>
				<td align="center">
					<button onclick="window.location='/team/admin/adUserSleepPro.jsp?u_id=<%=user.getU_id()%>&pageNum=<%=pageNum%>'">비공개전환</button>
				</td>
				<td align="center">
					<button onclick="window.location='/team/admin/adUserWakePro.jsp?u_id=<%=user.getU_id()%>&pageNum=<%=pageNum%>'">공개 전환</button>	
				</td>
			</tr>
	
			
		</table>

	
	</div> <%-- main div의 끝 --%>
	
	<div id="mainSub"></div>
	
	<div id="bottom"></div>
	
	</div>


</body>
</html>