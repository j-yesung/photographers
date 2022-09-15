<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
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
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	
	GalleryDAO dao = new GalleryDAO(); 
	GalleryDTO gallery = dao.getOneGallery(g_bno);
	dao.addReadCount(g_bno);

	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
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
	
		<div>
			<table width="1000">
				<tr>
					<td colspan="3">
						<h1>[ 상품번호 : <%=gallery.getG_bno()%> ] &nbsp; <b><%=gallery.getG_subject()%></b></h1>
					</td>
				</tr>
				<tr>
					<td rowspan="8" align="center">
						<img src="/team/save/<%=gallery.getG_img()%>" width="450" height="520"/>
					</td>
				</tr>
				<tr>
					<td>판매자</td>
					<td><%=gallery.getU_id()%></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><%=gallery.getU_email()%></td>
				</tr>
				<tr>
					<td>금액</td>
					<td><%=gallery.getG_price()%></td>
				</tr>
				<tr>
					<td>촬영 지역</td>
					<td><%=gallery.getG_imgLocation()%></td>
				</tr>
				<tr>
					<td>카메라 렌즈</td>
					<td><%=gallery.getG_imgLens()%></td>
				</tr>
				<tr>
					<td>카메라 기종</td>
					<td><%=gallery.getG_imgCamera()%></td>
				</tr>
				<tr>
					<td>사진 해상도</td>
					<td><%=gallery.getG_imgQuality()%></td>
				</tr>
				<tr>
					<td rowspan="2"><%=gallery.getG_content()%></td>
				</tr>
				<tr>
					<td align="center">
						<button onclick="window.location='/team/admin/adGallerySleepPro.jsp?g_bno=<%=gallery.getG_bno()%>&pageNum=<%=pageNum%>'">비공개전환</button>
					</td>
					<td align="center">
						<button onclick="window.location='/team/admin/adGalleryWakePro.jsp?g_bno=<%=gallery.getG_bno()%>&pageNum=<%=pageNum%>'">공개 전환</button>	
					</td>
				</tr>
			</table>
		</div>
	</div> <%-- main div의 끝 --%>
		
	
	<div id="mainSub" align="center">
		<button onclick="window.location='adBoardManage.jsp?pageNum=<%=pageNum%>'">전체글로 돌아가기</button>
	</div> <%-- mainSub의 끝 --%>
	
	<div id="bottom"></div>
	</div> <%-- box div의 끝 --%>
	


</body>
</html>