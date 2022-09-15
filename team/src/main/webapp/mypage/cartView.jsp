<%@page import="java.util.HashMap"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.mypage.model.UserCartDTO"%>
<%@page import="team.mypage.model.UserCartDAO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<meta charset="UTF-8">
	<title>장바구니</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="mypage_btn.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script>
function choisePri(){
	document.cartForm.submit();
}

$(function(){
	var ucno = document.getElementsByName("ucno");
	var count = ucno.length;
	
	$("#allCheck").click(function(){
		var cnList = $("input[name=ucno]");
		for(var i = 0; i<cnList.length; i++){
			cnList[i].checked = this.checked;
		}
	});
	$("input[name='ucno']").click(function(){
		if($("input[name='ucno']:checked").length == count){
			$("#allCheck")[0].checked= true;
		}
		else {
			$("#allCheck")[0].checked= false;
		}
	});
	
});

function selectDelete() {
	var ucno = $("input[name='ucno']").length
	var str = '';
	for(var i = 0; i<ucno; i++){
		if(document.getElementsByName("ucno")[i].checked==true){
			var ucno = document.getElementsByName("ucno")[i].value;
			if(i==ucno-1){
				str += "ucno="+ucno;
			}else{
				str += "ucno="+ucno+"&";
			}
		}
	}
	if(ucno == 0){
		alert("선택된 상품이 없습니다.");
	} else{
		open("cartDelete.jsp?"+str, "seleteDelete", "width=300, height=200");
	}
		
}

function allDelete(){
	var ucno = $("input[name='ucno']").length
	var str = '';
	for(var i = 0; i<ucno; i++){
		if(document.getElementsByName("ucno")[i]){
			var ucno = document.getElementsByName("ucno")[i].value;
			if(i==ucno-1){
				str += "ucno="+ucno;
			}else{
				str += "ucno="+ucno+"&";
			}
		}
	}
	if(ucno == 0){
		alert("선택된 상품이 없습니다.");
	} else{
		open("cartDelete.jsp?"+str, "seleteDelete", "width=300, height=200");
	}
	
		
	
}

</script>


<%
	request.setCharacterEncoding("UTF-8");


	// 페이징 처리
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
		pageNum = "1";   // 1로 값 체우기 
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize;
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 

	int orderAmount = 0; // 총금액 리턴받을 변수
	int count = 0; // 장바구니 갯수 리턴받을 변수
	List myCartList = null; // 나의 장바구니 리턴받을 변수

	String u_id = (String)session.getAttribute("userId");
	UserCartDAO dao = new UserCartDAO();
%>	
</head>
<%
	
	if(sel != null && search != null) { // 검색일때 
		count = dao.getCartSearchCount(u_id, sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
		System.out.println("장바구니 키워드 검색 매칭 수 : " + count);
		if(count > 0) {
			// 검색한 글 목록 가져오기 
			myCartList = dao.getCartSearch(startRow, endRow, u_id, sel, search); 
			System.out.println("장바구니 검색 목록 : " + myCartList);
		}
	}else { // 일반 게시판일때 
		// 장바구니 개수 카운팅 메서드
		count = dao.getMyCartCount(u_id);
		System.out.println("장바구니 추가 갯수 : " + count);
		// 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
		if(count > 0){
			// 장바구니 목록 가져오는 메서드
			myCartList = dao.getMyCarts(u_id, startRow, endRow);
			System.out.println("장바구니 상품 목록 : " + myCartList);
		}
	}
	
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
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
	<h2 align="left">  장바구니 </h2>

	
<form name="directOrderForm" action="/team/mypage/directOrderForm.jsp" method="post">
<table id="usetCartTable" width='1200' border='1'>
	<br/>
	<tr><td align="center" colspan='8' style="font-size:20pt"><b><%=session.getAttribute("userId")%>님의 장바구니</b></td></tr>
	<br/>
	<tr align='center'>
		<td width='20'><input type="checkbox" id="allCheck"/></td>
		<td width='30'>갤러리No.</td>
		<td width='150'>작    품</td>
		<td width='150'>작 품 명</td>
		<td width='50'>작    가</td>
		<td width='50'>판 매 가</td>
		<td width='50'>추가일자</td>
		<td width='50'>비    고</td>
	</tr>


	<% if(session.getAttribute("userId") == null){ // 비로그인시%>
		<script>
			alert("로그인시 이용가능한 페이지입니다.");
			window.location="/team/user/loginForm.jsp";
		</script>
	<%} %>
	
	
	<%-- if(count == 0){ 
		<tr align='center'>
			<td colspan='8' style="height:170px; font-size:15pt">장바구니에 담긴 상품이 없습니다.</td>
		</tr>--%>
	<% if(myCartList == null){ %>	
		<tr align='center'>
			<td colspan='8' style="height:170px; font-size:15pt">장바구니에 담긴 상품이 없습니다.</td>
		</tr>
	<% } else{
		for(int i = 0; i < myCartList.size(); i++){ 
	  		HashMap map = (HashMap)myCartList.get(i);
	  		GalleryDTO gallery = (GalleryDTO)map.get("gall");
	  		UserCartDTO cart = (UserCartDTO)map.get("cart");
	  		orderAmount += gallery.getG_price(); %>
  		
  		<tr>
			<td> <input type="checkbox" name="ucno" value="<%=cart.getUcno()%>" /></td>
			<td>
				<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><%=gallery.getG_bno()%></a>
			</td>
			<td>
				<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><img src="/team/save/<%=gallery.getG_img()%>" width="100"></a>
			</td>
			<td> <%=gallery.getG_subject() %> </td>
			<td> <%=cart.getU_id2() %> </td>
			<td> <fmt:formatNumber value="<%=gallery.getG_price() %>" /> 원 </td>
			<td> <%=cart.getUc_reg() %> </td>	
			<td>
          	  <a href="cartUnitDeletePro.jsp?ucno=<%=cart.getUcno()%>">삭제</a>
         	  <a href="directOrderForm.jsp?g_bno=<%=gallery.getG_bno()%>">주문</a>
            </td>
		<tr>
		  <% } %>
		<tr>
			<td colspan='8' align='right' style="height:50px; font-size:13pt"><b>총 <fmt:formatNumber value="<%=orderAmount %>" type="currency" currencySymbol="￦" /> 원</b></td>
		</tr>
		<tr> 
			<td colspan='8' align="right"><input type="button" value="장바구니 비우기" style="width:160px; height:50px; font-weight:bold; font-size:13pt;" onclick="allDelete()" /></td>
		</tr>
		</table>
		</form>
	<%	} //if else의 끝 %>
	</div> <%-- main div의 끝 --%>
	
	<div id="mainSub" align="center">
		
	<%-- 페이징처리 목록 뷰어 --%>
	 <% if(count > 0) { 
			int pageNumSize = 5; 
			// 한페이지에 보여줄 번호의 개수 
			// 총 몇페이지 나오는지 계산 
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			// 현재 페이지에 띄울 첫번째 페이지 번호 
			int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
			// 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
			int endPage = startPage + pageNumSize - 1; 
			if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 
	
			if(startPage > pageNumSize) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="cartView.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
				<%}else{%>
					<a class="pageNums" href="cartView.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
				<%}
			}
			
			for(int i = startPage; i <= endPage; i++) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="cartView.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
				<%}else{ %>
					<a class="pageNums" href="cartView.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
				<%} 
			}
			
			if(endPage < pageCount) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="cartView.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
			<%	}else{ %>
					<a class="pageNums" href="cartView.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
			<% } %>
		<%	}  %> 
		
	<%	} %>
	
		<br />
		<%-- 작품명, 작품번호 검색 --%>
		<form action="cartView.jsp" method="post">
			<select name="sel">
				<option value="g_subject" selected>작 품 명</option>
				<option value="g_bno">작품번호</option>
			</select>
			<input type="text" name="search" /> 
			<input type="submit" value="검색" />
			<input type="button" value="전체보기" onclick="window.location='cartView.jsp'"/>
		</form>

	</div><%-- mainSub div의 끝 --%>
	<div id="bottom"></div>
 </div><%-- box div의 끝  --%>
</body>
</html>