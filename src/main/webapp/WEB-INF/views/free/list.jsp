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
@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 400;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 700;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.ttf') format('truetype')
}

@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 300;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.ttf') format('truetype');
}

.nanumbarungothic * {
 font-family: 'NanumBarunGothic', sans-serif;
}

li {
   list-style:none;
  }
  
.container-sm { 
	font-family: 'NanumBarunGothic';
	letter-spacing: -1px;
}

/* 자유게시판 */
#freeTitle h2 {
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
   padding:2px 0 0 10px;
  }
  
.searchBox .searchWrap {
   width : 250px;
   height: 35px;
   border-radius: 25px;
   border: 1px solid #999;
  }

.searchBox .searchWrap .search{
  border: 0;
  margin: 0 10px 10px 0;
  outline: none;
  
 }
 
.searchBox .searchWrap .btn {
	width : 50px;
 }
  
</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<body>
<my:navbar></my:navbar>


	<c:if test="${not empty message }">
		<div class="alert alert-primary" role="alert">
		  ${message }
		</div>
	</c:if>

<!-- 전체 컨테이너 -->
<div class="container-sm">

	<div id="freeTitle">
		<h2>자유게시판</h2>
	</div>
	
	<!-- 좋아요 베스트 -->
	<div id="likeBestRankBox" >
		<p><span>HOT</span> 자유게시판 이번주 인기 글 </p>
		<table id="bestTable" class="table table-sm">
			<c:forEach items="${likeRank }" var="rank" >
			<tr>
				<td class="first"  width="100" >
					<p>${rank.fb_category }</p>
				</td>
				<td class="title">
					<c:url value="/free/get" var="getLink">
						<c:param name="number" value="${rank.fb_number }"></c:param>
					</c:url>
					<a href="${getLink}">
						${rank.fb_title }
					</a>
					<c:if test="${rank.fb_replyCount > 0 }">
						&nbsp;&nbsp;<i class="fa-regular fa-comment"></i> ${rank.fb_replyCount }
					</c:if>
				</td>
				<td width="70"><i class="fa-regular fa-heart"></i> ${rank.fb_likeCount }</td>
				<td width="70"><i class="fa-regular fa-eye"></i> ${rank.fb_viewCount }</td>
			</tr>
			</c:forEach>
		</table>
	</div>

	
	
	<!-- 카테고리 -->
	<div id="categoryBox" class="d-grid gap-2 ">
		<c:url value="/free/list" var="listLink"></c:url>
		<form action="${listLink }">
			<button id="btn1" class="cateBtn" name="category" value="" >전체</button>
			<button id="btn2" class="cateBtn" name="category" value="매칭후기" >매칭후기</button>
			<button id="btn3" class="cateBtn" name="category" value="구장후기" >구장후기</button>
			<button id="btn4" class="cateBtn" name="category" value="잡담" >잡담</button>
		</form>
	</div>
	
	<!-- 글목록 -->
	<div id="listBox" >
	<table class="table table-hover container">
		<thead>
			<tr scope="row">
				<td>No</td>
				<td>카테고리</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일시</td>
				<td>좋아요</td>
				<td>조회수</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boardList }" var="board">
				<c:url value="/free/get" var="getLink">
					<c:param name="number" value="${board.fb_number }"></c:param>
				</c:url>
				<tr onclick="location.href='${getLink}'" class="trtr">
					<td>${board.fb_number }</td>
					<td>${board.fb_category }</td>
					<td class="listTitle col-sm-6">
						<a href="${getLink}">
							${board.fb_title }
						</a>
						<!-- 댓글 수 출력 -->
						<c:if test="${board.fb_replyCount > 0 }">
							<i class="fa-regular fa-comment"></i> ${board.fb_replyCount }
						</c:if>
						<!-- 파일 수 출력 -->
						<c:if test="${board.countFile > 0 }">
								<i class="fa-regular fa-file"></i> ${board.countFile }
						</c:if>
					</td>
					<td>${board.nickName }</td>
					<td>${board.ago }</td>
					<td>${board.fb_likeCount }</td>
					<td>${board.fb_viewCount }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
    
    
    
    <div id="bottomBox">
    
	   	<!-- 검색창 -->
	   	<div class="searchBox">
			<c:url value="/free/list" var="listLink"></c:url>
			<form action="${listLink }" class="d-flex" role="search">
				<!-- 검색 범위 설정 -->
				<select name="t" class="searchSelect">
					<option value="all">전체</option>
					<option value="title" ${param.t == 'title' ? 'selected' : '' }>제목</option>
					<option value="content" ${param.t == 'content' ? 'selected' : '' }>본문</option>
					<option value="writer" ${param.t == 'writer' ? 'selected' : '' }>작성자</option>
				</select>
				<!-- 검색창 -->
				<div class="searchWrap">
		        <input value="${param.q }" class="search" type="search" placeholder="검색어를 입력해주세요." aria-label="Search" name="q" >
		        <button class="btn" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
				</div>
			</form>
	   	</div>


	<!-- 페이지네이션 -->
	<div class="paginationBox">
	  <ul class="pagination">
		  <!-- 첫페이지로 가는 버튼 : 1페이지일때 빼고 다 존재함 -->
		  <c:if test="${pageInfo.currentPageNumber != 1 }">
			  <c:url value="/free/list" var="listLink">
			  		<c:param name="page" value="1"></c:param>
			  		<c:param name="q" value="${param.q }"></c:param>
			  		<c:param name="t" value="${param.t }"></c:param>
			  		<c:param name="category" value="${param.category }"></c:param>
			  </c:url>
			  <li class="page-item"><a class="page-link" href="${listLink }">
			  	<i class="fa-solid fa-angles-left"></i>
			  </a></li>
		  </c:if>
		  
		  <!-- 이전 페이지 버튼 -->
		  <c:if test="${pageInfo.hasPrevButton}">
			  <c:url value="/free/list" var="listLink">
			  		<c:param name="page" value="${ pageInfo.jumpPrevPageNumber}"></c:param>
			  		<c:param name="q" value="${param.q }"></c:param>
			  		<c:param name="t" value="${param.t }"></c:param>
			  		<c:param name="category" value="${param.category }"></c:param>
			  </c:url>
			  <li class="page-item"><a class="page-link" href="${listLink }">
			  	<i class="fa-solid fa-angle-left"></i>
			  </a></li>
		  </c:if>
	  
		  <c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
		  	<c:url value="/free/list" var="listLink">
		  		<c:param name="page" value="${pageNumber }"></c:param>
		  		<c:param name="q" value="${param.q }"></c:param>
		  		<c:param name="t" value="${param.t }"></c:param>
		  		<c:param name="category" value="${param.category }"></c:param>
		  	</c:url>
		  	
		  	<!-- 현재 페이지 active 클래스 추가 -->
		    <li class="page-item
		  		  ${ pageInfo.currentPageNumber == pageNumber ? 'active' : ''}
		    "><a class="page-link" href="${listLink }">${pageNumber }</a></li>
		  </c:forEach>
		  
		  <!-- 다음 페이지 버튼 -->
		  <c:if test="${pageInfo.hasNextButton}">
			  <c:url value="/free/list" var="listLink">
			  		<c:param name="page" value="${ pageInfo.jumpNextPageNumber}"></c:param>
			  		<c:param name="q" value="${param.q }"></c:param>
			  		<c:param name="t" value="${param.t }"></c:param>
			  		<c:param name="category" value="${param.category }"></c:param>
			  </c:url>
			  <li class="page-item"><a class="page-link" href="${listLink }">
			  	<i class="fa-solid fa-angle-right"></i>
			  </a></li>
		  </c:if>
		  
		  <!-- 마지막 페이지로 가는 버튼 : 마지막페이지일때 빼고 다 존재함 -->
		  <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">				  	
			  <c:url value="/free/list" var="listLink">
			  		<c:param name="page" value="${pageInfo.lastPageNumber }"></c:param>
			  		<c:param name="q" value="${param.q }"></c:param>
			  		<c:param name="t" value="${param.t }"></c:param>
			  		<c:param name="category" value="${param.category }"></c:param>
			  </c:url>
			  <li class="page-item"><a class="page-link" href="${listLink }">
			  	<i class="fa-solid fa-angles-right"></i>
			  </a></li>
		  </c:if>
	   </ul>
	   </div>
	 
		<!-- 글작성 버튼 -->
		<!-- 로그인 했을때 -->
		<div class="insertBox">
		<sec:authorize access="isAuthenticated()">
			<c:url value="/free/insert" var="insertLink"></c:url>
			<a href="${insertLink}">
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
	        <h1 class="modal-title fs-5" id="exampleModalLabel">비회원이 글작성 눌렀을때</h1>
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
	
	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	
}

</script>
</body>
</html>