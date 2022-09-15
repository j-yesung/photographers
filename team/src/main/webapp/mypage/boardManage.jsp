<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="java.util.List"%>
<%@page import="team.mypage.model.UserSellDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardManage.jsp</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="mypage_btn.css" rel="stylesheet" type="text/css" />	

</head>

<%
	
	String u_id = (String)session.getAttribute("userId");
	// 페이징 처리
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
		pageNum = "1";   // 1로 값 체우기 
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 3;  // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize;
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
	
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String dateSel = request.getParameter("dateSel");
	
	UserSellDAO dao = new UserSellDAO();

	int count = 0;	// 내가 올린 글 담을 변수
	List myGalleryList = null;	// 현재 판매중인 내 상품목록 리턴받을 변수
		
	
	if(sel != null && search != null) { // 검색일때 
		count = dao.getGallerySearchCount(u_id, sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
		System.out.println("검색키워드에 맞는 게시글 수 : " + count);
		if(count > 0) {
			// 검색한 글 목록 가져오기 
			myGalleryList = dao.getGallerySearch(startRow, endRow, u_id, sel, search); 
			System.out.println("검색글 목록 : " + myGalleryList);
		}
	}else if(startDate != null && endDate != null){ // 기간조회시,
		count = dao.getAllDateCount(u_id, startDate, endDate);
		System.out.println("선택된 날짜 : " + startDate + " - " + endDate);
		System.out.println("해당기간 등록건 수 : " + count);
		if(count > 0){
			myGalleryList = dao.getAllDate(startRow, endRow, u_id, startDate, endDate);
			System.out.println("해당기간 등록상품 : " + myGalleryList);	
		}		
	}else { // 일반 게시판일때 	
		count = dao.getMyAllGalleryCount(u_id);
		System.out.println("해당아이디가 올린 글의 개수 : " + count);
		if(count > 0){		
			myGalleryList = dao.getMyAllGallerys(u_id, startRow, endRow);
			System.out.println("해당아이디가 올린 글 : " + myGalleryList);
		}
	}
%>

<%
	GalleryDTO dto = new GalleryDTO();
	int checkNum = 0;

	int sellNow = dao.getMyGalleryCount(u_id);
	int sellRequest = dao.getMyRequestCount(u_id);
	int sellSleep = dao.getMySellSleep(u_id);
	int allGallery = dao.getMyAllGalleryCount(u_id);
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
%>

<body>
	<%	if(session.getAttribute("userId") == null){ %>
			<script>
				alert("로그인 후 이용가능한 서비스입니다.");
				window.location.href="/team/user/loginForm.jsp";
			</script>
	<%	} %>


	
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
		<h2 align="left"> 게시글관리 </h2>
		
		<br />
		<table>
			<tr>
				<td>총 게시글 수</td> 
				<td>판매중인 상품 수(휴면상품)</td> 
				<td>판매요청 상품 수</td> 
			</tr>
			<tr>
				<td align="right"> <%=allGallery%> </td> 
				<td align="right"> <%=sellNow%>( <%=sellSleep %> )</td> 
				<td align="right"> <%=sellRequest%></td> 
			</tr>
		</table>
		<br />
		
		<form action="boardManage.jsp" method="post" >
		
			<select name="dateSel">
				<option value="g_reg" selected>등록일시</option>
			</select>
			<input type="date" name="startDate" /> &nbsp; - &nbsp;
			<input type="date" name="endDate" />
			<input type="submit" value="조회" />
		</form>
		
		
		<% if(count == 0){ %>
		<table>
			<tr>
				<td colspan="5">게시글이 없습니다.</td>
			</tr>
		</table>		
	<% }else { %>
		<table>
			<tr>
				<td> No. </td>
				<td> 갤러리 번호 </td>			
				<td> 갤러리 이미지 </td>			
				<td> 갤러리 제목 </td>			
				<td> 갤러리 작성자 </td>
				<td> 갤러리 상태</td>			
				<td> 갤러리 등록일시 </td>
					
			</tr>
		  <% for(int i = 0; i < myGalleryList.size(); i++){ %>
		  <% 	GalleryDTO gallery = (GalleryDTO)myGalleryList.get(i);%>
				<tr>
					<td> <%=number--%></td>
					<td>
						<a href="boardManageSelf.jsp?g_bno=<%=gallery.getG_bno()%>"><%=gallery.getG_bno()%></a>
					</td>
					<td>
						<a href="boardManageSelf.jsp?pageNum=<%=pageNum%>&g_bno=<%=gallery.getG_bno()%>&g_status=<%=gallery.getG_status()%>"><img src="/team/save/<%=gallery.getG_img()%>" width="100"></a>
					</td>
					<td> <%=gallery.getG_subject() %> </td>
					<td> <%=gallery.getU_id() %> </td>
					<td> <%=gallery.getG_status() %></td>
					<td> <%=gallery.getG_reg() %> </td>
				</tr>	
		  <% } %>
		 </table>
	<% } %>
	</div> <%-- main div  의 끝 --%>
	<div id="mainSub" align="center">
		
	<%-- 페이징처리 목록 뷰어 --%>
	 <% if(count > 0) { 
			// 한페이지에 보여줄 번호의 개수 
			int pageNumSize = 3; 
			// 총 몇페이지 나오는지 계산 
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			// 현재 페이지에 띄울 첫번째 페이지 번호 
			int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
			// 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
			int endPage = startPage + pageNumSize - 1; 
			if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 
	
			if(startPage > pageNumSize) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="boardManage.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
				<%}else{%>
					<a class="pageNums" href="boardManage.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
				<%}
			}
			
			for(int i = startPage; i <= endPage; i++) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="boardManage.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
				<%}else{ %>
					<a class="pageNums" href="boardManage.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
				<%} 
			}
			
			if(endPage < pageCount) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="boardManage.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
			<%	}else{ %>
					<a class="pageNums" href="boardManage.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
			<% } %>
		<%	}  %> 
		
	<%	}//if count > 0 %>
		<br />
		<%-- 작성자/내용 검색 --%>
		<form action="boardManage.jsp">
			<select name="sel">
				<option value="g_bno">갤러리번호</option>
				<option value="g_subject" selected>갤러리제목</option>
				<option value="g_status" >판매상태</option>
			</select>
			<input type="text" name="search" /> 
			<input type="submit" value="검색" />
			<input type="button" value="전체글로 돌아가기" onclick="window.location='boardManage.jsp'"/>
		</form>
	
	</div> <%-- mainSub div의 끝 --%>
	<div id="bottom"></div>
	
	</div> <%-- box div의 끝  --%>
</body>
</html>