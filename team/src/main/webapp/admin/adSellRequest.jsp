<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.admin.model.AdminDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>판매승인 요청페이지</title>
	<link href="team.css" rel="stylesheet" type="text/css"/>
	<link href="admin_btn.css" rel="stylesheet" type="text/css"/>
</head>
<%
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

	
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String dateSel = request.getParameter("dateSel");
	
	int count = 0; // 전체 구매완료글 개수 담을 변수 
	List allRequestList = null; // 전체 구매완료글 리턴받을 변수
	
	AdminDAO dao = new AdminDAO();
	
	if(sel != null && search != null) {  
		count = dao.getAllRequestSearchCount(sel, search);   
		System.out.println("검색키워드에 맞는 게시글 수 : " + count);
		if(count > 0) {
			allRequestList = dao.getAllRequestSearch(startRow, endRow, sel, search); 
			System.out.println("검색글 목록 : " + allRequestList);
		}
	}else if(startDate != null && endDate != null){ // 기간조회시,
		count = dao.getAllRequestDateCount(startDate, endDate);
		System.out.println("선택된 날짜 : " + startDate + " - " + endDate);
		System.out.println("선택된 날짜에 승인요청한 건 수  : " + count);
		if(count > 0){
			allRequestList = dao.getAllRequestDate(startRow, endRow, startDate, endDate);
			System.out.println("해당기간 승인요청목록 : " + allRequestList);	
		}	
	}else { 
		count = dao.getAllRequestCount();	
		System.out.println("승인요청한 건 수 : " + count);
		if(count > 0){
			allRequestList = dao.getAllRequest(startRow, endRow);
			System.out.println("전체 승인요청건 목록 : " + allRequestList);
		}
	}
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
		<h2 align="left"> 관리자 판매승인 요청 페이지 : <%=count%> 건 </h2>
		<br />
		
	<form action="adSellRequest.jsp?pageNum=<%=pageNum%>" method="post" >
		<select name="dateSel">
			<option value="g_reg" selected>작성일시</option>
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
				<td> 갤러리 번호 </td>			
				<td> 갤러리 이미지 </td>			
				<td> 갤러리 제목 </td>			
				<td> 갤러리 작성자 </td>
				<td> 갤러리 상태</td>			
				<td> 갤러리 작성일시 </td>
					
			</tr>
		  <% for(int i = 0; i < allRequestList.size(); i++){ %>
		  <% 	GalleryDTO gallery = (GalleryDTO)allRequestList.get(i);%>
				<tr>
					<td>
						<a href="adRejectForm.jsp?g_bno=<%=gallery.getG_bno()%>"><%=gallery.getG_bno()%></a>
					</td>
					<td>
						<a href="adRejectForm.jsp?pageNum=<%=pageNum%>&g_bno=<%=gallery.getG_bno()%>&g_status=<%=gallery.getG_status()%>"><img src="/team/save/<%=gallery.getG_img()%>" width="100"></a>
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
					<a class="pageNums" href="adSellRequest.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
				<%}else{%>
					<a class="pageNums" href="adSellRequest.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
				<%}
			}
			
			for(int i = startPage; i <= endPage; i++) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="adSellRequest.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
				<%}else{ %>
					<a class="pageNums" href="adSellRequest.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
				<%} 
			}
			
			if(endPage < pageCount) { 
				if(sel != null && search != null) { %>
					<a class="pageNums" href="adSellRequest.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
			<%	}else{ %>
					<a class="pageNums" href="adSellRequest.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
			<% } %>
		<%	}  %> 
		
	<% }//if count > 0 %>
	
		<br />
		<%-- 작성자/내용 검색 --%>
		<form action="adSellRequest.jsp">
			<select name="sel">
				<option value="g_bno">갤러리번호</option>
				<option value="u_id" >갤러리작성자</option>
				<option value="g_subject" selected>갤러리제목</option>
			</select>
			<input type="text" name="search" /> 
			<input type="submit" value="검색" />
			<input type="button" value="전체글로 돌아가기" onclick="window.location='adSellRequest.jsp'"/>
		</form>	
	
	
	</div>
	
	<div id="bottom"></div>
	
	</div>


</body>
</html>