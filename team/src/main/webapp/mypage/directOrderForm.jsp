<%@page import="team.mypage.model.PaymentDTO"%>
<%@page import="team.mypage.model.PaymentDAO"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@page import="team.user.model.UserDTO"%>
<%@page import="team.user.model.UserDAO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>바로구매</title>
   <link href="team.css" rel="stylesheet" type="text/css" />
   <link href="mypage_btn.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
   
<%	if(session.getAttribute("userId") == null){ // 비로그인시%>
	<script>
  		alert("로그인시 이용가능한 페이지입니다.");
  		window.location="/team/user/loginForm.jsp";
	</script>
<%	} %>     
   <%
   // 파라미터 가져오기
   
   String p_id = (String)session.getAttribute("userId");
   int g_bno = Integer.parseInt(request.getParameter("g_bno"));

   int p_finalPrice = 0; // 총금액 리턴받을 변수
   GalleryDAO gallDao = new GalleryDAO();
   GalleryDTO gallery = gallDao.getOneGallery(g_bno);
   
   PaymentDAO paymentDao = new PaymentDAO();
   UserDTO userDto = paymentDao.getUser(p_id);
   
   %>
   
 <!-- 메일보내는 메서드 -->
   
   

<%request.setCharacterEncoding("UTF-8");

   String sel = request.getParameter("sel");
   String search = request.getParameter("search"); %>   



</head>
   <% if(session.getAttribute("userId") == null){ // 비로그인시%>
      <script>
         alert("로그인시 이용가능한 페이지입니다.");
         window.location="/team/user/loginForm.jsp";
      </script>
   <%} %>

<body>
   <br />
   
   <div id="box">
   <div id="top">
      <div>
         <a href="/team/banner/main.jsp"><b style="font-size: 50px;">PHOTOGRAPERS</b></a>&emsp;&emsp;&emsp;
<%        if(session.getAttribute("adminId") != null) { %>   
            <a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
            <a href="/team/admin/adBoard.jsp" class="btn"> 관리자페이지</a>
<%        } else{ %>
            <a href="/team/gallery/showAll.jsp" class="btn2">갤러리</a>
            <a href="/team/mypage/myProfile.jsp" class="btn2">마이페이지</a>
            <a href="/team/mypage/cartView.jsp" class="btn2">장바구니</a>
            <a href="/team/mypage/likeView.jsp" class="btn2">좋아요</a>
<%        } %>
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
   <h2 align="left">  주문 / 결제 </h2>

   
<form id="form" action="directOrderPro.jsp" method="post" >
   <table id="orderTable" width='1100' border='1'>
      <br/>
      <tr><td align="center" colspan='8' style="font-size:20pt"><b>주문 / 결제</b></td></tr>
      <br/>
      <tr><td align="left" colspan='8' style="font-size:15pt"><b>구매자 정보</b></td></tr>
      
      <tr align='center'>
         <td width='30' align="left" colspan="8">아이디 : <%=p_id %></td>
      </tr>
      <tr align='center'>
         <td width='150' align="left"  colspan="8">이메일 : <%=userDto.getU_email()%></td>
      </tr>
   
   
   
      <tr><td align="left" colspan='8' style="font-size:15pt"><b>상품정보</b></td></tr>
      <tr align='center'>
         <td width='30'>갤러리No.</td>
         <td width='150'>작    품</td>
         <td width='150'>작 품 명</td>
         <td width='50'>작    가</td>
         <td width='50'>판 매 가</td>
      </tr>
      
      <%p_finalPrice+=gallery.getG_price();%>
           <tr>
            <td>
               <a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><%=g_bno%></a>
            </td>
            <td>
               <a href="/team/gallery/showContent.jsp?g_bno=<%=gallery.getG_bno()%>"><img src="/team/save/<%=gallery.getG_img()%>" width="100"></a>
            </td>
            <td> <%=gallery.getG_subject() %> </td>
            <td> <%=gallery.getU_id() %> </td>
            <td> <fmt:formatNumber value="<%=gallery.getG_price() %>" /> 원 </td>
         </tr>   
         <tr>
            <td colspan='8' align='right' style="height:50px; font-size:13pt"><b>총 <fmt:formatNumber value="<%=p_finalPrice %>" type="currency" currencySymbol="￦" /> 원</b></td>
         </tr>
         <tr>
               <td>결제방식</td>
                 <td>
            <select name="p_option">
                    <option value="카드" >카드</option>
                    <option value="무통장입금">무통장입금</option>
            </select>
            </td>
           </tr>
         <tr> 
            <td colspan='8' align='center'>
            <input type = "hidden" name="g_bno" value="<%=gallery.getG_bno()%>">
            <input type = "hidden" name="u_email" value="<%=userDto.getU_email()%>">
            <input type = "hidden" name="u_id" value="<%=gallery.getU_id()%>">
            <input type = "hidden" name="u_nick" value="<%=userDto.getU_nick()%>">
            <input type = "hidden" name="p_id" value="<%=p_id%>">
            <input type = "hidden" name="g_subject" value="<%=gallery.getG_subject()%>">
            <input type = "hidden" name="g_price" value="<%=gallery.getG_price()%>">
            <input type = "hidden" name="p_finalPrice" value="<%=p_finalPrice%>">
            
            <input type ="submit" id="button" value="결제하기" style="width:160px; height:50px; font-weight:bold; font-size:13pt;"/>
              </td>
          </tr>   
      </table>
</form>

   <script>
       // 메일보내는 메서드
   (function(){
         emailjs.init("OyTmVMS6l9j2YzwEa");
    })();
   
   const btn = document.getElementById('button');
   
   document.getElementById('form')
    .addEventListener('submit', function(event) {
      event.preventDefault();
   
      btn.value = '보내는중...';
   
      const serviceID = 'default_service';
      const templateID = 'template_jubs14b';
   
      emailjs.sendForm(serviceID, templateID, this)
       .then(() => {
         btn.value = '메일을 확인하세요';
         alert('결제완료!');
       }, (err) => {
         btn.value = '다시 시도해주세요';
         alert(JSON.stringify(err));
       });
      this.submit();
   });

 
   </script>
         
   </div> <%-- main div의 끝 --%>
   
   <div id="mainSub" align="center">

   
      <br />

   </div><%-- mainSub div의 끝 --%>
   <div id="bottom"></div>
 </div><%-- box div의 끝  --%>
</body>
</html>