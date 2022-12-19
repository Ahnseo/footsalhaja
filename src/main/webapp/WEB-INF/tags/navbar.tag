
<%@tag import="java.time.LocalDate"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- c커스텀 태그 사용하기 위해 --%>
<%@ attribute name="active" required="false" %> <%-- narvar active 초기값 false --%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>

<%--  아랫줄 부터 작성하세요 . navbar 코드를 복붙해오기  --%>
<%-- 시큐리티 로그인된 userId = userIdValue -> ${userIdValue } 으로 사용하겠습니다.--%>
<sec:authentication property="name" var="userIdValue"/>
<c:url value="/main/list" var="listLink" />
<style>
#wholeNav {
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
}
.bg1 {
	position: relative;
}

.nav_img {
	width: 30px;
	position: absolute;
	top: 10px;
	left: 10px;
}

.userName {
	position: absolute;
	top: 0;
	right: 0;
}

.bg2 {
	margin-top: 30px;
	text-align: center;
}

#navbar {
	padding: 0;
}

.navTitle {
	position: absolute;
	left: 50px;
	top: 10px;
	font-weight:bold;
	font-size: 20px;
}


</style>

<nav id="wholeNav" class="navbar navbar-expand-md navbar-dark sticky-top" style="background: linear-gradient(to right, #5F7161, #6D8B74)  ; padding: 0;">
  <!-- One of the primary actions on mobile is to call a business - This displays a phone button on mobile only -->
  <div class="navbar-toggler-right" style="color: #fff;">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
  </div>

  <div class="collapse navbar-collapse flex-column" id="navbar">
    <ul class="navbar-nav  w-100 px-3 justify-content-center bg1" >
      <li class="nav-item active" >
        <a class="nav-link" href="${listLink }">
        <img class="nav_img" alt="" src="${pageContext.request.contextPath}/logo.png">
        	<p class="navTitle">풋살하자</p>
        <!-- <span class="sr-only">(current)</span> --></a>
      </li>
      
      <sec:authorize access="isAuthenticated()" var="loggedIn"/>
      <c:if test="${not loggedIn }">
	      <li class="nav-item active userName">
	      </li>
      </c:if>

      <c:if test="${loggedIn }">
	      <li class="nav-item active userName d-flex">
	      	 <sec:authorize access="hasAuthority('admin')" var="adminLogin"/>
			 <c:if test="${adminLogin }">
				<p class="nav-link" style="color:white;">관리자 계정</p>
			 </c:if>
			 <sec:authorize access="hasAuthority('manager')" var="managerLogin"/>
			 <c:if test="${managerLogin }">
				<p class="nav-link" style="color:white;">매니저 계정</p>
			 </c:if>
	         <a class="nav-link" href="" ><span>${userIdValue } 님 환영합니다.</span></a>
	      </li>

      </c:if>
    </ul>
	
	
	
    <ul class="navbar-nav w-100 px-3 justify-content-end bg2" style="background: #5F7161;">


        
        <%-- security 를 사용하여, 로그인 된 userId를 c:param value="로그인된 ID값" 사용합니다. 현재 주소창에 접속방법 예시) mypage/list?userId=askc6361 --%>
        
        <c:url value="/mypage/list" var="mypageLink">
        	<c:param name="userId" value="${userIdValue }"/>
        	
        </c:url>
        <c:url value="/free/list" var="freeLink"></c:url>
        <c:url value="/academy/list" var="academyLink"></c:url>
        <li class="nav-item active">
        	<a class="nav-link ${active eq 'freeLink' ? 'active' : '' }" href="${freeLink}">자유게시판</a>
      	</li>
        <li class="nav-item active">
        	<a class="nav-link ${active eq 'academyLink' ? 'active' : '' }" href="${academyLink}">아카데미</a>
      	</li>
        
        <li class="nav-item active">
        	<c:url value="/qna/qnaMainBoard" var="qnaLink">
      			<c:param name="page" value="1"/>
      			<c:param name="c" value=""/>
      			<c:param name="q" value=""/>
      			<c:param name="t" value="all"/>
      		</c:url>
        	<a class="nav-link ${active eq 'qnaMainBoard' ? 'active' : '' }" href="${qnaLink}">고객문의</a>
      	</li>
      	<c:if test="${loggedIn }">
      	<li class="nav-item dropdown">
        	<a class="nav-link dropdown-toggle nav-link ${active eq 'mypageLink' ? 'active' : '' }" href="${mypageLink}" role="button" data-bs-toggle="dropdown" aria-expanded="false">마이페이지</a>
        	<ul class="dropdown-menu">		    
					<li><a class="dropdown-item" href="${mypageLink }">회원정보</a></li>
				 <c:url value="myAbDocumentList" var="myAblist">
	        		<c:param name="userId" value="${userIdValue }"/>
	        	 </c:url>
					<li><a class="dropdown-item" href="${myAblist }">아카데미 게시판 쓴 글 목록</a></li>
				<c:url value="myFbDocumentList" var="myFblist">
	        		<c:param name="userId" value="${userIdValue }"/>
	        	 </c:url>
					<li><a class="dropdown-item" href="${myFblist }">자유게시판에 쓴 글 목록</a></li>
				<c:url value="myMainDocumentList" var="myBooklist">
	        		<c:param name="userId" value="${userIdValue }"/>
	        	 </c:url>
				    <li><a class="dropdown-item" href="${myBooklist }">예약글 목록</a></li>
				 <c:url value="myReplyList" var="myReplylist">
	        		<c:param name="userId" value="${userIdValue }"/>
	        	 </c:url> 
				    <li><a class="dropdown-item" href="${myReplylist }">작성 댓글 목록</a></li>
				 <c:url value="myLikeList" var="myLikelist">
	        		<c:param name="userId" value="${userIdValue }"/>
	        	 </c:url>
				    <li><a class="dropdown-item" href="${myLikelist }">좋아요 한 글 목록</a></li>
			</ul>
      	</li>
      	</c:if>
      	<c:if test="${ not loggedIn }">
      	<li class="nav-item active">
      	</li>
      	</c:if>
      	
      	<sec:authorize access="hasAuthority('admin')">
        <li class="nav-item dropdown">
		    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		    	관리자
		    </a>
      		<c:url value="/admin/dashboard" var="dashboardLink"></c:url>
      		<c:url value="/admin/allMemberList" var="allMemberListLink">
      			<c:param name="page" value="1"/>
      			<c:param name="t" value="all"/>
      			<c:param name="q" value=""/>
      		</c:url>
      		<c:url value="/admin/allBookList" var="allBookListLink">
      			<c:param name="page" value="1"/>
      			<c:param name="t" value="all"/>
      			<c:param name="q" value=""/>
      		</c:url>
      		<c:url value="/admin/allQnAList" var="allQnAListLink">
      			<c:param name="page" value="1"/>
      			<c:param name="c" value=""/>
      			<c:param name="t" value="all"/>
      			<c:param name="q" value=""/>
      			<c:param name="s" value="yet"/>
      		</c:url>
		    <ul class="dropdown-menu">
			    <li><a class="dropdown-item" href="${dashboardLink }">대시보드</a></li>
			    <li><a class="dropdown-item" href="${allMemberListLink }">회원관리</a></li>
			    <li><a class="dropdown-item" href="${allBookListLink }">예약정보</a></li>
			    <li><a class="dropdown-item" href="${allQnAListLink }">전체문의</a></li>
		    </ul>
	    </li>
      	</sec:authorize>
      	<sec:authorize access="isAnonymous()">
	     	<c:url value="/member/login" var="loginLink"></c:url>
	      	<li class="nav-item active">
	       		<a class="nav-link " href="${loginLink }">로그인<span class="sr-only">(current)</span></a>
	     	</li>
     	</sec:authorize>
     	
     	<sec:authorize access="isAuthenticated()">
	     	<c:url value="/member/logout" var="logoutLink"></c:url>
	      	<li class="nav-item active">
	       		<a class="nav-link " href="${logoutLink }">로그아웃</a>
	     	</li>
     	</sec:authorize>
      
      
    </ul>

		</div>
  
  

</nav>