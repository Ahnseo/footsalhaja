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




<style>
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');
	.btn-m5{
		margin : 5px;
	}
	.listHover:hover {
		background-color: #D3D3D3;
		cursor: pointer;
	}
</style>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" type="text/css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

</head>
<body>
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active=""></my:navbar>
<section class="page-section" id="contact">
	<div class="container">
		 <!-- Contact Section Heading-->
		 <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">${member.userId}님의 회원정보</h2>
		 <!-- 권한은 List로 추가, 삭제한다. [ user AND ( manager OR admin) ] 회원은 여러 권한을 갖을 수 있다 . 하지만, 권한참조테이블 따로만들기 싫어서 그냥 하련다 .. -->


         
         <div class="row justify-content-center">
        	<div class="col-lg-8 col-xl-7">
        		<sec:authorize access="hasAnyAuthority('admin', 'manager')">
				 	<form action="${pageContext.request.contextPath}/member/addAuth" method="post">	
						<input type="hidden" name="userId" value="${member.userId}">
						<div class="d-flex mb-2">
							<div class="col-8">
							<select class="form-control " name="auth" id="addAuth">
								<option value="" disabled selected >회원권한선택</option>
								<option value="user">일반회원</option>
								<sec:authorize access="hasAuthority('admin')">
								<option value="manager">매니저</option>
								</sec:authorize>
								<option value="black">블랙리스트</option>
							</select>
							</div>
							<div class="col-1"></div>
							<div class="col-3">
							<button type="submit" class="btn btn-warning ">권한변경</button>
							</div>
						</div>
					</form>
				</sec:authorize>
				<form id="contactForm" data-sb-form-api-token="API_TOKEN">	
				<!-- ID -->
				<div class="form-floating mb-3">
					<input class="form-control" id="userId" type="text"
						name="userId" value="${member.userId}"
						data-sb-validations="required" readonly /> <label for="userId">ID</label>
				</div>

				<!-- 비밀번호 -->
				<div class="form-floating mb-3">
					<input class="form-control" id="password" type="password"
						name="password" value="${member.password}"
						data-sb-validations="required" readonly/> <label for="password">비밀번호</label>
				</div>

				<!-- 이름 -->
				<div class="form-floating mb-3">
					<input class="form-control" id="name" type="text" name="name"
						value="${member.name}" data-sb-validations="required" readonly />
					<label for="name">이름</label>
				</div>

				<!-- 성별 -->
				<div class="form-floating mb-3">
					<input class="form-control" id="personalGender" type="hidden" name="personalGender" value="${member.personalGender}" data-sb-validations="required" readonly /> 
					<label for="personalGender">성별</label>
					<c:if test="${member.personalGender eq 'M'}">
						<input class="form-control" type="text"  value="남자" data-sb-validations="required" readonly /> 
					</c:if>
					<c:if test="${member.personalGender eq 'F'}">
						<input class="form-control" type="text"  value="여자" data-sb-validations="required" readonly /> 
					</c:if>
				</div>
				<!-- 닉네임 -->
				<div class="form-floating mb-3">
					<input class="form-control" id="nickName" type="text"
						name="nickName" value="${member.nickName}"
						data-sb-validations="required" readonly/> <label for="nickName">닉네임</label>
				</div>

				<!-- 회원권한-->
				<input type="hidden" name="auth" value="${member.auth}" readonly >
				<div class="form-floating mb-3">
				<c:if test="${member.auth eq 'user'}">
					<input class="form-control" id="permission" type="text" name="permission" value="일반회원" data-sb-validations="required" readonly /> 
				</c:if>
				<c:if test="${member.auth eq 'manager'}">
					<input class="form-control" id="permission" type="text" name="permission" value="매니저" data-sb-validations="required" readonly /> 
				</c:if>
				<c:if test="${member.auth eq 'black'}">
					<input style="color : red;" class="form-control" id="permission" type="text" name="permission" value="블랙리스트" data-sb-validations="required" readonly /> 
				</c:if>	
				<c:if test="${member.auth eq 'admin'}">
					<input class="form-control" id="permission" type="text" name="permission" value="관리자" data-sb-validations="required" readonly /> 
				</c:if>	
					<label for="permission">회원권한</label>
				</div>
	
				<!-- 이메일 -->
				<div class="form-floating mb-3">
					<input class="form-control" id="email" type="email" name="email" value="${member.email}" data-sb-validations="required" readonly/>
					<label for="email">메일주소</label>
				</div>
				
				<!-- 생년월일  -->
				<div class="form-floating mb-3">
					<c:if test="${member.birthMM < 10}">
						<c:set var="zeroMM" value="0"/>
					</c:if>
					<c:if test="${member.birthDD < 10}">
						<c:set var="zeroDD" value="0"/>
					</c:if>

					<input class="form-control" type="text" id ="birthYYMMDD"name="birthYY" value="${member.birthYY}${zeroMM}${member.birthMM}${zeroDD}${member.birthDD}" readonly /> 
					<label for="birthYYMMDD">생년월일</label>
				</div>

				<div class="form-floating mb-3">
					<input class="form-control" type="text" name="activityArea"
						value="${member.activityArea}" readonly /> <label
						for="activityArea">활동지역</label>
				</div>

				<div class="form-floating mb-3">
					<input class="form-control" id="phone" type="text" name="phone"
						value="${member.phone}" data-sb-validations="required" readonly /> <label
						for="phone">전화번호</label>
				</div>
					
				</form>
						
			</div>
		</div>
	</div>	
	
	<my:footer></my:footer>
	
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = ${pageContext.request.contextPath};





</script>


</body>
</html>