<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
%>
<body>

	<div id="top">
		<div>
			<a href="/team/banner/main.jsp"><b style="font-size: 50px;">PHOTOGRAPERS</b></a>&emsp;&emsp;&emsp;
<%  			if(session.getAttribute("adminId") != null) { %>   
					<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
					<a href="/team/admin/adBoard.jsp" class="btn"> 관리자페이지</a>
<%  			} else{ %>
					<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
					<a href="/team/mypage/myProfile.jsp" class="btn2">마이페이지</a>
					<a href="/team/mypage/cartView.jsp" class="btn2">장바구니</a>
					<a href="/team/mypage/likeView.jsp" class="btn2">좋아요</a>
<%				} %>
			&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
<%				if(session.getAttribute("userId") == null && session.getAttribute("adminId") == null) { %>
					<a href="/team/user/loginForm.jsp" class="btn">로그인</a>
					<a href="/team/user/signupForm.jsp" class="btn">회원가입</a>
<%				} else { %>
					<a href="/team/user/logout.jsp" class="btn">로그아웃</a>
<%         		} %>
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
	</div>
	<div id="topLine"></div>

</body>
</html>