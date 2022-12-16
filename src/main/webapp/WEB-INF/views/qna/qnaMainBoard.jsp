<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
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
		#freeTitle h2 {
			text-align: center;
			padding: 60px;
		 }
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
	<my:navbar active="qnaMainBoard"></my:navbar>
	<div class="container">
		<div class="row">
			<div class="col">
			
				<div id="freeTitle">
					<h2>FAQ 자주묻는 질문</h2>
				</div>
				<div class="mb-3">
					<c:forEach items="${FAQList}" var="FAQ">
						<div class="accordion" id="accordionFAQ">
						  <div class="accordion-item">
						    <h2 class="accordion-header" id="${FAQ.faqId}">
						      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${FAQ.faqId}" aria-expanded="true" aria-controls="collapse${FAQ.faqId}">
						      ${FAQ.title}
						      </button>
						    </h2>
						    <div id="collapse${FAQ.faqId}" class="accordion-collapse collapse" aria-labelledby="${FAQ.faqId}" data-bs-parent="#accordionFAQ">
						      <div class="accordion-body">
						       ${FAQ.content}
						      </div>
						    </div>
						  </div>
						</div>
					</c:forEach>
				</div>
		
				<div class="container">
					<div id="freeTitle">
						<h2>QnA 문의</h2>
					</div>
					
					<!-- 검색기능   -->
					<div class="form-group">      
						<c:url value="/qna/qnaMainBoard" var="qnaMainBoardLink"/>
						<form action="${qnaMainBoardLink }" class="d-flex flex-row-reverse" role="search">
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
					
				</div>
				
				<div class="container">
					<div class="row">
						<div class="col">
							<table class="table">
								<thead>
									<tr>
										<th>번호</th>
										<th>카테고리</th>
										<th>제목</th>
										<th>좋아요</th>
										<th>작성자</th>
										<th>작성일시</th>
										<th>문의상태</th>
										<!-- <th>조회수</th> --> 
									</tr>
								</thead>
								 <tbody>
									 <c:forEach items="${allQnAListByDone}" var="allQnA" varStatus="st" >
										<c:url value="/qna/myQnAGet" var="getLink">
									 		<c:param name="userId" value="${allQnA.userId}"/>
									 		<c:param name="qnaId" value="${allQnA.qnaId}"/>
									 	</c:url>	
										<tr class="listHover" onclick="location.href='${getLink}'">
										 	<td>${allQnA.qnaId}</td>
										 	<td>${allQnA.category}</td>	
										 	<td>
										 		<a href="${getLink}">${allQnA.title}</a>
										 		<c:if test="${allQnA.replyCount != 0}">
										 		
										 			<span class="badge text-bg-light"><i class="fa-regular fa-message"></i> ${allQnA.replyCount}</span>
										 			
										 		</c:if>
										 	</td>
										 	<td>${allQnA.likeCount}</td>
										 	<td>${allQnA.userId}</td>
										 	<td>${allQnA.ago }</td>
										 	<td>
										 	 	<c:if test="${allQnA.status == '답변완료'}">  
										        	<span class="badge bg-success rounded-pill">${allQnA.status}</span>   								        	
										        </c:if>
										        <c:if test="${allQnA.status == '답변대기'}">  
										        	<span class="badge bg-danger rounded-pill">${allQnA.status}</span>   								        	
										        </c:if>
										    </td>
									 	</tr>
								 	</c:forEach>
								 </tbody>
							</table>
							
							<div>
							  <ul class="pagination justify-content-center">
							  	
							  	<!-- 맨앞 페이지 -->
							  	<c:if test="${qnaPageInfo.currentPageNumber > 10}">
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="firstPageLink">
								     
								     	<c:param name="page" value="1"/>
								     	<c:param name="q" value=""/>
								     	<c:param name="t" value="all"/>
								      </c:url>	
								      <a class="page-link" href="${firstPageLink}" aria-label="First">
								        맨앞
								      </a>
								    </li>
							    </c:if>    
							    <!-- 이전 10개의 페이지 ( 1 or 11 or 21 로 가기 ) -->
							    <c:if test="${qnaPageInfo.hasPrevButton}">
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="previousPageLink">
								     	
								     	<c:param name="page" value="${jumpPrevPageNumber}"/>
								     	<c:param name="q" value=""/>
								     	<c:param name="t" value="all"/>
								      </c:url>	
								      <a class="page-link" href="${previousPageLink}" aria-label="Previous">
								        이전
								      </a>
								    </li>
							    </c:if>
							    
							    <!-- 현재 페이지 -->
							    <c:forEach begin="${qnaPageInfo.leftPageNumber}" end="${qnaPageInfo.rightPageNumber}" var="pageNumber">
							    	<li class="page-item">
								    	<c:url value="/qna/qnaMainBoard" var="pageLink" >
				
									    	<c:param name="page" value="${pageNumber}"/>
									    	<c:param name="q" value=""/>
									     	<c:param name="t" value="all"/>
								    	</c:url>
								    	<a class="page-link ${qnaPageInfo.currentPageNumber eq pageNumber ? 'active' : ''}" href="${pageLink}">
								    		${pageNumber}
								    	</a>
								    </li>
							    </c:forEach>
							   
							    <!-- 다음 10개의 페이지 ( 11 or 21 or 31 로 가기 )-->
							    <c:if test="${qnaPageInfo.hasNextButton}">
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="nextPageLink">
								     
								     	<c:param name="page" value="${qnaPageInfo.jumpNextPageNumber}"/>
								     	<c:param name="q" value=""/>
								     	<c:param name="t" value="all"/>
								      </c:url>	
								      <a class="page-link" href="${nextPageLink}" aria-label="Previous">
								        다음
								      </a>
								    </li>
							    </c:if>
							    
							    <!-- 마지막 페이지 -->
							    <c:if test="${qnaPageInfo.currentPageNumber ne qnaPageInfo.lastPageNumber}">	    
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="lastPageLink">  
								        <c:param name="page" value="${qnaPageInfo.lastPageNumber}"/>
								        <c:param name="q" value=""/>
								     	<c:param name="t" value="all"/>
								      </c:url>	
								      <a class="page-link" href="${lastPageLink}" aria-label="Last">
								      	맨마지막
								      </a>
								    </li>
							    </c:if>
							  </ul>
							</div>
							<div class="d-flex flex-row-reverse">	
							
								<form action="/qna/insert" method="get">
								
									<button id="insertBtn" class="btn btn-success btn-m5" type="submit" >문의하기</button>	
								</form>
								
								<%-- 시큐리티 로그인된 userId = userIdValue -> ${userIdValue } 으로 사용하겠습니다.--%>
								<sec:authentication property="name" var="userIdValue"/>
								<form action="/qna/myQnAList" method="get">
									<input type="hidden" name="userId" value="${userIdValue}">
									<input type="hidden" name="page" value="1">
									<button id="myQnAListBtn" class="btn btn-primary btn-m5" type="submit" >내 문의내역</button>
								</form>
							</div>
						</div>
					</div>
				</div>
				
				<hr>
				
				<p>회사전화번호/찾아오시는길</p> 
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";
	
</script>
<script>
setTimeout(function() {
	  console.log("Works!");
	}, 1000);
</script>
	

</body>
</html>