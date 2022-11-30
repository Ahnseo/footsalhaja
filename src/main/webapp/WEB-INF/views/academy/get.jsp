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


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>