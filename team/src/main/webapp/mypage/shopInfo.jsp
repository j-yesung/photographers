<%@page import="team.mypage.model.UserLikeDAO"%>
<%@page import="team.mypage.model.UserCartDAO"%>
<%@page import="team.mypage.model.UserOrderDAO"%>
<%@page import="team.mypage.model.PaymentDAO"%>
<%@page import="team.mypage.model.UserSellDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="team.user.model.UserDTO"%>
<%@page import="team.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>myProfile.jsp</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="mypage_btn.css" rel="stylesheet" type="text/css" />
</head>
<%
	// 로그인했을때만 접근 가능한 페이지
	String u_id = (String)session.getAttribute("userId");
	String p_id = (String)session.getAttribute("userId");
	
	if(u_id == null){ %>
		<script>
			alert("로그인시 이용가능한 서비스입니다.");
			window.location.href="/team/user/loginForm.jsp";
		</script>	
<%  }else{ %>

<%
	UserDAO dao = new UserDAO();
	UserDTO user = dao.getUser(u_id);
	
	UserSellDAO sdao = new UserSellDAO();
	PaymentDAO pdao = new PaymentDAO();
	UserOrderDAO odao = new UserOrderDAO();
	UserCartDAO cdao = new UserCartDAO();
	UserLikeDAO ldao = new UserLikeDAO();
	
	int sellCount = pdao.myPaymentCount(u_id);	
	int sellNow = sdao.getMyGalleryCount(u_id);
	int sellRequest = sdao.getMyRequestCount(u_id);
	int buyCount = odao.myOrderCount(p_id);
	int cartCount = cdao.getMyCartCount(u_id);
	int likeCount = ldao.getMyLikeCount(u_id);
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
%>
	
<body>
	<br />
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
				<a href="/team/mypage/cartView.jsp" class="btn2">장바구니</a>
				<a href="/team/mypage/likeView.jsp" class="btn2">좋아요</a>
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
		<h4><a href="myProfile.jsp"> 프로필 정보 </a></h4> <br />
		<h4><a href="shopInfo.jsp"> 쇼핑정보 </a></h4> <br /> 
		<h4><a href="buyList.jsp"> 구매내역 </a></h4> <br /> 
		<h4><a href="sellStatus.jsp"> 판매내역 </a></h4> <br /> 
		<h4><a href="likeView.jsp"> 좋아요 상품 </a></h4> <br /> 
		<h4><a href="cartView.jsp"> 장바구니 상품 </a></h4> <br /> 
		<h4><a href="boardManage.jsp"> 게시글 관리 </a></h4>
		
	</div> <%-- left div의 끝 --%>
	
	<div id="leftLine"></div>
	
	<div id="main" align="center">
		<h2 align="left"> 쇼핑정보 </h2>
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
		</table>
		
		<br />
		<hr>
		
		<table>
			<h3 align="left">판매내역</h3>
			<tr>
				<td><a href="sellRequest.jsp">승인요청한 상품</a></td>
				<td><a href="sellNow.jsp">판매중인 상품</a></td>
				<td><a href="sellStatus.jsp">판매완료된 상품</a></td>
			</tr>
			<tr>
				<td><%=sellRequest%></td>
				<td><%=sellNow %></td>
				<td><%=sellCount%></td>
			
			</tr>
		</table>
			
		<br />
		<hr>
		
		<table>
			<h3 align="left">구매내역</h3>
			<tr>
				<td><a href="cartView.jsp">장바구니 담은 상품</a></td>
				<td><a href="likeView.jsp">관심상품</a></td>
				<td><a href="buyList.jsp">구매완료된 상품</a></td>
			</tr>
			<tr>
				<td><%=cartCount%></td>
				<td><%=likeCount%></td>
				<td><%=buyCount%></td>
			
			</tr>		
		</table>			
							
		
		
	</div> <%-- main div의 끝 --%>
	<div id="mainSub"></div>
	<div id="bottom"></div>
	</div> <%-- box div의 끝 --%>
</body>

<%}%>
</html>