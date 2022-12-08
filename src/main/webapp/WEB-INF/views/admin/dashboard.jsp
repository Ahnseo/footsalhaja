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
<style>
	div.mainBoard {
		width: 100%;
		height: :1150px;
		border: 1px solid black;
	}
	div.top{
		width: 100%;
		height: 150px;
		border: 1px solid black;
	}
	div.left {
		width: 50%;
		height: 500px;
		float: left;
		box-sizing: border-box;
		border: 1px solid black;
		overflow: scroll;
	}
	div.right {
		width: 50%;
		height: 500px;
		float: right;
		box-sizing: border-box;
		border: 1px solid black;
		overflow: scroll;
	}

</style>
</head>
<body>
	<my:navbar active=""></my:navbar>
	<div class="container">
		<div class="row mt-2 mb-5">
			<div class="col">	
		     	<div class="mainBoard">
		     		<div class="top">
		     			1. 관리자가 오늘의 할일 숫자로 표기  ( 매치예약건수(?), 매치취소건수(?), 답변대기문의(?), 신고접수(?) )
		     		</div>
			        <div class="left">
			        	2. 현황 (<그래프 차트 > 날짜/ 예약수/매출액/방문자/문의, goolge api )
			        </div>
			        <div class="right">
			        	<nav id="navbar-example1" class="navbar bg-light px-3 mb-3">
					        <a class="navbar-brand" href="#">일자별 요약</a>
				        </nav>
				        <div data-bs-spy="scroll" data-bs-target="#navbar-example1" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-light p-3 rounded-2" tabindex="0">
				        	<table class="table">
								<thead>
									<th>날짜</th>
									<th>예약</th>		
									<th>방문자</th>
									<th>문의</th>
								</thead>
								<tbody>	
									<tr>
									 	<td></td>
									 	<td></td>	 	
									 	<td></td>
									 	<td></td>
								 	</tr>						 	
								</tbody>
							</table>
						</div>
			        </div>
		        	<div class="left">
		        		
			        </div>
			        <div class="right">
				        <nav id="navbar-example2" class="navbar bg-light px-3 mb-3">
				        	<c:url value="/admin/allQnAList" var="allQnAListLink">
				        		<c:param name="page" value="1"/>
				        		<c:param name="q" value=""/>
				        		<c:param name="t" value="all"/>
				        	</c:url>
					        <a class="navbar-brand" href="${allQnAListLink}">QnA</a>
					        <ul class="nav nav-pills">
					        	<li class="nav-item">
					        		<a class="nav-link" href="#scrollspyHeading1">First</a>
					        	</li>
					        </ul>
				        </nav>
				        <div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-light p-3 rounded-2" tabindex="0">
					        <ol class="list-group list-group-numbered" >
						    	<c:forEach items="${waitingQnAList}" var="waitingQnA">
						    		<c:url value="/qna/myQnAGet" var="getWatingQnALink">
						    			<c:param name="userId" value="${waitingQnA.userId}"/>
						    			<c:param name="qnaId" value="${waitingQnA.qnaId}"/>
						    		</c:url>
						        	<li class="list-group-item d-flex justify-content-between align-items-start">	
							            <div class="ms-2 me-auto">
								            <div class="fw-bold">
								            	<a href="${getWatingQnALink}">
								            		${waitingQnA.title}
								            	</a>
								            </div>
								            ${waitingQnA.userId}
								        </div>
								        <span>${waitingQnA.insertDatetime} </span>
							            <span class="badge bg-danger rounded-pill">${waitingQnA.status}</span>   
						            </li>           
						        </c:forEach>
					        </ol>
				        </div>
			        </div>	
				</div>	
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>