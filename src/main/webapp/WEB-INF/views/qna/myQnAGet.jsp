<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<my:navbar active="getMyQnA"></my:navbar>
	<sec:authentication property="name" var="userIdValue"/>	
	<div class="container mt-3 mb-3">
		<div class="d-flex">
			<div class="mr-auto p-2"><h1>문의내용</h1></div> 
	    </div>
		<div class="row">
			<div class="col">		
				<form action="" method="post" class="form-control row g-3 mb-3">
					<div class="row d-flex">
						<div class="col-md-2">
							<label for="formControlInput1" class="form-label">문의번호</label>
							<input id="formControlInput1" class="form-control" type="hidden" name="qnaId" id="qnaIdVal" value="${qna.qnaId}">						
							<span class="badge bg-primary rounded-pill">${qna.qnaId}</span>
						</div>
						<div class="col-md-2">
							<label for="formControlInput2" class="form-label">카테고리</label>
							<input id="formControlInput2" class="form-control" type="hidden" name="category" value="${qna.category}" readonly >
							<span class="badge bg-primary rounded-pill">${qna.category}</span>
						</div>
					</div>
					<div class="row d-flex">
						<div class="col-md-4">
							<label for="formControlInput5" class="form-label"><i class="fa-solid fa-user"></i></label>
							<input id="formControlInput5" class="form-control" type="hidden" name="userId" id="userIdVal" value="${qna.userId}" readonly >
							<span class="badge bg-primary rounded-pill">${qna.userId}</span>
						</div>
						<div class="col-md-4">
							<label for="formControlInput6" class="form-label"><i class="fa-regular fa-clock"></i></label>						
							<input id="formControlInput6" class="form-control" type="hidden" name="insertDatetime" value="${qna.insertDatetime} " readonly >						
							<span class="badge bg-primary rounded-pill">${qna.insertDatetime}</span>
						</div>
						<div class="col-md-4">
							<label for="formControlInput7" class="form-label">처리상태</label>	
							<input id="formControlInput7" class="form-control" type="hidden" name="status" value="${qna.status} " readonly >
							<c:if test="${qna.status == '답변대기'}">
								<span class="badge bg-danger rounded-pill">${qna.status}</span>
							</c:if>
							<c:if test="${qna.status != '답변대기'}">
								<span class="badge bg-success rounded-pill">${qna.status}</span>
							</c:if>
						</div>
					</div>
					<div class="mb-3">
						<label for="formControlInput3" class="form-label">제목</label>
						<input id="formControlInput3" class="form-control" type="text"name="title" value="${qna.title}" readonly >
					</div>	
					<div class="mb-3">
						<label for="formControlInput4" class="form-label">내용</label>
						<textarea id="formControlInput4" class="form-control" name="content" readonly >${qna.content}</textarea>
					</div>
				
					<div class = "d-flex flex-row-reverse">			
						<c:url value="/qna/myQnAModify" var="myQnAModifyLink">
							<c:param name="userId" value="${qna.userId}"/>
							<c:param name="qnaId" value="${qna.qnaId}"/>
						</c:url>
						<button onclick="location.href='${myQnAModifyLink}'" class="btn btn-outline-warning" type="button">수정</button>		
						<div>
							<button class="btn btn-outline-success" type="button" id="likeBtn1">
								<!-- 문의내용 좋아요 버튼 -->
								<i class="fa-regular fa-thumbs-up"></i>
							</button>
						</div>
						<c:if test="${qnaAnswer == null}">
							<sec:authorize access="hasAuthority('admin')">
								<div class = "d-flex flex-row-reverse">
									<div>
										<!-- 답변하기 fetch -> post -> controller -->
										<button class="btn btn-outline-success" type="button" data-bs-toggle="collapse" data-bs-target="#qnaReplyCollapseAnswer" aria-expanded="false" aria-controls="collapseExample">
											답변하기
										</button>
									</div>
								</div>
							</sec:authorize>
						</c:if>
					</div>
				</form>	
				
				<!-- 답변 작성하기 -->
				<sec:authorize access="hasAuthority('admin')">		
					<div class="collapse" id="qnaReplyCollapseAnswer">
						<div class="card card-body">
							<div class="mb-3">
								<input type="hidden" id="qnaReplyQnAId" value="${qna.qnaId}" readonly>
								<input type="hidden" id="qnaReplyUserId" value="${qna.userId}" readonly>
								<input type="hidden" id="qnaReplyWriter" value="${userIdValue}" readonly>
								<label for="qnaReplyContent" class="form-label">내용</label>
								<textarea id="qnaReplyContent" class="form-control"></textarea>
							</div>
							<sec:authorize access="isAuthenticated()">
							<div class="d-flex flex-row-reverse">
								<button class="btn btn-outline-success" type="button" id="qnaReplyBtn">등록</button>
							</div>
							</sec:authorize>
						</div>
					</div>
				</sec:authorize>
				<!-- 답변 가져오기  -->
				<!-- //qnaReplyId,qnaId,userId,writer,content,insertDatetime -->
				<c:if test="${qnaAnswer != null}">
					<h1>답변내용 </h1>
					<div class="row g-3 mb-3">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header d-flex">
									<span class="p-1"><i class="fas fa-comments"></i></span>
									<span class="p-1"><i class="fa-solid fa-user"></i>${qnaAnswer.writer}</span>
									<span class="p-1"><i class="fa-regular fa-clock"></i>${qnaAnswer.insertDatetime}</span>
								</div>
								<div class="card-body">
									<p class="card-text">${qnaAnswer.content}</p>
									<div class="d-flex flex-row-reverse">
										<%-- <c:if test="${userIdValue == 'admin'}"> --%>
										<div>
											<input id="qnaReplyIdValue" type="hidden" value="${qnaAnswer.qnaReplyId}">
											<input id="qnaIdValue" type="hidden" value="${qnaAnswer.qnaId}">
											<input id="qnaUserIdValue" type="hidden" value="${qnaAnswer.userId}">
											<button id="qnaAnswerDeleteBtn" class="btn btn-outline-danger" type="button" >삭제</button>
										</div>
										<div>
											<button class="btn btn-outline-warning"  type="button"  data-bs-toggle="modal" data-bs-target="#modifyAnswerInputModal" >수정</button>
										</div>
										<%-- </c:if> --%>
										<sec:authorize access="isAuthenticated()">
											<button class="btn btn-outline-success" type="button" data-bs-toggle="modal" data-bs-target="#replyInputModal">
												댓글작성
											</button>
										</sec:authorize>	
									</div>
								</div>
							</div>
						</div>
					</div> 
				</c:if>
				<!--답변 수정 Modal by 답변Id  -->
		    	<div class="modal fade" id="modifyAnswerInputModal" tabindex="-1" aria-labelledby="modifyAnswerInputModalLabel" aria-hidden="true">
		    	  <div class="modal-dialog">
		    	    <div class="modal-content">
		    	      <div class="modal-header">
		    	        <h1 class="modal-title fs-5" id="modifyAnswerInputModalLabel">답변수정</h1>
		    	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    	      </div>
		    	      <div class="modal-body">
		    	      	<!-- //qnaReplyId,qnaId,userId,writer,content,insertDatetime -->
		    	      	<input type="hidden" id="qnaAnswerId" value="${qna.qnaReplyId}" readonly>
						수정할 답변 내용<textarea id="qnaAnswerContentModify" cols="40" rows="5"></textarea>
		    	      </div>
		    	      <div class="modal-footer">
		    	        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">취소</button>
		    	        <button id="modifyAnswerSubmitBtn" type="button" class="btn btn-outline-success">수정</button>
		    	      </div>
		    	    </div>
		    	  </div>
		    	</div>
		    	<!-- 댓글작성 Modal by 답변Id  -->
		    	<div class="modal fade" id="replyInputModal" tabindex="-1" aria-labelledby="replyInputModalLabel" aria-hidden="true">
		    	  <div class="modal-dialog">
		    	    <div class="modal-content">
		    	      <div class="modal-header">
		    	        <h1 class="modal-title fs-5" id="replyInputModalLabel">댓글작성</h1>
		    	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    	      </div>
		    	      <div class="modal-body">
		    	      	<!-- //qnaReplyId,qnaId,userId,writer,content,insertDatetime -->
		    	      	${qnaReply}
		    	      	답변 번호 <input type="hidden" id="qnaReplyId2" value="${qna.qnaReplyId}" readonly>
						게시물 번호 <input type="hidden" id="qnaReplyQnAId2" value="${qna.qnaId}" readonly>
						게시물 작성자 <input type="hidden" id="qnaReplyUserId2" value="${qna.userId}" readonly>
						댓글 작성자 <input type="hidden" id="qnaReplyWriter2" value="${userIdValue}" readonly>
						댓글 <textarea id="qnaReplyContent2" cols="40" rows="2"></textarea>
		    	      </div>
		    	      <div class="modal-footer">
		    	        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">취소</button>
		    	        <button id="qnaReplyBtn2" type="button" class="btn btn-outline-success">등록</button>
		    	      </div>
		    	    </div>
		    	  </div>
		    	</div>
				<!-- 댓글보기 답변이있을때만 , by 답변Id가있으면   -->
				<c:forEach items="${qnaReplyToAnswerList}" var="qnaReplyToAnswer">
					<div class="container">
						<div class="row g-3 mb-3">
			    			<div class="col-md-1">
			    				<i class="fa-solid fa-arrow-right"></i>
			    			</div>
			    			<div class="col-md-11">
					    		<div class="card">
					    		  <div class="card-header d-flex">
					    		  	<input type="text" id="qnaReplyToAnswerIdValue" value="${qnaReplyToAnswer.qnaReplyToAnswerId}">
					    		  	<span class="p-1"><i class="fas fa-comments"></i></span>
					    		  	<span class="p-1"><i class="fa-solid fa-user"></i>${qnaReplyToAnswer.userId}</span>
					    		  	<span class="p-1"><i class="fa-regular fa-clock"></i>${qnaReplyToAnswer.insertDatetime}</span>
					    		  </div>
					    		  <div class="card-body">
					    		    <p class="card-text">${qnaReplyToAnswer.content}</p>
					    		    <div class="d-flex flex-row-reverse">
					    		    	<%-- 로그인=> ${userIdValue} / 작성자=> ${qnaReplyToAnswer.userId} --%>
					    		    	<div>
					    		    		<button id="" onclick="deleteReply()" class="btn btn-outline-danger" type="button">삭제</button>
					    		    		<button class="btn btn-outline-warning"  type="button"  data-bs-toggle="modal" data-bs-target="#modifyReplyInputModal" >수정</button>
						    		    </div> 		
					    		    </div>
					    		  </div>
					    		</div>
				    		</div>	
			    		</div>
					</div>			
		    	</c:forEach>
		    	<!-- 댓글 수정 Modal by 답변Id  -->
		    	<div class="modal fade" id="modifyReplyInputModal" tabindex="-1" aria-labelledby="modifyReplyInputModalLabel" aria-hidden="true">
		    	  <div class="modal-dialog">
		    	    <div class="modal-content">
		    	      <div class="modal-header">
		    	        <h1 class="modal-title fs-5" id="modifyReplyInputModalLabel">댓글수정</h1>
		    	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		    	      </div>
		    	      <div class="modal-body">
		    	      	<!-- //qnaReplyId,qnaId,userId,writer,content,insertDatetime -->
		    	      	
		    	      	<input id="qnaReplyIdValue" type="text" value="${qnaReplyToAnswer.qnaReplyToAnswerId}" >
						수정할 댓글 내용<textarea id="qnaAnswerContentModify" cols="40" rows="3"></textarea>
		    	      </div>
		    	      <div class="modal-footer">
		    	        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">취소</button>
		    	        <button id="modifyReplySumbitBtn" type="button" onclick="modifyReply()" class="btn btn-outline-success">수정</button>
		    	      </div>
		    	    </div>
		    	  </div>
		    	</div>  
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";
//	<!-- 좋아요 기능 -->
//	document.querySelector("#likeBtn1").addEventListener("click", function(){
//		const qnaId = document.querySelector("#qnaId").value;
//		fetch(ctx + "/qna/likeCount", { 
//			method : "put",
//			headers : { "Content-Type" : "application/json" },
//			body : JSON.stringify({qnaId : qnaId})
//		})
//	});
	
if(qnaReplyBtn != null) {
	<!-- 답변 저장기능 (관리자만 작성가능)-->
	document.querySelector("#qnaReplyBtn").addEventListener("click", function() {
		const qnaId = document.querySelector("#qnaReplyQnAId").value;
		const userId = document.querySelector("#qnaReplyUserId").value;
		const writer = document.querySelector("#qnaReplyWriter").value;
		const content = document.querySelector("#qnaReplyContent").value;
		const data = {qnaId, userId, writer, content};
		fetch(ctx + "/qnaReply/add", { method : "put",
									    headers : { "Content-Type" : "application/json" },
									    body : JSON.stringify(data)
		})
		.then(res => res.text())
		.then(redirectPath => location.href = redirectPath)
	});
}	
<!-- 답변 수정 모달 기능 (관리자만 작성가능)-->
document.querySelector("#modifyAnswerSubmitBtn").addEventListener("click", function() {
	const qnaReplyId = document.querySelector("#qnaAnswerId").value;
	const content = document.querySelector("#qnaAnswerContentModify").value;
	const data = {qnaReplyId, content};
	fetch(ctx + "/qnaReply/qnaAnswerModify", { method : "post",
								    headers : { "Content-Type" : "application/json" },
								    body : JSON.stringify(data)
	})
	.then(res => res.text())
	.then(redirectPath => location.href = redirectPath)
	
});
	<!-- 답변 삭제  -->
	function deleteAnswer() {
		document.querySelector("#qnaAnswerDeleteBtn").addEventListener("click", function() {
			const qnaReplyId = document.querySelector("#qnaReplyIdValue").value;
			const qnaId = document.querySelector("#qnaIdValue").value;
			const userId = document.querySelector("#qnaUserIdValue").value;
			const data = {qnaReplyId, qnaId, userId};
			fetch(ctx + "/qnaReply/deleteQnAAnswer", 
					{ method : "delete",
			    	headers : { "Content-Type" : "application/json" },
			    	body : JSON.stringify(data)
			})
			.then(res => res.text())
			.then(redirectPath => location.href = redirectPath)
			
		});
	}
	
	
	<!-- 댓글 저장기능(답변글이 있을 때만 가능, 로그인한 모든 회원 ) -->
	document.querySelector("#qnaReplyBtn2").addEventListener("click", function() {
		const qnaReplyId = document.querySelector("#qnaReplyId2").value;
		const qnaId = document.querySelector("#qnaReplyQnAId2").value;
		const userId = document.querySelector("#qnaReplyUserId2").value;
		const writer = document.querySelector("#qnaReplyWriter2").value;
		const content = document.querySelector("#qnaReplyContent2").value;
		const data = {qnaReplyId, qnaId, userId, writer, content};
		fetch(ctx + "/qnaReply/addToAnswer", 
				{ method : "put",
				headers : { "Content-Type" : "application/json" },
				body : JSON.stringify(data)
		})
		.then(res => res.text())
		.then(redirectPath => location.href = redirectPath)
	});
	<!-- 댓글 수정 -->
	function modifyReply() {
		document.querySelector("#modifyReplySumbitBtn").addEventListener("click", function() {
			const qnaReplyToAnswerId = document.querySelector("#qnaReplyToAnswerIdValue").value;
			const content = document.querySelector("#qnaAnswerContentModify").value;
			const data = {qnaReplyToAnswerId, content};
			fetch(ctx + "/qnaReply/modifyReply", 
					{ method : "post",
			    	headers : { "Content-Type" : "application/json" },
			    	body : JSON.stringify(data)
			})
			
			
		});
	}

	
	<!-- function() 댓글 삭제  qnaReplyToAnswerId, qnaReplyId, qnaId, writer, content, userId, insertDatetime -->
	function deleteReply() {
		console.log("t삭제버튼 클릭됨 ");
		const qnaReplyToAnswerId = document.querySelector("#qnaReplyToAnswerIdValue").value;
		fetch(ctx + "/qnaReply/deleteQnAReply",
				{ method : "delete",
		    	headers : { "Content-Type" : "application/json" },
		    	body : JSON.stringify(qnaReplyToAnswerId)
		})
		.then(res => res.text())
		.then(redirectPath => location.href = redirectPath)
	};
	
	
	
	
	
</script>
</body>
</html>