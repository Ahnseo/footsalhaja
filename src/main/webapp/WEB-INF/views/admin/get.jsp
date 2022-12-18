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
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/footsalhaja/src/main/resources/assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
	
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" type="text/css" rel="stylesheet" />
	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

<style>
	.btn-m5{
		margin : 5px;
	}
	.listHover:hover {
		background-color: #D3D3D3;
		cursor: pointer;
	}
	
</style>

</head>
<body>
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active=""></my:navbar>

<div class="container">
	<div class="row">
		<div class="col">
			<h3>${member.userId}님의 회원정보</h3>
			<c:url value="/member/modify" var="modifyLink">
				<c:param name="userId" value="${member.userId}"/>
			</c:url>
			<form action="${modifyLink}" method="get">	
				ID <input type="text" name="userId" value="${member.userId}" readonly >
				<br>
				비밀번호 <input type="text" name="password" value="${member.password}" readonly >
				<br>
				이름 <input type="text" name="name" value="${member.name}" readonly >
				<br>
				성별 <input type="text" name="personalGender" value="${member.personalGender}" readonly >
				<br>
				닉네임 <input type="text" name="nickName" value="${member.nickName}" readonly >
				<br>
				개인ID/팀ID <input type="text" name="permission" value="${member.permission}" readonly >
				<br>
				Email <input type="email" name="email" value="${member.email}" readonly >
				<br>
				생년월일<br>
				<input type="text" name="birthYY" value="${member.birthYY}" readonly >년 
				<input type="text" name="birthMM" value="${member.birthMM}" readonly >월
				<input type="text" name="birthDD" value="${member.birthDD}" readonly >일

				<br>
				활동지역 <input type="text" name="activityArea" value="${member.activityArea}" readonly >
				<br>
				전화번호 <input type="text" name="phone" value="${member.phone}" readonly >
				<br>
			</form>
			
			<form action="">
				<h3>${member.userId}님에게 쪽지보내기 넣을까?</h3>
				<h3>매너지수(좋이요,나빠요, 블랙리스트 여부 )</h3>
			
			</form>
		</div>
	</div>
</div>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>



</body>
</html>