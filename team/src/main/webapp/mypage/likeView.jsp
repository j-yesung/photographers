<%@page import="java.util.HashMap"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.mypage.model.UserLikeDTO"%>
<%@page import="team.mypage.model.UserLikeDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관심상품</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="mypage_btn.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>
<script>
function choisePri(){
	document.likeForm.submit();
}

$(function(){
	var ulno = document.getElementsByName("ulno");
	var count = ulno.length;
	
	$("#allCheck").click(function(){
		var lnList = $("input[name=ulno]");
		for(var i = 0; i<lnList.length; i++){
			lnList[i].checked = this.checked;
		}
	});
	$("input[name='ulno']").click(function(){
		if($("input[name='ulno']:checked").length == count){
			$("#allCheck")[0].checked= true;
		}
		else {
			$("#allCheck")[0].checked= false;
		}
	});
	
});

function selectDelete() {
	var ulno = $("input[name='ulno']").length
	var str = '';
	for(var i = 0; i<ulno; i++){
		if(document.getElementsByName("ulno")[i].checked==true){
			var ulno = document.getElementsByName("ulno")[i].value;
			if(i==ulno-1){
				str += "ulno="+ulno;
			}else{
				str += "ulno="+ulno+"&";
			}
		}
	}
	if(ulno == 0){
		alert("선택된 상품이 없습니다.");
	} else{
		open("likeDelete.jsp?"+str, "seleteDelete", "width=300, height=200");
	}
		
}

function allDelete(){
	var ulno = $("input[name='ulno']").length
	var str = '';
	for(var i = 0; i<ulno; i++){
		if(document.getElementsByName("ulno")[i]){
			var ulno = document.getElementsByName("ulno")[i].value;
			if(i==ulno-1){
				str += "ulno="+ulno;
			}else{
				str += "ulno="+ulno+"&";
			}
		}
	}
	if(ulno == 0){
		alert("선택된 상품이 없습니다.");
	} else{
		open("likeDelete.jsp?"+str, "seleteDelete", "width=300, height=200");
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
	int count = 0; // 관심상품 갯수 리턴받을 변수
	List myLikeList = null; // 나의 관심상품 리턴받을 변수

	String u_id = (String)session.getAttribute("userId");
	UserLikeDAO dao = new UserLikeDAO();
%>	
</head>
<%
	
	if(sel != null && search != null) { // 검색일때 
		count = dao.getLikeSearchCount(u_id, sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
		System.out.println("관심상품 키워드 검색 매칭 수 : " + count);
		if(count > 0) {
			// 검색한 글 목록 가져오기 
			myLikeList = dao.getLikeSearch(startRow, endRow, u_id, sel, search); 
			System.out.println("관심상품 검색 목록 : " + myLikeList);
		}
	}else { // 일반 게시판일때 
		// 관심상품 개수 카운팅 메서드
		count = dao.getMyLikeCount(u_id);
		System.out.println("관심상품 추가 갯수 : " + count);
		// 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
		if(count > 0){
			// 관심상품 목록 가져오는 메서드
			myLikeList = dao.getMyLike(u_id, startRow, endRow);
			System.out.println("관심상품 상품 목록 : " + myLikeList);
		}
	}
	
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
%>	

<body>
	
	<div id="box">
<%-- ================================================= 상단바 ================================================= --%>
	<br/>
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
	<h2 align="left">  관심상품 </h2>
	
<form name="userLikeForm" action="" method="post" onsubmit="" >
<table id="usetLikeTable" width='1100' border='1'>
	<br/>
	<tr><td align="center" colspan='8' style="font-size:20pt"><b><%=session.getAttribute("userId")%>님의 관심상품</b></td></tr>
	<br/>
	<tr align='center'>
		<td width='20'><input type="checkbox" id="allCheck"/></td>
		<td width='30'>갤러리No.</td>
		<td width='150'>작    품</td>
		<td width='150'>작 품 명</td>
		<td width='50'>작    가</td>
		<td width='50'>추가일자</td>
		<td width='50'>비    고</td>
		
	</tr>


	<% if(session.getAttribute("userId") == null){ // 비로그인시%>
		<script>
			alert("로그인시 이용가능한 페이지입니다.");
			window.location="/team/user/loginForm.jsp";
		</script>
	<%} %>
	
	<%
	if(myLikeList == null){
	%><tr align='center'><td colspan='8' style="height:170px; font-size:15pt">
		관심상품에 담긴 상품이 없습니다.</td></tr>
	<%} else{
		for(int i = 0; i < myLikeList.size(); i++){ 
			
	  		HashMap map = (HashMap)myLikeList.get(i);
	  		GalleryDTO gallery = (GalleryDTO)map.get("gall");
	  		UserLikeDTO like = (UserLikeDTO)map.get("like");
	  		orderAmount+=gallery.getG_price();%>
  		
  		<tr>
  			<td> <input type="checkbox" name="ulno" value="<%=like.getUlno()%>" /></td>
			<td>
				<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><%=gallery.getG_bno()%></a>
			</td>
			<td>
				<a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><img src="/team/save/<%=gallery.getG_img()%>" width="100"></a>
			</td>
			<td> <%=gallery.getG_subject() %> </td>
			<td> <%=like.getU_id2()%> </td>
			<td> <%=like.getUl_reg() %> </td>
			<td>
            	<a href="likeUnitDeletePro.jsp?ulno=<%=like.getUlno()%>">삭제</a>
            </td>
		</tr>	
		  <% } %>
		  
		  <tr> 
			<td colspan='7' align="right"><input type="button" value="관심상품 비우기" style="width:160px; height:50px; font-weight:bold; font-size:13pt;" onclick="allDelete()" /></td>
		</tr>
		</table>
	</form>
	<%	} //if else의 끝 %>
	</div> <%-- main div의 끝 --%>
	
	<div id="mainSub" align="center">
		
	<%-- 페이징처리 목록 뷰어 --%>
	 <% if(count > 0) { 
			// 한페이지에 보여줄 번호의 개수 
			int pageNumSize = 5; 
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