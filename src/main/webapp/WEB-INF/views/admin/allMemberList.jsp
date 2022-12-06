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
<my:navbar active=""></my:navbar>
<div class="container">
	<h3>전체 회원 목록 </h3>
	<div class="row">
		<div class="col-md-10">
			<c:url value="/admin/allMemberList" var="allMemberListLink"></c:url>
			<form action="${allMemberListLink }" class="d-flex" role="search">
				<select name="t" id="searchTypeSelect" class="form-select">
		      		<option value="all">전체</option>
		      		<option value="userId" ${param.t == 'userId' ? 'selected' : '' }>ID</option>
		      		<option value="name" ${param.t == 'name' ? 'selected' : '' }>이름</option>
		      	</select>
				<input class="form-control me-2" type="search" name="q" value="${param.q }" placeholder="검색" aria-label="Search">
				<button class="btn btn-outline-success" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col">		
			<table class="table">
				<thead>
					<th>#</th>
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
					 <c:forEach items="${allMemberList}" var="member" >
					 <c:url value="/member/get" var="getLink">
					 	<c:param name="userId" value="${member.userId}"/>
					 </c:url>
							<tr>
							 	<td>${member.userId}</td>
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
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			  
			  	<!-- 맨앞 페이지 -->
			  	<c:if test="${memberPageInfo.currentPageNumber ne 1}">
				    <li class="page-item">
				      <c:url value="/admin/allMemberList" var="firstPageLink">   	
				     	<c:param name="page" value="1"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${firstPageLink}" aria-label="First">
				        첫 페이지
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 이전 10개의 페이지 ( 1 or 11 or 21 로 가기 ) -->
			    <c:if test="${memberPageInfo.hasPrevButton}">
				    <li class="page-item">
				      <c:url value="/admin/allMemberList" var="previousPageLink">
				     	<c:param name="page" value="${memberPageInfo.jumpPrevPageNumber}"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${previousPageLink}" aria-label="Previous">
				        이전
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 페이지 -->
			    <c:forEach begin="${memberPageInfo.leftPageNumber}" end="${memberPageInfo.rightPageNumber}" var="pageNumber">
			    	<li class="page-item">
				    	<c:url value="/admin/allMemberList" var="pageLink" >
					    	<c:param name="page" value="${pageNumber}"/>
					    	<c:param name="q" value="${param.q}"/>
					     	<c:param name="t" value="${param.t}"/>
				    	</c:url>
				    	<a class="page-link ${memberPageInfo.currentPageNumber eq pageNumber ? 'active' : ''}" href="${pageLink}">
				    		${pageNumber}
				    	</a>
				    </li>
			    </c:forEach>
			   
			    <!-- 다음 10개의 페이지 ( 11 or 21 or 31 로 가기 )-->
			    <c:if test="${memberPageInfo.hasNextButton}">
				    <li class="page-item">
				      <c:url value="/admin/allMemberList" var="nextPageLink">
				     	<c:param name="page" value="${memberPageInfo.jumpNextPageNumber}"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${nextPageLink}" aria-label="Previous">
				        다음
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 마지막 페이지 -->
			    <c:if test="${memberPageInfo.currentPageNumber ne memberPageInfo.lastPageNumber}">
				    <li class="page-item">
				      <c:url value="/admin/allMemberList" var="lastPageLink">  
				        <c:param name="page" value="${memberPageInfo.lastPageNumber}"/>
				        <c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${lastPageLink}" aria-label="Last">
				      	마지막 페이지
				      </a>
				    </li>
			    </c:if>
			  </ul>
			</nav>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>