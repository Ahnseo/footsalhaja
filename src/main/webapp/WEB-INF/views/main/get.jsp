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
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:navbar></my:navbar>
<div id="map" style="width:800px;height:400px;margin:30px auto;"></div>
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

<div class="container-md">
	<div class="row">
		<div class="col">

				<h1>no.${main.bookId }</h1> 
				
				작성자<input type="text" value="${main.userId }" readonly> <br>
				
				<sec:authentication property="name" var="username" />
				
				<c:if test="${main.userId == username }">
					<c:url value="/main/modify" var="modifyLink">
						<c:param name="bookId" value="${main.bookId }"></c:param>
					</c:url>
					<a href="${modifyLink }">
						<button id="modifyButton" type="button">수정하기</button>				
					</a>				
				</c:if>
				
				<div class="form-floating mb-3">

					<input id="matchInfo" type="text" class="form-control" value=" ${main.title} ${main.bookDate } ${main.bookTime} ${main.location_locationId } ${main.nickName } ${main.matchType } ${main.teamGender }" readonly>


					<label for="floatingInput">경기정보</label>
				</div>
			
				<div class="form-floating mb-3">
					<textarea class="form-control" style="resize: none; height: 100px" readonly>${main.content}</textarea>
					<label for="floatingInput">본문</label>
				</div>
        		
        		<h3>${main.ago }</h3>
		</div>
	</div>
</div>
	
<!-- 댓글 작성 -->

<hr>

<div id="replyMessage">
</div>
	
	<input type="hidden" id="bookId" value="${main.bookId }">
	<!-- 로그인 했을 떄 -->
	<sec:authorize access="isAuthenticated()"> 
	<!-- 댓글입력 -->
	<%-- 댓글컨트롤러에서 Authentication으로 아이디 받음
		작성자 
		
	<input type="hidden" id="userId" value="${main.userId }">  --%>
			
		댓글<input type="text" id="replyInput">
		<button id="replySendButton">댓글 작성</button>
	</sec:authorize>	
	
	<sec:authorize access="not isAuthenticated()">
		댓글을 작성하시려면 로그인하세요.
	</sec:authorize>
	
	<div class="row">
		<div class="col">
			<div id="replyListContainer">
			
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

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
	
	const removeButton = `<button data-bs-toggle="modal" data-bs-target="#removeReplyConfirmModal" data-reply-id="\${item.replyId}" id="\${removeReplyButtonId}">삭제</button>`
		
	const replyDiv = `
				<div>
					\${item.replyId} : \${item.replyContent} :\${item.ago}
					\${item.editable ? removeButton : '' }		
				</div>`;
			replyListContainer.insertAdjacentHTML("beforeend", replyDiv);
			
			
				//삭제 확인 버튼에 replyId 옮기기
				document.querySelector("#"+ removeReplyButtonId)
						.addEventListener("click", function(){
							document.querySelector("#removeConfirmModalSubmitButton").setAttribute("data-reply-id", this.dataset.replyId)
							// removeReply(this.dataset.replyId);
						});
				
		
			
		}
	});
}
/* 댓글 삭제 */
function removeReply(replyId){
	fetch(ctx + "/mainReply/remove/" + replyId, {
		method : "delete"
	}) 
	.then(res => res.json())
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
