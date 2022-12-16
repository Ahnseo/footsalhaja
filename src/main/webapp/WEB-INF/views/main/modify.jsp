<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 400;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 700;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.ttf') format('truetype')
}

@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 300;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.ttf') format('truetype');
}

.nanumbarungothic * {
 font-family: 'NanumBarunGothic', sans-serif;
}
#area{
	font-family: 'NanumBarunGothic';
	letter-spacing: -1px;
	position: relative;
	
}
#modi{
	position: absolute; 
	bottom: 0px; 
	left: 1350px;
}

#modiCancel{
	position: absolute; 
	bottom: 0px; 
	left: 1300px;
	backgroung-color: gray;
	width: 
}
#wide{
	max-width: 928px;
	margin: 5px 0 0 500px;
}

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
</head>
<body>

<div id="area">
<my:navbar></my:navbar>

<div id="wide">

<div class="container-md">
	<div class="row">
		<div class="col">
		
			<div style="text-align: center; font-size:30px;">${main.nickName }님 예약 변경</div>
			<input type="hidden" value="${main.member_userId }" readonly>
	
			<form id="modifyForm" action="" method="post" > 
				<input type="hidden" name="bookId" value="${main.bookId }">
				
				<div class="form-floating mb-3" >
					<input type="Date" class="form-control" name="bookDate" value="${main.bookDate }" >
					<label for="floatingInput">매칭 일정</label>
				</div>

				<div class="row g-2" >
 				 <div class="col-md">
					<div class="form-floating">
						<select class="form-select" id="region" name="region">
							<option selected value="1">서울</option>
							<option value="2">매칭</option>
						</select> 
						<label for="region">활동 지역</label>
					</div>
				</div>
					<div class="col-md">
						<div class="form-floating">
							<select class="form-select"  name="locationId" id="locationId">
								<option value="1">천마 풋살파크</option>
			     				<option value="2">아디다스 더베이스</option>
			      				<option value="3">도봉 루다 풋살장</option>
			    				<option value="4">영등포 SKY 풋살파크 A구장</option>
			      				<option value="5">은평 롯데몰 A구장</option>
							</select> 
							<label for="locationId">예약 장소</label>
							</div>
						</div>
					</div>
 				
 				<div class="form-floating" style="margin: 18px 0;">
				  <select class="form-select" id="floatingSelect" name="bookTime" >
				    <option selected value="${main.bookTime }">
				    기존 예약 시간 : 
				 	 <c:choose>
				 	 <c:when test="${main.bookTime == 1 }">
				 	 	<c:out value="06:00 ~ 8:00"/>
				 	 </c:when>
				 	 <c:when test="${main.bookTime == 2 }">
				 	 	<c:out value="09:00 ~ 11:00"/>
				 	 </c:when>
				 	 <c:when test="${main.bookTime == 3 }">
				 	 	<c:out value="14:00 ~ 16:00"/>
				 	 </c:when>
				 	 <c:when test="${main.bookTime == 4 }">
				 	 	<c:out value="18:00 ~ 20:00"/>
				 	 </c:when>
				 	 <c:when test="${main.bookTime == 5 }">
				 	 	<c:out value="21:00 ~ 23:00"/>
				 	 </c:when>
				 	 </c:choose> 
				    </option>
				     <option value="1">06:00 ~ 8:00</option>
					  <option value="2">09:00 ~ 11:00</option>
					  <option value="3">14:00 ~ 16:00</option>
					  <option value="4">18:00 ~ 20:00</option>
					  <option value="5">21:00 ~ 23:00</option>
				  </select>
				  <label for="floatingSelect">구장이용시간</label>
				</div>		
				
				<div class="row g-2"  style="margin: 18 0;" >
 				 <div class="col-md">
				<div class="form-floating" >
				  <select class="form-select" id="floatingSelect" name="level" >
				    <option selected value="${main.level }">
				    기존 선택 레벨 : 
				 	 <c:choose>
				 	 <c:when test="${main.level == 1 }">
				 	 	비기너
				 	 </c:when>
				 	 <c:when test="${main.level == 2 }">
				 	 	아마추어
				 	 </c:when>
				 	 <c:when test="${main.level == 3 }">
				 	 	챌린저
				 	 </c:when>
				 	 </c:choose> 
				    </option>
				     <option value="3">비기너</option>
					  <option value="2">아마추어</option>
					  <option value="1">챌린저</option>
				  </select>
				  <label for="floatingSelect">모집 레벨</label>
				</div>
				</div>
					
				
				<div class="col-md">
				<div class="form-floating" >
				  <select class="form-select" id="floatingSelect" name="matchType" >
				    <option selected value="${main.matchType }">
				    기존 선택 인원: 
				 	 <c:choose>
				 	 <c:when test="${main.matchType == 3 }">
				 	 	3 vs 3
				 	 </c:when>
				 	 <c:when test="${main.matchType == 4 }">
				 	 	4 vs 4
				 	 </c:when>
				 	 <c:when test="${main.matchType == 5 }">
				 	 	5 vs 5
				 	 </c:when>
				 	 </c:choose> 
				    </option>
				     <option value="3">3 vs 3</option>
					  <option value="4">4 vs 4</option>
					  <option value="5">5 vs 5</option>
				  </select>
				  <label for="floatingSelect">매칭 인원</label>
				</div>
			</div>
			<div class="col-md">
				<div class="form-floating" >
				  <select class="form-select" id="floatingSelect" name="teamGender" >
				    <option selected value="${main.teamGender }">
				 	 기존 선택 성별:
				 	 <c:choose>
				 	 <c:when test="${main.teamGender == 'F' }">
				 	 	여자만
				 	 </c:when>
				 	 <c:when test="${main.teamGender == 'M' }">
				 	 	남자만
				 	 </c:when>
				 	 </c:choose> 
				    </option>
				     <option value="F">여자만</option>
					  <option value="M">남자만</option>
				  </select>
				  <label for="floatingSelect">매칭 성별</label>
				</div>
			</div>
			</div>
			
			
			<div class="form-floating"  style="margin: 18px 0;">
				  <select class="form-select" id="floatingSelect" name="status" >
				     <option value="0">모집완료</option>
					  <option value="1">모집중</option>
				  </select>
				  <label for="floatingSelect">모집상태</label>
				</div>
				
				<div class="form-floating mb-3">
					<input type="text" class="form-control" name="title" value=" ${main.title }">		
					<label for="floatingInput">제목</label>
				</div>
				
				<div class="form-floating mb-3">
					<textarea class="form-control" name="content" style="resize: none; height: 150px;" >${main.content}</textarea>
					<label for="floatingTextarea2">본문</label>
				</div>
			</form>
			
</div>		
			
			<div id="modi">
			<input type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal" style="background-color: #6D8B74; border-radius:5px; border-color:#6D8B74; color:white; width: 60px; height: 30px;">
			</div>
			<c:url value="/main/remove" var="removeLink"/>
			<form id="removeForm" action="${removeLink }" method="post">
			<input type="hidden" name="bookId" value="${main.bookId }">
			</form>
			<input type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal" style="background-color: #FFFFFF; border-color:#FFFFFF; color:black; width: 60px; height: 30px; text-decoration: underline;">
			
			<button class="btn btn-secondary" id="modiCancel"  style="width: 60px; height: 30px;">
				<a href="/main/list"style="color: white;">취소</a>
			</button>
					
				
			</div>
		</div>
	</div>


<!-- modify Modal -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        수정하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="modifyConfirmButton" type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- remove Modal -->
	<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="removeConfirmButton" type="button" class="btn btn-danger">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<my:footer></my:footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   $(document).ready(function() {
         $('#region').change(function() {
            var res = $('#region option:selected').val();
            var option = '';
            console.log(res);
            if (res == '1') {
               console.log("1");
               option += '<option value="1">천마 풋살파크</option>';
               option += '<option value="2">아디다스 더베이스</option>';
               option += '<option value="3">도봉 루다 풋살장</option>';
               option += '<option value="4">영등포 SKY 풋살파크 A구장</option>';
               option += '<option value="5">은평 롯데몰 A구장</option>';
            
            } else {
               console.log("2");
               option += '<option value="6">피치 부천 이마트 부천점</option>';
               option += '<option value="7">용인 기흥 낫소 풋살파크</option>';
               option += '<option value="8">칼라힐 풋살파크 B구장</option>';
               option += '<option value="9">인천 더 베스트 풋볼파크 구월점</option>';
               option += '<option value="10">하남 감일 장수천 풋살파크</option>';
            }
            $('#locationId').empty().append(option);
         });
      });


//수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

// 삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});
</script>
</body>
</html>