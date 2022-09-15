<%@page import="team.admin.model.AdminDAO"%>
<%@page import="team.admin.model.AdminDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자페이지 대시보드</title>
	<link href="team2.css" rel="stylesheet" type="text/css"/>
	<link href="admin_btn.css" rel="stylesheet" type="text/css"/>
	 <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
</head>
	
	<%		
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	AdminDAO dao = new AdminDAO();
	AdminDTO loading = dao.getLoad(); 
	

	System.out.println("1"+ loading.getSi_Loading());
	System.out.println("2"+ loading.getSi_MainImg()); 
	System.out.println("3"+ loading.getSi_TodayImg()); 

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
			<%  if(session.getAttribute("adminId") != null){ %>	
				<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
				<a href="/team/admin/adBoard.jsp" class="btn"> 관리자페이지</a>
			<%  }else{ %>
					<a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
					<a href="/team/mypage/myProfile.jsp" class="btn2">마이페이지</a>
					<a href="/team/user/userCart.jsp" class="btn2">장바구니</a>
					<a href="/team/mypage/userLike.jsp" class="btn2">좋아요</a>
			<%  } %>
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<%			if(session.getAttribute("userId") == null && session.getAttribute("adminId") == null){ %>
					<a href="/team/user/loginForm.jsp" class="btn">로그인</a>
					<a href="/team/user/signupForm.jsp" class="btn">회원가입</a>
	<%			} else { %>
					<a href="/team/user/logout.jsp" class="btn">로그아웃</a>
	<%			} %>
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
		
		<div id="main1">
			<form action="adLoadingModifyPro.jsp" method="post" name="gForm" enctype="multipart/form-data">
			<div id="Loading"><h2>로딩영상 수정</h2></div>
			
				<video muted loop autoplay height="360" width="500">
			    	<source src="/team/save/<%=loading.getSi_Loading()%>" type="video/mp4">   
			    </video>
					<div class="button"	>
				    	<input type="file" name="si_Loading">
						<input type="hidden" name="si_LoadingEx" value="<%=loading.getSi_Loading()%>"/>
						<input type="submit" value="수정하기" onClick='return confirmSubmit()' />
				 	</div> 

			</form>
		</div>
			
			
		<div id="main2">				
			<form id="target" action="adMainModifyPro.jsp" method="post" enctype="multipart/form-data">
			<div id="MainImg"><h2>이미지 수정</h2></div>
				<div>
					<img src="/team/save/<%=loading.getSi_MainImg()%>" width="300" height="200"/>
						<input type="file" name="si_MainImg"/>
						<input type="hidden" name="si_MainImgEx" value="<%=loading.getSi_MainImg()%>"/>
					<img src="/team/save/<%=loading.getSi_TodayImg() %>" width="300" height="200"/>
						<input type="file" name="si_TodayImg"/>
						<input type="hidden" name="si_TodayImgEx" value="<%=loading.getSi_TodayImg()%>"/>
					<div class="button"	>
							<input type="submit" value="수정하기" onClick='return confirmSubmit()'/>
					</div> 
				 </div>
			</form>
		</div>		
		
		<div id="mainSub"></div>
		
		<div id="bottom"></div>
		
	</div>
	
	<script>
		function confirmSubmit()
		{
		var agree=confirm("정말 수정하시겠습니까?");
		if (agree)
			return true ;
		else
			return false ;
		}
	</script>

</body>

</html>