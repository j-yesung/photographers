<%@page import="team.mypage.model.PaymentDTO"%>
<%@page import="team.mypage.model.PaymentDAO"%>
<%@page import="team.mypage.model.UserOrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="payment" class="team.mypage.model.PaymentDTO" />
<jsp:setProperty property="*" name="payment"/>
<%
	String u_id = (String)session.getAttribute("userId");
	String p_id = request.getParameter("u_id");
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));

	PaymentDAO dao = new PaymentDAO(); 
	dao.insertOrder(payment); // 주문내역 DB 저장
	
	dao.afterOrderCartDelete(g_bno); // 장바구니에서 주문하면 장바구니 목록리스트에서 지워지는 메서드 호출
	
%>
		
		<script>
			alert("결제가 완료되었습니다. :) ");
			window.location.href = "/team/gallery/showAll.jsp";
		</script>


</body>
</html>