<%@page import="team.user.model.UserDAO"%>
<%@page import="team.user.model.UserDTO"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 상세페이지</title>
<link rel="stylesheet" type="text/css" href="styleGallery.css">
<link rel="stylesheet" type="text/css" href="styleGalleryBtn.css">
<link rel="stylesheet" type="text/css" href="styleGalleryCategory.css">
</head>
<%
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) { pageNum = "1"; }

	GalleryDAO dao = new GalleryDAO(); 
	GalleryDTO gallery = dao.getOneGallery(g_bno);
	dao.addReadCount(g_bno);
%>
<body>
	
<%-- 상단바 --%>
	<jsp:include page="/layout/top.jsp"/>
	
<%-- 카테고리 --%>
	<jsp:include page="/layout/category.jsp"/>
	
<%-- 상세 정보 --%>	
	<br/>
	<div>
		<table style="width: 1000px;">
			<tr>
				<td colspan="4">
					<h1><b><%=gallery.getG_subject()%></b></h1>
				</td>
			</tr>
			<tr>
				<td rowspan="8" align="center">
					<img src="/team/save/<%=gallery.getG_img()%>" width="700" height="520"/>
				</td>
			</tr>
			<tr>
				<td>판매자</td>
				<td colspan="2"><%=gallery.getU_id()%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td colspan="2"><%=gallery.getU_email()%></td>
			</tr>
			<tr>
				<td>금액</td>
				<td colspan="2"><fmt:formatNumber value="<%=gallery.getG_price() %>" /> 원</td>
			</tr>
			<tr>
				<td>촬영 지역</td>
				<td colspan="2"><%=gallery.getG_imgLocation()%></td>
			</tr>
			<tr>
				<td>카메라 렌즈</td>
				<td colspan="2"><%=gallery.getG_imgLens()%></td>
			</tr>
			<tr>
				<td>카메라 기종</td>
				<td colspan="2"><%=gallery.getG_imgCamera()%></td>
			</tr>
			<tr>
				<td>사진 해상도</td>
				<td colspan="2"><%=gallery.getG_imgQuality()%></td>
			</tr>
			<tr>
				<td rowspan="2" height="100"><%=gallery.getG_content()%></td>
				<%-- 
				<td colspan="2" align="center">
					<input type="button" value="뒤로가기" onclick="window.location='showAll.jsp?pageNum=<%=pageNum%>'"/>
					<input type="submit" value="수정하기" onclick="window.location='galleryModifyForm.jsp?g_bno=<%=gallery.getG_bno()%>&pageNum=<%=pageNum%>'"/>
					<input type="button" value="주문하기" onclick="team/ window.location='showAll.jsp?pageNum=<%=pageNum%>'"/> 
				</td>
				--%>
			</tr>
			<tr>
				<td align="center">
					<form method="post" name="addCart" action="/team/mypage/addCartPro.jsp">
						<input type="hidden" name="g_bno" value="<%=gallery.getG_bno()%>"/>
						<input type="hidden" name="u_id2" value="<%=gallery.getU_id()%>">
						<input type="submit" value="장바구니에 담기"/>
					</form>
				</td>
				<td align="center">
					<form method="post" name="addLike" action="/team/mypage/addLikePro.jsp">
						<input type="hidden" name="g_bno" value="<%=gallery.getG_bno()%>"/>
						<input type="hidden" name="u_id2" value="<%=gallery.getU_id()%>">
						<input type="submit" value="관심상품 담기"/>
					</form>
				</td>
				<td align="center">
					<form method="post" name="order" action="/team/mypage/directOrderForm.jsp">
						<input type="hidden" name="g_bno" value="<%=gallery.getG_bno()%>"/>
						<input type="hidden" name="u_id2" value="<%=gallery.getU_id()%>">
						<input type="submit" value="바로구매">
					</form>
				</td>
			</tr>
		</table>
	</div>
	
	<script>
		function delOK() { if(!confirm('정말로 삭제하시겠습니까?')){ window.location.href = "galleryDeletePro.jsp"; }}
	</script>
</body>
</html>