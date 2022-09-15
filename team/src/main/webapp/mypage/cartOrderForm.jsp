<%@page import="team.gallery.model.GalleryDAO"%>
<%@page import="team.mypage.model.PaymentDAO"%>
<%@page import="team.user.model.UserDTO"%>
<%@page import="team.user.model.UserDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.mypage.model.UserCartDTO"%>
<%@page import="team.mypage.model.UserCartDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 / 결제</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	
	<script>
		// 유효성 검사
		function paymentcheckField(){
			let inputs = document.inputForm;
			if(!inputs.p_option.value){	// name속성이 id인 요소의 value가 없으면 true
				alert("결제방식을 선택하세요.");
				return false;	// pro페이지로 이동 금지.
			}
	</script>


<%
	request.setCharacterEncoding("UTF-8");

	int orderAmount = 0; // 총금액 리턴받을 변수
	int count = 0; // 장바구니 갯수 리턴받을 변수
	List myOrderList = null; // 나의 장바구니 리턴받을 변수

	String u_id = (String)session.getAttribute("userId");
	
	PaymentDAO dao = new PaymentDAO();
 	
	UserDAO userDao = new UserDAO();
	UserDTO dto = userDao.getUser(u_id);

	GalleryDTO gallDto = new GalleryDTO();
%>	
</head>
	<% if(session.getAttribute("userId") == null){ // 비로그인시%>
		<script>
			alert("로그인시 이용가능한 페이지입니다.");
			window.location="/team/user/main.jsp";
		</script>
	<%} %>
	
<%
	
		count = dao.getMyOrderCount(u_id);
		System.out.println("주문할 상품 갯수 : " + count);
		// 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
		if(count > 0){
			// 주문서 목록 가져오는 메서드
			myOrderList = dao.getMyOrders(u_id);
			System.out.println("나의 주문 상품 목록 : " + myOrderList);
		}
	
%>	

<body>
	<br />
	
	<div id="box">
	<div id="top">
	<div>
				<a href="/team/banner/main.jsp"><b style="font-size: 50px;">PHOTOGRAPERS</b></a>&emsp;&emsp;&emsp;
				<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
				<a href="/team/mypage/myProfile.jsp" class="btn2">마이페이지</a>
				<a href="/team/mypage/cartView.jsp" class="btn2">장바구니</a>
				<a href="/team/mypage/likeView.jsp" class="btn2">좋아요</a>
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
<%				if(session.getAttribute("userId") == null){ %>
					<a href="/team/user/loginForm.jsp" class="btn">로그인</a>
					<a href="/team/user/signupForm.jsp" class="btn">회원가입</a>
<%				} else { %>
					<a href="/team/user/logout.jsp" class="btn">로그아웃</a>
<%				} %>
			</div>

				<form action="/team/gallery/showView.jsp" method="post" name="find">
					<input type="text" name="findKeyword" placeholder="검색어를 입력하세요"/>
					<input class="btn3" type="submit" value="검색"/>
				</form>


   </div> <%-- top div의 끝  --%>
	<div id="topLine"></div>
	   <div id="left">
      <h1> 마이페이지 </h1>
      <br /><br />
      <h4><a href="myProfile.jsp"> 프로필 정보 </a></h4>
      <h4><a href="shopInfo.jsp"> 쇼핑정보 </a></h4> 
      <h4><a href="buyList.jsp"> 구매내역 </a></h4> 
      <h4><a href="sellStatus.jsp"> 판매내역 </a></h4> 
      <h4><a href="userLike.jsp"> 좋아요 상품 </a></h4> 
      <h4><a href="userCart.jsp"> 장바구니 상품 </a></h4> 
      <h4><a href="boardManage.jsp"> 게시글 관리 </a></h4>
      
   
   
   </div> <%-- left div의 끝 --%>
	<div id="leftLine"></div>
	<div id="main" align="center">

	
<form name="paymentForm" action="orderPro.jsp" method="post">
<table id="usetCartTable" width='1100' border='1'>

	<tr><td align="center" colspan='8' style="font-size:20pt"><b>주문 / 결제</b></td></tr>
	<tr><td align="left" colspan='8' style="font-size:15pt"><b>구매자 정보</b></td></tr>
	
	<tr align='center'>
		<td width='30' align="left" colspan="8">아이디 : <%=u_id %></td>
	</tr>
	<tr align='center'>
		<td width='150' align="left"  colspan="8">이메일 : <%=dto.getU_email() %> </td>
	</tr>



	<tr><td align="left" colspan='8' style="font-size:15pt"><b>상품정보</b></td></tr>
	<tr align='center'>
		<td width='30'>갤러리No.</td>
		<td width='150'>작    품</td>
		<td width='150'>작 품 명</td>
		<td width='50'>작    가</td>
		<td width='50'>판 매 가</td>
	</tr>
	
	<% 
	
		for(int i = 0; i < myOrderList.size(); i++){ 
			
	  		HashMap map = (HashMap)myOrderList.get(i);
	  		GalleryDTO gallery = (GalleryDTO)map.get("gall");
	  		UserCartDTO cart = (UserCartDTO)map.get("cart");
	  		orderAmount+=gallery.getG_price();%>
  		
  		<tr>
			<td>
				<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><%=gallery.getG_bno()%></a>
			</td>
			<td>
				<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><img src="/team/save/<%=gallery.getG_img()%>" width="100"></a>
			</td>			<td> <%=gallery.getG_subject() %> </td>
			<td> <%=cart.getU_id2() %> </td>
			<td> <%=gallery.getG_price() %> </td>
		</tr>	
		  <% } %>
		<tr>
			<td colspan='8' align='right' style="height:50px; font-size:13pt"><b>총 <%=orderAmount %>원</b></td>
		</tr>
		<tr>
            <td>결제방식</td>
           	<td>
			<select name="p_option">
                 <option value="카드">카드</option>
                 <option value="무통장입금">무통장입금</option>
			</select>
			</td>
	     </tr>
		<tr>
			<td colspan='8' align='center'>
			
			<%
			%>
			<input type = "hidden" name="u_id" value="<%=u_id%>">
			<input type = "hidden" name="g_bno" value="<%=gallDto.getG_bno()%>">
			<input type = "hidden" name="p_id" value="<%=gallDto.getU_id() %>">
			<input type = "hidden" name="g_subject" value="<%=gallDto.getG_subject() %>">
			<input type = "hidden" name="g_price" value="<%=gallDto.getG_price()%>">
			<input type = "hidden" name="p_finalPrice" value="<%=orderAmount%>">
			<input type="submit" value="결제하기" style="width:160px; height:50px; font-weight:bold; font-size:13pt;"/>
		  	</td>
		</table>
		</form>

	</div> <%-- main div의 끝 --%>
	
	<div id="mainSub" align="center">
		
		<br />

	</div><%-- mainSub div의 끝 --%>
	<div id="bottom"></div>
 </div><%-- box div의 끝  --%>
</body>
</html>