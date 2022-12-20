<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
<input type="hidden" id="userIdVal" value="${qna.userId}" readonly >
<input type="hidden" id="qnaIdVal" value="${qna.qnaId}"readonly>

	<div class="container-sm">
	
		<div id="freeTitle">
			<h2>문의수정</h2>
		</div>
		<form action="" method="post">
		<input id="formControlInput2" class="form-control" type="hidden" name="category" value="${qna.category}" readonly>
			<!-- 문의 번호, 제목, 카테고리, userId, 작성일시, 좋아요, 처리상태   -->
			<div class="post_wrap">
				<div class="post_top">
					<p class="top_category">문의번호 ${qna.qnaId } </p>
					<p class="top_category">${qna.category } </p>	
					<p class="top_category"> 
						<c:if test="${qna.status == '답변대기'}"><span>${qna.status}</span></c:if>
						<c:if test="${qna.status != '답변대기'}"><span>${qna.status}</span></c:if>	
					</p>
					
					<ul>
						<li><i class="fa-solid fa-envelope"></i></li>
						<li class="top_nickName"><i class="fa-solid fa-user"></i> ${qna.userId } </li>
						<li class="top_nickName"><i class="fa-regular fa-clock"></i> ${qna.ago } </li>
						<li class="top_nickName"><i class="fa-regular fa-heart"></i> ${qna.likeCount } </li>
					</ul>
					
					<div class="top_title">
						<label for="" class="form-label">제목</label>
						<input id="" class="form-control" name="title" value="${qna.title }" />
					</div>
					
				</div><!-- </div class = "post_top" -->
				
				<!-- 문의 본문  -->
				<div class="top_content">
					<label for="" class="form-label">내용</label>
					<textarea id="" class="form-control" name="content">${qna.content}</textarea>
				</div>
				<div class = "d-flex flex-row-reverse">
					<!-- 삭제 / 수정 완료버튼  -->
					<button class="btn btn-danger btn-m5" type="button" id="deleteQnABtn" >삭제</button>
					<button class="btn btn-success btn-m5"  type="submit" id="" >수정완료</button>
				</div>
			</div>
			
			
		</form>
		
	</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

document.querySelector("#deleteQnABtn").addEventListener("click", function (){
	const qnaId = document.querySelector("#qnaIdVal").value;
	const userId = document.querySelector("#userIdVal").value;
	const data = {qnaId, userId}
	
	fetch( ctx + "/qna/deleteMyQnA", {
		method : "delete",
		headers : {"Content-Type" : "application/json"},
		body : JSON.stringify(data)
	})
	.then(res => res.text())
	.then(redirectPath => location.href = ctx+redirectPath)
});

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>