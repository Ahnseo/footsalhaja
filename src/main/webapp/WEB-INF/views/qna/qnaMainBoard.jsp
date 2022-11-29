<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
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
	<h1> QnA Main Board 입니다 무엇이 궁금하신가요?</h1>
	
	<p> 자주묻는질문 pagination : 5개씩 여러게 </p>
	<div class="accordion" id="accordionExample">
	  <div class="accordion-item">
	    <h2 class="accordion-header" id="headingOne">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
	        Accordion Item #1
	      </button>
	    </h2>
	    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
	      <div class="accordion-body">
	        <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
	      </div>
	    </div>
	  </div>	
	  <div class="accordion-item">
	    <h2 class="accordion-header" id="headingTwo">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
	        Accordion Item #2
	      </button>
	    </h2>
	    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
	      <div class="accordion-body">
	        <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
	      </div>
	    </div>
	  </div>
	  <div class="accordion-item">
	    <h2 class="accordion-header" id="headingThree">
	      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
	        Accordion Item #3
	      </button>
	    </h2>
	    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
	      <div class="accordion-body">
	        <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
	      </div>
	    </div>
	  </div>
	</div>
	<br>
	<form class="d-flex" role="search">
		<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
		<button class="btn btn-outline-success" type="submit">Search</button>
	</form>
	<h3> search 로 인한 검색 결과 -> 게시판 테이블 만들기 </h3>
	<p> 전체 질문 게시 pagination : 5개씩 여러게 </p>
		<table class="table">
			<thead>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>문의상태</th>
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
	
	
	 
	<form action="/qna/insert" method="get">
		<button type="submit" id="insertBtn"> 문의하기 : qnaController insert -> insert.jsp </button>	
	</form>
	<form action="/qna/getMyQnA" method="get">
		<button type="submit" id="getBtn">  내 문의내역 : qnaController get -> get.jsp </button>
	</form>
	<hr>
	
	<p>회사전화번호/찾아오시는길</p> 
	
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	const ctx = "${pageContext.request.contextPath}";
	
</script>
	

</body>
</html>