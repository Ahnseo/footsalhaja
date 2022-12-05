<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<body>
<my:navbar></my:navbar>


	<h1>프리보드 ${board.fb_number }번 게시물 수정</h1>
	

	<form id="modifyForm" action="" method="post">

	<input type="hidden" name="fb_number" value="${board.fb_number}"/>
	카테고리 <select name="fb_category">
				<option>매칭후기</option>
				<option>구장후기</option>
				<option>잡담</option>
			</select><br>
	제목 <input type="text" name="fb_title" value="${board.fb_title }"/><br>
	본문 <textarea name="fb_content">${board.fb_content }</textarea><br>
	작성일시 <input type="datetime-local" value="${board.fb_insertDatetime}" readonly/><br>
	작성자 <input type="text" name="member_userId" value="${board.member_userId }" readonly/><br>
	</form>
	
	<input type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
		
	<c:url value="/free/remove" var="removeLink"></c:url>
	<form id="removeForm" action="${removeLink }" method="post">
		<input type="hidden" name="number" value="${board.fb_number }"/>
	</form>
	<input type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal"/>
	
	
	
	<!-- 수정 모달 -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        수정하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="modifyConfirmButton" type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 삭제 모달 -->
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


	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	// 수정확인 버튼 클릭하면 수정 form 전송
	document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
		document.querySelector("#modifyForm").submit();
	});
	
	// 삭제확인 버튼 클릭하면 삭제 form 전송
	document.querySelector("#removeConfirmButton").addEventListener("click", function() {
		document.querySelector("#removeForm").submit();
	});

</script>
</body>
</html>










