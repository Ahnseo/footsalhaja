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
<title>내가 메인게시판에 쓴 글</title>
</head>
<body>
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container">
	<div class="row">
		<div class="col">
			<h3>${list.userId}님의 예약 리스트 </h3> 
			<table class="table">
				<thead>		
					<th>예약 날짜</th>
					<th>예약 시간</th>
					<th>제목</th>
					<th>모집상태</th>
					<th>예약장소</th>
					<th>매칭</th>
					<th>실력</th>
					<th>팀성별</th>

				</thead>
				<tbody>
					<c:forEach items="${list.userMainList}" var="mainlist">
						<tr>	
						 	<td>${mainlist.bookDate}</td>
						 	<td>${mainlist.bookTime}</td>					 	
						 	<td>
								<c:url value="/main/get" var="getLink">
									<c:param name="bookId" value="${mainlist.bookId}"></c:param>
								</c:url> 
								<a class='move' href="${getLink }">${mainlist.title} </a>
							</td>
						 	<td>${mainlist.status}</td>
						 	<td>${mainlist.stadiumName}</td>
						 	<td>${mainlist.matchType}</td>
						 	<td>${mainlist.level}</td>
						 	<td>${mainlist.teamGender}</td>

					 	</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

	<!-- 페이지네이션 -->
	<div class="row">
		<div class="col">
			<nav aria-label="Page navigation example">
			  <ul class="pagination">
			  
				  <!-- 첫페이지로 가는 버튼 : 1페이지일때 빼고 다 존재함 -->
				  <c:if test="${pageInfo.currentPageNumber != 1 }">
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  	<c:param name="userId" value="${list.userId}"></c:param>
					  	<c:param name="page" value="1"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">&laquo;</a></li>
				  </c:if>
				  
				  <!-- 이전 페이지 버튼 -->
				  <c:if test="${pageInfo.hasPrevButton}">
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  		<c:param name="userId" value="${list.userId}"></c:param>
					  		<c:param name="page" value="${ pageInfo.jumpPrevPageNumber}"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">이전</a></li>
				  </c:if>

				  <c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
				  	<c:url value="/mypage/myMainDocumentList" var="listLink">
				  	<c:param name="userId" value="${list.userId}"></c:param>
				  		<c:param name="page" value="${pageNumber }"></c:param>
				  	</c:url>
				  	
				  	<!-- 현재 페이지 active 클래스 추가 -->
				    <li class="page-item
				  		  ${ pageInfo.currentPageNumber == pageNumber ? 'active' : ''}
				    "><a class="page-link" href="${listLink }">${pageNumber }</a></li>
				  </c:forEach>
				  
				  <!-- 다음 페이지 버튼 -->
				  <c:if test="${pageInfo.hasNextButton}">
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  		<c:param name="userId" value="${list.userId}"></c:param>
					  		<c:param name="page" value="${ pageInfo.jumpNextPageNumber}"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">다음</a></li>
				  </c:if>
				  
				  <!-- 마지막 페이지로 가는 버튼 : 마지막페이지일때 빼고 다 존재함 -->
				  <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">				  	
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  		<c:param name="userId" value="${list.userId}"></c:param>
					  		<c:param name="page" value="${pageInfo.lastPageNumber }"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">&raquo;</a></li>
				  </c:if>
				  
			   </ul>
			</nav>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>