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

#userTitle h3 {
	text-align: center;
 }

.list {
	padding: 60px;
}

.list span {
	padding: 1.0em;
}

.list .badge {
	font-weight: bold;
	font-size: 14px;
}

.list a {
	font-size: 20px;
}

 object {
  text-align: center;
  max-width: 250px;
  height: 250px;
  object-fit: cover;
}

defaultImg {

  text-align: center;
  max-width: 250px;
  height: 250px;
  object-fit: cover;
}

#myInfo {
	margin-top: 10px;
}


</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<body>
<myInfo:navbar active="myInfopageLink"></myInfo:navbar>
<div class="container-sm">
		<div id="userTitle">
			<h3>${myInfo.userId}님의 마이페이지</h3>
		</div>
		<div style="text-align : center; ">
			<c:if test="${member.profileImg eq null}">
				<img class= "defaultImg" src="${pageContext.request.contextPath}/기본프로필.png">
			</c:if>
			<c:forEach items="${member.profileImg }" var="name">
				<div class= "containerProfile">	
					<object data="${imgUrl }/${member.userId }/${name}" type="image/png">
						<img src="${pageContext.request.contextPath}/기본프로필.png">
					</object>
				</div>
			</c:forEach>		
		<div>
				<c:url value="/mypage/get" var="myInfoGetLink">
					<c:param name="userId" value="${myInfo.userId}"/>
				</c:url>
					<a href="${myInfoGetLink}"><button type="button" id= "myInfo" class="btn btn-outline-success">회원정보 확인</button></a>
			</div>
		</div>

<div class = "list">

	<ul class="list-group">
	   <c:url value="/mypage/myAbDocumentList" var="listLink">
			<c:param name="userId" value="${myInfo.userId}"></c:param>
		</c:url>
	  <li onclick="location.href='${listLink}'"  class="list-group-item d-flex justify-content-between align-items-center">
		<a href="${listLink }">아카데미 게시판에 쓴 글 목록</a>
	    <span class="badge bg-primary rounded-pill">${countActivity.countAllAblist}</span>
	  </li>
	    <c:url value="/mypage/myFbDocumentList" var="listLink">
			<c:param name="userId" value="${myInfo.userId}"></c:param>
		</c:url>
	  <li onclick="location.href='${listLink}'" class="list-group-item d-flex justify-content-between align-items-center">
		<a href="${listLink }" > 자유 게시판에 쓴 글 글 목록</a>
	    <span class="badge bg-primary rounded-pill">${countActivity.countAllFblist}</span>
	  </li>
	    <c:url value="/mypage/myMainDocumentList" var="listLink">
			<c:param name="userId" value="${myInfo.userId}"></c:param>
		</c:url>
	  <li onclick="location.href='${listLink}'" class="list-group-item d-flex justify-content-between align-items-center">
		<a href="${listLink }" >예약 글 목록</a>
	    <span class="badge bg-primary rounded-pill">${countActivity.countAllMainlist}</span>
	  </li>
		<c:url value="/mypage/myReplyList" var="listLink">
			<c:param name="userId" value="${myInfo.userId}"></c:param>
		</c:url>
	    <li onclick="location.href='${listLink}'" class="list-group-item d-flex justify-content-between align-items-center">
		<a href="${listLink }">작성 댓글 목록</a>
	    <span class="badge bg-primary rounded-pill">${countActivity.countAbReplyList + countActivity.countFbReplyList + countActivity.countMainReplyList} </span>
	  </li>
		<c:url value="/mypage/myLikeList" var="listLink">
			<c:param name="userId" value="${myInfo.userId}"></c:param>
		</c:url>
	      <li onclick="location.href='${listLink}'" class="list-group-item d-flex justify-content-between align-items-center">
		<a href="${listLink }" > 좋아요한 글 목록</a>
	    <span class="badge bg-primary rounded-pill">${countActivity.countUserAbLike + countActivity.countUserFbLike} </span>
	  </li>
	</ul>
	
	</div>


</div>		
<my:footer></my:footer>		
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>