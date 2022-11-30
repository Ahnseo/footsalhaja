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
<title>회원가입</title>
</head>
<body>
<my:navbar active="insert"></my:navbar>
<!--현재 member테이블 의 컬럼들 
( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) 
-->
<div class="container">
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
				개인ID/팀ID 
					<select name="permission" >
						<option value="0" selected="selected">개인용 ID</option>
						<option value="1">팀전용 ID</option>
					</select>
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
	-- member table 새로 만들어서 해봤는데요. DB저장 됩니당. 
	-- 각자 jdbc에서, member table 수정 하시고 해보세요 , 그리고.. 어떻게 더 수정해야할까요 
	
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
	  `permission` int(1) NOT NULL DEFAULT 0,
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