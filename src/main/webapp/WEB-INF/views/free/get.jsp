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
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<body>

<my:navbar></my:navbar>

	

	<h1>프리보드 ${board.fb_number }번 게시물</h1>
	
	<!-- 좋아요 -->
	<h1>
		<span 
			<sec:authorize access="not isAuthenticated()">
				style="pointer-events: none;"
			</sec:authorize>		
		id="likeButton" >
							
			<c:if test="${board.liked }">
				<i class="fa-solid fa-thumbs-up"></i>
			</c:if>
			<c:if test="${not board.liked }">
			<i class="fa-regular fa-thumbs-up"></i>
			</c:if>					
		</span>
		
		<span id="likeCount">${board.fb_likeCount }</span>
	</h1>
	
	<p>조회수 ${board.fb_viewCount }</p> 
	제목 <input type="text" value="${board.fb_title }" readonly /><br>
	카테고리 <input type="text" value="${board.fb_category }" readonly /><br>
	
	본문 <div id="summernote" readonly>${board.fb_content }</div> <br>
	
	작성일시 <input type="datetime-local" value="${board.fb_insertDatetime }" readonly /><br>
	작성자 <input type="text" value="${board.member_userId }" readonly /><br>
	닉네임 <input type="text" value="${board.nickName }" readonly /><br>
	
	
	<!-- 작성자와 authentication.name이 같아야 수정버튼 보여주기 -->
	<sec:authentication property="name" var="userIdValue" />
	
	<c:if test="${board.member_userId == userIdValue}" >
		<c:url value="/free/modify" var="modifyLink">
			<c:param name="number" value="${board.fb_number }"></c:param>
		</c:url>
		<a class="btn btn-warning" href="${modifyLink }">수정</a>
	</c:if>
	
	
	<hr />
	
	<!-- 댓글입력 알림 -->
	<div id="replyMessage1"></div>
	
	게시글번호 <input type="text" id="freeBoard_fb_number" value="${board.fb_number }" readonly/><br>
	<!-- 로그인 했을때-->
	<sec:authorize access="isAuthenticated()">
	<!-- 댓글입력  -->
		<%-- 댓글컨트롤러에서 Authentication으로 아이디 받음
		작성자 <input
				value="${userIdValue }" id="member_userId"
		 		readonly type="text" name="member_userId"/><br> --%>
		댓글 <input type="text" id="fb_replyContent" /><br>
				
		<button id="replyButton1">댓글쓰기</button>
	</sec:authorize>
	
	<!-- 로그인 안했을때 -->
	<sec:authorize access="not isAuthenticated()">
		댓글을 작성하시려면 로그인하세요.
	</sec:authorize>
	
	
	<!-- 댓글 리스트 -->
		<div class="row">
			<div class="col">
				<div id="replyListContainer">
					<!-- 댓글 나오는 부분 -->
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

	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

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
			document.querySelector("#likeButton").innerHTML = `<i class="fa-solid fa-thumbs-up"></i>`
		} else {
			document.querySelector("#likeButton").innerHTML = `<i class="fa-regular fa-thumbs-up"></i>`
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
	.then(data => document.querySelector("#replyMessage1").innerText = data.message)
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
			/* 수정 삭제버튼 */
			const editButton = `<button data-bs-toggle="modal" data-bs-target="#replyModifyModal" data-reply-id="\${item.fb_replyNumber}" id="\${modifyReplyButtonId}"> 수정</button>
								<button data-bs-toggle="modal" data-bs-target="#replyDeleteModal" data-reply-id="\${item.fb_replyNumber}" id="\${removeReplyButtonId}"> 삭제</button>`
			
			const replyDiv = 
				`<div>
					댓글 : \${item.fb_replyContent}
					작성시간 : \${item.ago}
					작성자 : \${item.member_userId}
					닉네임 : \${item.nickName}
					\${item.editable ? editButton : ''}
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
	.then(data => document.querySelector("#replyMessage1").innerText = data.message)
	.then(() => listReply());
}



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
		document.querySelector("#replyMessage1").innerText = data.message;
	})
	.then(() => listReply());
});

</script>
</body>
</html>










