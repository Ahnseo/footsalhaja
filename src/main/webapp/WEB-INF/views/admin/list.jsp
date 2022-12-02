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
<title>회원목록</title>
</head>
<body>
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active="memberList"></my:navbar>
<div class="container">
	<div class="row">
		<div class="col">
			<h3>여러개의 버튼만들예정 </h3>
			<p>회원목록 (=사용자목록 )) : /admin/list.jsp </p>
			<p>운영진 설정 </p>
			<p>메일발송 </p>
			<p>문자(SMS )발송 </p>
			<p></p>
			<table class="table">
				<thead>
					<th>#status</th>
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
					 <c:forEach items="${memberList}" var="member" varStatus="st">
					 <c:url value="/admin/get" var="getLink">
					 	<c:param name="userId" value="${member.userId}"/>
					 </c:url>
							<tr>
							 	<td>${st.count}</td>
							 	<td>
							 		<a href="${getLink}">${member.userId}</a>
							 	</td>
							 	<td>${member.password}</td>
							 	<td>${member.personalGender}</td>
							 	<td>${member.name}</td>
							 	<td>${member.nickName}</td>
							 	<td>${member.email}</td>
							 	<td>${member.birthYY}-${member.birthMM}-${member.birthDD}</td>
							 	<td>${member.activityArea}</td>
							 	<td>${member.phone}</td>
							 	<td>${member.permission}</td>
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