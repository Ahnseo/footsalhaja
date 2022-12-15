<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- 구글 열차트 -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['bar']});
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
		<!-- javaScript forEach 문으로  -->
		var data = google.visualization.arrayToDataTable([
		      ['days', '방문자', '예약', '문의'],	  
		      <c:forEach items="${chartList}" var="chart">
				
				['${chart.date}',${chart.visitCount},${chart.bookedCount},${chart.qnaCount}]
				<c:if test="${not empty chartList.size() }">
					,
				</c:if>	
			</c:forEach>  
		    ]);
	
	  var options = {
	    chart: {
	      title: 'Company futsalhaja weeks data',
	      subtitle: '방문자, 예약, 문의 7일 차트',
	    }
	  };
	  var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
	  chart.draw(data, google.charts.Bar.convertOptions(options));
	}

</script>
</head>
<body>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
	div.mainBoard {
		width: 100%;
		height: :1150px;
		
	}
	div.top{
		width: 100%;
		height: 150px;
		
	}
	div.left {
		width: 50%;
		height: 500px;
		float: left;
		box-sizing: border-box;
		
		overflow: scroll;
	}
	div.right {
		width: 50%;
		height: 500px;
		float: right;
		box-sizing: border-box;
		
		overflow: scroll;
	}
	.mr10px{
		margin-right:10px;
	}

</style>
</head>
<body>
	<my:navbar active=""></my:navbar>
	<div class="container">
		<div class="row mt-2 mb-5">
			<div class="col">	
		     	<div class="mainBoard">
		     		<div class="top p-2">
		     			1.오늘의 할일<br>
		     			<span class="mr10px">오늘방문자</span><span class="badge bg-danger rounded-pill mr10px">${todayVisitCount}</span>
		     			<span class="mr10px">예약된 매치</span><span class="badge bg-danger rounded-pill mr10px">${todaybookedCount}</span> 
		     			<span class="mr10px">QnA</span><span class="badge bg-danger rounded-pill mr10px">${todayWaitingQnACount}</span>  
		     		</div>
			        <div class="left p-2">
			        	<div id="columnchart_material" style="width: 620px; height: 450px;"></div>
			        </div>
			        <div class="right p-2">
			        	<nav id="navbar-example1" class="navbar bg-light px-3 mb-3">
					        <a class="navbar-brand" href="#">날짜별 요약 1Month</a>
				        </nav>
				        <div data-bs-spy="scroll" data-bs-target="#navbar-example1" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-light p-3 rounded-2" tabindex="0">
				        	<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>방문자</th>		
										<th>예약</th>
										<th>문의</th>
									</tr>
								</thead>
								<tbody>	
									<c:forEach items="${chartList}" var="chart">
										<tr>
										 	<td>${chart.date}</td>
										 	<td>${chart.visitCount}</td>	 	
										 	<td>${chart.bookedCount}</td>
										 	<td>${chart.qnaCount}</td>
									 	</tr>		
								 	</c:forEach>
								</tbody>
							</table>
						</div>
			        </div>
		        	<div class="left p-2">
			        	<nav id="navbar-example1" class="navbar bg-light px-3 mb-3">
				        	<c:url value="/main/list" var="bookLink"/>
					        <a class="navbar-brand" href="${bookLink}">오늘의 예약</a>
					        <ul class="nav nav-pills">
					        	<li class="nav-item">
					        		<a class="nav-link" href="${bookLink}"><i class="fa-solid fa-link"></i></a>
					        	</li>
					        </ul>
				        </nav>
				        <div data-bs-spy="scroll" data-bs-target="#navbar-example1" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-light p-3 rounded-2" tabindex="0">
					        <ol class="list-group list-group-numbered" >
						    	<c:forEach items="${bookedList}" var="booked">
						    		<c:url value="/main/get" var="bookedLink">
						    			<c:param name="bookId" value="${booked.bookId}"/>
						    		</c:url>
						        	<li class="list-group-item d-flex justify-content-between align-items-start">	
							            
						        		<div class="row">
								            <div class="fw-bold">
								            	<a href="${bookedLink}">
								            		${booked.title}
								            	</a>
								            </div>
								        </div>
								        <div class="row">
									        <div class="col">
										        <div  class="ms-2 me-auto">
										       
									           		<i class="fa-solid fa-user"></i> ${booked.userId}
									            </div>
									            
										        <span class="mr10px">${booked.stadiumName}</span>
										        <span class="mr10px">${booked.bookDate}</span>
										        
										        <c:choose>
											        <c:when test="${booked.bookTime == 6}">
											        	<span class="mr10px">6:00~8:00</span>
											        </c:when>
											        <c:when test="${booked.bookTime == 9}">
											        	<span class="mr10px">9:00~11:00</span>
											        </c:when>
											        <c:when test="${booked.bookTime == 14}">
											        	<span class="mr10px">14:00~16:00</span>
											        </c:when>
											        <c:when test="${booked.bookTime == 18}">
											        	<span class="mr10px">18:00~20:00</span>
											        </c:when>
											        <c:when test="${booked.bookTime == 21}">
											        	<span class="mr10px">21:00~23:00</span>
											        </c:when>
										        </c:choose>
										        
										        <c:if test="${booked.status == 0}">  
										        	<span class="badge bg-success rounded-pill">모집완료</span>   								        	
										        </c:if>
									        </div>
								        </div>
						            </li>           
						        </c:forEach>
					        </ol>
				        </div>
			        </div>
			        <div class="right p-2">
				        <nav id="navbar-example2" class="navbar bg-light px-3 mb-3">
				        	<c:url value="/admin/allQnAList" var="allQnAListLink">
				        		<c:param name="page" value="1"/>
				        		<c:param name="q" value=""/>
				        		<c:param name="t" value="all"/>
				        	</c:url>
					        <a class="navbar-brand" href="${allQnAListLink}">대기중인 QnA</a>
					        <ul class="nav nav-pills">
					        	<li class="nav-item">
					        		<a class="nav-link" href="${allQnAListLink}"><i class="fa-solid fa-link"></i></a>
					        	</li>
					        </ul>
				        </nav>
				        <div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-light p-3 rounded-2" tabindex="0">
					        <ol class="list-group list-group-numbered" >
						    	<c:forEach items="${waitingQnAList}" var="waitingQnA">
						    		<c:url value="/qna/myQnAGet" var="getWatingQnALink">
						    			<c:param name="userId" value="${waitingQnA.userId}"/>
						    			<c:param name="qnaId" value="${waitingQnA.qnaId}"/>
						    		</c:url>
						        	<li class="list-group-item d-flex justify-content-between align-items-start">	
							            <div class="ms-2 me-auto">
								            <div class="fw-bold">
								            	<a href="${getWatingQnALink}">
								            		${waitingQnA.title}
								            	</a>
								            </div>
								            ${waitingQnA.userId}
								        </div>
								        <span class="mr10px">${waitingQnA.ago} </span> 
							            <span class="badge bg-danger rounded-pill">${waitingQnA.status}</span>   
						            </li>           
						        </c:forEach>
					        </ol>
				        </div>
			        </div>	
				</div>	
			</div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>




</body>
</html>