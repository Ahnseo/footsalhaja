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
<title>전체 문의 목록</title>
</head>
<body>
<sec:authentication property="name" var="userIdValue"/>
<my:navbar active=""></my:navbar>
<div class="container-fluid">
	<h3>전체문의내역(답변대기/ 답변완료 기능 추가하기)</h3>	
	<div class="row">
		<div class="col-md-10">
			<c:url value="/admin/allQnAList" var="allQnAlistLink"></c:url>
			<form action="${allQnAlistLink }" class="d-flex" role="search">
				<select name="t" id="searchTypeSelect" class="form-select">
		      		<option value="all">전체</option>
		      		<option value="title" ${param.t == 'title' ? 'selected' : '' }>제목</option>
		      		<option value="content" ${param.t == 'content' ? 'selected' : '' }>본문</option>
		      		<option value="userId" ${param.t == 'userId' ? 'selected' : '' }>작성자</option>
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
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성자</th>
						<th>좋아요</th>
						<th>문의상태</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${allQnAList}" var="allQnAList"  >
						<tr>
						 	<td>${allQnAList.qnaId}</td>	
						 	<td>${allQnAList.category}</td>
						 	<!-- 특정회원의 QnA 보러가기 -->
						 	<c:url value="/qna/myQnAGet" var="myQnAGetLink">
						 		<c:param name="userId" value="${allQnAList.userId}"/>
						 		<c:param name="qnaId" value="${allQnAList.qnaId}"/>
						 	</c:url>
						 	<td><a href="${myQnAGetLink}">${allQnAList.title}</a></td>
						 	<td>${allQnAList.content}</td>
						 	<td>${allQnAList.userId}</td>
						 	<td>${allQnAList.likeCount}</td>
						 	<td>
						 	 	<c:if test="${allQnAList.status == '답변완료'}">  
						        	<span class="badge bg-success rounded-pill">${allQnAList.status}</span>   								        	
						        </c:if>
						        <c:if test="${allQnAList.status == '답변대기'}">  
						        	<span class="badge bg-danger rounded-pill">${allQnAList.status}</span>   								        	
						        </c:if>
						    </td>
						 	
					 	</tr>
				 	</c:forEach>
				 </tbody>
			</table>
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			  
			  	<!-- 맨앞 페이지 -->
			  	<c:if test="${qnaPageInfo.currentPageNumber ne 1}">
				    <li class="page-item">
				      <c:url value="/admin/allQnAList" var="firstPageLink">   	
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
			    <c:if test="${qnaPageInfo.hasPrevButton}">
				    <li class="page-item">
				      <c:url value="/admin/allQnAList" var="previousPageLink">
				     	<c:param name="page" value="${jumpPrevPageNumber}"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${previousPageLink}" aria-label="Previous">
				        이전
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 페이지 -->
			    <c:forEach begin="${qnaPageInfo.leftPageNumber}" end="${qnaPageInfo.rightPageNumber}" var="pageNumber">
			    	<li class="page-item">
				    	<c:url value="/admin/allQnAList" var="pageLink" >
					    	<c:param name="page" value="${pageNumber}"/>
					    	<c:param name="q" value="${param.q}"/>
					     	<c:param name="t" value="${param.t}"/>
				    	</c:url>
				    	<a class="page-link ${qnaPageInfo.currentPageNumber eq pageNumber ? 'active' : ''}" href="${pageLink}">
				    		${pageNumber}
				    	</a>
				    </li>
			    </c:forEach>
			   
			    <!-- 다음 10개의 페이지 ( 11 or 21 or 31 로 가기 )-->
			    <c:if test="${qnaPageInfo.hasNextButton}">
				    <li class="page-item">
				      <c:url value="/admin/allQnAList" var="nextPageLink">
				     	<c:param name="page" value="${qnaPageInfo.jumpNextPageNumber}"/>
				     	<c:param name="q" value="${param.q}"/>
				     	<c:param name="t" value="${param.t}"/>
				      </c:url>	
				      <a class="page-link" href="${nextPageLink}" aria-label="Previous">
				        다음
				      </a>
				    </li>
			    </c:if>
			    
			    <!-- 마지막 페이지 -->
			    <c:if test="${qnaPageInfo.currentPageNumber ne qnaPageInfo.lastPageNumber}">
				    <li class="page-item">
				      <c:url value="/admin/allQnAList" var="lastPageLink">  
				        <c:param name="page" value="${qnaPageInfo.lastPageNumber}"/>
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