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
ul{
   list-style:none;
   padding-left:0px;
   }
</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<body>
<my:navbar></my:navbar>


	<c:if test="${not empty message }">
		<div class="alert alert-primary" role="alert">
		  ${message }
		</div>
	</c:if>

	<h1>프리보드 목록</h1>
	
	<!-- 좋아요 베스트 -->
	<table class="table">
		<thead>
			<tr>
				<td>순위</td>
				<td>카테고리</td>
				<td>제목</td>
				<td>좋아요</td>
				<td>조회수</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${likeRank }" var="rank" >
			<tr>
				<td>${rank.ranking }</td>
				<td>${rank.fb_category }</td>
				<td>
					<c:url value="/free/get" var="getLink">
						<c:param name="number" value="${rank.fb_number }"></c:param>
					</c:url>
					<a href="${getLink}">
						${rank.fb_title }
					</a>
				</td>
				<td>${rank.fb_likeCount }</td>
				<td>${rank.fb_viewCount }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	
	<table class="table">
		<thead>
			<tr>
				<td>글번호</td>
				<td>좋아요</td>
				<td>카테고리</td>
				<td>제목</td>
				<td>조회수</td>
				<td>작성자</td>
				<td>닉네임</td>
				<td>작성일시</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boardList }" var="board">
				<tr>
					<td>${board.fb_number }</td>
					<td>${board.fb_likeCount }</td>
					<td>${board.fb_category }</td>
					<td>
						<c:url value="/free/get" var="getLink">
							<c:param name="number" value="${board.fb_number }"></c:param>
						</c:url>
						<a href="${getLink}">
							${board.fb_title }
						</a>
						<c:if test="${board.fb_replyCount > 0 }">
							댓글[${board.fb_replyCount }]
						</c:if>
					</td>
					<td>${board.fb_viewCount }</td>
					<td>${board.member_userId }</td>
					<td>${board.nickName }</td>
					<td>${board.ago }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	<!-- 검색창 -->
	<c:url value="/free/list" var="listLink"></c:url>
	<form action="${listLink }" class="d-flex" role="search">
		<!-- 검색 범위 설정 -->
		<select name="t" class="">
			<option value="all">전체</option>
			<option value="title" ${param.t == 'title' ? 'selected' : '' }>제목</option>
			<option value="content" ${param.t == 'content' ? 'selected' : '' }>본문</option>
			<option value="writer" ${param.t == 'writer' ? 'selected' : '' }>작성자</option>
		</select>
		<!-- 검색창 -->
        <input value="${param.q }" class="" type="search" placeholder="검색어를 입력해주세요." aria-label="Search" name="q">
        <button class="btn btn-outline-success" type="submit">검색</button>
        <!-- 카테고리 -->
		<button name="category" value="매칭후기" >매칭후기</button>
		<button name="category" value="구장후기" >구장후기</button>
		<button name="category" value="잡담" >잡담</button>
	</form>
    
    
	    <!-- 글작성 버튼 -->
	    <!-- 로그인 했을때 -->
	    <sec:authorize access="isAuthenticated()">
		    <c:url value="/free/insert" var="insertLink"></c:url>
		    <a href="${insertLink}">
			    <button>글작성</button>
		    </a>
	    </sec:authorize>
	    <!-- 로그인 안 했을때 -->
	    <sec:authorize access="not isAuthenticated()">
			<button data-bs-toggle="modal" data-bs-target="#nonMemberModal" id="nonMemberInsertButton">글작성</button>
	    </sec:authorize>
    
    
	
	
	<!-- 페이지네이션 -->
	<div class="row">
		<div class="col">
			<nav aria-label="Page navigation example">
			  <ul class="pagination">
			  
				  <!-- 첫페이지로 가는 버튼 : 1페이지일때 빼고 다 존재함 -->
				  <c:if test="${pageInfo.currentPageNumber != 1 }">
					  <c:url value="/free/list" var="listLink">
					  		<c:param name="page" value="1"></c:param>
					  		<c:param name="q" value="${param.q }"></c:param>
					  		<c:param name="t" value="${param.t }"></c:param>
					  		<c:param name="category" value="${param.category }"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">맨앞버튼</a></li>
				  </c:if>
				  
				  <!-- 이전 페이지 버튼 -->
				  <c:if test="${pageInfo.hasPrevButton}">
					  <c:url value="/free/list" var="listLink">
					  		<c:param name="page" value="${ pageInfo.jumpPrevPageNumber}"></c:param>
					  		<c:param name="q" value="${param.q }"></c:param>
					  		<c:param name="t" value="${param.t }"></c:param>
					  		<c:param name="category" value="${param.category }"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">이전</a></li>
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
					  <li class="page-item"><a class="page-link" href="${listLink }">다음</a></li>
				  </c:if>
				  
				  <!-- 마지막 페이지로 가는 버튼 : 마지막페이지일때 빼고 다 존재함 -->
				  <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">				  	
					  <c:url value="/free/list" var="listLink">
					  		<c:param name="page" value="${pageInfo.lastPageNumber }"></c:param>
					  		<c:param name="q" value="${param.q }"></c:param>
					  		<c:param name="t" value="${param.t }"></c:param>
					  		<c:param name="category" value="${param.category }"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">맨뒤버튼</a></li>
				  </c:if>
				  
			   </ul>
			</nav>
		</div>
	</div>

	
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


</script>
</body>
</html>