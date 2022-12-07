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
<title>회원가입</title>
</head>
<body>
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active="insert"></my:navbar>
<div class="container">
	<h3>회원가입</h3>
	<div class="row">
		<div class="col">
			<form action="" method="post">
				ID <input type="text" name="userId" id="">
				<br>
				비밀번호 <input type="text" name="password" id="">
				<br>
				이름 <input type="text" name="name" id="">
				<br>
				성별 <select name="personalGender" >
						<option value="M" selected="selected">남자</option>
						<option value="F">여자</option>
					</select>
				<br>
				닉네임 <input type="text" name="nickName" id="">
				<br>
				Email <input type="email" name="email" id="">
				<br>
				
				생년월일 
				<select id="birthYY" name="birthYY" >
				  <option value="">년</option>
				  <c:forEach var="i" begin="1990" end="2023">
				    <option value="${i}">${i}</option>
				  </c:forEach>
				</select>
				  
				<select id="birthMM" name="birthMM" >
				  <option value="">월</option>
				  <c:forEach var="i" begin="1" end="12">
					  <c:choose>
					      <c:when test="${i lt 10 }">
					          <option value="0${i}">0${i}</option>
					      </c:when>
					      <c:otherwise>
					          <option value="${i}">${i}</option>
					      </c:otherwise>
					  </c:choose>
				  </c:forEach>
				</select>
				  
				<select id="birthDD" name="birthDD" >
				  <option value="">일</option>
				  <c:forEach var="i" begin="1" end="31">
				  <c:choose>
				      <c:when test="${i lt 10 }">
				          <option value="0${i}">0${i}</option>
				      </c:when>
				      <c:otherwise>
				          <option value="${i}">${i}</option>
				      </c:otherwise>
				  </c:choose>
				  </c:forEach>
				</select>
				<br>
				
				활동지역 <input type="text" name="activityArea" id="">
				<br>
				전화번호 <input type="text" name="phone" id="">
				<br>
				
				<input type="submit" value="등록">
			</form>
		</div>
	</div>
</div>	
<div>
	<textarea name="" id="" cols="300" rows="100">
	### 권한 사용하기 위해 member 테이블 컬럼변경  permission => auth (user/manager/admin) ###
	예시) member.auth = admin 일 때만, 버튼 보이게하기 ! 
    	sec:authorize access="hasAuthority('admin')">
			<button type="button" class="btn btn-danger">블랙리스트</button>
		sec:authorize>
	
	CREATE TABLE `member` (
			  `userId` varchar(50) NOT NULL,
			  `name` varchar(45) NOT NULL,
			  `password` varchar(255) NOT NULL,
			  `nickName` varchar(45) NOT NULL,
			  `email` varchar(45) NOT NULL,
			  `birthYY` int(11) NOT NULL,
			  `birthMM` int(11) NOT NULL,
			  `birthDD` int(11) NOT NULL,
			  `activityArea` varchar(45) NOT NULL,
			  `phone` varchar(45) NOT NULL,
			  `profileImage` varchar(255) DEFAULT NULL,
			  `personalGender` char(1) NOT NULL,
			  `auth` char(45) DEFAULT 'user',
			  `insertDateTime` datetime NOT NULL DEFAULT current_timestamp(),
			  PRIMARY KEY (`userId`),
			  UNIQUE KEY `nickName_UNIQUE` (`nickName`),
			  UNIQUE KEY `email_UNIQUE` (`email`),
			  UNIQUE KEY `phone_UNIQUE` (`phone`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
	
	</textarea>
</div>
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>