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
<title>Insert title here</title>
</head>
<body>
	<sec:authentication property="name" var="userIdValue"/>
	<my:navbar active="myQnAList"></my:navbar>
	<div class="container">
		<div>
			<div>
				<table class="table">
					<h3>${userIdValue} 님의 문의내역</h3>
					
					<thead>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>내용</th>
						<th>문의상태</th>
					</thead>
					 <tbody>
						 <c:forEach items="${myQnAList}" var="myQnAList" varStatus="st" >
							<tr>
							 	<td>${myQnAListSize - st.count + 1 }</td>	
							 	<td>${myQnAList.category}</td>
							 	<td>${myQnAList.title}</td>
							 	<td>${myQnAList.content}</td>
							 	<td>${myQnAList.status}</td>
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