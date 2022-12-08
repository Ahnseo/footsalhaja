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
		    <div class="p-3"><button class="btn btn-outline-success" type="button" id="likeBtn1"><i class="fa-regular fa-thumbs-up"></i></button></div>
	    </div>
		<div class="row">
			<div class="col">		
				<form action="" method="post" class="form-control row g-3 mb-3">
					<div class="d-flex">
						<div class="col-md-2">
							<label for="formControlInput1" class="form-label">문의번호</label>
							<input id="formControlInput1" class="form-control" type="hidden" name="qnaId" id="qnaId" value="${qna.qnaId}">						
							<span class="badge bg-primary rounded-pill">${qna.qnaId}</span>
						</div>
						<div class="col-md-2">
							<label for="formControlInput2" class="form-label">카테고리</label>
							<input id="formControlInput2" class="form-control" type="hidden" name="category" value="${qna.category}" readonly >
							<span class="badge bg-primary rounded-pill">${qna.category}</span>
						</div>
						<div class="col-md-2">
							<label for="formControlInput5" class="form-label"><i class="fa-solid fa-user"></i></label>
							<input id="formControlInput5" class="form-control" type="hidden" name="userId" value="${qna.userId}" readonly >
							<span class="badge bg-primary rounded-pill">${qna.userId}</span>
						</div>
						<div class="col-md-2">
							<label for="formControlInput6" class="form-label"><i class="fa-regular fa-clock"></i></label>						
							<input id="formControlInput6" class="form-control" type="hidden" name="insertDatetime" value="${qna.insertDatetime} " readonly >						
							<span class="badge bg-primary rounded-pill">${qna.insertDatetime}</span>
						</div>
						<div class="col-md-2">
							<label for="formControlInput7" class="form-label">처리상태</label>						
							<input id="formControlInput7" class="form-control" type="hidden" name="status" value="${qna.status} " readonly >
							<span class="badge bg-primary rounded-pill">${qna.status}</span>
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
						<div>
							<button class="btn btn-outline-danger" type="button" id="" >삭제</button>
						</div>	
						<div>
							<button class="btn btn-outline-warning"  type="button" id="" >수정</button>
						</div >					
						<div class = "d-flex flex-row-reverse">
							<sec:authorize access="hasAuthority('admin')">
								<div>
								<!-- 답변하기 post -> controller -->
									<button class="btn btn-outline-success" type="button" data-bs-toggle="collapse" data-bs-target="#qnaReplyCollapseAnswer" aria-expanded="false" aria-controls="collapseExample">
										답변하기
									</button>
								</div>
							</sec:authorize>
						</div>
					</div>
				</form>	
				
				<h1>답변내용 </h1>
				
				<sec:authorize access="hasAuthority('admin')">
					<div class="collapse" id="qnaReplyCollapseAnswer">
						<div class="card card-body">
							<input type="hidden" id="qnaReplyQnAId" value="${qna.qnaId}" readonly>
							<input type="hidden" id="qnaReplyUserId" value="${qna.userId}" readonly>
							<input type="hidden" id="qnaReplyWriter" value="${userIdValue}"  readonly>
							<div class="mb-3">
								<label for="qnaReplyContent" class="form-label">내용</label>
								<textarea id="qnaReplyContent" class="form-control"></textarea>
							</div>
							<div class="d-flex flex-row-reverse">
								<button class="btn btn-outline-success" type="button" id="qnaReplyBtn">등록</button>
							</div>
						</div>
					</div>
				</sec:authorize>
				<!-- 답변 가져오기(리스트 ..)  -->
				<!-- //qnaReplyId,qnaId,userId,writer,content,insertDatetime -->
				<c:forEach items="${qnaReplyList}" var="qnaReply">	
				<div class="row g-3 mb-3">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header d-flex">
								<span class="p-1"><i class="fas fa-comments"></i></span>
								<span class="p-1"><i class="fa-solid fa-user"></i>${qnaReply.writer}</span>
								<span class="p-1"><i class="fa-regular fa-clock"></i>${qnaReply.insertDatetime}</span>
							</div>
							<div class="card-body">
								<p class="card-text">${qnaReply.content}</p>
								<div class="d-flex flex-row-reverse">
								<a href="#" class="btn btn-danger">삭제</a>    		    
								<button class="btn btn-outline-success" type="button" data-bs-toggle="modal" data-bs-target="#replyInputModal">
								댓글작성 <!-- 댓글작성 버튼 modal  -->
								</button>
								</div>
							</div>
						</div>
					</div>
				</div> 
				</c:forEach>
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
				<!-- 댓글보기 by 답변Id  -->
				<div>
		    		<c:forEach items="${qnaReplyToAnswerList}" var="qnaReplyToAnswer">
		    			<div class="row g-3 mb-3">
			    			<div class="col-md-1">
			    				<i class="fa-solid fa-arrow-right"></i>
			    			</div>
			    			<div class="col-md-11">
					    		<div class="card">
					    		  <div class="card-header d-flex">
					    		  	<span class="p-1"><i class="fas fa-comments"></i></span>
					    		  	<span class="p-1"><i class="fa-solid fa-user"></i>${qnaReplyToAnswer.userId}</span>
					    		  	<span class="p-1"><i class="fa-regular fa-clock"></i>${qnaReplyToAnswer.insertDatetime}</span>
					    		  </div>
					    		  <div class="card-body">
					    		    <p class="card-text">${qnaReplyToAnswer.content}</p>
					    		    <div class="d-flex flex-row-reverse">
						    		    <a href="#" class="btn btn-danger">삭제</a>
						    		    <a href="#" class="btn btn-primary">답글</a>
					    		    </div>
					    		  </div>
					    		</div>
				    		</div>
			    		</div>
		    		</c:forEach>
		    	</div>			
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";
	<!-- 좋아요 기능 -->
	document.querySelector("#likeBtn1").addEventListener("click", function(){
		const qnaId = document.querySelector("#qnaId").value;
		fetch(ctx + "/qna/likeCount", { 
			method : "put",
			headers : { "Content-Type" : "application/json" },
			body : JSON.stringify({qnaId : qnaId})
		})
		
	});

	<!-- 답변 저장기능 (관리자만 작성가능)-->
	<c:if test="${not empty userIdValue}">
		document.querySelector("#qnaReplyBtn").addEventListener("click", function() {
			const qnaId = document.querySelector("#qnaReplyQnAId").value;
			const userId = document.querySelector("#qnaReplyUserId").value;
			const writer = document.querySelector("#qnaReplyWriter").value;
			const content = document.querySelector("#qnaReplyContent").value;
			const data = {qnaId, userId, writer, content};
			fetch(ctx + "/qnaReply/add", { method : "put",
										    headers : { "Content-Type" : "application/json" },
										    body : JSON.stringify(data)
			});
		});
	</c:if>
	
	<!-- 답변에 대한 댓글 저장기능(답변글이 있을 때만 가능, 로그인한 모든 회원 ) -->
	<c:if test="${not empty userIdValue}">
		document.querySelector("#qnaReplyBtn2").addEventListener("click", function() {
			const qnaReplyId = document.querySelector("#qnaReplyId2").value;
			const qnaId = document.querySelector("#qnaReplyQnAId2").value;
			const userId = document.querySelector("#qnaReplyUserId2").value;
			const writer = document.querySelector("#qnaReplyWriter2").value;
			const content = document.querySelector("#qnaReplyContent2").value;
			const data = {qnaReplyId, qnaId, userId, writer, content};
			fetch(ctx + "/qnaReply/addToAnswer", { method : "put",
										    headers : { "Content-Type" : "application/json" },
										    body : JSON.stringify(data)
			});
		});
	</c:if>
</script>
</body>
</html>