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
		width: 40%;
		height: 500px;
		float: left;
		box-sizing: border-box;
		border: 1px solid black;
		overflow: scroll;
	}
	div.right {
		width: 60%;
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
		<div class="row">
			<div class="col">	
		     	<div class="mainBoard">
		     		<div class="top">
		     			1. 관리자가 오늘의 할일 숫자로 표기  ( 매치예약건수(?), 매치취소건수(?), 답변대기문의(?), 신고접수(?) )
		     		</div>
			        <div class="left">
			        	2. 방문현황 (<차트> 날짜/ 예약수/매출액/방문자/문의, goolge api )
			        </div>
			        <div class="right">
			        	3. 일자별 요약 테이블 보기 by 날짜 (일자, 방문자, 예약수, 문의갯수 LEFT JOIN )
			        	<table class="table">
							<thead>
								<th>날짜</th>
								<th>예약</th>
								<th>매출액</th>
								<th>방문자</th>
								<th>문의</th>
							</thead>
							<tbody>	
								<tr>
								 	<td></td>
								 	<td></td>
								 	<td></td>
								 	<td></td>
								 	<td></td>
							 	</tr>						 	
							</tbody>
						</table>
			        </div>
		        	<div class="left">
		        		4. 현황 (<차트> 날짜/ 예약수/매출액/방문자/문의, goolge api )
			        </div>
			        <div class="right">
				        <ol class="list-group list-group-numbered">
					    	<c:forEach items="${waitingQnAList}" var="waitingQnA">	
					        	<li class="list-group-item d-flex justify-content-between align-items-start">
						            <div class="ms-2 me-auto">
							            <div class="fw-bold">${waitingQnA.title}</div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>