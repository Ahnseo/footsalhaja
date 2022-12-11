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

<style>
#searchTypeSelect {
	width: auto;
}
</style>

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
							<th>좋아요</th>
							<th>제목</th>
							<th>닉네임</th>
							<th>작성시간</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${boardList}" var="board">
							<tr>
								<td>${board.ab_number }</td>
								<td>${board.ab_category }</td>
								<td>${board.countLike }</td>
								<td>
 									<c:url value="/academy/get" var="getLink">
										<c:param name="ab_number" value="${board.ab_number}"></c:param>
									</c:url>
									<a class= 'move' href="${getLink }">
										${board.ab_title}
									</a>
									
									<!-- 댓글 수 출력 -->
									<c:if test="${board.replyCnt > 0 }">
										<span class="badge rounded-pill text-bg-light">
											<i class="fa-regular fa-comment-dots"></i>
											${board.replyCnt }
										</span>
									</c:if>
									
									<!-- 파일 수 출력 -->
									<c:if test="${board.countFile > 0 }">
										<span class="badge rounded-pill text-bg-light">
											<i class="fa-regular fa-file"></i>
											${board.countFile }
										</span>
									</c:if>
								</td>
								<td>${board.nickName }</td>
								<td>${board.ago }</td>
								<td>${board.ab_viewCount }</td>
							</tr>
						</c:forEach> 
					</tbody>
				</table>
				
				<!-- 검색 -->
				<div class='row'>
					<div class="col-lg-12">
						<form id='searchForm' action="/academy/list" method='get'>
							<select name='type'>
								<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="TWC"
									<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>전체 검색</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
							</select> 
							
							<input type='text' name='keyword'
								value='<c:out value="${pageMaker.cri.keyword }"/>'> 
							<input type='hidden' name='pageNum'
								value='<c:out value="${pageMaker.cri.pageNum }"/>'> 
							<input type='hidden' name='amount'
								value='<c:out value="${pageMaker.cri.amount }"/>'>
								
							<button class='btn btn-default'>Search</button>
							
							<!-- 카테고리 -->
							<button class='btn btn-default' name = "category" value = "레슨">레슨</button>
							<button class='btn btn-default' name = "category" value = "꿀팁">꿀팁</button>
							<button class='btn btn-default' name = "category" value = "팀원모집">팀원모집</button>
							<button class='btn btn-default' name = "category" value = "질문/답변">질문/답변</button>
							
						</form>
					</div>
				</div>

				<!-- 페이지네이션 -->
				<div class="container-md">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="page-item">
								<a class="page-link" href="${pageMaker.startPage -1 }" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
							</li>
						</c:if>
						
						<c:forEach var ="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						<li class="page-item ${pageMaker.cri.pageNum == num ?"active" : "" }"><a class="page-link" href="${num }">${num }</a></li>
						</c:forEach>
						
						<c:if test="${pageMaker.next }">
							<li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1 }" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
							</li>
						</c:if>
					</ul>
				</div>

				<form id="actionForm" action="/academy/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
				</form>


				<!-- 글 작성버튼 -->
				<div class="d-flex flex-row-reverse">
					<c:url value="/academy/register" var="registerLink" />
					<a class="btn btn-outline-primary" href="${registerLink }" role="button">글작성</a>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script type="text/javascript">

/* 페이징 버튼처리 */

var actionForm = document.getElementById("actionForm");

let pageButtons = document.querySelectorAll(".page-item a")

for (const button of pageButtons){
	button.addEventListener("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.querySelector("input[name='pageNum']").value= this.getAttribute("href");
		actionForm.submit();	
	})
}

		
/* 검색 이벤트 처리 */

var searchForm = document.getElementById("searchForm");
	
document.querySelector("#searchForm button").addEventListener("click", function(e) {
		e.preventDefault();
		//화면에 검색 종류가 없다면 검색하지 않도록 제어
		if(searchForm.querySelector("select[name='type']").value=="") {
			alert("검색 종류를 선택하세요");
			return false;
		}
		//화면에 키워드가 없다면 검색을 하지 않도록 제어
		if(searchForm.querySelector("input[name='keyword']").value=="") {
			alert("키워드를 입력하세요");
			return false;
		}
		
		//검색버튼을 클릭하면 <form>태그의 전송을 막고, 페이지 번호는 1 이되도록 처리
		searchForm.querySelector("input[name='pageNum']").value="1";
		
		searchForm.submit();
	});
	

</script>

</body>
</html>