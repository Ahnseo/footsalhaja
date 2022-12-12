<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="myInfo" tagdir="/WEB-INF/tags" %>
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
<title>좋아요한 글 목록</title>
</head>
<body>
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container">
	<div class="row">
		<div class="col">
			<h3>${userId}님이 좋아요한 글 목록 입니다.</h3>
			<table class="table">
				<thead>		
					<th>아카데미 게시판 글 제목</th>
					<th>아카데미 게시판 글 작성날짜</th>
				</thead>
				<tbody>
					<c:forEach items="${usrAbLikeList}" var="likeAbList">
						<tr>	
 						 	<td>
								<c:url value="/academy/get" var="getLink">
									<c:param name="ab_number" value="${likeAbList.ab_number}"></c:param>
								</c:url> 
								<a class='move' href="${getLink }">${likeAbList.ab_title} </a>
							</td> 
						 	<td>${likeAbList.ab_insertDatetime}</td>					 	
					</c:forEach>
				</tbody>
			</table>
			<table class="table">
				<thead>	
					<th>자유게시판 글 제목</th>
					<th>자유게시판 글 작성날짜</th>
				</thead>
				<tbody>
					<c:forEach items="${userFbLikeList}" var="likeFbList">
						<tr>
 						 	<td>
								<c:url value="/free/get" var="getLink">
									<c:param name="number" value="${likeFbList.fb_number}"></c:param>
								</c:url> 
								<a class='move' href="${getLink }">${likeFbList.fb_title} </a>
							</td> 
						 	<td>${likeFbList.fb_insertDatetime}</td>					 	
					 	</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
		
		
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>