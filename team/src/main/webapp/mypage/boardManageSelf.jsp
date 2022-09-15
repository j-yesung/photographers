<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardManageSelf.jsp</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="mypage_btn.css" rel="stylesheet" type="text/css" />	
</head>
<%
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	String pageNum = request.getParameter("pageNum");
	String g_status = request.getParameter("g_status");
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
	
	GalleryDAO dao = new GalleryDAO(); 
	GalleryDTO gallery = dao.getOneGallery(g_bno);
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
	<div id="main">
		<br />
		<h1 align="center"> <b><%=gallery.getG_subject()%></b> </h1>
		<div align="center">
		<table>
			<tr>
				<td rowspan="7" width="400px" height="500px"><img src="/team/save/<%=gallery.getG_img()%>" width="370" height="450px"></td>
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
				<td>내용</td>
				<td colspan="2"><%=gallery.getG_content()%></td>
			</tr>
		</table>
		</div>
		<div align="center">
		<button onclick="window.location='/team/gallery/galleryModifyForm.jsp?pageNum=<%=pageNum%>&g_bno=<%=gallery.getG_bno()%>'">수정하기</button>
		<%if(Integer.parseInt(g_status) == 0){ %>
		<button onclick="window.location='/team/gallery/galleryDeletePro.jsp?pageNum=<%=pageNum%>&g_bno=<%=gallery.getG_bno()%>'">승인요청 취소</button>	
		<%} %>
		<%if(Integer.parseInt(g_status) == 1){ %>
		<button onclick="window.location='/team/gallery/gallerySleepPro.jsp?pageNum=<%=pageNum%>&g_bno=<%=gallery.getG_bno()%>'">비공개 전환</button>
		<%} %>
		<%if(Integer.parseInt(g_status) == 2){ %>
			<button onclick="window.location='/team/gallery/galleryWakePro.jsp?pageNum=<%=pageNum%>&g_bno=<%=gallery.getG_bno()%>'">게시글 부활</button>		
	    <%} %>
	    <button onclick="window.location='/team/mypage/boardManage.jsp?pageNum=<%=pageNum%>'"> 뒤로가기 </button>
		</div>
	
	</div>
	<div id="mainSub"></div>
	<div id="bottom"></div>
		
	</div> <%-- div box의 끝 --%>
</body>

</html>