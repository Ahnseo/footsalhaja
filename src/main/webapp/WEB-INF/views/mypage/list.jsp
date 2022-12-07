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
<title>회원목록</title>
</head>
<body>
<!--현재 myInfo테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container">
	<div class="row">
		<div class="col">
			<h3>${myInfo.userId}님의 마이페이지 입니다.</h3>
			<table class="table">
				<thead>		
					<th>userId</th>
					<th>Password</th>
					<th>성별</th>
					<th>이름</th>
					<th>닉네임</th>
					<th>Email</th>
					<th>생년월일</th>
					<th>활동지역</th>
					<th>전화번호</th>
					<th>회원권한(개인/팀)</th>
				</thead>
				<tbody>
					<c:url value="/mypage/get" var="myInfoGetLink">
						<c:param name="userId" value="${myInfo.userId}"/>
					</c:url>
					<tr>	
					 	<td>
					 		<a href="${myInfoGetLink}">${myInfo.userId}</a>
					 	</td>
					 	<td>${myInfo.password}</td>
					 	<td>${myInfo.personalGender}</td>
					 	<td>${myInfo.name}</td>
					 	<td>${myInfo.nickName}</td>
					 	<td>${myInfo.email}</td>
					 	<td>${myInfo.birthYY}-${myInfo.birthMM}-${myInfo.birthDD}</td>
					 	<td>${myInfo.activityArea}</td>
					 	<td>${myInfo.phone}</td>
					 	<td>${myInfo.permission}</td>
				 	</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>