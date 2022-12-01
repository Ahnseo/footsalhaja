<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
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
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active=""></my:navbar>

<h3>${member.userId}님의 회원정보</h3>
<div class="container">
	<div class="row">
		<div class="col">	
			ID <input type="text" value="${member.userId}" readonly >
			<br>
			비밀번호 <input type="text" value="${member.password}" readonly >
			<br>
			이름 <input type="text" value="${member.name}" readonly >
			<br>
			성별 <input type="text" value="${member.personalGender}" readonly >
			<br>
			닉네임 <input type="text" value="${member.nickName}" readonly >
			<br>
			개인ID/팀ID <input type="text" value="${member.permission}" readonly >
			<br>
			Email <input type="email" value="${member.email}" readonly >
			<br>
			생년월일 <input type="text" value="${member.birthYY - member.birthMM - member.birthDD}" readonly >
			<br>
			활동지역 <input type="text" value="${member.activityArea}" readonly >
			<br>
			전화번호 <input type="text" value="${member.phone}" readonly >
		</div>
	</div>
</div>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>