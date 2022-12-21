<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.lang.Deprecated" %>
<%
	//오늘 날짜 구하기
	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
	//한달 후 날짜 구하기
	Date addMonth = new Date();
    
    int getNowMM = nowDate.getMonth();
    
    addMonth.setMonth(getNowMM + 1);
    
%>
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
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');
	
	
	.container-sm { 
		font-family: 'Noto Sans KR', sans-serif;
		letter-spacing: -1px;
		font-size: 16px;
	}
	.listHover:hover {
		background-color: #D3D3D3;
		cursor: pointer;
	}
	.btn-m5{
		margin : 5px;
	}

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

</head>
<body>
<my:navbar active=""></my:navbar>
<div class="container">
<h3>전체 예약내역</h3>

	<!-- 검색기능 + 예약날짜 + 구장별 + 모집상태  -->
	<div class="form-group">     
	
		<c:url value="/admin/allBookList" var="allBookListLink"></c:url> 	
		<form action="${allBookListLink }"  role="search">
			<label for="col-12">예약일정</label>
			<div class="d-flex col-12 mb-2">
			
				<!-- 현재 날짜 설정  -->
				<c:set value="<%=sf.format(nowDate)%>" var="nowDate"/>
				<!-- ${nowDate}  -->
				
				<!-- 한달후 날짜 설정 -->
				<c:set value='<%=sf.format(addMonth)%>' var="addMonth" /> 
				<!-- ${addMonth}  -->
				
				<!-- 날짜별로 조회하면  DB query => ORDER BY b.bookDate ASC  -->
				<c:choose>
					<c:when test="${empty param.d1 && empty param.d2}">
						<!-- 오늘 부터 ~ 다음 달 까지  -->
						<input type="Date" class="form-control col-2" id="d1" name="d1" value="${nowDate }" ${param.d1 == '${param.d1 }' ? 'selected' : '' }>
						<span class=" col-1"> 부터 </span>
						
						<input type="Date" class="form-control col-2" id="d2" name="d2" value="${addMonth }" ${param.d1 == '${param.d2 }' ? 'selected' : '' }>
						<span class=" col-1"> 까지 </span>
					</c:when>
					
					<c:when test="${not empty param.d1 && not empty param.d2}">
						<!-- 원하는 날짜 선택 검색 -->
						<input type="Date" class="form-control col-2" id="d1" name="d1" value="${param.d1 }" ${param.d1 == '${param.d1 }' ? 'selected' : '' }>
						<span class=" col-1"> 부터 </span>
						<input type="Date" class="form-control col-2" id="d2" name="d2" value="${param.d2 }" ${param.d2 == '${param.d2 }' ? 'selected' : '' }>
						<span class=" col-1"> 까지 </span>
					</c:when>
					
				</c:choose>
				
				
			</div>
			
			<div class="d-flex flex-row-reverse" >
				<div class="col-sm-1">
				    <button id="searchBtn" class="btn btn-outline-success" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
			    </div>
			   
		      	<div class="col-sm-3">
				    <input class="form-control " type="search" name="q" value="${param.q }" placeholder="검색" aria-label="Search">
			    </div>
			   
				<div class="col-sm-2">
					<select name="t" id="searchTypeSelect" class="form-select">
			      		<option value="all">전체</option>	      		
			      		<option value="title" ${param.t == 'title' ? 'selected' : '' }>제목</option>
			      		<option value="userId" ${param.t == 'userId' ? 'selected' : '' }>작성자</option>
			      		<option value="content" ${param.t == 'content' ? 'selected' : '' }>본문</option>
			      		<option value="stadiumName" ${param.t == 'stadiumName' ? 'selected' : '' }>구장이름</option>
			      	</select>
		      	</div>	
		      	
		      	<div class="col-2">	
		      	</div>
		      	
		      	<div class="col-2">
			      	<select name="s" id="" class="form-select">
			      		<option value="" ${param.s == '' ? 'selected' : '' }>모집상태</option>
			      		<option value="done" ${param.s == 'done' ? 'selected' : '' }>모집완료 </option>
						<option value="yet" ${param.s == 'yet' ? 'selected' : '' }>모집중 </option>
					</select>
		      	</div>
		      	
		      	<div class="col-2">
			      	<select class="form-select" name="l" id="">
			      	 	<option  value="" ${param.l == '' ? 'selected' : '' } >예약장소</option>
					    <option value="1" ${param.l == '1' ? 'selected' : '' } >천마 풋살파크</option>
					    <option value="2" ${param.l == '2' ? 'selected' : '' } >아디다스 더베이스</option>
					   	<option value="3" ${param.l == '3' ? 'selected' : '' } >도봉 루다 풋살장</option>
					    <option value="4" ${param.l == '4' ? 'selected' : '' } >영등포 SKY 풋살파크 A구장</option>
					    <option value="5" ${param.l == '5' ? 'selected' : '' } >은평 롯데몰 A구장</option>
					   
					    <option value="6" ${param.l == '6' ? 'selected' : '' } >피치 부천 이마트 부천점</option>
					    <option value="7" ${param.l == '7' ? 'selected' : '' } >용인 기흥 낫소 풋살파크</option>
					   	<option value="8" ${param.l == '8' ? 'selected' : '' } >칼라힐 풋살파크 B구장</option>
					    <option value="9" ${param.l == '9' ? 'selected' : '' } >인천 더 베스트 풋볼파크 구월점</option>
					    <option value="10" ${param.l == '10' ? 'selected' : '' } >하남 감일 장수천 풋살파크</option>
		   			</select>
				</div>
				
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
				     	<c:param name="s" value="${param.s}"/>
				     	<c:param name="l" value="${param.l}"/>
				     	<c:param name="d1" value="${param.d1}"/>
				     	<c:param name="d2" value="${param.d2}"/>
				      </c:url>	
				      <a class="page-link" href="${firstPageLink}" aria-label="First">
				      &laquo;
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
				     	<c:param name="s" value="${param.s}"/>
				     	<c:param name="l" value="${param.l}"/>
				     	<c:param name="d1" value="${param.d1}"/>
				     	<c:param name="d2" value="${param.d2}"/>
				      </c:url>	
				      <a class="page-link" href="${previousPageLink}" aria-label="Previous">
				      &lt;
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 페이지 -->
			    <c:forEach begin="${bookedPage.leftPageNumber}" end="${bookedPage.rightPageNumber}" var="pageNumber">
			    	<li class="page-item ${bookedPage.currentPageNumber eq pageNumber ? 'active' : ''}">
				    	<c:url value="/admin/allBookList" var="pageLink" >
					    	<c:param name="page" value="${pageNumber}"/>
					    	<c:param name="q" value="${param.q}"/>
					     	<c:param name="t" value="${param.t}"/>
					     	<c:param name="s" value="${param.s}"/>
					     	<c:param name="l" value="${param.l}"/>
					     	<c:param name="d1" value="${param.d1}"/>
					     	<c:param name="d2" value="${param.d2}"/>
				    	</c:url>
				    	<a class="page-link " href="${pageLink}">
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
				     	<c:param name="s" value="${param.s}"/>
				     	<c:param name="l" value="${param.l}"/>
				     	<c:param name="d1" value="${param.d1}"/>
				     	<c:param name="d2" value="${param.d2}"/>
				      </c:url>	
				      <a class="page-link" href="${nextPageLink}" aria-label="Previous">
				      &gt;
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
				     	<c:param name="s" value="${param.s}"/>
				     	<c:param name="l" value="${param.l}"/>
				     	<c:param name="d1" value="${param.d1}"/>
				     	<c:param name="d2" value="${param.d2}"/>
				      </c:url>	
				      <a class="page-link" href="${lastPageLink}" aria-label="Last">
				      &raquo;
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







