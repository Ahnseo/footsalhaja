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
	<div class="container">
		<div class="row">
			<div class="col">
				<sec:authentication property="name" var="userIdValue"/>
				<h3>문의번호:${qna.qnaId}</h3> 
				<!-- 데이터 불러오기  -->
				<form action="" method="post">
					<input type="hidden" name="qnaId" id="qnaId" value="${qna.qnaId}">
					카테고리 <input type="text" name="category" value="${qna.category}" readonly ><br>
					제목 <input type="text"name="title" value="${qna.title}" readonly ><br>
					본문 <textarea name="content" readonly >${qna.content}</textarea><br>
					아이디 <input type="text" name="userId" value="${qna.userId}"><br>
					처리상태 <input type="text" name="status" value="${qna.status} " readonly ><br>
					작성시간 <input type="text" name="insertDatetime" value="${qna.insertDatetime} " readonly ><br>
				</form>
				
				<!-- 수정 삭제 버튼 -->  
				<div class = "d-flex">
					<button type="button" id="likeBtn1">좋아요</button>
					
					<form action="" method="">
						<button type="sumbit" id="" >수정</button>
					</form>
					
					<form action="" method="">
						<button type="sumbit" id="" >삭제</button>
					</form>
				</div>
				<!-- 답변하기 post -> controller -->
				
				<sec:authorize access="hasAuthority('admin')">
					<div>
					    <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#qnaReplyDiv" aria-expanded="false" aria-controls="collapseExample">
					    	답변하기
					    </button>
			    	</div>
					<div class="collapse" id="qnaReplyDiv">
						<div class="card card-body">
							<input type="hidden" id="qnaReplyQnAId" value="${qna.qnaId}">
							<input type="hidden" id="qnaReplyUserId" value="${qna.userId}">
							답변<textarea id="qnaReplyContent" cols="50" rows="5"></textarea>
							작성자 <input type="text" value="${userIdValue}" readonly>
							<div>
								<button type="button" id="qnaReplyBtn">등록</button>
							</div>
						</div>
					</div>
				</sec:authorize>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";\
	<!-- 좋아요 기능 -->
	document.querySelector("#likeBtn1").addEventListener("click", function(){
		const qnaId = document.querySelector("#qnaId").value;
		fetch(ctx + "/qna/likeCount", { 
			method : "put",
			headers : { "Content-Type" : "application/json" },
			body : JSON.stringify({qnaId : qnaId})
		})
		
	});
	
	<!-- 답변 기능 -->
	document.querySelector("#qnaReplyBtn").addEventListener("click", function() {
		const qnaId = document.querySelector("#qnaReplyQnAId").value;
		const userId = document.querySelector("#qnaReplyUserId").value;
		const content = document.querySelector("#qnaReplyContentId").value;
		const data = {qnaId, content};
		fetch(ctx + "/qnaReply/add", { method : "put",
									    headers : { "Content-Type" : "application/json" },
									    body : JSON.string(data)
		})
		.then(res => res.json())
		.then(data => )
	});
	
</script>
</body>
</html>