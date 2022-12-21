<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');


* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

ul {
   list-style:none;
  }

.container-sm { 
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
	font-size: 16px;
}

.post_wrap {
	border: 1px solid #ced4da;
	border-radius: 10px;
	margin-bottom: 10px;
}

/* 상단 버튼부분 */
.topbtnBox {
	margin: 30px 0 15px 0;
	position: relative;
}
.topbtnBox .modifyBtn {
	position: absolute;
	top: 0;
	right: 0;
}
.topbtnBox .removeBtn {
	position: absolute;
	top: 0;
	right: 60px;
}

/* 상단 제목부분 */
.post_top {
}
.post_top .top_category {
	border: 1px solid #ddd;
 	vertical-align: middle;
 	display: inline-block;
 	margin: 20px 20px 0;
 	padding: 0 4px;
 	
 	color: #666;
 	font-size: 14px;
 	font-weight: normal;
}
.post_top .top_title {
	font-size: 20px;
	font-weight: bold;
	margin: 10px 20px;
}
.post_top ul {
	text-align: left;
	padding-left:0;
}
.post_top ul li {
	display: inline-block;
	margin-left: 20px;
	font-size: 13px;
}

.post_wrap .top_content {
	margin: 40px 20px;
}

.post_wrap .likeBox {
	text-align: center;
}
.post_wrap .likeBox i {
	color: #1cb99e;
}

.likeBox .likeIcon {
	font-size: 26px;
	color: green;
}
.likeBox .likeCount1 {
	font-size: 14px;
	margin-top: -20px;
	color: #333;
}
.likeBox .likeCount2 {
	font-size: 14px;
	margin-top: -15px;
	font-weight: bold;
	color: #333;
}

/* 댓글 */
.replyBox  {
	border: 1px solid #ced4da;
	border-radius: 10px;
	margin-bottom: 30px;
	height: 130px;
	position: relative;
}

.replyBox .row {
	padding-left: 30px;	
}

.replyBox .replyContentInput {
	border: 0;
	height: 80px;
	margin-top: 10px;
	padding-left: 20px;
}
.replyBox .replyBnt {
	position: absolute;
	bottom: 0;
	right: 0;
}

.notLogin {
	text-align: center;
	margin-top: 55px;
}

/* 댓글 리스트 */
.reply_list {
	margin-bottom: 10px; 
	padding: 0 20px;
}
.reply_list span {
	height: 1px;
	background: #ced4da;
	margin-bottom: 20px; 
}

.reply_list .replylist_top {
	text-align: left;
	position: relative;
}

.reply_list .replylist_top p {
	display: inline-block;
	font-size: 14px;
}
.reply_list .replylist_top .ago {
	display: inline-block;
	font-size: 12px;
	color: #666;
	margin-left: 10px;
}

.reply_list .replylist_top .btn {
	position: absolute;
	top: 0;
	right: 0;
}
.reply_list .replylist_top .b1 {
	position: absolute;
	top: 0;
	right: 45px;
}

/* 파일 */
.fileBox {
	margin-top: 100px;
	margin-left: 40px;
}

.fileBox a {
	color: #666;
}

.post_top .imgBox {
	vertical-align: middle;
}

.post_top .imgBox object {
	width: 30px;
	height: 30px;
	border-radius: 50%;
}
.post_top .imgBox img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
}



</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

<body>

<my:navbar></my:navbar>
<input type="hidden" value="${board.fb_number }" />
<input type="hidden" value="${board.member_userId }"  />
<input type="hidden" id="freeBoard_fb_number" value="${board.fb_number }" readonly/>

<!-- 전체 컨테이너 -->
<div class="container-sm" >

	<!-- 게시글로 돌아가기 버튼 -->
	<div class="topbtnBox">
		<c:url value="/free/list" var="listLink"></c:url>
		<a href="${listLink }">
			<button type="button" class="btn btn-outline-success">게시글 목록</button>
		</a>
		
		<!-- 작성자와 authentication.name이 같아야 버튼 보여주기 -->
		<sec:authentication property="name" var="userIdValue" />
		<c:if test="${board.member_userId == userIdValue}" >
		<!-- 삭제버튼 -->
			<c:url value="/free/remove" var="removeLink"></c:url>
			<form id="removeForm" action="${removeLink }" method="post">
				<input type="hidden" name="number" value="${board.fb_number }"/>
			</form>
			<input class="btn btn-outline-success removeBtn" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal"/>
			<!-- 수정버튼 -->
			<c:url value="/free/modify" var="modifyLink">
				<c:param name="number" value="${board.fb_number }"></c:param>
			</c:url>
			<a class="btn btn-outline-success modifyBtn" href="${modifyLink }">수정</a>
		</c:if>
	</div>
	
	<!-- 본문 -->
	<div class="post_wrap">
		<div class="post_top">
			<p class="top_category">${board.fb_category }</p>
			<p class="top_title">${board.fb_title }</p>
			<ul>
				<li class="imgBox"> 
					<c:if test="${board.profileImg eq null}">
						<img class= "defaultImg" src="${pageContext.request.contextPath}/기본프로필.png">
					</c:if>
					<c:forEach items="${board.profileImg }" var="name">
						<div class= "containerProfile">	
							<%-- <object data="${imgUrl }/user_profile/${member.userId }/${name}" type="image/png"> --%>
							<object data="${imgUrl }/user_profile/${board.member_userId }/${name}" type="image/png">
								<img src="${pageContext.request.contextPath}/기본프로필.png">
							</object>
						</div>
					</c:forEach>	
				</li>
				<li class="top_nickName">${board.nickName }</li>
				<li class="top_insertDatetime">${board.ago }</li>
				<li class="top_likeCount">좋아요 ${board.fb_likeCount }</li>
				<li class="top_insertDatetime">조회 ${board.fb_viewCount }</li>
			</ul>
		</div>
		<div id="summernote" class="top_content">${board.fb_content }</div>
		
	<!-- 파일 -->
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<div class="fileBox">
		<c:forEach items="${board.fb_fileName }" var="fileName">
			<div class="fileText">
				<i class="fa-solid fa-paperclip"></i>
				<a href="${ctx }/free/download/${board.fb_number}/${fileName}">
				<c:out value="${fileName.substring(36)}" /></a>
			</div>
		</c:forEach>
	</div>
		
		<!-- 좋아요 -->
		<div class="likeBox">
			<p 
				<sec:authorize access="not isAuthenticated()">
					style="pointer-events: none;"
				</sec:authorize>		
			id="likeButton" class="likeIcon">
								
				<c:if test="${board.liked }">
					<i class="fa-solid fa-heart"></i>
				</c:if>
				<c:if test="${not board.liked }">
				<i class="fa-regular fa-heart"></i>
				</c:if>					
			</p>
			<p class="likeCount1">좋아요</p>
			<p id="likeCount" class="likeCount2">${board.fb_likeCount }</p>
		</div>
		
	</div><!-- 본문끝 -->
	
			
	<!-- 댓글입력 알림 -->
	<!-- <div id="replyMessage1"></div> -->
	
	
	
	<!-- 댓글 부분 -->
	<div class="replyBox container">
			<!-- 로그인 했을때-->
			<sec:authorize access="isAuthenticated()">
			<!-- 댓글입력  -->
			<%-- 댓글컨트롤러에서 Authentication으로 아이디 받음
			작성자 <input
					value="${userIdValue }" id="member_userId"
			 		readonly type="text" name="member_userId"/><br> --%>
			 	<div class="row">
				<input class="row replyContentInput" type="text" id="fb_replyContent"
					placeholder="댓글을 입력해주세요."/><br>
			 	</div>
						
				<button id="replyButton1" class="replyBnt btn btn-success" >댓글 등록</button>
			</sec:authorize>
			
			<!-- 로그인 안했을때 -->
			<div class="notLogin">
				<sec:authorize access="not isAuthenticated()">
					댓글을 작성하시려면 로그인하세요.
				</sec:authorize>
			</div>
		</div>
	
	<!-- 댓글 리스트 -->
		<div class="row">
			<div class="col">
				<div id="replyListContainer">
					<!-- 댓글 나오는 부분 -->
				</div>
			</div>
		</div>
		
</div> <!-- 전체 컨테이너 -->
	
	<!-- 게시글 삭제 모달 -->
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
	        <button id="removeConfirmButton" type="button" class="btn btn-primary">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 댓글 삭제 확인 모달 -->
	<div class="modal fade" id="replyDeleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
	        <button type="button" id="replyDeleteConfirmButton" class="btn btn-primary" data-bs-dismiss="modal">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 댓글 수정 모달 -->
	<div class="modal fade" id="replyModifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">댓글 수정 양식</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <input type="text" id="modifyReplyInput"/>	
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" id="replyModifyConfirmButton" class="btn btn-primary" data-bs-dismiss="modal">수정</button>
	      </div>
	    </div>
	  </div>
	</div>

<my:footer></my:footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

//삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});

/* 좋아요 */
document.querySelector("#likeButton").addEventListener("click", function() {
	const freeBoard_fb_number = document.querySelector("#freeBoard_fb_number").value; 
	
	fetch(`\${ctx}/free/like`, {
		method : "put",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify({fb_number:freeBoard_fb_number})
	})
	.then(res => res.json())
	.then(data => {
		if (data.current == 'liked') {
			document.querySelector("#likeButton").innerHTML = `<i class="fa-solid fa-heart"></i>`
		} else {
			document.querySelector("#likeButton").innerHTML = `<i class="fa-regular fa-heart"></i>`
		}
		
		document.querySelector("#likeCount").innerText = data.count;
	});
});



// 댓글리스트
listReply();

/* 댓글수정 모달에 수정확인버튼 */
document.querySelector("#replyModifyConfirmButton").addEventListener("click", function() {
	
	const fb_replyNumber = this.dataset.replyId;
	const fb_replyContent = document.querySelector("#modifyReplyInput").value;
	const data = {fb_replyNumber, fb_replyContent}
	
	fetch(`\${ctx}/freeReply/modify`, {
		method : "put",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(() => listReply());
});

/* 댓글삭제 확인버튼 */
document.querySelector("#replyDeleteConfirmButton").addEventListener("click", function() {
	removeReply(this.dataset.replyId);
});

/* 수정모달에 댓글내용 가져오기 */
function readReplyAndSetModalForm(fb_replyNumber) {
	fetch(`\${ctx}/freeReply/get/\${fb_replyNumber}`)
	.then(res => res.json())
	.then(reply => {
		document.querySelector("#modifyReplyInput").value = reply.fb_replyContent;
	})
}



/* 댓글 리스트 */
function listReply() {
	const freeBoard_fb_number = document.querySelector("#freeBoard_fb_number").value;
	
	fetch(`\${ctx}/freeReply/list/\${freeBoard_fb_number}`)
	.then(res => res.json())
	.then(list => {
		// 댓글 목록 다 지우고
		const replyListContainer = document.querySelector("#replyListContainer");
		replyListContainer.innerHTML = "";
		
		// 다시 댓글목록 가져오기
		// item = replyDto
		for (const item of list) {
			
			const modifyReplyButtonId = `modifyReplyButton\${item.fb_replyNumber}`;
			const removeReplyButtonId = `removeReplyButton\${item.fb_replyNumber}`;
			const rereplyButtonId = `rereplyButton\${item.fb_replyNumber}`;
			
			/* 수정 삭제버튼 */
			const editButton = `<button class="btn btn-outline-success btn-sm b1" data-bs-toggle="modal" data-bs-target="#replyModifyModal" data-reply-id="\${item.fb_replyNumber}" id="\${modifyReplyButtonId}"> 수정</button>
								<button class="btn btn-outline-success btn-sm" data-bs-toggle="modal" data-bs-target="#replyDeleteModal" data-reply-id="\${item.fb_replyNumber}" id="\${removeReplyButtonId}"> 삭제</button>`
			/* <button data-reply-id="\${item.fb_replyNumber}" id="\${rereplyButtonId}"> 대댓글</button>
			<div id="rereplyForm">
					<input id="rereplyContent" name="rereplyContent" type="text">
					<button id="rereButton">대댓글입력</button>
				</div>`*/
								
			const replyDiv = 
				`<div class="reply_list">
					<span class="row"></span>
					<div class="replylist_top">
						<p> \${item.nickName}</p>
						<p class="ago"> \${item.ago}</p>
						\${item.editable ? editButton : ''}
					</div>
					<p> \${item.fb_replyContent}</p>
				</div>`;
				
			replyListContainer.insertAdjacentHTML("beforeend", replyDiv);
			
			if(item.editable){
				// 수정 모달에 댓글 내용 넣기
				document.querySelector("#" + modifyReplyButtonId).addEventListener("click", function() {
					document.querySelector("#replyModifyConfirmButton").setAttribute("data-reply-id", this.dataset.replyId)
					readReplyAndSetModalForm(this.dataset.replyId);
				});
				
				// 모달 삭제확인 버튼에 replyId 옮기기
				document.querySelector("#" + removeReplyButtonId).addEventListener("click", function() {
					// console.log(item.fb_replyNumber + "번 삭제버튼 클릭됨");
					// console.log(this.dataset.replyId + "번 댓글 삭제예정");
					document.querySelector("#replyDeleteConfirmButton").setAttribute("data-reply-id", this.dataset.replyId)
					// removeReply(this.dataset.replyId);
				});
			}
		}
	});
}


/* 댓글 삭제 */
function removeReply(replyId) {
	fetch(ctx + "/freeReply/delete/" + replyId, {
		method : "delete"
	})
	.then(res => res.json())
	.then(() => listReply());
}



/* 대댓글입력 */
/* document.querySelector("#rereButton").addEventListener("click", function() {
	const freeBoard_fb_number = document.querySelector("#freeBoard_fb_number").value; 
	const rereplyContent = document.querySelector("#rereplyContent").value;
	
	const data = {
		freeBoard_fb_number,
		rereplyContent,
		
	}
	
	fetch(`\${ctx}/freeReply/rereAdd`, {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => {
		document.querySelector("#rereplyContent").value = "";
	})
	.then(() => listReply());
});
 */

/* 댓글 입력 */
document.querySelector("#replyButton1").addEventListener("click", function() {
	const freeBoard_fb_number = document.querySelector("#freeBoard_fb_number").value; 
	const fb_replyContent = document.querySelector("#fb_replyContent").value;
	/* const member_userId = document.querySelector("#member_userId").value; */
	
	const data = {
		freeBoard_fb_number,
		fb_replyContent
		/* member_userId */
	}
	
	fetch(`\${ctx}/freeReply/add`, {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => {
		document.querySelector("#fb_replyContent").value = "";
	})
	.then(() => listReply());
});

</script>
</body>
</html>










