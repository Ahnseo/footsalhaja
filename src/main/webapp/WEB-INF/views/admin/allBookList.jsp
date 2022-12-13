<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>      
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
<title>Insert title here</title>
</head>
<body>
<my:navbar active=""></my:navbar>
<div class="container">
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
						<tr>
						 	<td>${booked.bookId}</td>
						 	<c:url value="/main/get" var="getBookedLink">
						 		
						 		<c:param name="bookId" value="${booked.bookId}"/>
						 	</c:url>
						 	<td><a href="${getBookedLink}">${booked.title}</a></td>
						 	<td>${booked.bookDate}</td>
						 	<td>${booked.bookTime}</td>
						 	<td>${booked.stadiumName}</td>
						 	<td>${booked.matchType}</td>
						 	<td>${booked.level}</td>					 	
						 	<td>${booked.teamGender}</td>
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
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>