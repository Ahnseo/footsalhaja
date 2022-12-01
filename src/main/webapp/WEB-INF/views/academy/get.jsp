

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<body>
<my:navbar></my:navbar>

	<h1>${board.ab_number }번 페이지</h1>
	
	제목 <input type ="text" value="${board.ab_title }" readonly> <br>
	말머리 <input type ="text" value="${board.ab_category }" readonly> <br>
	본문 <textarea readonly>${board.ab_content }</textarea> <br>
	작성자 <input type ="text" value="${board.member_userId }" readonly> <br>
	작성일시 <input type = "datetime-local" value = "${board.ab_insertDatetime }" readonly>
	
	<c:url value="/academy/modify" var="modifyLink">
		<c:param name="ab_number" value="${board.ab_number }"></c:param>
	</c:url>
	<a class="btn btn-warning" href="${modifyLink }">수정</a>


	<!-- 글 목록버튼 -->
	<div class="d-flex flex-row-reverse">
		<c:url value="/academy/list" var="listLink" >
			<c:param name="pageNum" value='${cri.pageNum }'></c:param>
			<c:param name="amount" value='${cri.amount }'></c:param>
		</c:url>
		<a class="btn btn-outline-primary" href="${listLink }"
			role="button">목록</a>
	</div>


	<!-- 댓글 창 -->
	
	<div id="replyMessage">
	</div>
	
	<div class="container-md">
		<div class="row">
			<div class="col">
				<!-- 참조키 (ab_number, member_userId) 값_ -->
				<input type="hidden" id="ab_number" value="${board.ab_number }">
				<input type="hidden" id="member_userId" value="${board.member_userId }">
				<input type="text" id="replyInput">
				<button id="replySendButton">댓글쓰기</button>
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<div id="replyListContainer">
				
				</div>
			</div>
		</div>
	</div>
	
	<%-- 댓글 삭제 확인 모달 --%>
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
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" data-bs-dismiss="modal" id="removeConfirmModalSubmitButton" class="btn btn-danger">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%-- 댓글 수정 모달 --%>
	<div class="modal fade" id="modifyReplyFormModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5">댓글 수정 양식</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <input type="text" id="modifyReplyInput">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" data-bs-dismiss="modal" id="modifyFormModalSubmitButton" class="btn btn-danger">수정</button>
	      </div>
	    </div>
	  </div>
	</div>
	

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>

/* 댓글 이벤트 처리 */
	const ctx = "${pageContext.request.contextPath}";

	listReply();
	
	/* 수정모달에서 댓글 읽어오기 */
	function readReplyAndSetModalForm(replyId) {
		fetch(ctx + "/reply/get/" + replyId)
		.then(res => res.json())
		.then(reply => {
			document.querySelector("#modifyReplyInput").value = reply.ab_replyContent;
		});
	} 
	
	/* 댓글 수정 */
	document.querySelector("#modifyFormModalSubmitButton").addEventListener("click", function() {
	const content = document.querySelector("#modifyReplyInput").value;
	const id = this.dataset.replyId;
	const data = {id, content};
	
	
	fetch(`\${ctx}/reply/modify`, {
		method : "put",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => document.querySelector("#replyMessage").innerText = data.message)
	.then(() => listReply());
}); 
	
	/* 댓글 삭제 */
	document.querySelector("#removeConfirmModalSubmitButton").addEventListener("click", function() {
		//댓글 삭제 버튼은 여러개고 모달창의 삭제버튼은 하나이므로
		//삭제할 댓글의 삭제버튼의replyID를 가져올 수 있어(아래 setAttribute로 부여)
	 //모달 삭제버튼에 전달하고 해당 replyID의 댓글 삭제 진행
	removeReply(this.dataset.replyId);
	});
	
	function listReply() {
		const ab_number = document.querySelector("#ab_number").value;
		fetch(`\${ctx}/reply/list/\${ab_number}`)
		.then(res => res.json())
		.then(list => {
			const replyListContainer = document.querySelector("#replyListContainer");
			replyListContainer.innerHTML = "";
			
			for (const item of list) {
				const modifyReplyButtonId = `modifyReplyButton\${item.ab_replyNumber}`;

				const removeReplyButtonId = `removeReplyButton\${item.ab_replyNumber}`;
				
				const replyDiv = `<div>\${item.ab_replyContent} : \${item.ab_replyInsertDatetime}
								<button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#modifyReplyFormModal" data-reply-id="\${item.ab_replyNumber}" id="\${modifyReplyButtonId}">
									<i class="fa-solid fa-pen"></i>
								</button>
								<button data-bs-toggle="modal" data-bs-target="#removeReplyConfirmModal" data-reply-id="\${item.ab_replyNumber}" id="\${removeReplyButtonId}">
									<i class="fa-solid fa-x"></i>
								</button>
								</div>`;
				
				replyListContainer.insertAdjacentHTML("beforeend", replyDiv);
				
				// 수정 폼 모달에 댓글 내용 넣기
				document.querySelector("#" + modifyReplyButtonId).addEventListener("click", function() {
						document.querySelector("#modifyFormModalSubmitButton").setAttribute("data-reply-id", this.dataset.replyId);
						readReplyAndSetModalForm(this.dataset.replyId);
					}); 
				
				document.querySelector("#" + removeReplyButtonId)
				.addEventListener("click", function() {
					//모달 삭제버튼에 전달 할 삭제할 댓글의 삭제버튼의replyID를 setAttribute를 이용해 부여
					document.querySelector("#removeConfirmModalSubmitButton").setAttribute("data-reply-id", this.dataset.replyId);
				});
			}
		});
	}
	
	
	
	/* 댓글 삭제 */
	function removeReply(replyId) {

	fetch(ctx + "/reply/remove/" + replyId, {
		method: "delete"
	})
	.then(res => res.json())
	.then(data => document.querySelector("#replyMessage").innerText = data.message)
	.then(() => listReply());
}
	
	
	document.querySelector("#replySendButton").addEventListener("click", function() {
		const ab_number = document.querySelector("#ab_number").value;
		const ab_replyContent = document.querySelector("#replyInput").value;
		const member_userId = document.querySelector("#member_userId").value;
		
		const data = {
			ab_number,
			ab_replyContent,
			member_userId
		};
		
		fetch(`\${ctx}/reply/add`, {
			method : "post",
			headers : {
				"Content-Type" : "application/json"
			},
			body : JSON.stringify(data)
		})
		.then(res => res.json())
		.then(data => {
			document.querySelector("#replyInput").value = "";
			document.querySelector("#replyMessage").innerText = data.message;
		})
		.then(() => listReply());
	});
</script>



</body>
</html>