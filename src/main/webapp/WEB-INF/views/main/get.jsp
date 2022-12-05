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
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:navbar></my:navbar>
<div id="map" style="width:800px;height:400px;margin:30px auto;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17df836d167348dc7ea95e69cb597603"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		// 마커가 표시될 위치
        var markerPosition  = new kakao.maps.LatLng(36.300442, 127.574917); 
 
        // 마커 생성
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
 
        // 마커가 지도 위에 표시되도록 설정
        marker.setMap(map);
 
        // 아래 코드는 지도 위의 마커를 제거하는 코드
        // marker.setMap(null);  
		</script>
<%-- ---------------------------------------------------------------- --%>	

<div class="container-md">
	<div class="row">
		<div class="col">

				<h1>no.${main.bookId }</h1> 
				
				<c:url value="/main/modify" var="modifyLink">
					<c:param name="bookId" value="${main.bookId }"></c:param>
				</c:url>
				<a href="${modifyLink }">
					<button id="modifyButton" type="button">수정하기</button>				
				</a>
				
				<div class="form-floating mb-3">
					<input id="matchInfo" type="text" class="form-control" value=" ${main.stadiumTitle} ${main.bookDate } ${main.bookTime} ${main.nickName } ${main.matchType } ${main.teamGender }" readonly>
					<label for="floatingInput">경기정보</label>
				</div>
			
				<div class="form-floating mb-3">
					<textarea class="form-control" style="resize: none; height: 100px" readonly>${main.content}</textarea>
					<label for="floatingInput">본문</label>
				</div>
        
		</div>
	</div>
</div>
	
<!-- 댓글 작성 -->

<hr>
<div id="replyMessage">
</div>

<div class="container-md">
	<div class="row">
		<div class="col">
			<input type="hidden" id="bookId" value="${main.bookId }">
			<input type="text" id="replyInput">
			<button type='button' id="replySendButton">댓글 작성</button>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div id="replyListContainer">
			
			</div>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

listReply();

function listReply(){
	const bookId = document.querySelector("#bookId").value;
	fetch(`\${ctx}/reply/list/\${bookId}`)
	.then(res => res.json())
	.then(list => {
		for(const item of list){
			const replyDiv = `<div>\${item.content} : \${item.inserted}</div>`;
			document.querySelector("#replyListContainer").insertAdjacentHTML("beforeend", replyDiv);
		}
	});
}

document.querySelector("#replySendButton").addEventListener("click", function(){
	const bookId = document.querySelector("#bookId").value;
	const replyContent = document.querySelector("#replyInput").value;
	
	const data = {
			bookId,
			replyContent
	};
	
	fetch(`\${ctx}/reply/add`, {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res=>res.json())
	.then(data => {
		document.querySelector("#replyMessage").innerText = data.message;
	});
});


</script>
</body>
</html>















































