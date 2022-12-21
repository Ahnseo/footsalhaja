<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');
li {
   list-style:none;
  }
  
.container-sm { 
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
}
/* 아카데미게시판 */
#academyTitle h2 {
	text-align: center;
	padding: 60px;
 }
 
 /* 인기글 */
#likeBestRankBox {
	border-radius: 15px;
	border: 1px solid #ddd;
	margin-left: 30px;
 }
 
#likeBestRankBox p {
	font-size:18px;
	font-weight: bold;
	letter-spacing: -1px;
	
	margin: 15px 0  10px 30px;
}
#likeBestRankBox span {
	color: red;
}
 #bestTable tr td {
 	color: #666;
 	font-size: 16px;
 	border: 0;
 }
 
 #bestTable .title:hover{
 	text-decoration: underline;
 }
  
 #bestTable tr td a {
 	text-decoration: none;
 	color: #333;
 }
 
 #bestTable tr td.first {
 	text-align: center;
 }
 
 #bestTable tr td.first p {
 	border: 1px solid #ddd;
 	vertical-align: middle;
 	display: inline-block;
 	margin: 0 auto;
 	padding: 0 4px;
 	
 	color: #666;
 	font-size: 14px;
 	font-weight: normal;
 }
 
 /* 카테고리 */
#categoryBox {
	text-align: center;
	margin: 60px;
}
#categoryBox .cateBtn {
	border: 0;
	background : 0;
	font-size: 16px;
	margin: 0 20px;
}
#categoryBox .cateBtn:hover {
	color: #1cb99e;
	font-weight: bold;
	text-decoration: underline;
}
.clickCateBtn {
 	color: lightgreen;
	font-weight: bold;
	text-decoration: underline;
 }
/* 글목록 */
#listBox .table{
	font-size: 16px;
	letter-spacing: -1px;
	text-align: center;
}
#listBox .table .listTitle {
	text-align: left;
}
#listBox .table .trtr {
	cursor: pointer;
}
#listBox .table .trtr:hover .listTitle {
 	font-weight: bold;
 }
 
#listBox .table tr td {
	height: 60px;
	vertical-align: middle;
}
#listBox .table tr td a {
 	text-decoration: none;
 	color: #333;
 	padding: 15px;
 }
 
/* 검색 페이징 글작성버튼 */
#bottomBox{
	margin: 30px 0;
	text-align: center;
	position: relative;
	
}
#bottomBox .searchBox{
	display: inline-block;
	position: absolute;
	top: 0;
	left: 0;
}
#bottomBox .paginationBox{
	display: inline-block;
	margin-top: 60px;
}
#bottomBox .insertBox{
	display: inline-block;
	position: absolute;
	top: 0;
	right: 0;
}
/* 검색창 */
.searchBox .searchSelect{
   width : 80px;
   height: 35px;
   border-radius: 25px;
   border: 1px solid #999;
   
   color: #666;
   padding-left: 10px;
  }
  
.searchBox .searchWrap {
   width : 250px;
   height: 35px;
   border-radius: 25px;
   border: 1px solid #999;
  }
.searchBox .searchWrap .search{
  border: 0;
  outline: none;
  margin-top: 5px;
 }
 
.searchBox .searchWrap .btn {
	padding: 0 5px 5px 0;
 }
  
</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<body>

<my:navbar></my:navbar>

	<div class="container-sm">
		<div id="academyTitle">
			<h2>아카데미 게시판</h2>
			</div>
			
		<!-- 좋아요 베스트 -->
		<div id="likeBestRankBox" >
			<p><span>HOT</span> 아카데미게시판 이번주 인기 글 </p>
			<table id="bestTable" class="table table-sm">
				<c:forEach items="${likeRank }" var="rank" >
				<tr>
					<td class="first"  width="100">
						<p>${rank.ab_category }</p>
					</td>
					<td class="title">
						<c:url value="/academy/get" var="getLink">
							<c:param name="ab_number" value="${rank.ab_number }"></c:param>
						</c:url>
						<a href="${getLink}">
							${rank.ab_title }
						</a>
						<c:if test="${rank.replyCnt > 0 }">
							&nbsp;&nbsp;<i class="fa-regular fa-comment"></i>${rank.replyCnt }
						</c:if>
					</td>
					<td width="70"><i class="fa-regular fa-heart"></i> ${rank.countLike }</td>
					<td width="70"><i class="fa-regular fa-eye"></i> ${rank.ab_viewCount }</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 카테고리 -->
		<div id="categoryBox" class="d-grid gap-2 ">
			<c:url value="/academy/list" var="listLink"></c:url>
			<form action="${listLink }">
				<button class='cateBtn' name="category" value="">전체</button>
				<button class='cateBtn' name="category" value="레슨">레슨</button>
				<button class='cateBtn' name="category" value="꿀팁">꿀팁</button>
				<button class='cateBtn' name="category" value="팀원모집">팀원모집</button>
				<button class='cateBtn' name="category" value="질문/답변">질문/답변</button>
			</form>
		</div>
		<!-- 글목록 -->
		<div id="listBox" >
		<table class="table table-hover container">
			<thead>
				<tr scope="row">
					<th>No</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>닉네임</th>
					<th>작성시간</th>
					<th><i class="fa-regular fa-heart"></i></th>
					<th><i class="fa-regular fa-eye"></i></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList}" var="board">
					<c:url value="/academy/get" var="getLink">
						<c:param name="ab_number" value="${board.ab_number}"></c:param>
					</c:url>
					<tr onclick="location.href='${getLink}'" class="trtr">
						<td>${board.ab_number }</td>
						<td>${board.ab_category }</td>
						<td class="listTitle col-sm-6">
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
						<td>${board.countLike }</td>
						<td>${board.ab_viewCount }</td>
					</tr>
				</c:forEach> 
			</tbody>
		</table>
	</div>		
	<div id="bottomBox">			
	<!-- 검색 -->
	<!-- 검색창 -->
	   	<div class="searchBox">
			<c:url value="/academy/list" var="listLink"></c:url>
			<form id='searchForm' action="${pageContext.request.contextPath}/academy/list" method='get' class="d-flex" >
				<select class="searchSelect" name='type'>
					<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
					<option value="TWC"
						<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>전체</option>
					<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
				</select> 
				<!-- 검색창 -->
				<div class="searchWrap">
					<input class="search" type='text' name='keyword' placeholder="검색어를 입력해주세요."
						value='<c:out value="${pageMaker.cri.keyword }"/>'> 
					<input type='hidden' name='pageNum'
						value='<c:out value="${pageMaker.cri.pageNum }"/>'> 
					<input type='hidden' name='amount'
						value='<c:out value="${pageMaker.cri.amount }"/>'>
						
					<button class="btn" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
			</form>
		</div>

		<!-- 페이지네이션 -->
		<div class="paginationBox">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="page-item">
						<a class="page-link" href="${pageMaker.startPage -1 }" aria-label="Previous"> <i class="fa-solid fa-angles-left"></i></a>
					</li>
				</c:if>
				
				<c:forEach var ="num" begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }">
				<li class="page-item ${pageMaker.cri.pageNum == num ?"active" : "" }"><a class="page-link" href="${num }">${num }</a></li>
				</c:forEach>
				
				<c:if test="${pageMaker.next }">
					<li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1 }" aria-label="Next"> <i class="fa-solid fa-angle-right"></i></a>
					</li>
				</c:if>
			</ul>
		</div>

		<form id="actionForm" action="${pageContext.request.contextPath}/academy/list" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
			<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
		</form>

	<!-- 글작성 버튼 -->
		<!-- 로그인 했을때 -->
		<div class="insertBox">
			<sec:authorize access="isAuthenticated()">
				<c:url value="/academy/register" var="registerLink" />
				<a href="${registerLink}">
					<button class="btn btn-outline-success">글쓰기</button>
				</a>
			</sec:authorize>
		<!-- 로그인 안 했을때 -->
			<sec:authorize access="not isAuthenticated()">
				<button class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#nonMemberModal" id="nonMemberInsertButton">글쓰기</button>
			</sec:authorize>	
		</div>
	</div>
</div> <!-- 전체 컨테이너 -->

<!-- 비회원 글작성버튼 클릭시 로그인유도 팝업 -->
	<div class="modal fade" id="nonMemberModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">로그인해주세요</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        회원만 게시글 작성이 가능합니다. 로그인해주세요.
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <c:url value="/member/login" var="loginLink"></c:url>
	        <a href="${loginLink }">
	       		<button type="button" class="btn btn-primary">로그인</button>
	        </a>
	      </div>
	    </div>
	  </div>
	</div>
	
<my:footer></my:footer>	
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