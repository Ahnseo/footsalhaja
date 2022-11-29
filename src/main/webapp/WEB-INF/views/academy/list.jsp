<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아카데미 게시판 리스트 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:navbar></my:navbar>

	<div class="container-md">
		<div class="row">
			<div class="col">
			

<%-- 				<c:if test="${not empty message }">
					<div class="alert alert-success">
						${message }
					</div>
				</c:if> --%>
				
				<h1>아카데미 게시판</h1>
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>말머리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${boardList}" var="board">
							<tr>
								<td>${board.ab_number }</td>
								<td>${board.ab_category }</td>
								<td>
 									<c:url value="/board/get" var="getLink">
										<c:param name="ab_number" value="${board.ab_number}"></c:param>
									</c:url>
									<a href="${getLink }">
										${board.ab_title}
									</a>
									
<%-- 									//댓글 수 출력
									<c:if test="${board.countReply > 0 }">
										<span class="badge rounded-pill text-bg-light">
											<i class="fa-regular fa-comment-dots"></i>
											${board.countReply }
										</span>
									</c:if>
									
									//파일 수 출력
									<c:if test="${board.countFile > 0 }">
										<span class="badge rounded-pill text-bg-light">
											<i class="fa-regular fa-file"></i>
											${board.countFile }
										</span>
									</c:if> --%>
								</td>
								<td>${board.member_userId }</td>
								<td>${board.ab_insertDatetime }</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
			</div>
		</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>