<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
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
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

<style>
@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 400;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 700;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.ttf') format('truetype')
}

@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 300;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.ttf') format('truetype');
}
.container-sm { 
	font-family: 'NanumBarunGothic';
	letter-spacing: -1px;
	font-size: 16px;
}
#freeTitle h2 {
	text-align: center;
	padding: 60px;
}	
.btn-m5{
	margin : 5px;
}
</style>


</head>
<body>
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active="insert"></my:navbar>

<!-- 전체 컨테이너 -->
<div class="container-sm">
	<h3>회원가입</h3>
	<div class="row">
		<div class="col-5">
			<form action="" method="post">
				ID
				<div class="input-group mb-3">
			      <input type="text" class="form-control" name="userId"  placeholder="ID" aria-label="" aria-describedby="button-addon1">
			      <button class="btn btn-primary" type="button" id="button-addon1">ID중복확인</button>
			    </div>
			    
			    Password
			    <div class="input-group mb-3">
			      <input type="password" class="form-control" name="password"  placeholder="Password" aria-label="Password" aria-describedby="">
			    </div>
			    
			    이름
			    <div class="input-group mb-3">
			      <input type="text" class="form-control" name="name"  placeholder="이름" aria-label="" >
			    </div>
			    
				성별
				<select class="input-group mb-3 form-control" name="personalGender" >
					<option value="M" selected="selected">남자</option>
					<option value="F">여자</option>
				</select>
				
				닉네임 
				<div class="input-group mb-3">
			      <input type="text" class="form-control" name="nickName"  placeholder="닉네임" aria-label="" >
			    </div>

				Email	
				<div class="input-group mb-3">
			      <input type="email" class="form-control" name="email"  placeholder="Email" aria-label="" >
			    </div>			
				
				생년월일 
				<div class="d-flex">
					<select class="input-group mb-3 form-control mr-2" id="birthYY" name="birthYY" >
					  <option value="">년</option>
					  <c:forEach var="i" begin="1990" end="2023">
					    <option value="${i}">${i}</option>
					  </c:forEach>
					</select>
					  
					<select class="input-group mb-3 form-control mr-2" id="birthMM" name="birthMM" >
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
					  
					<select class="input-group mb-3 form-control  mr-2" id="birthDD" name="birthDD" >
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
				</div>	
				
				
				활동지역 
				<div class="input-group mb-3">
			      <input type="text" class="form-control" name="activityArea"  placeholder="활동지역" aria-label="" >
			    </div>
				
				
				전화번호 
				<div class="input-group mb-3">
			      <input type="text" class="form-control" name="phone"  placeholder="전화번호" aria-label="" >
			    </div>
			
				<div class="d-flex flex-row-reverse">
					<button class="btn btn-primary" type="submit">회원가입</button>
				</div>
			</form>
		</div>
	</div>
</div>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>