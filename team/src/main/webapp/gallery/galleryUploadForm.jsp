<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리 등록</title>
<link rel="stylesheet" type="text/css" href="styleGallery.css">
<link rel="stylesheet" type="text/css" href="styleGalleryBtn.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" ></script>
</head>
<%
	String u_id = (String)session.getAttribute("userId");
	String ad_id = (String)session.getAttribute("adminId");
	String pageNum = request.getParameter("pageNum");

	if(session.getAttribute("userId") == null){ %>
		<script>
		   window.location="/team/user/loginForm.jsp";
		   alert("로그인시 이용 가능한 페이지입니다.");
		</script>
<% 	} %>
<body>

<%-- 상단바 --%>
	<jsp:include page="/layout/top.jsp"/>
	
<%-- 등록폼 --%>
   <div id="main" align="center">
      <form action="galleryUploadPro.jsp?pageNum=<%=pageNum%>" method="post" name="inputForm" enctype="multipart/form-data" onsubmit="return checkField();">
         <table>
            <tr>
                  <td align="center" colspan="2">
                      <h2>갤러리 등록</h2>
                  </td>
              </tr>
            <tr>
               <td>*제목</td>
               <td><input type="text" name="g_subject" placeholder="&lt필수&gt 제목을 입력하세요" style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>*이메일</td>
               <td><input type="text" name="u_email" placeholder="&lt필수&gt 이메일을 입력하세요" style="width: 530px;"/></td>
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
               <td>*사진</td>
               <td><input type="file" name="g_img"/></td>
            </tr>
            <tr>
               <td>*가격</td>
               <td><input type="text" name="g_price" placeholder="&lt필수&gt 가격을 입력하세요" style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>개인 블로그</td>
               <td><input type="text" name="u_sns" placeholder="링크를 삽입하세요." style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>*내용</td>
               <td><textarea rows="20" cols="80" name="g_content" placeholder="&lt필수&gt 내용을 입력하세요." style="width: 530px;"></textarea></td>
            </tr>
            <tr>
               <td>태그</td>
               <td><input type="text" name="g_tag" placeholder="태그를 입력하세요." style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>촬영 지역 </td>
               <td><input type="text" name="g_imglocation" placeholder="촬영 지역을 입력하세요." style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>카메라 렌즈 </td>
               <td><input type="text" name="g_imgLens" placeholder="사용 렌즈를 입력하세요." style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>카메라 기종</td>
               <td><input type="text" name="g_imgCamera" placeholder="사용 기종을 입력하세요." style="width: 530px;"/></td>
            </tr>
            <tr>
               <td>사진 해상도</td>
               <td><input type="text" name="g_imgQuality" placeholder="사진 해상도를 입력하세요." style="width: 530px;"/></td>
            </tr>
            <tr>
               <td colspan="2">
                  <p style="color: gray; font-size:14px;">※ 판매시, 수수료 10%프로가 부과되며 세부 내용은 [My page > 판매현황] 에서 확인하실 수 있습니다.</p>
               </td>
            </tr>      
            <tr>
               <td colspan="2">
                  <input type="checkbox" name="agreements" onClick="agreeCheck(this.form)"> [필수] 판매대금에 대한 수수료 10% 적용에 관한 위 내용에 동의합니다.
               </td>
            </tr>
            <tr>
               <td colspan="2" align="center">
                  <input type="button" value="뒤로가기" onclick="history.go(-1)"/>
                  <input type="reset" value="재작성"/>
                  <input type="submit"  name="checkButton" value="등록하기" disabled/>
               </td>
            </tr>
         </table>
      </form>
   </div>
   
   <script>
   
   		function checkField(){
      		let inputs = document.inputForm;
      		if(!inputs.g_subject.value){ alert("제목을 입력하세요."); return false; } 
	      	if(!inputs.u_email.value){ alert("이메일을 입력하세요."); return false; }
	      	if(!inputs.g_img.value){ alert("사진을 첨부하세요."); return false; }
	      	if(!inputs.g_price.value){ alert("가격을 입력하세요."); return false; }
	      	if(!inputs.g_content.value){ alert("내용을 입력하세요."); return false; }
		}
		function agreeCheck(frm){
			if(frm.checkButton.disabled==true){ frm.checkButton.disabled=false; }
			else{ frm.checkButton.disabled=true; }
		}
		function login_check(){ 
			var u_id = '<%=(String)session.getAttribute("userId")%>';
			if(u_id == "null") { alert("로그인 후 사용하실 수 있습니다."); } 
			else { url = "galleryUploadForm.jsp?pageNum=<%=pageNum%>"
				location.replace(url); }
		}
		function itemChange(){ 
			var animal = ["애완동물", "야생동물", "해양동물", "파충류", "공룡", "기타"];
		    var animalNum = [1, 2, 3, 4, 5, 6]; 
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
		    
		    var selectItem = $("#category1").val(); 
		    var changeItem; 
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
		    
		    $('#category2').empty();
		    
		    for(var count = 0; count < changeItem.length; count++){
		       var option = $("<option value='"+changeItemNum[count]+"'>"+changeItem[count]+"</option>"); 
		       $('#category2').append(option);            
		    } 
		 }
   </script>

</body>
</html>