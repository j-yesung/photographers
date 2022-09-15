<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userDeleteForm.jsp</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="user_btn.css" rel="stylesheet" type="text/css" />	
</head>


<%
	// 로그인했을때만 접근 가능한 페이지
	String u_id = (String)session.getAttribute("userId");	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 


	if(session.getAttribute("userId") == null){ %>
		<script>
			alert("로그인시 이용가능한 서비스입니다.");
			window.location.href="main.jsp";
		</script>	
<%  }else{ %>


<body>
	<div id="box">
	<br />
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
		<h1> 마이페이지 </h1>
		<br /><br />
		<h4><a href="/team/mypage/myProfile.jsp"> 프로필 정보 </a></h4> <br />
		<h4><a href="/team/mypage/shopInfo.jsp"> 쇼핑정보 </a></h4> <br /> 
		<h4><a href="/team/mypage/buyList.jsp"> 구매내역 </a></h4> <br /> 
		<h4><a href="/team/mypage/sellStatus.jsp"> 판매내역 </a></h4> <br /> 
		<h4><a href="/team/mypage/likeView.jsp"> 좋아요 상품 </a></h4> <br /> 
		<h4><a href="/team/mypage/cartView.jsp"> 장바구니 상품 </a></h4> <br /> 
		<h4><a href="/team/mypage/boardManage.jsp"> 게시글 관리 </a></h4>
		
	</div> <%-- left div의 끝 --%>
	<div id="leftLine"></div>
	
	<br />
	
	<div id="main" align="center"> 
	<br />
		<h1 align="center"> 회원정보 탈퇴 </h1>
		<form action="userDeletePro.jsp" method="post">	
			<table>
				<tr> 
					<td> 탈퇴를 원하시면 비밀번호를 입력하세요 <br />
						<input type="password" name="u_pw" /> </td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="탈퇴" />
						<input type="button" value="취소" onclick="window.location='/team/mypage/myProfile.jsp'" />
					</td>
				</tr>
			</table>
		</form>		

	</div>
	<div id="mainSub"></div>
	<div id="bottom"></div>
	</div><%-- box div의 끝 --%>
	

</body>

<% } %>
</html>