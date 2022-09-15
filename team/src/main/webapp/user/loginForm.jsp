<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginForm.jsp</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="user_btn.css" rel="stylesheet" type="text/css" />	
	<script>
		// 유효성 검사
		function checkField(){
			let inputs = document.loginForm;
			if(!inputs.u_id.value){
				alert("아이디를 입력해주세요.");
				return false;
			}
			if(!inputs.u_pw.value){
				alert("비밀번호를 입력해주세요.");
				return false;
			}
		}
	</script>
<%

	String sel = request.getParameter("sel");
	String search = request.getParameter("search");

	if(session.getAttribute("userId") != null ){ // 로그인시 -> 로그인 불가능%>
		<script>
			alert("이미 로그인된 상태입니다..");
			window.location.href="/team/banner/main.jsp"
		</script>
 <% }else{ // 비로그인시 -> 로그인가능 %>

</head>


<body>
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
	<div id="left"></div>
	<div id="leftLine"></div>
	
	<br />
	
	<div id="main" align="center"> 
	
	<br /><br />
	<form action="loginPro.jsp" method="post" name="loginForm" onsubmit="return checkField()">
		<table>
			<tr>
				<td onclick="window.location='loginForm.jsp'" width="150px"> 로그인 </td>
				<td onclick="window.location='signupForm.jsp'" width="150px"> 회원가입 </td>
			</tr>
			<tr>
				<td colspan="2" align="left"> 아이디 <br /> 
					<input type="text" name="u_id" placeholder="아이디를 입력하세요." style="width : 270px"/>
				</td>
				
			</tr>
			<tr>
				<td colspan="2" align="left"> 비밀번호 <br />
					<input type="password" name="u_pw" placeholder="비밀번호를 입력하세요." style="width : 270px"/>
				</td>
			</tr>
			<tr align="left">
				<td colspan="2"><input type="checkbox" name="u_auto" value="1" /> 자동로그인 </td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="로그인"  width="200px" height="100px"/></td>
			</tr>
			<tr>	 
				<td colspan="2">
				<input type="button" value="아이디찾기" onclick="window.location='userFindId.jsp'"/> 
				<input type="button" value="비밀번호찾기" onclick="window.location='userFindPw.jsp'"/> 
				</td>
			</tr>
		
		</table>
	</form>	
	</div>
	<div id="mainSub"></div>
	<div id="bottom"></div>
	</div><%-- box div의 끝 --%>
</body>
  <% } %>
</html>