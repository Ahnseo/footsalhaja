<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
}


.box {	 
	position: relative;
	 display: flex;
	 justify-content: center;
	 height: 200px;
	 padding:auto; 
	 
}

.container1 {
	border: 2px solid #5F7161;
	border-radius: 10px;
	font-color: black;
	width: 600px;
	font-size: 20px;
	border-radius: 10px;
	margin: 10px 10px;
	padding: 5px 10px;
}
#container1content{
	font-size: 18px;
	font-weight: semi-bold;
}
.container2 {
	position: relative;
	border: 2px solid #5F7161;
	border-radius: 10px;
	font-color: black;
	width: 400px;
	font-size: 20px;
	margin: 10px 10px;
	padding: 5px 10px;
}
.contentBox{
	text-align: center;
}
.content{
	border: 2px solid #5F7161;
	border-radius: 10px;
	font-color: black;
	margin: auto;
	width: 1000px;
	height: 100px;
	padding: 10px;
	text-align: justify;
	
}

#reply {
	position: relative;
	display: flex;
	border-bottom: 2px solid #999999;
	width: 1000px;
	height: 70px;
	margin: 5px 0px 5px 55px;
	padding: 2.5px 10px;
}
#modi {
	position: absolute; 
	bottom:300px; 
	left: 60px;
}


</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
</head>
<body>
<div id="area">
<my:navbar></my:navbar>

<div id="map" style="width:1000px;height:450px;margin:30px auto;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17df836d167348dc7ea95e69cb597603"></script>
	<script>
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	
	var lat = ${lat};	//위도 
	var lng = ${lng};	// 경도
	
	//alert("lat : " + lat  + "lng :" +lng);
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(lat, lng), //지도의 중심좌표.
		level: 3, //지도의 레벨(확대, 축소 정도)
		marker: marker
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
  	var markerPosition  = new kakao.maps.LatLng(lat, lng); 
  
     // 마커 생성
     var marker = new kakao.maps.Marker({
         position: markerPosition
     });
     
     marker.setMap(map);
		</script>
<%-- ---------------------------------------------------------------- --%>	
<div class="container-md" id="whole">
	<div class="row">
		<div class="col">

			<!-- <h3>no.${main.bookId }</h3>  -->
				<sec:authentication property="name" var="username" />
				
				<div class="box">
					<div class="container1">
					<h2><i class="fa-solid fa-futbol"></i> 매치 포인트 </h2>
						
					<div id="container1content">
							<div id="level">
							<i class="fa-solid fa-ranking-star"></i>
								<c:choose>
								<c:when test="${main.level == '1' }">
									비기너
								</c:when>
								<c:when test="${main.level == '2' }">
									아마추어
								</c:when>
								<c:when test="${main.level == '3' }">
									챌린저
								</c:when>
								</c:choose>
							</div>
						
						<div id="matchType">
						<i class="fa-solid fa-flag-checkered"></i>
							<c:choose>
								<c:when test="${main.matchType == '3' }">
									3 vs 3
								</c:when>
								<c:when test="${main.matchType == '4' }">
									4 vs 4
								</c:when>
								<c:when test="${main.matchType == '5' }">
									5 vs 5
								</c:when>
								</c:choose>
						</div>
						<div id="teamGender">
						<i class="fa-solid fa-venus-mars"></i>
							<c:choose>
								<c:when test="${main.teamGender == 'F' }">
									여자만
								</c:when>
								<c:when test="${main.teamGender == 'M' }">
									남자만
								</c:when>
								</c:choose>
						</div>
						
						<div id="shoes">
						<i class="fa-solid fa-shoe-prints"></i>
						<c:choose>
						<c:when test="${main.locationId == '1' }">
							풋살화,운동화
						</c:when>
						<c:when test="${main.locationId == '2' }">
							실내풋살화
						</c:when>
						<c:when test="${main.locationId == '3' }">
							풋살화
						</c:when>
						<c:when test="${main.locationId == '4' }">
							풋살화,운동화
						</c:when>
						<c:when test="${main.locationId == '5' }">
							풋살화
						</c:when>
						<c:when test="${main.locationId == '6' }">
							실내풋살화, 운동화
						</c:when>
						<c:when test="${main.locationId == '7' }">
							실내풋살화
						</c:when>
						<c:when test="${main.locationId == '8' }">
							풋살화, 운동화
						</c:when>
						<c:when test="${main.locationId == '9' }">
							풋살화
						</c:when>
						<c:when test="${main.locationId == '10' }">
							풋살화
						</c:when>
						</c:choose>
						</div>
					</div>
					</div>
					
					<input type="hidden" id="bookDate1" value="${main.bookDate }">
					
					<div class="container2">
						<div id="bookDate" style="font-weight: bold;">
						${main.bookDate } 
						</div>
						<div id="day" style="position: absolute; bottom: 141px; left: 120px; font-weight: bold;">
						<script type="text/javascript">
						document.write(getDateStr(bookDate1));
						</script>
						</div>
						
						<div id="bookTime" style="font-weight: bold;">
						<c:choose>
						<c:when test="${main.bookTime == '1' }">
							6:00 ~ 8:00
						</c:when>
						<c:when test="${main.bookTime == '2' }">
							9:00 ~ 11:00	
						</c:when>
						<c:when test="${main.bookTime == '3' }">
							14:00 ~ 16:00	
						</c:when>
						<c:when test="${main.bookTime == '4' }">
							18:00 ~ 20:00	
						</c:when>
						<c:when test="${main.bookTime == '5' }">
							21:00 ~ 23:00	
						</c:when>
						</c:choose>	
						</div>
						
						<div style="font-weight: bold;">
						<c:choose>
						<c:when test="${main.locationId == '1' }">
							천마 풋살파크
						</c:when>
						<c:when test="${main.locationId == '2' }">
							아디다스 더베이스
						</c:when>
						<c:when test="${main.locationId == '3' }">
							도봉 루다 풋살장
						</c:when>
						<c:when test="${main.locationId == '4' }">
							영등포 SKY 풋살파크 A구장
						</c:when>
						<c:when test="${main.locationId == '5' }">
							은평 롯데몰 A구장
						</c:when>
						<c:when test="${main.locationId == '6' }">
							피치 부천 이마트 부천점
						</c:when>
						<c:when test="${main.locationId == '7' }">
							용인 기흥 낫소 풋살파크
						</c:when>
						<c:when test="${main.locationId == '8' }">
							칼라힐 풋살파크 B구장
						</c:when>
						<c:when test="${main.locationId == '9' }">
							인천 더 베스트 풋볼파크 구월점
						</c:when>
						<c:when test="${main.locationId == '10' }">
							하남 감일 장수천 풋살파크
						</c:when>
						</c:choose>
						</div>
						
						
						<div style="font-size:13px; text-decoration: underline;">상세주소</div>						
						<div style="font-size:15px;">
						<c:choose>
						<c:when test="${main.locationId == '1' }">
							송파구 성내천로29길 28
						</c:when>
						<c:when test="${main.locationId == '2' }">
							용산구 한강대로23길 55 현대아이파크몰 리빙파크 9층
						</c:when>
						<c:when test="${main.locationId == '3' }">
							도봉구 방학로 223
						</c:when>
						<c:when test="${main.locationId == '4' }">
							영등포구 선유로43길 19
						</c:when>
						<c:when test="${main.locationId == '5' }">
							은평구 통일로 1050
						</c:when>
						<c:when test="${main.locationId == '6' }">
							부천시 석천로 188
						</c:when>
						<c:when test="${main.locationId == '7' }">
							용인시 기흥구 신고매로 59 리빙파워센터 RF층
						</c:when>
						<c:when test="${main.locationId == '8' }">
							안양시 동안구 시민대로 312
						</c:when>
						<c:when test="${main.locationId == '9' }">
							인천시 남동구 인하로 485
						</c:when>
						<c:when test="${main.locationId == '10' }">
							하남시 서하남로12번길 28-20
						</c:when>
						</c:choose>
						</div>
					
						
						<div id="nickName" style="font-size: 15px;">
						작성자: ${main.nickName }
						</div>
					</div>								
				</div>
					
					<div class="contentBox">
						<div class="content">
							${main.content }
						</div>									
					</div>
				
	        		<div style="font-size:12px; position:absolute; bottom: -20px; right: 100px;">
	        		${main.ago }
	        		</div>
							

				
				<div id="modi">
					<c:if test="${main.userId == username }">
						<c:url value="/main/modify" var="modifyLink">
							<c:param name="bookId" value="${main.bookId }"></c:param>
						</c:url>
						<a href="${modifyLink }">
							<button id="modifyButton" type="button" style="background-color: #6D8B74; border-radius:5px; border-color:#6D8B74; color:white;">수정하기</button>				
						</a>				
					</c:if>
				</div>
		</div>
	</div>
</div>
	
<!-- 댓글 작성 -->

<hr>
	
	<input type="hidden" id="bookId" value="${main.bookId }">
	<!-- 로그인 했을 떄 -->
	<sec:authorize access="isAuthenticated()"> 
	<!-- 댓글입력 -->
	<%-- 댓글컨트롤러에서 Authentication으로 아이디 받음
		작성자 
		
	<input type="hidden" id="userId" value="${main.userId }">  --%>
			
		
	<div class="container-md" style="padding: 20px 70px;">
		<div class="input-group mb-3" style=" width:1000px;">
			 <input type="text" id="replyInput" class="form-control" placeholder="댓글쓰기" aria-describedby="replySendButton">
			 <button class="btn btn-outline-secondary" type="button" id="replySendButton">작성</button>
		</div>
	</div>

	</sec:authorize>	
	
	<sec:authorize access="not isAuthenticated()">
	<div class="container-md" style="padding: 20px 70px;">
		<div class="input-group mb-3" style=" width:1000px;">
		    <input type="text" id="replyInputBlocked" class="form-control" placeholder="댓글을 작성하시려면 로그인하세요." readonly>
		</div>
	</div>
	
	</sec:authorize>
	
	<div class="container-md">
	
	<div class="row">
		<div class="col">
			<div id="replyListContainer">
			
			</div>
		</div>
	</div>
	
	</div>

<%-- 댓글 삭제 확인 모달 --%>
	<!-- Modal -->
	<div class="modal fade" id="removeReplyConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">댓글 삭제 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        댓글을 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" data-bs-dismiss="modal" id="removeConfirmModalSubmitButton" class="btn btn-danger">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

function getDateStr(){
	  const bookDate1 = document.querySelector("#bookDate1").value;
	  var yyyyMMdd = String(bookDate1);
	  var sYear = yyyyMMdd.substring(0,4);
	  var sMonth = yyyyMMdd.substring(5,7);
	  var sDate = yyyyMMdd.substring(8,10);
	  var date = new Date(Number(sYear), Number(sMonth)-1, Number(sDate));
		
	  var week = ['일', '월', '화', '수', '목', '금', '토'];
	  return  '(' + week[date.getDay()] + ')';
	}

	var result = getDateStr(bookDate1);
	getDateStr(bookDate1);
	
	document.getElementById("day").innerHTML+= result
	
listReply();

document.querySelector("#removeConfirmModalSubmitButton").addEventListener("click", function() {
	removeReply(this.dataset.replyId);
});
/* 댓글 리스트*/
function listReply(){
	const bookId = document.querySelector("#bookId").value;
	
	fetch(`\${ctx}/mainReply/list/\${bookId}`)
	.then(res => res.json())
	.then(list => {
		const replyListContainer = document.querySelector("#replyListContainer");
		replyListContainer.innerHTML = "";
		
	for(const item of list){
	
	const removeReplyButtonId = `removeReplyButton\${item.replyId}`;
	
	const removeButton = `<button data-bs-toggle="modal" data-bs-target="#removeReplyConfirmModal" data-reply-id="\${item.replyId}" id="\${removeReplyButtonId}" style="background-color: white; border-color:white; font-size: 5px;">삭제</button>`
		
	const replyDiv = `
	
	
				<div id="reply">  
					<div  style="font-size: 15px; font-weight: bold;">
					\${item.nickName} 
					</div>
					<div style="font-size: 13px; padding: 2.5px 0 0 10px;">
					\${item.ago}
					</div>				
					<div style="position: absolute; bottom:3px; "">
					\${item.replyContent} 
					</div>
					<div style="position: absolute; bottom:1px; right: 0px;">
					\${item.editable ? removeButton : '' }		
					</div>
				</div>`;
			replyListContainer.insertAdjacentHTML("beforeend", replyDiv);
			
				if(item.editable){
					//삭제 확인 버튼에 replyId 옮기기
					document.querySelector("#"+ removeReplyButtonId).addEventListener("click", function(){
								document.querySelector("#removeConfirmModalSubmitButton").setAttribute("data-reply-id", this.dataset.replyId)
								// removeReply(this.dataset.replyId);
							});
					
				}
				
		
			
		}
	});
}
/* 댓글 삭제 */
function removeReply(replyId){
	fetch(ctx + "/mainReply/remove/" + replyId, {
		method : "delete"
	})
	//받은 게 없어서 코드 지우기
	//.then(res => res.json())
	.then(() => listReply());
} 


/*댓글 입력*/
document.querySelector("#replySendButton").addEventListener("click", function(){
	const book_bookId = document.querySelector("#bookId").value;
	const replyContent = document.querySelector("#replyInput").value;
	//const userId = document.querySelector("#userId").value;
	
	const data = {
			book_bookId,
			replyContent
			//userId
	}
	
	fetch(`\${ctx}/mainReply/add`, {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res=>res.json())
	.then(data => {
		document.querySelector("#replyInput").value = "";
		
	})
	.then(() => listReply());
});


</script>
</body>
</html>
