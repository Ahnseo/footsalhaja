<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.lang.Deprecated" %>
<%
	//오늘 날짜 구하기
	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
	//한달 후 날짜 구하기
	Date addMonth = new Date();
    
    int getNowMM = nowDate.getMonth();
    
    addMonth.setMonth(getNowMM + 1);
    
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" charset="UTF-8" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
<link href="//fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<style>
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');



/* 플로팅 버튼 */
.fab-container {
	position: fixed;
	bottom: 50px;
	right: 50px;
	z-index: 999;
	cursor: pointer;
}

.fab-icon-holder {
	width: 50px;
	height: 50px;
	border-radius: 100%;
	background: #6D8B74;
	
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
}

.fab-icon-holder:hover {
	opacity: 0.8;
}

.fab-icon-holder i {
	display: flex;
	align-items: center;
	justify-content: center;
	
	height: 100%;
	font-style: 25px;
	color: #ffffff;
}

.fab {
	width: 60px;
	height: 60px;
	background: #5F7161;
}

.fab-options {
	list-style-type: none;
	margin: 0;
	
	position: absolute;
	bottom: 70px;
	right: 0;
	
	opacity: 0;
	
	transition: all 0.3s ease;
	transform: scale(0);
	transform-origin: 85% bottom;
}

.fab:hover + .fab-options, .fab-options:hover {
	opacity: 1;
	transform: scale(1);
}

.fab-options li {
	display: flex;
	justify-content: flex-end;
	padding: 5px;
}

.fab-label {
	padding: 2px 5px;
	align-self: center;
	user-select: none;
	white-space: nowrap;
	border-radius: 3px;
	font-size: 16px;
	background: #666666;
	color: #ffffff;
	box-shadow: 0 6px 20px rgba(0,0,0,0.2);
	margin-right: 10px;
}

#body {
	max-width: 928px;
	margin: 0 auto;
	background-color: #fff;
	
}

#wrapper {
	display: block;
	width: 100%;
	background-color: #fff;
	letter-spacing: -1px;
	font-family: 'Noto Sans KR', sans-serif;
}

#idOfUl {
	margin: 0 auto;
	width: 1000px;
	text-align: center;
}

#idOfUl li {
	margin: 0;
}

/* 게시글 body */
.contents-box {
	display: -webkit-box;
	padding: 0 16px;
	width: 100%;
	height: 42px;
	box-sizing: border-box;
	background-color: #000;
	
}

.matches {
	display: block;
	width: 100%;
}

.listHover:hover {
	background-color: #D3D3D3;
	cursor: pointer;
}

.listStat {
	display: table-cell;
	vertical-align: middle;
}


.ing1, .ing2, .list-match-time {
	display: inline-block;
	width:100px; 
}


.bookTime {
	padding-right: 10px;
}

.listDate, .timeFont {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	margin-bottom: 3px;
	text-align: center;
	font-size: 14px;
	margin: auto;
}

.list-match-info {
	width: 60%;
	height: 30px;
	text-align: left;
}

.listGender, .listMatchType, .listRegion, .listLevel {
	display: inline-block;
	font-size: 10px;
}

.list-group li {
	display: table;
	text-align: center;
}

.datepick_wrap {
	position:relative;
	display: inline-block;
	
}

.stadiumName {
	text-align: left;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 16px;
	font-weight: 500;
	
}

.btn-ing1 {
	background-color: #0c70f2;
	color: #fff;
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
	border: 1px solid #0c70f2;
	width: 90px;
	height: 45px;
}

.btn-ing2 {
	background-color: #D30000;
	color: #fff;
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
	border: 1px solid #D30000;
	width: 90px;
	height: 45px;
}

.writer {
	text-align: center;
	width: 80px;
	height: 25px;
	padding-top: 10px;
	padding-bottom: 10px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
	margin-left: 30px;
	margin-right: 30px;
}

.listGender::before {
	content: "|";
}

.listMatchType::before {
	content: "|";
}

.listLevel::before {
	content: "|";
}

.opt {
	text-align: center;
	padding-bottom: 20px;
}

/* 달력 디자인 */
 .ui-widget-header { border: 0px solid #dddddd; background: #fff; } 

 .ui-datepicker-calendar>thead>tr>th { font-size: 14px !important; } 

 .ui-datepicker .ui-datepicker-header { position: relative; padding: 10px 0; } 

 .ui-state-default,
 .ui-widget-content .ui-state-default,
 .ui-widget-header .ui-state-default,
 .ui-button,
 html .ui-button.ui-state-disabled:hover,
 html .ui-button.ui-state-disabled:active { border: 0px solid #c5c5c5; background-color: transparent; font-weight: normal; color: #454545; text-align: center; } 

 .ui-datepicker .ui-datepicker-title { margin: 0 0em; line-height: 16px; text-align: center; font-size: 14px; padding: 0px; font-weight: bold; } 

 .ui-datepicker { display: none; background-color: #fff; border-radius: 4px; margin-top: 10px; margin-left: 0px; margin-right: 0px; padding: 20px; padding-bottom: 10px; width: 300px; box-shadow: 10px 10px 40px rgba(0, 0, 0, 0.1); z-index: 9999 !important;} 

 .ui-widget.ui-widget-content { border: 1px solid #eee; } 

 #datepicker:focus>.ui-datepicker { display: block; } 

 .ui-datepicker-prev,
 .ui-datepicker-next { cursor: pointer; } 

 .ui-datepicker-next { float: right; } 

 .ui-state-disabled { cursor: auto; color: hsla(0, 0%, 80%, 1); } 

 .ui-datepicker-title { text-align: center; padding: 10px; font-weight: 100; font-size: 20px; } 

 .ui-datepicker-calendar { width: 100%; } 

 .ui-datepicker-calendar>thead>tr>th { padding: 5px; font-size: 20px; font-weight: 400; } 

 .ui-datepicker-calendar>tbody>tr>td>a { color: #000; font-size: 12px !important; font-weight: bold !important; text-decoration: none;}

 .ui-datepicker-calendar>tbody>tr>.ui-state-disabled:hover { cursor: auto; background-color: #fff; } 

 .ui-datepicker-calendar>tbody>tr>td { border-radius: 100%; width: 44px; height: 30px; cursor: pointer; padding: 5px; font-weight: 100; text-align: center; font-size: 12px; } 

 .ui-datepicker-calendar>tbody>tr>td:hover { background-color: transparent; opacity: 0.6; } 

 .ui-state-hover,
 .ui-widget-content .ui-state-hover,
 .ui-widget-header .ui-state-hover,
 .ui-state-focus,
 .ui-widget-content .ui-state-focus,
 .ui-widget-header .ui-state-focus,
 .ui-button:hover,
 .ui-button:focus { border: 0px solid #cccccc; background-color: transparent; font-weight: normal; color: #2b2b2b; } 

 .ui-widget-header .ui-icon { background-image: url("${pageContext.request.contextPath}/btns.png"); } 

 .ui-icon-circle-triangle-e { background-position: -20px 0px; background-size: 36px; } 

 .ui-icon-circle-triangle-w { background-position: -0px -0px; background-size: 36px; } 

 .ui-datepicker-calendar>tbody>tr>td:first-child a { color: red !important; } 

 .ui-datepicker-calendar>tbody>tr>td:last-child a { color: #0099ff !important; } 

 .ui-datepicker-calendar>thead>tr>th:first-child { color: red !important; } 

 .ui-datepicker-calendar>thead>tr>th:last-child { color: #0099ff !important; } 

 .ui-state-highlight,
 .ui-widget-content .ui-state-highlight,
 .ui-widget-header .ui-state-highlight { border: 0px; background: #f1f1f1; border-radius: 50%; padding-top: 10px; padding-bottom: 10px; } 

 .inp { padding: 10px 10px; background-color: #f1f1f1; border-radius: 4px; border: 0px; } 

 .inp:focus { outline: none; background-color: #eee; }
 
 .btnSearch {
 	background-color: #6D8B74;
	border-radius: 5px;
	border-color: #6D8B74;
	color: #fff;
	width: 60px;
	height: 30px;
 }

</style>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.js"></script> 
<body>
<%-- 시큐리티 로그인된 userId = userIdValue -> ${userIdValue } 으로 사용하겠습니다.--%>
<sec:authentication property="name" var="userIdValue"/>

<c:url value="/main/insert" var="insertLink" >
	<c:param name="userId" value="${userIdValue }"></c:param>
</c:url>
<c:url value="/mypage/list" var="mypageLink" >
	<c:param name="userId" value="${userIdValue }"></c:param>
</c:url>
<c:url value="/member/login" var="loginLink"></c:url>

<c:url value="/qna/myQnAList" var="myQnAListLink">
<c:param name="userId" value="${userIdValue}"/>
	<c:param name="page" value="1"/>
	<c:param name="c" value=""/>
	<c:param name="t" value="all"/>
	<c:param name="q" value=""/>
</c:url>

<my:navbar active="mainLink"></my:navbar>

<div id="wrapper">
	<!-- carousel slide -->
	<div id="body" class="container">
        <div class="row">
            <div class="col">
                <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true" data-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner" style="border-radius: 5%">
                        <div class="carousel-item active">
                            <img src="${pageContext.request.contextPath}/광고4.png" class="w-100" style="height: 400px; width: 750px;"alt="...">
                            <div class="carousel-caption d-none d-md-block">
                                <h5></h5>
                                <p></p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/광고5.png" class="w-100" style="height: 400px; width: 750px;" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                                <h5></h5>
                                <p></p>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/광고6.png" class="w-100" style="height: 400px; width: 750px;" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                                <h5></h5>
                                <p></p>
                            </div>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

<!-- 플로팅 버튼 -->
<sec:authorize access="isAuthenticated()" var="loggedIn"/>
<c:if test="${loggedIn }">
<div class="fab-container">
	<div class="fab fab-icon-holder">
		<i class="fa-solid fa-pen-nib"></i>
	</div>

	<ul class="fab-options">
		<li>
			<span class="fab-label">작성하기</span>
			<div onclick="location.href='${insertLink}'" class="fab-icon-holder">
				<i class="fa-solid fa-pen-nib"></i>
			</div>
		</li>
		<li>
			<span class="fab-label">마이페이지</span>
			<div onclick="location.href='${mypageLink}'" class="fab-icon-holder">
				<i class="fa-solid fa-circle-user"></i>
			</div>
		</li>
		<li>
			<span class="fab-label">문의하기</span>
			<div onclick="location.href='${myQnAListLink }'" class="fab-icon-holder">
				<i class="fa-solid fa-headset"></i>
			</div>
		</li>
		<!-- <li>
			<span class="fab-label">달력</span>
			<div class="fab-icon-holder">
				<i class="fa-solid fa-calendar-week"></i>
			</div>
		</li> -->
		
	</ul>
</div>
</c:if>

<c:if test="${not loggedIn }">
	<div class="fab-container">
		<div onclick="location.href='${loginLink}'" class="fab fab-icon-holder"><i class="fa-solid fa-pen-nib"></i></div>
	</div>
</c:if>


<!-- 데이트 피커 -->
<!-- <input type="text" name="sdate" id="sdate" value="">
<input type="text" name="edate" id="edate" value=""> -->




<%-- <nav id="navbar-example2" class="navbar bg-light px-3 mb-3">
	<a class="navbar-brand" href="${listLink}">예약 리스트</a>
	  <ul class="nav nav-pills">
		 <li class="nav-item">
			<a class="nav-link" href="#scrollspyHeading1">First</a>
		</li>
	  </ul>
</nav> --%>


            

	<div id="getId" class="">
	  <div data-bs-spy="scroll" data-bs-target="#navbar-example2"  data-bs-smooth-scroll="true" class="scrollspy-example p-5 rounded-2 " tabindex="0">
		<div class="row">
			<!-- 현재 날짜 설정 사용할거면, 쓰세요 -->
			<c:set value="<%=sf.format(nowDate)%>" var="nowDate"/>
			<!-- ${nowDate}  -->
			
			<!-- 한달후 날짜 설정 사용할거면, 쓰세요 -->
			<c:set value='<%=sf.format(addMonth)%>' var="addMonth" /> 
			<!-- ${addMonth}  -->
			
			<form name="searchForm">
			<div class="opt">
				<label for="" style="margin-right: 5px;">달력 조회</label>
				<div class="datepick_wrap"><input style="width: 120px;" type="text" class="datepicker" placeholder="날짜 선택" value="${datepickerSday}" id="datepickerSday" name="datepickerSday"></div>
				<span class="waveStr">~</span>
				<div class="datepick_wrap"><input style="width: 120px;" type="text" class="datepicker" placeholder="날짜 선택" value="${datepickerEday} "id="datepickerEday" name="datepickerEday"></div>
				<input class="btnSearch" type="button" id="btnSearch" value="조회">
			</div>
			</form>
			
		<ul class="list-group" id="idOfUl">
			<c:forEach items="${bookList }" var="main">
				<c:url value="/main/get" var="getLink">
					<c:param name="bookId" value="${main.bookId}"/>
				</c:url>
				<li class="list-group-item d-flex justify-content-between align-items-start listHover" onclick="location.href='${getLink}'">	
					<div class="list-match-time">
						<p class="listDate">${main.bookDate} </p>
							<!-- 예약 시간 -->
							<c:if test="${main.bookTime eq 6}">
								<p class="timeFont">06:00</p>
							</c:if>
							<c:if test="${main.bookTime eq 9}">
								<p class="timeFont">09:00</p>
							</c:if>
							<c:if test="${main.bookTime eq 14}">
								<p class="timeFont">14:00</p>
							</c:if>
							<c:if test="${main.bookTime eq 18}">
								<p class="timeFont">18:00</p>
							</c:if>
							<c:if test="${main.bookTime eq 21}">
								<p class="timeFont">21:00</p>
							</c:if>
					</div>
						
							
						
						<div class="list-match-info">
							<div class="stadiumName">
							<!-- 구장이름, 성별, 매치방식, 실력 -->
								<c:choose>
									<c:when test="${main.locationId eq 1 }">
									 	천마 풋살파크
									</c:when>
									<c:when test="${main.locationId eq 2 }">
									 	아디다스 더베이스
									</c:when>
									<c:when test="${main.locationId eq 3 }">
									 	도봉 루다 풋살장
									</c:when>
									<c:when test="${main.locationId eq 4 }">
									 	영등포 SKY 풋살파크 A구장
									</c:when>
									<c:when test="${main.locationId eq 5 }">
									 	은평 롯데몰 A구장
									</c:when>
									<c:when test="${main.locationId eq 6 }">
									 	피치 부천 이마트 부천점
									</c:when>
									<c:when test="${main.locationId eq 7 }">
									 	용인 기흥 낫소 풋살파크
									</c:when>
									<c:when test="${main.locationId eq 8 }">
									 	칼라힐 풋살파크 B구장
									</c:when>
									<c:when test="${main.locationId eq 9 }">
									 	인천 더 베스트 풋볼파크 구월점
									</c:when>
									<c:when test="${main.locationId eq 10 }">
									 	하남 감일 장수천 풋살파크
									</c:when>
								</c:choose>
							</div>
							
								<!-- 지역 -->
								<div class="listRegion">
									<c:if test="${main.region eq 1}">
										<span>서울</span>
									</c:if>
									<c:if test="${main.region eq 2}">
										<span>경기</span>
									</c:if>
								</div>
								
								<!-- 매치방식 -->
								<div class="listMatchType">
									<c:if test="${main.matchType eq 3 }">
										<span class="typeFont">3vs3</span>
									</c:if>
									<c:if test="${main.matchType eq 4 }">
										<span>4vs4</span>
									</c:if>
									<c:if test="${main.matchType eq 5 }">
										<span>5vs5</span>
									</c:if>
								</div>
							
								<!-- 성별 -->
								<div class="listGender">
									<c:if test="${main.teamGender eq 'M' }">
										<span class="genderFont">남자</span>
									</c:if>
									<c:if test="${main.teamGender eq 'F' }">
										<span class="genderFont">여자</span>
									</c:if>
								</div>
												
								<!-- 레벨 -->
								<div class="listLevel">
									<c:if test="${main.level eq 1}">
										<span>비기너</span>
									</c:if>
									<c:if test="${main.level eq 2}">
										<span>아마추어</span>
									</c:if>
									<c:if test="${main.level eq 3}">
										<span>챌린저</span>
									</c:if>
								</div>
						</div>
						
						<div class="writer">
							${main.nickName}
						</div>
						
						
						
							
						<!-- 모집중, 모집완료 -->
						<div class="listStat">
							<c:if test="${main.status eq 0}">
								<button class="btn-ing2 ">모집완료</button>
							</c:if>
	
							<c:if test="${main.status eq 1}">
								<button class="btn-ing1">모집중</button>
							</c:if>
						</div>
					</li>        
			</c:forEach>
		</ul>
		</div>
	</div>
</div>
</div>
<my:footer></my:footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<script>
$(function(){
	   $("input[id^='datepicker']").each(function() {
	      var date_id = "#" + this.id;
	      
	      $(date_id).datepicker({
	         dateFormat: 'yy-mm-dd',         
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         dayNamesShort: ['일','월','화','수','목','금','토'],
	         dayNamesMin: ['일','월','화','수','목','금','토'],
	         showMonthAfterYear: true,
	         yearSuffix: '.',         
	         minDate: 0,
	         maxDate: "+3M"
	      });
	      
	      var now = new Date();
	      firstDate = new Date(now.getFullYear(),now.getMonth());  
	      //$(date_id).val($.datepicker.formatDate('yy-mm-dd', now));      
	   }) 
	   
	});

$(document).ready(function(){
	$('#btnSearch').on('click', function(){
	   var startDate = $('#datepickerSday').val();
	   var endDate = $('#datepickerEday').val();

		console.log("startDate : " + startDate + " / endDate : " + endDate );
		var frm = document.searchForm;
		frm.method = "Get";
		frm.action ="list";
		frm.submit();
	});
});


$(window).ready(function() {
	$('.carousel').carousel({
	  interval: 3500
	});
});

</script>
</body>
</html>