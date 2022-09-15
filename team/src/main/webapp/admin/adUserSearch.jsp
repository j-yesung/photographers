<%@page import="team.user.model.UserDTO"%>
<%@page import="team.admin.model.AdminDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 회원정보 조회</title>
	<link href="team.css" rel="stylesheet" type="text/css"/>
	<link href="admin_btn.css" rel="stylesheet" type="text/css"/>
	
<%
	// 관리자 세션
	String u_id = (String)session.getAttribute("adminId");
	
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

	// mainSub의 검색form 파라미터 가져오기
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 	
	
	// 기간조회 파라미터
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String dateSel = request.getParameter("dateSel");
	
//--------------------------------------------------------------------

	int count = 0; // 회원게시물 카운팅갯수 담을 변수 
	List allUserList = null;

	// 관리자 모든 회원 카운팅 메서드
	AdminDAO dao = new AdminDAO();
	
	if(sel != null && search != null){
		count = dao.getAllUserSearchCount(sel, search);
		if(count > 0){
			allUserList = dao.getAllUserSearch(startRow, endRow, sel, search); 
		}
	}else if(startDate != null && endDate != null){ // 기간조회시,
		count = dao.getAllUserDateCount(startDate, endDate);
		System.out.println("선택된 날짜 : " + startDate + " - " + endDate);
		System.out.println("선택된 날짜에 가입한 회원수 : " + count);
		if(count > 0){
			allUserList = dao.getAllUserDate(startRow, endRow, startDate, endDate);
			System.out.println("해당기간 등록상품 : " + allUserList);	
		}		
	}else{
		count = dao.getAllUserCount();
		if(count > 0){
			allUserList = dao.getAllUser(startRow, endRow);
		}
	}
	
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
%>
	
<%
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
			<h2 align="left"> 전체회원정보 조회 : <%=count %> 건 </h2>
		<br />
		<table>
			<tr>
				<td style="width : 200px;" align="center" background="green">총 회원 수</td>
				<td style="width : 200px;" align="center">정상계정 수</td>
				<td style="width : 200px;" align="center">휴면계정 수</td>
			</tr>
			<tr>
				<td align="right"><%=count%></td>
				<td align="right"><%=userNow%></td>
				<td align="right"><%=userSleep%></td>
			</tr>
		
		</table>
		<br />	
		
	<form action="adUserSearch.jsp?pageNum=<%=pageNum%>" method="post" >
		<select name="dateSel">
			<option value="g_reg" selected>가입일시</option>
		</select>
		<input type="date" name="startDate" /> &nbsp; - &nbsp;
		<input type="date" name="endDate" />
		<input type="submit" value="조회" />
	</form>			
					

		<%	if(count == 0){  %>
				<table>
					<tr>
						<td colspan="5">게시글이 없습니다.</td>
					</tr>
				</table>	
		<%	}else{	// 작은else%>
				<table>
				<tr align="center">
					<td> No. </td>
					<td> 회원고유번호 </td>
					<td> 회원이미지</td>		
					<td> 아이디 </td>	
					<td> 닉네임 </td>			
					<td> 이메일 </td>	
					<td> SNS주소 </td>		
					<td> 회원상태 </td>
					<td> 가입일시 </td>
				</tr>
				
				 <% for(int i = 0; i < allUserList.size(); i++){ %>
			  		<% UserDTO user = (UserDTO)allUserList.get(i);%>
					
					<tr>
						<td><%=number-- %></td>
						<td>
							<a href="/team/admin/adUserManage.jsp?u_userno=<%=user.getU_userno()%>&pageNum=<%=pageNum%>&u_id=<%=user.getU_id()%>"><%=user.getU_userno()%></a>
						</td>
						<td>
							<a href="/team/admin/adUserManage.jsp?u_userno=<%=user.getU_userno()%>&pageNum=<%=pageNum%>&u_id=<%=user.getU_id()%>"><img src="/team/save/<%=user.getU_photo()%>" width="100"></a>
						</td>
						<td><%=user.getU_id()%></td>
						<td><%=user.getU_nick()%></td>
						<td><%=user.getU_email()%></td>
						<td><%=user.getU_sns()%></td>
						<td><%=user.getU_status()%></td>
						<td><%=user.getU_reg()%></td>
					</tr>	
			  <% } %>
			</table>
		<%	} //if else의 끝 %>				
		
		
		
		</div>
		
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
							<a class="pageNums" href="adUserSearch.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
						<%}else{%>
							<a class="pageNums" href="adUserSearch.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
						<%}
					}
					
					for(int i = startPage; i <= endPage; i++) { 
						if(sel != null && search != null) { %>
							<a class="pageNums" href="adUserSearch.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
						<%}else{ %>
							<a class="pageNums" href="adUserSearch.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
						<%} 
					}
					
					if(endPage < pageCount) { 
						if(sel != null && search != null) { %>
							<a class="pageNums" href="adUserSearch.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
					<%	}else{ %>
							<a class="pageNums" href="adUserSearch.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
					<% } %>
				<%	}  %> 	
			   <%} //if count > 0%>	
	   
		<br />			
			<%-- 작성자/내용 검색 --%>
			<form action="adUserSearch.jsp">
				<select name="sel">
					<option value="u_userno">회원번호</option>
					<option value="u_id" selected>회원ID</option>
					<option value="u_status" >회원상태</option>
				</select>
				<input type="text" name="search" /> 
				<input type="submit" value="검색" />
				<input type="button" value="전체글로 돌아가기" onclick="window.location='adUserSearch.jsp'"/>
			</form>	
		
		
		</div> <%-- mainSub div의 끝 --%>
		
		<div id="bottom"></div>
		
	</div> <%-- box div의 끝 --%>


</body>
</html>