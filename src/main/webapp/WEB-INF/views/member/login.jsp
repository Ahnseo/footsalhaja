<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>      
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
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');
	#freeTitle h2 {
		text-align: center;
		padding: 60px;
	}	
	.btn-m5{
		margin : 5px;
	}
</style>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

</head>
<body>
<my:navbar active="login"></my:navbar>

<div class="container-sm " style="height: 750px">
	<div class="row justify-content-center">
		<div class="col-5">
			<div id="freeTitle">
				<h2>로그인</h2>
			</div>
			<form action="" method="post">
				
				<div class="form-floating p-1">
				    <input type="text" class="form-control" id="floating1" name="username" placeholder="ID">
				    <label for="floating1">ID</label>
				</div>
				
				<div class="form-floating p-1">
				    <input type="password" class="form-control" id="floating2" name="password" placeholder="Password">
				    <label for="floating2">Password</label>
				</div>
				<div class="p-1">
					<input type="checkBox" name="remember-me" > Remember Me <br>
				</div>
				
				<%--  <sec:csrfInput/> 모든 페이지에 넣어야한다.. 하지만 복잡해서 지금은 안쓰겟다.  --%>
				<div class="d-flex" style="justify-content : center ">
					<button type="submit" class="btn btn-primary m-1" >로그인</button>
				</div>
			</form>
			
			<form action="${pageContext.request.contextPath}/member/insert" >
				<div class="d-flex" style="justify-content : center ">
					<button type="submit" class="btn btn-primary m-1" >회원가입</button>
				</div>
				
			</form>
		</div>
	</div>
</div>
<my:footer></my:footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>