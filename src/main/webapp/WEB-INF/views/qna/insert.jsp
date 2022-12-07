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
	<my:navbar active="insert"></my:navbar>
	<div class="container">
		<div class="row">
			<div class="col">	
				<h1> 문의 내용을 작성하는 페이지 </h1>
				<form action="" method="post">
					<select name="category" class="form-select" aria-label="Default select example">
					  <option selected disabled >카테고리</option>
					  <option value="시설문의">시설문의</option>
					  <option value="신고/제재">신고/제재</option>
					  <option value="결제문의">결제문의</option>
					  <option value="기타문의">기타문의</option>
					</select>
					<br>
					<input type="text" name="title" value="" placeholder="제목" >
					<br>
					<textarea name="content" placeholder="본문" ></textarea>
					<br>
					<sec:authentication property="name" var="userIdValue"/>
					<input name="userId" value="${userIdValue}" readonly >
					<br>
					<input type="submit" value="문의하기">
				</form>
			</div>
		</div>
	</div>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>