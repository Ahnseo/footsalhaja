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
	<my:navbar active="qnaMainBoard"></my:navbar>
	<div class="container">
		<div class="row">
			<div class="col">
				<h3>FAQ 자주하는 질문</h3>
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

				<!-- 검색기능 추가 예정  -->
				<h3> QnA 무엇이 궁금하신가요? </h3>
				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
				<table class="table">
					<thead>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>문의상태</th>
					</thead>
					 <tbody>
						 <c:forEach items="${myQnAList}" var="myQnAList" varStatus="st" >
							<tr>
							 	<td>${myQnAList.qnaId}</td>
							 	<td>${myQnAList.category}</td>
							 	<td>${myQnAList.title}</td>
							 	<td>${myQnAList.content}</td>
							 	<td>${myQnAList.status}</td>
						 	</tr>
					 	</c:forEach>
					 </tbody>
				</table>
				
				<form action="/qna/insert" method="get">
					<button type="submit" id="insertBtn">문의하기</button>	
				</form>
				
				<%-- 시큐리티 로그인된 userId = userIdValue -> ${userIdValue } 으로 사용하겠습니다.--%>
				<sec:authentication property="name" var="userIdValue"/>
				<form action="/qna/myQnAList" method="get">
					<input type="hidden" name="userId" value="${userIdValue}">
					<input type="hidden" name="page" value="1">
					<button type="submit" id="myQnAListBtn">내 문의내역</button>
			
				</form>
				<hr>
				
				<p>회사전화번호/찾아오시는길</p> 
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";
	
</script>
	

</body>
</html>