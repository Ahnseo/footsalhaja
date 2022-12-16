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
	.listHover:hover {
		background-color: #D3D3D3;
		cursor: pointer;
	}
	.btn-m5{
		margin : 5px;
	}

</style>
</head>
<body>
<my:navbar active=""></my:navbar>
<div class="container">
<h3>전체 예약내역</h3>
	<p>검색키워드 =제목,id검색  + 최신순/예약 날짜별/예약시간별 /구장별 매치타입별 /Level별 /모집상태별로 버튼 누를때 마다 -> script: 쿼리 DESC<-> ASC 변경  </p>

	<!-- 검색기능   -->
	<div class="form-group">      
	<c:url value="/admin/allBookList" var="allBookListLink"></c:url>
		<form action="${allBookListLink }" class="d-flex flex-row-reverse" role="search">
			 <div>
			    <button class="btn btn-outline-success" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
		    </div>
		   
	      	<div class="col-sm-3">
			    <input class="form-control " type="search" name="q" value="${param.q }" placeholder="검색" aria-label="Search">
		    </div>
		   
			<div class="col-sm-2">
				<select name="t" id="searchTypeSelect" class="form-select">
		      		<option value="all">전체</option>
		      		<option value="userId" ${param.t == 'userId' ? 'selected' : '' }>ID</option>
		      		<option value="name" ${param.t == 'name' ? 'selected' : '' }>이름</option>
		      	</select>
	      	</div>	
	      	 <div class="col-sm-6">
			 </div>
		</form>
	</div>
	
	
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>예약날짜</th>
						<th>예약시간</th>
						<th>구장</th>
						<th>매치타입</th>
						<th>Level</th>
						<th>성별</th>
						<th>작성자</th>
						<th>모집상태</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${allBookedList}" var="booked"  >
						<c:url value="/main/get" var="getBookedLink">
					 		<c:param name="bookId" value="${booked.bookId}"/>
					 	</c:url>
						<tr class="listHover" onclick="location.href='${getBookedLink}'">
						 	<td>${booked.bookId}</td>
						 	
						 	<td><a href="${getBookedLink}">${booked.title}</a></td>
						 	<td>${booked.bookDate}</td>
						 	
						 	<td>
							 	<c:choose>
							        <c:when test="${booked.bookTime == 6}">
							        	<span class="mr10px">6:00~8:00</span>
							        </c:when>
							        <c:when test="${booked.bookTime == 9}">
							        	<span class="mr10px">9:00~11:00</span>
							        </c:when>
							        <c:when test="${booked.bookTime == 14}">
							        	<span class="mr10px">14:00~16:00</span>
							        </c:when>
							        <c:when test="${booked.bookTime == 18}">
							        	<span class="mr10px">18:00~20:00</span>
							        </c:when>
							        <c:when test="${booked.bookTime == 21}">
							        	<span class="mr10px">21:00~23:00</span>
							        </c:when>
						        </c:choose>
						 	</td>
						 	
						 	<td>${booked.stadiumName}</td>
						 	
						 	<td>
							 	<c:if test="${booked.matchType eq '3'}">
						 		3 vs 3 
						 		</c:if>
						 		<c:if test="${booked.matchType eq '4'}">
						 		4 vs 4
						 		</c:if>
						 		<c:if test="${booked.matchType eq '5'}">
						 		5 vs 5 
						 		</c:if>				 	
						 	</td>
						 	<td>
						 		<c:if test="${booked.level eq '1'}">
						 		비기너 
						 		</c:if>
						 		<c:if test="${booked.level eq '2'}">
						 		아마추어 
						 		</c:if>
						 		<c:if test="${booked.level eq '3'}">
						 		챌린저 
						 		</c:if>
						 	</td>					 	
						 	<td>					 	
							 	<c:if test="${booked.teamGender eq 'M'}">
									남자
								</c:if>
								<c:if test="${booked.teamGender eq 'F'}">
									여자
								</c:if>
						 	</td>
						 	
						 	<td>${booked.userId}</td>
						 	
						 	<td>
							    <c:if test="${booked.status == 0}">  
						        	<span class="badge bg-success rounded-pill">모집완료</span>   								        	
						        </c:if>
						        <c:if test="${booked.status == 1}">  
						        	<span class="badge bg-danger rounded-pill">모집중</span>   								        	
						        </c:if>
					        </td>
					        
					 	</tr>
				 	</c:forEach>
				 </tbody>
			</table>
			
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			  
			  	<!-- 맨앞 페이지 -->
			  	<c:if test="${bookedPage.currentPageNumber ne 1}">
				    <li class="page-item">
				      <c:url value="/admin/allBookList" var="firstPageLink">   	
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
			    <c:if test="${bookedPage.hasPrevButton}">
				    <li class="page-item">
				      <c:url value="/admin/allBookList" var="previousPageLink">
				     	<c:param name="page" value="${bookedPage.jumpPrevPageNumber}"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${previousPageLink}" aria-label="Previous">
				        이전
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 페이지 -->
			    <c:forEach begin="${bookedPage.leftPageNumber}" end="${bookedPage.rightPageNumber}" var="pageNumber">
			    	<li class="page-item">
				    	<c:url value="/admin/allBookList" var="pageLink" >
					    	<c:param name="page" value="${pageNumber}"/>
					    	<c:param name="q" value="${param.q}"/>
					     	<c:param name="t" value="${param.t}"/>
				    	</c:url>
				    	<a class="page-link ${bookedPage.currentPageNumber eq pageNumber ? 'active' : ''}" href="${pageLink}">
				    		${pageNumber}
				    	</a>
				    </li>
			    </c:forEach>
			   
			    <!-- 다음 10개의 페이지 ( 11 or 21 or 31 로 가기 )-->
			    <c:if test="${bookedPage.hasNextButton}">
				    <li class="page-item">
				      <c:url value="/admin/allBookList" var="nextPageLink">
				     	<c:param name="page" value="${bookedPage.jumpNextPageNumber}"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${nextPageLink}" aria-label="Previous">
				        다음
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 마지막 페이지 -->
			    <c:if test="${bookedPage.currentPageNumber ne bookedPage.lastPageNumber}">
				    <li class="page-item">
				      <c:url value="/admin/allBookList" var="lastPageLink">  
				        <c:param name="page" value="${bookedPage.lastPageNumber}"/>
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