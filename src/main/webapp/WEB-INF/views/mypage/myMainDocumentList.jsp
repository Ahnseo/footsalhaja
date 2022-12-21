<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="myInfo" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
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

/* 예약 글 목록 */
#userMainTitle h3 {
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
#listBox .table. th{
	font-size: 13px;
	letter-spacing: -1px;
	text-align: center;
	padding: 5px;
}


#listBox tbody{
	font-size: 16px;
	letter-spacing: -1px;
	vertical-align: middle;
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


</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<body>
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container-sm">
	<div id="userMainTitle">
		<h3>${list.userId}님의 예약 리스트 </h3>
	</div> 
	<div id="listBox" >
		<table class="table table-hover container">
			<thead>
				<tr class = "trtr" scope="row">	
					<th>예약 날짜</th>
					<th>예약 시간</th>
					<th>모집상태</th>
					<th>예약장소</th>
					<th>매칭</th>
					<th>실력</th>
					<th>팀성별</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list.userMainList}" var="mainlist">
					<c:url value="/main/get" var="getLink">
						<c:param name="bookId" value="${mainlist.bookId}"></c:param>
					</c:url> 
					<tr onclick="location.href='${getLink}'" class="trtr">	
					 	<td>${mainlist.bookDate}</td>
					 	<c:choose>
					        <c:when test="${mainlist.bookTime == 6}">
					        	<td>6:00~8:00</td>
					        </c:when>
					        <c:when test="${mainlist.bookTime == 9}">
					        	<td>9:00~11:00</td>
					        </c:when>
					        <c:when test="${mainlist.bookTime == 14}">
					        	<td>14:00~16:00</td>
					        </c:when>
					        <c:when test="${mainlist.bookTime == 18}">
					        	<td>18:00~20:00</td>
					        </c:when>
					        <c:when test="${mainlist.bookTime == 21}">
					        	<td>21:00~23:00</td>
					        </c:when>
				        </c:choose>					 	
					 	<c:if test="${mainlist.status == 0}">  
							<td>모집완료</td>
						</c:if>
						<c:if test="${mainlist.status == 1}">  
							<td>모집중</td>
						</c:if>
					 	<td>${mainlist.stadiumName}</td>
					 	<td>${mainlist.matchType}</td>
					 	<c:choose>
					        <c:when test="${mainlist.level == 1}">
					        	<td>비기너</td>
					        </c:when>
					        <c:when test="${mainlist.level == 2}">
					        	<td>아마추어</td>
					        </c:when>
					        <c:when test="${mainlist.level == 3}">
					        	<td>챌린저</td>
					        </c:when>
					 	</c:choose>
					 	<td>${mainlist.teamGender}</td>
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
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  	<c:param name="userId" value="${list.userId}"></c:param>
					  	<c:param name="page" value="1"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">&laquo;</a></li>
				  </c:if>
				  
				  <!-- 이전 페이지 버튼 -->
				  <c:if test="${pageInfo.hasPrevButton}">
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  		<c:param name="userId" value="${list.userId}"></c:param>
					  		<c:param name="page" value="${ pageInfo.jumpPrevPageNumber}"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">이전</a></li>
				  </c:if>

				  <c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
				  	<c:url value="/mypage/myMainDocumentList" var="listLink">
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
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  		<c:param name="userId" value="${list.userId}"></c:param>
					  		<c:param name="page" value="${ pageInfo.jumpNextPageNumber}"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">다음</a></li>
				  </c:if>
				  
				  <!-- 마지막 페이지로 가는 버튼 : 마지막페이지일때 빼고 다 존재함 -->
				  <c:if test="${pageInfo.currentPageNumber != pageInfo.lastPageNumber }">				  	
					  <c:url value="/mypage/myMainDocumentList" var="listLink">
					  		<c:param name="userId" value="${list.userId}"></c:param>
					  		<c:param name="page" value="${pageInfo.lastPageNumber }"></c:param>
					  </c:url>
					  <li class="page-item"><a class="page-link" href="${listLink }">&raquo;</a></li>
				  </c:if>
				  
			  </ul>
		</div>
	</div>
</div>
<my:footer></my:footer>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>