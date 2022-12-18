<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="myInfo" tagdir="/WEB-INF/tags" %>
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

/* 자유게시판 글 목록 */
#userFreeTitle h3 {
	text-align: center;
	padding: 60px;
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
	color: green;
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

#listBox .table tr td {
	height: 60px;
	vertical-align: middle;
}

#listBox .table tr td a {
 	text-decoration: none;
 	color: #333;
 	padding: 15px;
 }



</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<body>
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container-sm">
	<div id="userFreeTitle">
		<h3>${list.userId}님이 자유게시판에 쓴 글 리스트</h3> 
	</div>
	<div id="listBox" >
		<table class="table table-hover container">
			<thead>
				<tr scope="row">
					<th>글번호</th>
					<th>말머리</th>
					<th>제목</th>
					<th>작성시간</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
					<c:forEach items="${list.userFbList}" var="fblist">
						<c:url value="/free/get" var="getLink">
							<c:param name="number" value="${fblist.fb_number}"></c:param>
						</c:url> 
						<tr onclick="location.href='${getLink}'" class="trtr">		
						 	<td>${fblist.fb_number}</td>
						 	<td>${fblist.fb_category}</td>					 	
						 	<td class="listTitle col-sm-6">

								<a class='move' href="${getLink }">${fblist.fb_title} </a>
							</td>
						 	<td>${fblist.ago}</td>
						 	<td>${fblist.fb_viewCount}</td>
					 	</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	<div id="bottomBox">
	<!-- 페이지네이션 -->
		<div class="paginationBox">
			<ul class="pagination">
		  <!-- 첫페이지로 가는 버튼 : 1페이지일때 빼고 다 존재함 -->
			  <c:if test="${pageInfo.currentPageNumber != 1 }">
				  <c:url value="/mypage/myFbDocumentList" var="listLink">
				  	<c:param name="userId" value="${list.userId}"></c:param>
				  	<c:param name="page" value="1"></c:param>
				  </c:url>
				  <li class="page-item"><a class="page-link" href="${listLink }">&laquo;</a></li>
			  </c:if>
			  
			  <!-- 이전 페이지 버튼 -->
			  <c:if test="${pageInfo.hasPrevButton}">
				  <c:url value="/mypage/myFbDocumentList" var="listLink">
				  		<c:param name="userId" value="${list.userId}"></c:param>
				  		<c:param name="page" value="${ pageInfo.jumpPrevPageNumber}"></c:param>
				  </c:url>
				  <li class="page-item"><a class="page-link" href="${listLink }">이전</a></li>
			  </c:if>

			  <c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
			  	<c:url value="/mypage/myFbDocumentList" var="listLink">
			  	<c:param name="userId" value="${list.userId}"></c:param>
			  		<c:param name="page" value="${pageNumber }"></c:param>
			  	</c:url>
			  	
			  	<!-- 현재 페이지 active 클래스 추가 -->
			    <li class="page-item
			  		  ${ pageInfo.currentPageNumber == pageNumber ? 'active' : ''}
			    "><a class="page-link" href="${listLink }">${pageNumber }</a></li>
			  </c:forEach>
			  
			  <!-- 다음 페이지 버튼 -->
			  <c:if test="${pageInfo.hasNextButton}">
				  <c:url value="/mypage/myFbDocumentList" var="listLink">
				  		<c:param name="userId" value="${list.userId}"></c:param>
				  		<c:param name="page" value="${ pageInfo.jumpNextPageNumber}"></c:param>
				  </c:url>
				  <li class="page-item"><a class="page-link" href="${listLink }">다음</a></li>
			  </c:if>
			  
			  <!-- 마지막 페이지로 가는 버튼 : 마지막페이지일때 빼고 다 존재함 -->
			  <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">				  	
				  <c:url value="/mypage/myFbDocumentList" var="listLink">
				  		<c:param name="userId" value="${list.userId}"></c:param>
				  		<c:param name="page" value="${pageInfo.lastPageNumber }"></c:param>
				  </c:url>
				  <li class="page-item"><a class="page-link" href="${listLink }">&raquo;</a></li>
			  </c:if>
			  
		   </ul>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>