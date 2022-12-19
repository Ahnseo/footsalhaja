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
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}
ul {
   list-style:none;
  }
.container-sm { 
	font-family: 'NanumBarunGothic';
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
</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

<body>
<my:navbar></my:navbar>

<!-- 전체 컨테이너 -->
<div class="container-sm" >
	<!-- 전체글/수정버튼 -->
	
	
	<!-- 게시글로 돌아가기 버튼 -->
	<div class="topbtnBox">
		<c:url value="/academy/list" var="listLink"></c:url>
		<a href="${listLink }">
			<button type="button" class="btn btn-outline-success">게시글 목록</button>
		</a>
		

		<!-- 작성자와 authentication.name이 같아야 삭제&수정버튼 보여주기 -->
		<sec:authentication property="name" var="userIdValue" />
		
		<!-- 삭제버튼 -->
		<c:url value="/academy/remove" var="removeLink"></c:url>
			<form id="removeForm" action="${removeLink }" method="post">
				<input type="hidden" name="ab_number" value="${board.ab_number }"/>
			</form>
			<input class="btn btn-outline-success removeBtn" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal"/>
		<!-- 수정버튼 -->	

		<c:if test="${board.member_userId == userIdValue}" >
			<c:url value="/academy/modify" var="modifyLink">
				<c:param name="ab_number" value="${board.ab_number }"></c:param>
			</c:url>
			<a class="btn btn-outline-success modifyBtn" href="${modifyLink }">수정</a>
		</c:if>
	</div>
	

	<div class="post_wrap">
		<div class="post_top">
			<p class="top_category">${board.ab_category }</p>
			<p class="top_title">${board.ab_title }</p>
			<ul>
				<li class="top_nickName">${board.nickName }</li>
				<li class="top_insertDatetime">${board.ab_insertDatetime }</li>
				<li class="top_likeCount">좋아요 ${board.countLike }</li>
				<li class="top_insertDatetime">조회 ${board.ab_viewCount }</li>
			</ul>
		</div>
		<div id="summernote" class="top_content">${board.ab_content }</div>
	
	<!-- 파일 -->
	<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<div class="fileBox">
		<c:forEach items="${board.ab_fileName }" var="fileName">
			<div class="fileText">
				<i class="fa-solid fa-paperclip"></i>
				<a href="${ctx }/academy/download/${board.ab_number}/${fileName}">
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
			<p id="likeCount" class="likeCount2">${board.countLike }</p>
		</div>
		

	</div><!-- 본문끝 -->

<!-- 댓글 부분 -->
	<div class="replyBox container">
		<!-- 참조키 (ab_number, member_userId) 값_ -->
		<input type="hidden" id="ab_number" value="${board.ab_number }">
		<input type="hidden" id="member_userId" value="${board.member_userId }">
			<!-- 로그인 했을때-->
			<sec:authorize access="isAuthenticated()">
			<!-- 댓글입력  -->

			 	<div class="row">
				<input class="row replyContentInput" type="text" id="ab_replyContent"
					placeholder="댓글을 입력해주세요."/><br>
			 	</div>
						
				<button id="replySendButton" class="replyBnt btn btn-success" >댓글 등록</button>
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
			<!-- 댓글 페이지 출력란 -->
			<div class="paginationBox" id="replyPageFooter">
			</div>
		</div>
    
	</div>
</div>

	
	
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
	
	
	<%-- 댓글 삭제 확인 모달 --%>
	<div class="modal fade" id="removeReplyConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        댓글을 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
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
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" data-bs-dismiss="modal" id="modifyFormModalSubmitButton" class="btn btn-danger">수정</button>
	      </div>
	    </div>
	  </div>
	</div>
	

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>

//삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});


/* 댓글 이벤트 처리 */
	const ctx = "${pageContext.request.contextPath}";
	
	const ab_number = document.querySelector("#ab_number").value;
	
	const urlParams = new URL(location.href).searchParams;
	
	if (!urlParams.get('page')) {
		urlParams.set('page',1);
	};
	
	var page = urlParams.get('page');
	
	listReply(page);
	
	
	//댓글 리스트
	function listReply(page) {
		
		fetch(`\${ctx}/academy/reply/list/\${ab_number}/\${page}`)
		.then(res => res.json())
		.then(list => {
			const replyListContainer = document.querySelector("#replyListContainer");
			replyListContainer.innerHTML = "";
			
 			const replyCnt=list[0].replyCnt;
			
			console.log(replyCnt);
			
			/* 댓글 페이지 번호 출력하는 show ReplyPage()  */
			var pageNum = 1;
			const replyPageFooter = document.querySelector("#replyPageFooter");
			replyPageFooter.innerHTML = "";
			
			/* 댓글 출력 */
			for (const item of list[0].list) {
				
				console.log(item);
				
				const modifyReplyButtonId = `modifyReplyButton\${item.ab_replyNumber}`;

				const removeReplyButtonId = `removeReplyButton\${item.ab_replyNumber}`;
				
				const editButton = `<button class="btn btn-outline-success btn-sm b1" data-bs-toggle="modal" data-bs-target="#replyModifyModal" data-reply-id="\${item.ab_replyNumber}" id="\${modifyReplyButtonId}"> <i class="fa-solid fa-pen"></i></button>
					<button class="btn btn-outline-success btn-sm" data-bs-toggle="modal" data-bs-target="#replyDeleteModal" data-reply-id="\${item.ab_replyNumber}" id="\${removeReplyButtonId}"> <i class="fa-solid fa-x"></i></button>`
				
				const replyDiv = `<div class="reply_list">
					<span class="row"></span>
					<div class="replylist_top">
						<p> \${item.nickName}</p>
						<p class="ago"> \${item.ago}</p>
						\${item.editable ? editButton : ''}
					</div>
					<p> \${item.ab_replyContent}</p>
				</div>`;
				
				replyListContainer.insertAdjacentHTML("beforeend", replyDiv);
				
				if (item.editable) {
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
			} showReplyPage(replyCnt);
			/* 댓글 페이징 버튼 이동 */
			let pageButtons = document.querySelectorAll(".page-item span")
			
			for (const button of pageButtons){
			
				button.addEventListener("click", function(e) {
					e.preventDefault();
					console.log("page click");
					var targetPageNum = this.getAttribute("href");

					//댓글 페이지 번호를 변경한 후 
					pageNum = targetPageNum;
					//해당 페이지의 댓글 가져오게 함
					listReply(pageNum);
				})
			}
			
			function showReplyPage(replyCnt) {
				console.log("1");
				var endNum = Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum != 1;
				var next = false;
				
				if(endNum * 10 >= replyCnt) {
					endNum = Math.ceil(replyCnt/10.0);
				}
				
				if(endNum * 10 < replyCnt) {
					next = true;
				}
				var str = "<ul class='pagination'>";

				if(prev) {
					str += "<li class='page-item'><span class='page-link' href='"+(startNum-1)+"'><i class='fa-solid fa-angles-left'></i></span></li>";
				}
				
				for(var i=startNum ; i<=endNum; i++){
					var active = pageNum == i? "active":"";
					str+="<li class='page-item "+active+" '><span class='page-link' href='"+i+"'>"+i+"</span></li>";
				}
				
				if(next) {
					str+= "<li class='page-item'><span class='page-link' href='"+(endNum+1) + "'><i class='fa-solid fa-angle-right'></i></span></li>";
				}

				str += "</ul></div>";
				console.log(str);
				
				replyPageFooter.insertAdjacentHTML("beforeend", str);
			}
		
		})
	}
	

	
	/* 수정모달에서 댓글 읽어오기 */
	function readReplyAndSetModalForm(replyId) {
		fetch(ctx + "/academy/reply/get/" + replyId)
		.then(res => res.json())
		.then(reply => {
			document.querySelector("#modifyReplyInput").value = reply.ab_replyContent;
		});
	} 
	
	/* 댓글 수정 */
	document.querySelector("#modifyFormModalSubmitButton").addEventListener("click", function() {
	const ab_replyContent = document.querySelector("#modifyReplyInput").value;
	const ab_replyNumber = this.dataset.replyId;
	const data = {ab_replyNumber, ab_replyContent};
	
	fetch(`\${ctx}/academy/reply/modify`, {
		method : "put",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => {
		document.querySelector("#replyMessage").innerText = data.message;})
	.then(() => listReply(page));
}); 
	
	/* 댓글 삭제 */
	document.querySelector("#removeConfirmModalSubmitButton").addEventListener("click", function() {
		//댓글 삭제 버튼은 여러개고 모달창의 삭제버튼은 하나이므로
		//삭제할 댓글의 삭제버튼의replyID를 가져올 수 있어(아래 setAttribute로 부여)
	 //모달 삭제버튼에 전달하고 해당 replyID의 댓글 삭제 진행
	removeReply(this.dataset.replyId);
	});
	

	
	/* 댓글 삭제 */
	function removeReply(replyId) {

	fetch(ctx + "/academy/reply/remove/" + replyId, {
		method: "delete"
	})
	.then(res => res.json())
	.then(data => document.querySelector("#replyMessage").innerText = data.message)
	.then(() => listReply(page));
}
	
	/* 댓글 입력 버튼 */
	document.querySelector("#replySendButton").addEventListener("click", function() {
		const ab_number = document.querySelector("#ab_number").value;
		const ab_replyContent = document.querySelector("#ab_replyContent").value;
		const member_userId = document.querySelector("#member_userId").value;
		
		const data = {
			ab_number,
			ab_replyContent,
			member_userId
		};
		
		fetch(`\${ctx}/academy/reply/add`, {
			method : "post",
			headers : {
				"Content-Type" : "application/json"
			},
			body : JSON.stringify(data)
		})
		.then(res => res.json())
		.then(data => {
			document.querySelector("#ab_replyContent").value = "";
		})
		.then(() => listReply(page));
	});
	
	/* 좋아요 버튼 */
	document.querySelector("#likeButton").addEventListener("click", function() {
	const boardId = document.querySelector("#ab_number").value;
	
	fetch(`\${ctx}/academy/like`, {
		method : "put",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify({ab_number})
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
	
	
</script>



</body>
</html>