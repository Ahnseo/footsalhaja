<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
	<h1>${board.ab_number }번 게시물 수정</h1>
	
	<form id="modifyForm" action="" method="post">
	<input type="hidden" name="ab_number" value="${board.ab_number }">
	
	제목 <input type="text" name="ab_title" value="${board.ab_title }"> <br>
	  
	말머리 <select name="ab_category">
        <option value="lesson">레슨</option>
        <option value="tip">꿀팁</option>
        <option value="recruitment">팀원모집</option>
        <option value="qna">질문/답변</option>
    </select>
    
    <br>
	
	본문 <textarea name="ab_content">${board.ab_content }</textarea> <br>
	
	작성자 <input type ="text" value="${board.member_userId }" readonly> <br>
	작성일시 <input type = "datetime-local" value = "${board.ab_insertDatetime }" readonly>
	</form>
	
	<input type="submit" value="수정" data-bs-toggle="modal"
		data-bs-target="#modifyModal">
	
	<!-- 삭제버튼 -->
	<c:url value ="/academy/remove" var="removeLink"></c:url>
	
	<form  id="removeForm" action="${removeLink }" method="post">
		<input type="hidden" name="ab_number" value="${board.ab_number }">
	</form>
	
	<input type="submit" value="삭제" data-bs-toggle="modal"
		data-bs-target="#removeModal">
	
	

	<!-- modify Modal 수정 확인 -->
	<div class="modal fade" id="modifyModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">수정하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button id="modifyConfirmButton" type="button"
						class="btn btn-primary">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- remove Modal 삭제확인 -->
	<div class="modal fade" id="removeModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button id="removeConfirmButton" type="button"
						class="btn btn-danger">확인</button>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>


<!-- 수정&삭제 확인 모달  -->
	<script>
		document.querySelector("#modifyConfirmButton").addEventListener(
				"click", function() {
					document.querySelector("#modifyForm").submit();
				})

		document.querySelector("#removeConfirmButton").addEventListener(
				"click", function() {
					document.querySelector("#removeForm").submit();
				})
	</script>


</body>
</html>