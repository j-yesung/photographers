<%@page import="team.admin.model.AdminDAO"%>
<%@page import="team.admin.model.AdminDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PHOTOGRAPHERS</title>
<link href="loadstyle.css" rel="stylesheet" type="text/css" />
</head>

</head>
	<% 
		AdminDAO dao = new AdminDAO();
		AdminDTO loading = dao.getLoad();
		
		System.out.println("loading"+ loading.getSi_Loading());
	%>
<body>
 <!-- Video Source -->
  <!-- https://www.pexels.com/video/icecaps-covering-the-mountains-ranges-3214448/ -->
  <section class="showcase">
    <header>
      <h2 class="logo">Photographers</h2>
      <div class="toggle"></div>
    </header>
    <video muted loop autoplay>
    	<source src="/team/save/<%=loading.getSi_Loading()%>" type="video/mp4" >   
    </video>
    <div class="overlay"></div>
    <div class="text">
      <h2>Never Stop To </h2> 
      <h3>Exploring The World</h3>
       <p>  “Travel isn’t always pretty. It isn’t always comfortable. 
       Sometimes it hurts, it even breaks your heart. But that’s okay. 
       The journey changes you; it should change you. 
       It leaves marks on your memory, on your consciousness, on your heart, and on your body. 
       You take something with you. Hopefully, you leave something good behind.” – Anthony Bourdain</p>
      <a href="main.jsp">Explore</a>
    </div>
    <ul class="social">
      <li><a href="#"><img src="https://i.ibb.co/x7P24fL/facebook.png"></a></li>
      <li><a href="#"><img src="https://i.ibb.co/Wnxq2Nq/twitter.png"></a></li>
      <li><a href="#"><img src="https://i.ibb.co/ySwtH4B/instagram.png"></a></li>
    </ul>
  </section>
  <div class="menu">
    <ul>
      <li><a href="#">Home</a></li>
      <li><a href="#">News</a></li>
      <li><a href="#">Destination</a></li>
      <li><a href="#">Blog</a></li>
      <li><a href="#">Contact</a></li>
    </ul>
  </div>
  
  <script>
  const menuToggle = document.querySelector('.toggle');
  const showcase = document.querySelector('.showcase');

  menuToggle.addEventListener('click', () => {
    menuToggle.classList.toggle('active');
    showcase.classList.toggle('active');
  })
  </script>
</body>
</html>