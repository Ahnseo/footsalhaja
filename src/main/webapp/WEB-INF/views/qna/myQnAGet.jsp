<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.net.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Insert title here</title>

<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');


.container-sm { 
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
	font-size: 16px;
}
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

#freeTitle h2 {
	text-align: center;
	padding: 60px;
 }

ul {
   list-style:none;
  }

.post_wrap {
	border: 1px solid #ced4da;
	border-radius: 10px;
	margin: 0 0 30px 0;
}
.reply_wrap {
	border: 1px solid #ced4da;
	border-radius: 10px;
	margin: 0 0 30px 0;
}


/* 상단 버튼부분 */
.topbtnBox {
	margin: 30px 0 15px 0;
	position: relative;
}
.topbtnBox .modifyBtn {
	text-align: right;
	position: absolute;
	top: 0;
	right: 0;
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
.reply_wrap .reply_content {
	margin: 0px 20px;
	
}
.reply_wrap ul {
	text-align: left;
	padding-left:0;
}
.reply_wrap ul li {
	display: inline-block;
	margin-left: 20px;
	font-size: 13px;
}

.post_wrap .likeBox {
	text-align: center;
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
.btn-m5{
	margin : 5px;
}
.listHover:hover {
	background-color: #D3D3D3;
	cursor: pointer;
}


</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

</head>
<body>
	<my:navbar active="getMyQnA"></my:navbar>
	<sec:authentication property="name" var="userIdValue"/>	
	<input class="form-control" type="hidden" name="qnaId" id="qnaIdVal" value="${qna.qnaId}" readonly>	
	<input class="form-control" type="hidden" name="userId" id="userIdVal" value="${qna.userId}" readonly >
	
	<!-- 전체 컨테이너 -->
<div class="p-4">
	<div class="container-sm">
		<div id="freeTitle">
			<h2>문의</h2>
		</div>
		<!-- 문의 번호, 제목, 카테고리, userId, 작성일시, 좋아요, 처리상태   -->
		<div class="post_wrap">
			<div class="post_top">
				<p class="top_category">문의번호 ${qna.qnaId } </p>
				<p class="top_category">${qna.category } </p>	
				<p class="top_category"> 
					<c:if test="${qna.status == '답변대기'}"><span>${qna.status}</span></c:if>
					<c:if test="${qna.status != '답변대기'}"><span>${qna.status}</span></c:if>	
				</p>
	
				<ul class=" p-2 mt-2">
					<li><i class="fa-solid fa-envelope"></i></li>
					<li class="top_nickName"><i class="fa-solid fa-user"></i> ${qna.userId } </li>
					<li class="top_nickName"><i class="fa-regular fa-clock"></i> ${qna.ago } </li>
					<li class="top_nickName"><i class="fa-regular fa-thumbs-up"></i> ${qna.likeCount } </li>
				</ul>
				<div class="top_content">
					<label for="" class="form-label">제목</label>
					<p class="form-control">${qna.title } </p>
				</div>
			</div><!-- </div class = "post_top" -->
			
			<!-- 문의 본문  -->
			<div class="top_content ">
				<label for="" class="form-label">내용</label>
				<textarea id="" class="form-control mb-3 " name="content">${qna.content}</textarea>
				
				<%-- 이미지 출력 --%>
				<div>
					<c:forEach items="${qna.fileName }" var="name">
						<div>
							<img class="img-fluid img-thumbnail" src="${imgUrl }/qna/${qna.qnaId }/${URLEncoder.encode(name, 'utf-8')}" alt="">
						</div>
					</c:forEach>		
				</div>
			</div>
			
			
			<!-- 문의내용 좋아요 버튼 -->
			<div class="likeBox">
				
				<p  <sec:authorize access="not isAuthenticated()">
						style="pointer-events: none;"
					</sec:authorize>	
					id="likeBtn" class="likeIcon"
					>
					
					<i class="fa-regular fa-thumbs-up"></i>
					
				</p>
				<p class="likeCount1">도움이 되었어요!</p>
				
				<p id="likeCnt" class="likeCount2"> ${qna.likeCount }</p>
			
			</div><!-- 좋아요 버튼 -->
			
			
			<div class="d-flex flex-row-reverse"> 
				<c:if test="${qna.userId == userIdValue}" ><!-- 문의 수정은 작성자 userId 만!! -->
					<c:url value="/qna/myQnAModify" var="myQnAModifyLink">
						<c:param name="userId" value="${qna.userId}"/>
						<c:param name="qnaId" value="${qna.qnaId}"/>
					</c:url>	
					<button onclick="location.href='${myQnAModifyLink}'" class="btn btn-warning btn-m5" type="button">
						수정
					</button><!-- 수정 버튼 -->	
				</c:if>
				
				
				<!-- 답변하기 버튼  답변이 없을때만 => 작성가능!  fetch -> post방 -> controller -->
				<sec:authorize access="hasAnyAuthority('admin', 'manager')">
				<c:if test="${qnaAnswer == null}">	
					<button class="btn btn-success btn-m5" type="button" data-bs-toggle="collapse" data-bs-target="#qnaReplyCollapseAnswer" aria-expanded="false" aria-controls="collapseExample">
						답변하기
					</button>	
				</c:if>
				</sec:authorize><!-- 답번하기 버튼 (관리자와 매니저 만 )-->	
				
			</div> 
			
		</div>
	</div>
	
	<div class="container m-auto">	
		<!-- 답변 작성하기 -->
		<sec:authorize access="hasAnyAuthority('admin', 'manager')">
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
						<button class="btn btn-success btn-m5" type="button" id="qnaReplyBtn">등록</button>
					</div>
					</sec:authorize>
				</div>
			</div>
		</sec:authorize>
		
		<!-- 답변 가져오기  -->
		<!-- //qnaReplyId,qnaId,userId,writer,content,insertDatetime -->
		<!-- 문의 번호, 제목, 카테고리, userId, 작성일시, 좋아요, 처리상태   -->
		<c:if test="${qnaAnswer != null}">
			<div class="container-sm ">
				<div id="freeTitle">
					<h2>답변</h2>
				</div>
				<div class="post_wrap">
					<div class="post_top">		
						<ul class="p-2 mt-2">
							<li><i class="fa-solid fa-envelope-open-text"></i></li>
							<li class="top_nickName"><i class="fa-solid fa-user"></i> ${qnaAnswer.writer } </li>
							<li class="top_nickName"><i class="fa-regular fa-clock"></i> ${qnaAnswer.ago } </li>
						
						</ul>
					</div><!-- </div class = "post_top" -->

					<!-- 답변 본문  -->
					<div class="top_content">
						<label for="" class="form-label">답변내용</label>
						<p class="" >${qnaAnswer.content }</p>
					</div>
					
					<div class="d-flex flex-row-reverse">
					
						<sec:authorize access="hasAuthority('admin')">
						<div>
							<input id="qnaReplyIdValue" type="hidden" value="${qnaAnswer.qnaReplyId}">
							<input id="qnaIdValue" type="hidden" value="${qnaAnswer.qnaId}">
							<input id="qnaUserIdValue" type="hidden" value="${qnaAnswer.userId}">
							<button id="qnaAnswerDeleteBtn" onclick="deleteAnswer()" class="btn btn-danger btn-m5" type="button" >삭제</button>
						</div>
						<div>
							<button class="btn btn-warning btn-m5"  type="button"  data-bs-toggle="modal" data-bs-target="#modifyAnswerInputModal" >수정</button>
						</div>
						</sec:authorize>
						
						<sec:authorize access="isAuthenticated()">
							<button class="btn btn-success btn-m5" type="button" data-bs-toggle="modal" data-bs-target="#replyInputModal">
								댓글작성
							</button>
						</sec:authorize>	
					</div>
				</div><!-- </div class="post_wrap" -->	
			</div>
		</c:if>
	</div>	
	
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
			수정할 답변 내용<textarea id="qnaAnswerContentModify" cols="40" rows="5">${qnaAnswer.content }</textarea>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger btn-m5" data-bs-dismiss="modal">취소</button>
	        <button id="modifyAnswerSubmitBtn" type="button" class="btn btn-success btn-m5">수정</button>
	      </div>
	    </div>
	  </div>
	</div>
    	
	<!-- 댓글 작성 Modal by 답변Id  -->
	<div class="modal fade" id="replyInputModal" tabindex="-1" aria-labelledby="replyInputModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="replyInputModalLabel">댓글작성</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      <div>
    	    댓글 
    	    <!-- //qnaReplyId,qnaId,userId,content,insertDatetime -->
    	    
    	    <input type="hidden" id="qnaReplyId2" value="${qna.qnaReplyId}" readonly>
    	    <input type="hidden" id="qnaReplyQnAId2" value="${qna.qnaId}" readonly>
    	    <input type="hidden" id="qnaReplyUserId2" value="${userIdValue}" readonly>
    	    
	      </div>
	      <div>
	      	<textarea id="qnaReplyContent2" cols="45" rows="3"></textarea>
		  </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger btn-m5" data-bs-dismiss="modal">취소</button>
	        <button id="qnaReplyBtn2" type="button" class="btn btn-success btn-m5">등록</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container m-auto">	
	<!-- 댓글보기 답변이있을때만 , by 답변Id가있으면   -->
	
	
	
		<div id="replyListContainer"></div>
		
		
		
	</div>
	<!-- 댓글 수정 Modal by 답변Id  -->
	<div class="modal fade" id="modifyReplyInputModal" tabindex="-1" aria-labelledby="modifyReplyInputModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="modifyReplyInputModalLabel">댓글수정</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	
			수정할 댓글 내용
			<textarea id="modifyReplyInput" cols="40" rows="3"></textarea>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger btn-m5" data-bs-dismiss="modal">취소</button>
	        <button id="modifyReplySumbitBtn" type="button" onclick="" class="btn btn-success btn-m5">등록</button>
	      </div>
	    </div>
	  </div>
	</div>  
</div>	

<my:footer></my:footer>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";
	
	listReply();
	
	function listReply() {
		const answerId = document.querySelector("#qnaAnswerId").value;
		
		fetch(`\${ctx}/qnaReply/list/\${answerId}`)
		.then(res => res.json())
		.then(list => {
			
			const replyListContainer = document.querySelector("#replyListContainer");
			replyListContainer.innerHTML = "";
			
			for (const item of list) {
				
				//console.log(item.qnaReplyToAnswerId);
				const modifyReplyButtonId = `modifyReplyButton\${item.qnaReplyToAnswerId}`;
				const removeReplyButtonId = `removeReplyButton\${item.qnaReplyToAnswerId}`;
				
				const editButton = `
					<div>
						<button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modifyReplyInputModal" id="\${modifyReplyButtonId}" data-reply-id="\${item.qnaReplyToAnswerId}" >
							수정
						</button>
						<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteReplyInputModal" id="\${removeReplyButtonId}" data-reply-id="\${item.qnaReplyToAnswerId}" >
							삭제
						</button>
					</div>
					`
				
				
				const replyDiv = `
					<input type="hidden" id="\${item.qnaReplyToAnswerId}" value="\${item.qnaReplyToAnswerId}">
					<div class="container-sm d-flex">
						<div class="col-sm-1">						
							<i class="fa-solid fa-arrow-right"></i>	
						</div>
						<div class="col-sm-11">
							<div class="reply_wrap d-flex" >
								<div class="col-sm-6"  style="margin-top: 10px;">
									<div class="reply_content">
										<div class="top_content">
											<i class="fa-solid fa-comments"></i>
											<label for="" class="form-label">댓글</label>
											<p class="" >\${item.content}</p>
										</div>
									</div>
								</div>
								<div class="col-sm-3" style="margin : auto;">
									<ul>
										<li><i class="fa-solid fa-user"></i>\${item.userId}</li>
										<li><i class="fa-regular fa-clock"></i>\${item.ago}</li>
									</ul>
								</div>
								<div class="col-sm-3 "  style="margin : auto;">
									\${item.editable ? editButton : ''}
								</div>
							</div>
						</div>
					</div>`;
				replyListContainer.insertAdjacentHTML("beforeend", replyDiv);
				
				if (item.editable) {
					// 수정 폼 모달에 댓글 내용 넣기
					document.querySelector("#" + modifyReplyButtonId).addEventListener("click", function() {
							<!-- modifyReplySumbitBtn 에 replyId 값 넣기 -->
							document.querySelector("#modifyReplySumbitBtn").setAttribute("data-reply-id", this.dataset.replyId);
							readReplyAndSetModalForm(this.dataset.replyId);
					});
				}	
				if (item.editable) {
					// 댓글 삭제 
					document.querySelector("#"+removeReplyButtonId).addEventListener("click", function(){
						const qnaReplyToAnswerId = this.dataset.replyId;
						fetch(`\${ctx}/qnaReply/deleteQnAReply`, {
							method : "delete",
							headers : {"Content-Type" : "application/json"},
							body : JSON.stringify({qnaReplyToAnswerId})
						})
						.then( ()=> history.go(0) )
					});
					
				}
					
				
			}
		});
	}
	<!-- ### Modal안에 dataset 값 넣기 ############# -->
	function readReplyAndSetModalForm(replyId) {
		fetch(`\${ctx}/qnaReply/get/\${replyId}`)
		.then(res => res.json())
		.then(reply => {
			document.querySelector("#modifyReplyInput").value = reply.content;
		});
	}
	<!-- 댓글 수정 최종 수정 버튼 누르면 업데이트 실행   -->
	document.querySelector("#modifyReplySumbitBtn").addEventListener("click", function(){
		const qnaReplyToAnswerId = this.dataset.replyId;
		const content = document.querySelector("#modifyReplyInput").value;
		const data = {qnaReplyToAnswerId, content};
		fetch(`\${ctx}/qnaReply/modifyReply`,{
			method : "post",
			headers : {"Content-Type" : "application/json"},
			body : JSON.stringify(data)
		})
		.then(()=> listReply())
		.then(()=> history.go(0))
	});
	
	
const qnaReplyBtn = document.querySelector("#qnaReplyBtn");
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

	<!-- 답변 수정 모달 전송 버튼 기능 (관리자만 작성가능)-->
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
}	
	<!-- 답변 삭제  -->
	function deleteAnswer() {
		
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
	
	}
	
	
	<!-- 댓글 저장기능 (답변글이 있을 때만 가능, 로그인한 모든 회원 ) -->
	document.querySelector("#qnaReplyBtn2").addEventListener("click", function() {
		const qnaReplyId = document.querySelector("#qnaReplyId2").value;
		const qnaId = document.querySelector("#qnaReplyQnAId2").value;
		const userId = document.querySelector("#qnaReplyUserId2").value;
		const content = document.querySelector("#qnaReplyContent2").value;
		
		const data = {qnaReplyId, qnaId, userId, content};
		fetch(ctx + "/qnaReply/addToAnswer", 
				{ method : "put",
				headers : { "Content-Type" : "application/json" },
				body : JSON.stringify(data)
		})
		.then(res => res.text())
		.then(redirectPath => location.href = redirectPath)
	});
	
	
	
	<!-- 좋아요 기능 -->
	document.querySelector("#likeBtn").addEventListener("click", function(){
		const qnaId = document.querySelector("#qnaIdVal").value;
		
		fetch(ctx + "/qna/likeCount", { 
			method : "put",
			headers : { "Content-Type" : "application/json" },
			body : JSON.stringify({qnaId : qnaId})
		})
		
		.then(()=> history.go(0));
		
	});
	
	
</script>
</body>
</html>