<%@page import="team.user.model.UserDTO"%>
<%@page import="team.user.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>userModifyForm.jsp</title>
	<link href="team.css" rel="stylesheet" type="text/css" />
	<link href="user_btn.css" rel="stylesheet" type="text/css" />	
	
	<script>
		// 유효성 검사
		function checkField(){
			let inputs = document.inputForm;
			if(!inputs.u_id.value){	// name속성이 id인 요소의 value가 없으면 true
				alert("아이디를 입력하세요.");
				return false;	// pro페이지로 이동 금지.
			}
			if(!inputs.u_pw.value){	
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if(!inputs.u_pwch.value){
				alert("비밀번호 확인란을 입력하세요.");
				return false;
			}
			if(!inputs.u_nick.value){
				alert("닉네임을 입력하세요.");
				return false;
			}
			if(!inputs.u_email.value){
				alert("이메일을 입력하세요.");
				return false;
			}
			if(inputs.u_pw.value != inputs.u_pwch.value){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
		}
	
		function openConfirmId(inputForm) {
	         if(inputForm.u_id.value == ""){
	            alert("아이디를 입력하세요.");
	            return;    // 이 함수 강제종료
	         }
	         // 검사 팝업 열기 
	         let url = "confirmId.jsp?u_id=" + inputForm.u_id.value;         
	         open(url, "confirmId", "width=300, height=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no"); 
	      }
		
		function openConfirmNick(inputForm) {
	         // 사용자가 u_nick 입력란에 작성을 했는지 체크 
	         if(inputForm.u_nick.value == ""){
	            alert("닉네임을 입력하세요.");
	            return;    // 이 함수 강제 종료 
	         }
	         // 닉네임 중복 검사 팝업 열기 
	         let url = "confirmNick.jsp?u_nick=" + inputForm.u_nick.value;         
	         open(url, "confirmNick", "width=300, height=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no"); 
	      }
	</script>
	
</head>
<%
	// 로그인했을때만 접근 가능한 페이지
	String u_id = (String)session.getAttribute("userId");	
	
	if(session.getAttribute("userId") == null){ %>
		<script>
			alert("로그인시 이용가능한 서비스입니다.");
			window.location.href="main.jsp";
		</script>	
<%  }else{ %>

<%
	UserDAO dao = new UserDAO();
	UserDTO user = dao.getUser(u_id);
	
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
%>
<body>
	<div id="box">
	<br />
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
		<h1> 마이페이지 </h1>
		<br /><br />
		<h4><a href="/team/mypage/myProfile.jsp"> 프로필 정보 </a></h4> <br />
		<h4><a href="/team/mypage/shopInfo.jsp"> 쇼핑정보 </a></h4> <br /> 
		<h4><a href="/team/mypage/buyList.jsp"> 구매내역 </a></h4> <br /> 
		<h4><a href="/team/mypage/sellStatus.jsp"> 판매내역 </a></h4> <br /> 
		<h4><a href="/team/mypage/likeView.jsp"> 좋아요 상품 </a></h4> <br /> 
		<h4><a href="/team/mypage/cartView.jsp"> 장바구니 상품 </a></h4> <br /> 
		<h4><a href="/team/mypage/boardManage.jsp"> 게시글 관리 </a></h4>
		
	</div> <%-- left div의 끝 --%>
	<div id="leftLine"></div>
	
	<br />
	
	<div id="main" align="center"> 
	
	<br /><br />

	<h1 align="center">회원정보 수정</h1>
	<form action="userModifyPro.jsp" method="post" onsubmit="return checkField()" name="inputForm" enctype="multipart/form-data" >

		<table>
			<tr>
				<td>아이디(필수기입)</td>
				<td><%=u_id%></td>
			</tr>
			<tr>
				<td>비밀번호(필수기입)</td>
				<td><input type="password" name="u_pw" value="<%=user.getU_pw()%>" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인 *</td>
				<td><input type="password" name="u_pwch" /></td>
			</tr>						
			<tr>
				<td>닉네임(필수기입)</td>
				<td><input type="text" name="u_nick" value="<%=user.getU_nick() %>"  />
					<input type="button" value="닉네임 중복확인" onclick="openConfirmNick(this.form)" />
				</td>
			</tr>
			<tr>
				<td>email(필수기입)</td>
				<td>
				<%
					if(user.getU_email() == null){ //db에 사용자 email 없는 상태%> 
						<input type="text" name="u_email" />
				  <%}else{ //DB에 사용자 Email이 있는상태  %>
						<input type="text" name="u_email" value="<%=user.getU_email()%>" />
				  <%}%>
				</td>
			</tr>		
			<tr>
				<td>profile photo</td>
				<td>
					<%
					if(user.getU_photo() == null){ // DB에 photo가 없는경우 %>
						<img src="/team/save/defaultImg.png" width="150" />
						<%-- 히든으로는 default 이미지 파일명 숨겨서 보내기 --%>
						<input type="hidden" name="u_exPhoto" value="defaultImg.png" />
				<%	}else{ // DB에 Photo가 있을경우 %>
						<img src="/team/save/<%=user.getU_photo()%>" width="150" />
						<%-- 히든으로는 기존에 사용자가 등록했던 이미지 파일명 숨겨서 보내기 --%>
						<input type="hidden" name="u_exPhoto" value="<%=user.getU_photo()%>" />	
				<%  }%>
					 
				<br />
					<%-- 사용자가 등록/수정 버튼 --%>
					<input type="file" name="u_photo" />
				</td>
			</tr>
			<tr>
				<td>블로그</td>
				<td><input type="text" name="u_sns" value="<%=user.getU_sns()%>"/></td>
			</tr>	
			<tr>
				<td> 관심사 선택 </td>
				<td>
					<select name="u_favorite1">
					      <option value="animal">동물</option>
		                  <option value="food">음식</option>
		                  <option value="happymoment">추억</option>
		                  <option value="hoilday">휴일</option>
		                  <option value="nature">자연</option>
		                  <option value="character">인물</option>
		                  <option value="religion">종교</option>
		                  <option value="sports">스포츠</option>
		                  <option value="weather">날씨</option>
					</select>				
					<select name="u_favorite2">
					      <option value="animal">동물</option>
		                  <option value="food">음식</option>
		                  <option value="happymoment">추억</option>
		                  <option value="hoilday">휴일</option>
		                  <option value="nature">자연</option>
		                  <option value="character">인물</option>
		                  <option value="religion">종교</option>
		                  <option value="sports">스포츠</option>
		                  <option value="weather">날씨</option>
					</select>				
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정" />
					<input type="reset" value="재작성" />					
					<input type="button" value="취소" onclick="window.location='/team/mypage/myProfile.jsp'" />					
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