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

	<style>

	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');


	.container-sm { 
		font-family: 'Noto Sans KR', sans-serif;
		letter-spacing: -1px;
		font-size: 16px;
	}
	* {
	    padding: 0;
	    margin: 0;
	    box-sizing: border-box;
	}

	#freeTitle h2 {
		text-align: center;
		padding: 60px;
	 }

	ul {
	   list-style:none;
	  }

	.post_wrap {
		border: 1px solid #ced4da;
		border-radius: 10px;
		margin: 0 0 30px 0;
	}
	.reply_wrap {
		border: 1px solid #ced4da;
		border-radius: 10px;
		margin: 0 0 30px 0;
	}


	/* 상단 버튼부분 */
	.topbtnBox {
		margin: 30px 0 15px 0;
		position: relative;
	}
	.topbtnBox .modifyBtn {
		text-align: right;
		position: absolute;
		top: 0;
		right: 0;
	}

	/* 상단 제목부분 */
	.post_top {
		
	}
	.post_top .top_category {
		border: 1px solid #ddd;
	 	vertical-align: middle;
	 	display: inline-block;
	 	margin: 20px 20px 0;
	 	padding: 0 4px;
	 	
	 	color: #666;
	 	font-size: 14px;
	 	font-weight: normal;
	}
	.post_top .top_title {
		font-size: 20px;
		font-weight: bold;
		margin: 10px 20px;
	}
	.post_top ul {
		text-align: left;
		padding-left:0;
	}
	.post_top ul li {
		display: inline-block;
		margin-left: 20px;
		font-size: 13px;
	}

	.post_wrap .top_content {
		margin: 40px 20px;
		
	}
	.reply_wrap .reply_content {
		margin: 0px 20px;
		
	}
	.reply_wrap ul {
		text-align: left;
		padding-left:0;
	}
	.reply_wrap ul li {
		display: inline-block;
		margin-left: 20px;
		font-size: 13px;
	}

	.post_wrap .likeBox {
		text-align: center;
	}

	.likeBox .likeIcon {
		font-size: 26px;
		color: green;
	}
	.likeBox .likeCount1 {
		font-size: 14px;
		margin-top: -20px;
		color: #333;
	}
	.likeBox .likeCount2 {
		font-size: 14px;
		margin-top: -15px;
		font-weight: bold;
		color: #333;
		
	}
	.btn-m5{
		margin : 5px;
	}
	.listHover:hover {
		background-color: #D3D3D3;
		cursor: pointer;
	}
	.basicPageBtn{
		background-color : #47E5C4;
		font-color: white;
	}


	</style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">


</head>
<body>
	<my:navbar active="qnaMainBoard"></my:navbar>
	<%-- 시큐리티 로그인된 userId = userIdValue -> ${userIdValue } 으로 사용하겠습니다.--%>
	<sec:authentication property="name" var="userIdValue"/>
	
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
					
					<!-- 검색기능 + 카테고리   -->
					<div class="form-group">      
						<c:url value="/qna/qnaMainBoard" var="qnaMainBoardLink"></c:url> 	
						<form action="${qnaMainBoardLink }"  role="search">
							<div class="d-flex flex-row-reverse" >
								<div class="col-sm-1">
								    <button class="btn btn-outline-success" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
							    </div>
							   
						      	<div class="col-sm-3">
						      		<input type="hidden" name="page" value="${qnaPageInfo.currentPageNumber}">
								    <input class="form-control " type="search" name="q" value="${param.q }" placeholder="검색" aria-label="Search">
							    </div>
							   
								<div class="col-sm-2">
									<select name="t" id="searchTypeSelect" class="form-select">
							      		<option value="all">전체</option>
							      		<option value="userId" ${param.t == 'userId' ? 'selected' : '' }>작성자</option>
							      		<option value="content" ${param.t == 'content' ? 'selected' : '' }>본문</option>
							      	</select>
						      	</div>	
						      	<div class="col-4">
						      	</div>
						      	<div class="col-2">
							      	<select name="c" id="searchTypeSelect" class="form-select">
										<option value="" >카테고리</option>
										<option value="accusation" ${param.c == 'accusation' ? 'selected' : '' }>신고/재제</option>
										<option value="payment" ${param.c == 'payment' ? 'selected' : '' }>결제문의</option>
										<option value="facility" ${param.c == 'facility' ? 'selected' : '' }>시설문의</option>
										<option value="etc" ${param.c == 'etc' ? 'selected' : '' }>기타문의</option>
									</select>
								</div>
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
										<th>작성자</th>
										<th>작성일시</th>
										<th><i class="fa-regular fa-thumbs-up"></i></th>
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
										 			<span class=""><i class="fa-regular fa-comment"></i> ${allQnA.replyCount}</span>
										 		</c:if>
										 		<c:if test="${allQnA.fileCount != 0}">
									 				<span class=""><i class="fa-regular fa-file"></i> ${allQnA.fileCount}</span>		
									 			</c:if>
										 	</td>
										 	<td>${allQnA.userId}</td>
										 	<td>${allQnA.ago }</td>
										 	<td>${allQnA.likeCount}</td>
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
							
							<nav>
							  <ul class="pagination justify-content-center ">
							  	
							  	<!-- 맨앞 페이지 -->
							  	<c:if test="${qnaPageInfo.currentPageNumber > 10}">
								    <li class="page-item ">
								      <c:url value="/qna/qnaMainBoard" var="firstPageLink">
								     	<c:param name="page" value="1"/>
								     	<c:param name="c" value="${param.c}"/>
								     	<c:param name="q" value="${param.q}"/>
								     	<c:param name="t" value="${param.t}"/>				
								      </c:url>	
								      <a class="page-link " href="${firstPageLink}" aria-label="First">
								      &laquo;
								      </a>
								    </li>
							    </c:if>    
							    
							    <!-- 이전 10개의 페이지 ( 1 or 11 or 21 로 가기 ) -->
							    <c:if test="${qnaPageInfo.hasPrevButton}">
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="previousPageLink">			     	
								     	<c:param name="page" value="${jumpPrevPageNumber}"/>
								     	<c:param name="c" value="${param.c}"/>
								     	<c:param name="q" value="${param.q}"/>
								     	<c:param name="t" value="${param.t}"/>
								      </c:url>	
								      <a class="page-link" href="${previousPageLink}" aria-label="Previous">
								      &lt;
								      </a>
								    </li>
							    </c:if>
							    
							    <!-- 현재 페이지 -->
							    <c:forEach begin="${qnaPageInfo.leftPageNumber}" end="${qnaPageInfo.rightPageNumber}" var="pageNumber">
							    	<li class="page-item ${qnaPageInfo.currentPageNumber eq pageNumber ? 'active' : ''}">
								    	<c:url value="/qna/qnaMainBoard" var="pageLink" >		
									    	<c:param name="page" value="${pageNumber}"/>
									    	<c:param name="c" value="${param.c}"/>
							      			<c:param name="t" value="${param.t}"/>
							      			<c:param name="q" value="${param.q}"/>
								    	</c:url>
								    	<a class="page-link" href="${pageLink}">
								    		${pageNumber}
								    	</a>
								    </li>
							    </c:forEach>
							   
							    <!-- 다음 10개의 페이지 ( 11 or 21 or 31 로 가기 )-->
							    <c:if test="${qnaPageInfo.hasNextButton}">
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="nextPageLink">								     
								     	<c:param name="page" value="${qnaPageInfo.jumpNextPageNumber}"/>
								     	<c:param name="c" value="${param.c}"/>
								     	<c:param name="q" value="${param.q}"/>
								     	<c:param name="t" value="${param.t}"/>
								      </c:url>	
								      <a class="page-link" href="${nextPageLink}" aria-label="Previous">
								      &gt;
								      </a>
								    </li>
							    </c:if>
							    
							    <!-- 마지막 페이지 -->
							    <c:if test="${qnaPageInfo.currentPageNumber ne qnaPageInfo.lastPageNumber}">	    
								    <li class="page-item">
								      <c:url value="/qna/qnaMainBoard" var="lastPageLink">  
								        <c:param name="page" value="${qnaPageInfo.lastPageNumber}"/>
								        <c:param name="c" value="${param.c}"/>
								     	<c:param name="q" value="${param.q}"/>
								     	<c:param name="t" value="${param.t}"/>
								      </c:url>	
								      <a class="page-link" href="${lastPageLink}" aria-label="Last">
								      &raquo;
								      </a>
								    </li>
							    </c:if>
							    
							  </ul>
							</nav>
							
							<sec:authorize access="isAuthenticated()">
							<div class="d-flex flex-row-reverse">	
								
								<form action="${pageContext.request.contextPath}/qna/insert" method="get">
									<button id="insertBtn" class="btn btn-success btn-m5" type="submit" >문의하기</button>	
								</form>
								
								
								<c:url value="/qna/myQnAList" var="myQnAListLink">
									<c:param name="userId" value="${userIdValue}"/>
					      			<c:param name="page" value="1"/>
					      			<c:param name="c" value=""/>
					      			<c:param name="t" value="all"/>
					      			<c:param name="q" value=""/>
					      		</c:url>
					      		<button onclick="location.href='${myQnAListLink}'" class="btn btn-primary btn-m5" type="submit" >내 문의내역</button>
					      		
							</div>
							</sec:authorize>
							
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