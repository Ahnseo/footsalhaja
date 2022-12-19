<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="myInfo" tagdir="/WEB-INF/tags" %>
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

.nanumbarungothic * {
 font-family: 'NanumBarunGothic', sans-serif;
}

li {
   list-style:none;
  }
  
.container-sm { 
	font-family: 'NanumBarunGothic';
	letter-spacing: -1px;
}

/* 작성한 댓글 목록 */
#userReplyTitle h3 {
	text-align: center;
	padding: 60px;
 }
 

 
 /* 카테고리 */
#categoryBox {
	text-align: left;
	margin: 10px;
}

#categoryBox .cateBtn {
	border: 0;
	background : 0;
	font-size: 25px;
	margin: 0 20px;
}

#categoryBox .cateBtn:hover {
	color: green;
	font-weight: bold;
	text-decoration: underline;
}

.clickCateBtn {
 	color: lightgreen;
	font-weight: bold;
	text-decoration: underline;
 }

/* 글목록 */
#listBox .table{
	font-size: 16px;
	letter-spacing: -1px;
	text-align: center;
}

#listBox .table .listTitle {
	text-align: left;
}

#listBox .table tr td {
	height: 60px;
	vertical-align: middle;
}

#listBox .table tr td a {
 	text-decoration: none;
 	color: #333;
 	padding: 15px;
 }

/* 검색 페이징 글작성버튼 */
#bottomBox{
	margin: 30px 0;
	text-align: center;
	position: relative;
	
}
#bottomBox .searchBox{
	display: inline-block;
	position: absolute;
	top: 0;
	left: 0;
}
#bottomBox .paginationBox{
	display: inline-block;
	margin-top: 60px;
}
#bottomBox .insertBox{
	display: inline-block;
	position: absolute;
	top: 0;
	right: 0;
}



</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<body>
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container-sm">
	<div id="userReplyTitle">
		<h3>${userId}님이 작성한 댓글 <i class="fa-regular fa-comment-dots"></i></h3>
	</div>
	<div id="categoryBox" >
<<<<<<< HEAD
=======

>>>>>>> main
		<a id ="bookBtn" href="#categoryBox"><button type="button" class="btn btn-outline-success">예약 (${countActivity.countMainReplyList})</button></a>
		<a id ="academyBtn" href="#academy"><button type="button" class="btn btn-outline-success">아카데미 (${countActivity.countAbReplyList})</button></a>
		<a id ="freeBtn" href="#freeBoard"><button type="button" class="btn btn-outline-success">자유게시판 (${countActivity.countFbReplyList})</button></a>
	</div>		
<!-- 글목록 -->


	<div id="listBox" >
		<div id="book">
			<table class="table table-hover container">
				<thead>
					<tr scope="row">
						<th>예약게시판 댓글내용</th>
						<th>예약게시판 댓글 작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userMainReplyList}" var="replyMainList">
<<<<<<< HEAD
=======

>>>>>>> main
						<c:url value="/main/get" var="getLink">
							<c:param name="bookId" value="${replyMainList.book_bookId}"></c:param>
						</c:url> 
						<tr onclick="location.href='${getLink}'" class="trtr">
 						 	<td class="listTitle col-sm-6">
								<i class="fa-regular fa-comment-dots"></i><a class='move' href="${getLink }">${replyMainList.replyContent} </a>
							</td> 
						 	<td>${replyMainList.ago}</td>					 	
<<<<<<< HEAD
=======

>>>>>>> main
					 	</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div id="listBox" >		
		<div id="academy">
			<table class="table table-hover container">
				<thead>
					<tr scope="row">		
						<th>아카데미 게시판 댓글내용</th>
						<th>아카데미 게시판 댓글 작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userAbReplyList}" var="replyAbList">
<<<<<<< HEAD
=======

>>>>>>> main
						<c:url value="/academy/get" var="getLink">
							<c:param name="ab_number" value="${replyAbList.ab_number}"></c:param>
						</c:url> 
						<tr onclick="location.href='${getLink}'" class="trtr">	
						 	<td class="listTitle col-sm-6">
							<i class="fa-regular fa-comment-dots"></i><a class='move' href="${getLink }">${replyAbList.ab_replyContent} </a>
						</td> 
					 	<td>${replyAbList.ago}</td>					 	
<<<<<<< HEAD
=======

>>>>>>> main
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div id="listBox" >	
		<div id="freeBoard">
			<table class="table table-hover container">
				<thead>
					<tr scope="row">
						<th>자유게시판 댓글내용</th>
						<th>자유게시판 댓글 작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${userFbReplyList}" var="replyFbList">
						<c:url value="/free/get" var="getLink">
							<c:param name="number" value="${replyFbList.freeBoard_fb_number}"></c:param>
						</c:url> 
						<tr onclick="location.href='${getLink}'" class="trtr">	
							<td class="listTitle col-sm-6">
								<i class="fa-regular fa-comment-dots"></i><a class='move' href="${getLink }">${replyFbList.fb_replyContent} </a>
							</td> 
						 	<td>${replyFbList.ago}</td>					 	
<<<<<<< HEAD
=======

>>>>>>> main
					 	</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>	
	</div>	
</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
		<script type="text/javascript">
			$(".btn btn-default").click(function(event){
				x = $(this).attr("href");
				$("html, body").stop().animate({ scrollTop : $(x).offset().top - 130}, 1000, "easeInOutExpo");
			});
		
		
		</script>



</body>
</html>