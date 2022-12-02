<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- c커스텀 태그 사용하기 위해 --%>
<%@ attribute name="active" required="false" %> <%-- narvar active 초기값 false --%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>

<%--  아랫줄 부터 작성하세요 . navbar 코드를 복붙해오기  --%>


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
        <a class="nav-link" href="http://localhost:8080/main/list">풋살하자<span class="sr-only">(current)</span></a>
      </li> 
    </ul>

	
    <ul class="navbar-nav w-100 bg-secondary px-3 justify-content-end">
	<li class="nav-item active">
        	<a class="nav-link" href="#">공지사항<span class="sr-only">(current)</span></a>
    </li>
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          커뮤니티
        </a>
 
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="#">자유게시판</a></li>
          <li><a class="dropdown-item" href="http://localhost:8080/academy/list">아카데미</a></li>
          <li><a class="dropdown-item" href="#">중고장터</a></li>
        </ul>
       </li>
        
        <c:url value="/qna/qnaMainBoard" var="qnaLink"></c:url>
        <li class="nav-item active">
        	<a class="nav-link ${active eq 'qnaMainBoard' ? 'active' : '' }" href="${qnaLink}">고객문의</a>
      	</li>
        
        <li class="nav-item active">
        	<a class="nav-link" href="#">회원가입<span class="sr-only">(current)</span></a>
      	</li>
      
      	<li class="nav-item active">
       		<a class="nav-link" href="#">로그인<span class="sr-only">(current)</span></a>
     	</li>
      
      
    </ul>


  </div>

</nav>