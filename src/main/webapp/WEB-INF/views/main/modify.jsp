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


<div class="container-md">
	<div class="row">
		<div class="col">
		
			<h1>no.${main.bookId } 수정</h1>
	
			<form id="modifyForm" action="" method="post">
				<input type="hidden" name="bookId" value="${main.bookId }">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" name="stadiumTitle" value=" ${main.stadiumTitle }">		
					<label for="floatingInput">제목</label>
				</div>
				
				<div class="form-floating mb-3">
					<textarea class="form-control" name="content" style="resize: none; height: 100px" >${main.content}</textarea>
					<label for="floatingTextarea2">본문</label>
				</div>
				
				<div class="form-floating mb-3">
					<input type="Date" class="form-control" name="bookDate" value="${main.bookDate }">
					<label for="floatingInput">경기일정</label>
				</div>
				<div class="mb-3">
					<select name="bookTime">
						<option value="">기존 예약 시간 : ${main.bookTime }</option>
						<option value="10-12시">10-12시</option>
					</select>
				</div>
				<div class="">
					<select name="location_locationId" id="">
						<option value="10">경기</option>
					</select>
				</div>
				
				<div class="form-floating mb-3">
					<input type="text" name="matchType" class="form-control"  placeholder="matchType" value="${main.matchType }">
					<label for="floatingInput">경기인원</label>
				</div>
		
				<div class="form-floating mb-3">
					<input type="text" name="level" class="form-control"  placeholder="level" value="${main.level }">
					<label for="floatingInput">수준</label>
				</div>
		
				<div class="form-floating mb-3">
					<input type="text" name="teamGender" class="form-control"  placeholder="teamGender" value="${main.teamGender }">
					<label for="floatingInput">성별</label>
				</div>
		
				<div class="form-floating mb-3">
					<input type="text" name="status"class="form-control"  placeholder="status" value="${main.status }">
					<label for="floatingInput">모집상태</label>
				</div>
	<input class="btn btn-warning" type="submit" value="수정완료" >  
			</form>
	
		<c:url value="/main/remove" var="removeLink"/>
		<form action="${removeLink }" method="post">		
		<input type="hidden" name="bookId" value="${main.bookId }">
		<input class="btn btn-danger" type="submit" value="삭제하기">
		</form>

		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
/*  document.querySelector("#modifyConfirmButton").addEventListener("click", function(){
	document.querySelector("#modifyForm").submit();
});
document.querySelector("#removeConfirmButton").addEventListener("click", function({
	document.querySelector("#removeForm").submit();
}); */ 

</script>
</body>
</html>