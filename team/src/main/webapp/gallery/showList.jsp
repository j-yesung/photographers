<%@page import="java.util.List"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 리스트</title>
<link rel="stylesheet" type="text/css" href="styleGallery.css">
<link rel="stylesheet" type="text/css" href="styleGalleryBtn.css">
<link rel="stylesheet" type="text/css" href="styleGalleryCategory.css">
</head>
<%
	int cate2 = Integer.parseInt(request.getParameter("category2"));
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null) { pageNum = "1"; }
	int pageSize = 9;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	GalleryDAO dao = new GalleryDAO();
	List<GalleryDTO> galleryList = null;
	int count = dao.getGalleryCategoryCount(cate2);
	
	if(count > 0) { galleryList = dao.getGalleryCategoryList(cate2, startRow, endRow); }
	int number = count - (currentPage - 1) * pageSize;
%>
<body>

<%-- 상단바 --%>
	<jsp:include page="/layout/top.jsp"/>
	
<%-- 카테고리 --%>
	<jsp:include page="/layout/category.jsp"/>
	
<%-- 갤러리--%>
<%	if(count == 0) { %>
		<div id="main2" align="center">게시글이 없습니다.</div>
<%	} else { %>
		<div id="main2" align="center">
<%		for(int i = 0; i < galleryList.size(); i++) {
			GalleryDTO gallery = galleryList.get(i); %>
			<div style="margin: 20px; font-family: 'NanumGothicBold'; font-size: 13px; text-align: right;">
				<a href="showContent.jsp?g_bno=<%=gallery.getG_bno()%>&pageNum=<%=pageNum%>">
				<img src="/team/save/<%=gallery.getG_img()%>" width="200" height="200"/></a><br/>
				좋아요 <%=gallery.getG_like()%>&ensp;조회수 <%=gallery.getG_readCount()%><br/>
			</div>
<%		} %>
		</div>
<%	} %>
	<button class="btn3" onclick="window.location='galleryUploadForm.jsp'">갤러리 등록</button>
	
<%-- 페이징--%>
	<div id="bottom">
	<br/>
<%		if(count > 0) {
			int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
			int pageNumSize = 5;
			int startPage = ((currentPage - 1) / pageNumSize) * pageNumSize + 1;
			int endPage = startPage + pageNumSize - 1;
			if(endPage > pageCount) { endPage = pageCount; }
			
			if(startPage > pageNumSize) {
				if(sel != null && search != null) { %>
					<a href="showList.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
<%				} else { %>
					<a href="showList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
<%				}
			}
			for(int i = startPage; i <= endPage; i++) { 
				if(sel != null && search != null) { %>
					<a href="showList.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
<%				} else { %>
					<a href="showList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
<%				} 
			}
			if(endPage < pageCount) {
				if(sel != null && search != null) { %>
					<a href="showList.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
<%				} else { %>
					<a href="showList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
<%				}
			}
		} %>
	</div>
	
</body>
</html>