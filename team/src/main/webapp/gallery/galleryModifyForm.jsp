<%@page import="team.gallery.model.GalleryDTO"%>
<%@page import="team.gallery.model.GalleryDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 수정</title>
<link rel="stylesheet" type="text/css" href="styleGallery.css">
<link rel="stylesheet" type="text/css" href="styleGalleryBtn.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
</head>
<%
	int g_bno = Integer.parseInt(request.getParameter("g_bno"));
	String pageNum = request.getParameter("pageNum");

	GalleryDAO dao = new GalleryDAO();
	GalleryDTO gallery = dao.getOneGallery(g_bno);
%>
<body>

<%-- 상단바 --%>
	<jsp:include page="/layout/top.jsp"/>
	
<%-- 수정폼 --%>
	<div id="main" align="center">	
		<form action="galleryModifyPro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
			<input type="hidden" name="g_bno" value="<%=g_bno%>"/>
			<table>
				<tr>
		            <td align="center" colspan="2">
		                <h1>갤러리 수정</h1>
		            </td>
	        	</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="g_subject" value="<%=gallery.getG_subject()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="u_email" value="<%=gallery.getU_email()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
		            <td width="200">카테고리</td>
		            <td>
						<select id="category1" name="category1" onchange="itemChange()">
							<option value="0" selected="selected">대분류</option>
						    <option value="1">동물</option>
						    <option value="2">음식</option>
						    <option value="3">행복</option>
						    <option value="4">휴일</option>
						    <option value="5">자연</option>
						    <option value="6">인물</option>
						    <option value="7">종교</option>
						    <option value="8">날씨</option>
						    <option value="9">스포츠</option>
						</select>
						<select id="category2" name="category2" >
							<option value="0" selected="selected">중분류</option>
						</select>
					</td> 
				</tr>
				<tr>
					<td rowspan="2">사진</td>
					<td>
						<img src="/team/save/<%=gallery.getG_img()%>" width="500" style="width: 530px;"/>
					</td>
				</tr>
				<tr>
					<td>
						<input type="file" name="g_img"/>
						<input type="hidden" name="g_imgEx" value="<%=gallery.getG_img()%>"/>
					</td>	
				</tr>	
				<tr>
					<td>가격</td>
					<td><input type="text" name="g_price" value="<%=gallery.getG_price()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>개인 블로그</td>
					<td><input type="text" name="u_sns" value="<%=gallery.getU_sns()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="80" name="g_content" style="width: 530px;"><%=gallery.getG_content()%></textarea></td>
				</tr>
				<tr>
					<td>태그</td>
					<td><input type="text" name="g_tag" value="<%=gallery.getG_tag()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>촬영 지역</td>
					<td><input type="text" name="g_imglocation" value="<%=gallery.getG_imgLocation()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>카메라 렌즈 </td>
					<td><input type="text" name="g_imgLens" value="<%=gallery.getG_imgLens()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>카메라 기종</td>
					<td><input type="text" name="g_imgCamera" value="<%=gallery.getG_imgCamera()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td>사진 해상도</td>
					<td><input type="text" name="g_imgQuality" value="<%=gallery.getG_imgQuality()%>" style="width: 530px;"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<p style="color: gray; font-size:14px;">※ 판매시, 수수료 3%프로가 부과되며 세부 내용은 [My page > 판매현황] 에서 확인하실 수 있습니다.</p>
					</td>
				</tr>		
				<tr>
					<td colspan="2">
						<input type="checkbox" name="agreements" value="o"> [필수] 판매대금에 대한 수수료 3% 적용에 관한 위 내용에 동의합니다.
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="뒤로가기" onclick="history.go(-1)"/>
						<input type="reset" value="재작성"/>
						<input type="submit" value="수정하기"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<script>
	    function login_check() { 
	       	var u_id = '<%=(String)session.getAttribute("userId")%>';
			if(u_id == "null") { alert("로그인 후 사용하실 수 있습니다."); } 
			else { url = "galleryUploadForm.jsp?pageNum=<%=pageNum%>"
					location.replace(url); }
		}
	    function itemChange(){ 
	    	
	    	// 대분류변수(이름은 big카테고리에 지정해놓은 한글이름을 영어로 마음대로, 아래 코드에서만 쓸거 ) 
	    	//   		= [대분류에 해당하는 중분류 내역들 담은 배열]
	    	var animal = ["애완동물", "야생동물", "해양동물", "파충류", "공룡", "기타"]; // mCategory테이블에 저장된 mc_name
	    	var animalNum = [1, 2, 3, 4, 5, 6]; // mCategory테이블에 저장된 mc_num
	    	var food = ["한식","양식","중식","일식","음료", "간편식"];
	    	var foodNum = [7, 8, 9, 10, 11, 12];  
	    	var happy = ["생일","졸업","계약","결혼식","부모","임신"]; 
	    	var happyNum = [13, 14, 15, 16, 17, 18];
	    	var holiday = ["부활절","공휴일","크리스마스","여행","여가","휴가"];
	    	var holidayNum = [19,20,21,22,23,24];
	    	var nature = ["꽃","물","산","숲","하늘","환경"];
	    	var natureNum = [25,26,27,28,29,30];
	    	var human = ["가족","남성/여성","자식","친구","연인","부모님"];
	    	var humanNum = [31,32,33,34,35,36];
	    	var religion = ["영혼","불교","기독교","유대교","천주교","이슬람"];
	    	var religionNum = [37,38,39,40,41,42];
	    	var weather =  ["비","눈","구름","번개","태풍","지평선"];
	    	var weatherNum = [43,44,45,46,47,48];
	    	var sports =  ["팀","수상","하계","동계","올림픽","레크레이션"];
	    	var sportsNum = [49,50,51,52,53,54];
	    	
	    	// jquery문법 = $("#category1") : id속성값이 category1인 태그를 선택  .val() : 선택한 태그의 벨류값가져오기 (option태그의 value속성값)
	    	var selectItem = $("#category1").val(); // 예: 음식선택하면 2를 가져옴
	    	
	    	var changeItem;  // 변수 (대분류 선택한것에 따라 중분류에 띄워줄 배열 담을 변수 미리선언)
	    	var changeItemNum; 
	    	
	    	if(selectItem == "1"){  
	    		changeItem = animal;
	    		changeItemNum = animalNum;
	    	}else if(selectItem == "2"){
	    		changeItem = food;
	    		changeItemNum = foodNum;
	    	}else if(selectItem == "3"){  
	    		changeItem =  happy;
	    		changeItemNum = happyNum;
	    	}else if(selectItem == "4"){  
	    		changeItem =  holiday;
	    		changeItemNum = holidayNum;
	    	}else if(selectItem == "5"){  
	    		changeItem =  nature;
	    		changeItemNum = natureNum;
	    	}else if(selectItem == "6"){  
	    		changeItem =  human;
	    		changeItemNum = humanNum;
	    	}else if(selectItem == "7"){  
	    		changeItem =  religion;
	    		changeItemNum = religionNum;
	    	}else if(selectItem == "8"){  
	    		changeItem =  weather;
	    		changeItemNum = weatherNum;
	    	}else if(selectItem == "9"){  
	    		changeItem =  sports;
	    		changeItemNum = sportsNum; 
	    	}
	    	
	    	$('#category2').empty(); // 중분류 셀렉트 박스안에있는 option들 다 지우기
	    	
	    	for(var count = 0; count < changeItem.length; count++){ // 중분류 선택된 배열 개수만큼 반복
	    		var option = $("<option value='"+changeItemNum[count]+"'>"+changeItem[count]+"</option>"); 
	    		$('#category2').append(option);            
	    	} 
	    }
	</script>	   
    
</body>
</html>