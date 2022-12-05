<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:navbar></my:navbar>

<h1>no.${main.bookId } 수정</h1>
	
	<form id="modifyForm1" action="" method="post">
		<div class="mb-3">
			<label for="" class="form-label">제목</label>
			<input required="required" type="text" class="form-control" name="stadiumTitle" value=" ${main.stadiumTitle }">		
		</div>
		
		<div class="mb-3">
			<label for="" class="form-label">본문</label>
			<textarea required="required" rows="10" class="form-control" name="content">${main.content}</textarea>
		</div>
		
		<div class="mb-3">
			<input type="datetime-local" name="bookDatetime" value="${main.bookDatetime }"/>
		</div>
		
		<div class="mb-3">
			<input type="text" placeholder="경기장 주소 검색" >
			<button onclick="location='modifyAddress'" type="button" value="주소수정">주소수정</button>		
		</div>
		

		<div class="mb-3">
			<input type="text" name="matchType" placeholder="matchType" value="${main.matchType }">
		</div>

		<div class="mb-3">
			<input type="text" name="level" placeholder="level" value="${main.level }">
		</div>

		<div class="mb-3">
			<input type="text" name="teamGender" placeholder="teamGender" value="${main.teamGender }">
		</div>

		<div class="mb-3">
			<input type="text" name="status" placeholder="status" value="${main.status }">
		</div>

		<div>
			<label for="" class="form-label">
			</label>
			<input class="form-control-plaintext" type="text" readonly>
		</div>		
		<input type="submit" value="수정완료">
	</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
/* document.querySelector("#modifyConfirmButton").addEventListener("click", function(){
	document.querySelector("#modifyForm").submit();
});
document.querySelector("#removeConfirmBUtton").addEventListener("click", function({
	document.querySelector("#removeForm").submit();
}); */
</script>
</body>
</html>