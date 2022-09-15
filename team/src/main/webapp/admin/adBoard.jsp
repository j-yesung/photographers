<%@page import="team.admin.model.AdminDAO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자페이지 대시보드</title>
	<link href="team.css" rel="stylesheet" type="text/css"/>
	<link href="admin_btn.css" rel="stylesheet" type="text/css"/>
<%
	// 관리자 세션
	String u_id = (String)session.getAttribute("adminId");
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 

	//--------------------------------------------------------------------
	
	//★★★★★★매출관련★★★★★★
	
	// 관리자 모든 회원게시물 카운팅 메서드
	AdminDAO dao = new AdminDAO();
	
	// 총 판매금액 구하는 메서드
	int totalPrice = 0;
	totalPrice = dao.getTotalPrice();

	// 총 판매건수 구하는 메서드
	int sellCount = 0;
	sellCount = dao.getAllPaymentCount();	
	
	//--------------------------------------------------------------------
	
	//★★★★★★상품관련★★★★★★★
	
	// 총 판매중인 상품수
	int galleryCount = 0;
	galleryCount = dao.getAllGallerysCount();
	// 현재 판매중인 상품수 
	int sellNow = 0;
	sellNow = dao.getSellNow();
	// 현재 휴면중인 상품수
	int sellSleep = 0;
	sellSleep = dao.getSellSleep();
	// 현재 승인요청 상품수
	int sellRequest = 0;
	sellRequest = dao.getAllRequestCount();
	
	//---------------------------------------------------------------------
	
	// 유저관련
	int userCount = 0;
	userCount = dao.getAllUserCount();
	// 정상유저 + 휴면 유저 카운팅메서드
	int userNow = 0;
	int userSleep = 0;
	userNow = dao.getUserNow();
	userSleep = dao.getUserSleep();
%>		
</head>
	
	


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
		<h1>관리자 페이지</h1>
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
		<h2 align="left"> 관리자 대시보드 </h2>
		<br />
		<hr>
		<br />
		<h3 align="left"> 판매현황 </h3>
		<table>
			<tr> 
				<td colspan="4" align="center" width="600px"><a onclick="window.location='adSalesManage.jsp'">결제금액</a></td> 
			</tr>
			<tr>
				<td align="center">총 결제건수</td>
				<td align="center">총 결제금액</td>
				<td align="center">총 정산금액</td>
				<td align="center">총 판매수수료</td>
			</tr>
			<tr>
				<td align="right"><%=sellCount%></td>
				<td align="right"><fmt:formatNumber value="<%=totalPrice%>" /> 원</td>
				<td align="right"><fmt:formatNumber value="<%=(int)(totalPrice * 0.8)%>" /> 원</td>
				<td align="right"><fmt:formatNumber value="<%=(int)(totalPrice * 0.2)%>" /> 원</td>
			</tr>
		</table>
		<br />
		<table>
			<tr>
				<td colspan="4" align="center" width="600px"><a onclick="window.location='adBoardManage.jsp'">판매상품</a></td>
			</tr>
			<tr>
				<td align="center">총 상품 수</td>
				<td align="center">판매중인 상품 수</td>
				<td align="center">휴면상품 수</td>
				<td align="center">승인요청건 수</td>
			</tr>
			<tr>
				<td align="right"><%=galleryCount%></td>
				<td align="right"><%=sellNow%></td>
				<td align="right"><%=sellSleep%></td>
				<td align="right"><%=sellRequest%></td>
			</tr>
		</table>
		<br />
		<hr>
		<h3 align="left">회원현황</h3>
		<table>
			<tr>
				<td colspan="3" align="center" width="600px" ><a onclick="window.location='adUserSearch.jsp'">회원</a></td>
			</tr>
			<tr>
				<td align="center">총 회원 수</td>
				<td align="center">정상회원 수</td>
				<td align="center">휴면회원 수</td>
			</tr>
			<tr>
				<td align="right"><%=userCount%></td>
				<td align="right"><%=userNow%></td>
				<td align="right"><%=userSleep%></td>
			</tr>
			
		</table>		
	
	</div>
	
	<div id="mainSub"></div>
	
	<div id="bottom"></div>
	
	</div>


</body>
</html>