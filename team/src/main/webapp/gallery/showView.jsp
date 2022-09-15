<%@page import="java.util.List"%>
<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 검색 결과</title>
<link rel="stylesheet" type="text/css" href="styleGallery.css">
<link rel="stylesheet" type="text/css" href="styleGalleryBtn.css">
<link rel="stylesheet" type="text/css" href="styleGalleryCategory.css">
</head>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	String sel = request.getParameter("sel");
	String search = request.getParameter("search"); 
	
	if(pageNum == null) { pageNum = "1"; }
	int pageSize = 9;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;	
	int endRow = currentPage * pageSize;
	
	GalleryDAO dao = new GalleryDAO();
	List<GalleryDTO> galleryList = null;
	int count = 0;
	
	// 검색 결과 게시판
	if(sel != null && search != null) { count = dao.getGallerySearchCount(sel, search); }
	if(count > 0) { galleryList = dao.getGallerySearch(startRow, endRow, sel, search); }
	
	int number = count - (currentPage - 1) * pageSize;
%>
<body>

<%	if(search.equals("")) { %>
	<script>
		alert("검색어를 입력해 주세요.");
		history.go(-1);
	</script>
<%	} %>

<%-- 상단바 --%>
	<jsp:include page="/layout/top.jsp"/>
	
<%-- 카테고리 --%>
	<jsp:include page="/layout/category.jsp"/>

<%-- 갤러리 --%>	
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
		
<%-- 페이징 --%>	
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
					<a href="showView.jsp?pageNum=<%=startPage-1%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
<%				} else { %>
					<a href="showView.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
<%				}
			}
			for(int i = startPage; i <= endPage; i++) { 
				if(sel != null && search != null) { %>
					<a href="showView.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
<%				} else { %>
					<a href="showView.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
<%				} 
			}
			if(endPage < pageCount) {
				if(sel != null && search != null) { %>
					<a href="showView.jsp?pageNum=<%=startPage+pageNumSize%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
<%				} else { %>
					<a href="showView.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
<%				}
			}
		} %>
	</div>				
	
</body>
</html>