<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- c커스텀 태그 사용하기 위해 --%>
<%@ attribute name="active" required="false" %> <%-- narvar active 초기값 false --%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>

<%--  아랫줄 부터 작성하세요 . navbar 코드를 복붙해오기  --%>
<%-- 시큐리티 로그인된 userId = userIdValue -> ${userIdValue } 으로 사용하겠습니다.--%>
<sec:authentication property="name" var="userIdValue"/>

<c:url value="/main/list" var="listLink" />

<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
  <!-- One of the primary actions on mobile is to call a business - This displays a phone button on mobile only -->
  <div class="navbar-toggler-right">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
  </div>

  <div class="collapse navbar-collapse flex-column " id="navbar">
    <ul class="navbar-nav  w-100 px-3 justify-content-center">
      <li class="nav-item active">
        <a class="nav-link" href="/main/list"><span style="font-weight:bold">풋살하자</span></a>
      </li> 
      <li class="nav-item active">
         <a class="nav-link" href="" ><span style="font-weight:bold">${userIdValue } 님 환영합니다.</span></a>
      </li>
    </ul>

    <ul class="navbar-nav w-100 bg-secondary px-3 justify-content-end">
	  <li class="nav-item active">
        <a class="nav-link" href="#">공지사항</a>
      </li>
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          커뮤니티
        </a>
 
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="#">자유게시판</a>
          <a class="dropdown-item" href="/academy/list">아카데미</a>
          <a class="dropdown-item" href="#">중고장터</a>
        </div>
        
        <%-- security 를 사용하여, 로그인 된 userId를 c:param value="로그인된 ID값" 사용합니다. 현재 주소창에 접속방법 예시) mypage/list?userId=askc6361 --%>
        
        <c:url value="/mypage/list" var="mypageLink">
        	<c:param name="userId" value="${userIdValue }"/>
        </c:url>
        <li class="nav-item active">
        	<a class="nav-link ${active eq 'mypageLink' ? 'active' : '' }" href="${mypageLink}">마이페이지</a>
      	</li>
        <c:url value="/qna/qnaMainBoard" var="qnaLink"></c:url>
        <li class="nav-item active">
        	<a class="nav-link ${active eq 'qnaMainBoard' ? 'active' : '' }" href="${qnaLink}">고객문의</a>
      	</li>
        <c:url value="/admin/list" var="memberLink"></c:url>
        <li class="nav-item active">
        	<a class="nav-link  ${active eq 'memberList' ? 'active' : '' }" href="${memberLink}">관리자</a>
      	</li>
       <%--  <c:url value="/member/insert" var="insertMemberLink"></c:url>
        <li class="nav-item active">
        	<a class="nav-link  ${active eq 'insert' ? 'active' : '' }" href="${insertMemberLink}">회원가입</a>
      	</li> --%>
      	
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