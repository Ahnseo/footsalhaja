<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
	integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
#body {
	max-width: 928px;
	margin: 0 auto;
	background-color: #fff;
}

#wrapper {
	display: block;
	width: 100%;
	background-color: black;
}

.contents-box {
	padding: 0 16px 32px;
}

.title {
	color: #000;
	font-size: 20px;
	letter-spacing: -.01em;
	font-weight: 500;
	line-height: 1em;
	padding: 25px 5px 25px 5px;
}
</style>
</head>
<body>
	<sec:authentication property="name" var="username"/>
	<my:navbar></my:navbar>


	<div id="wrapper">

		<form id="insertForm1" action="/main/insert" method="post">
			<input type="text" name="userId" value="${member.userId }"
				disabled="disabled">

			<div id="body">
				<div class="contents-box">
					<div class="title">매치 작성</div>

					<div class="mb-3">
						<input required="required" type="text" class="form-control"
							name="title" placeholder="제목을 작성해주세요">
					</div>

					<div class="mb-3">
						<label for="" class="form-label">예약날짜</label> <input type="Date" name="bookDate" />
					</div>

					<div class="mb-3">
						<label for="" class="form-label">예약시간</label> <select id="bookTime" name="bookTime">
							<option value="16:00 ~ 18:00">16:00 ~ 18:00</option>
							<option value="18:00 ~ 20:00">18:00 ~ 20:00</option>
							<option value="20:00 ~ 22:00">20:00 ~ 22:00</option>
						</select>
					</div>
	
					<div class="mb-3">
					   <label for="" class="form-label">예약장소</label>
					   <select id="region" name="region">
					      <option value="1">서울</option>
					      <option value="2">경기</option>
					   </select>
					   <select name="location_locationId" id="location">
					      <option value="1">천마 풋살파크</option>
					      <option value="2">아디다스 더베이스</option>
					      <option value="3">도봉 루다 풋살장</option>
					      <option value="4">영등포 SKY 풋살파크 A구장</option>
					      <option value="5">은평 롯데몰 A구장</option>
					   </select>
		  			 </div>
			
					<!-- items은  mainController에서 정해준 값 > 아래 위치 참조  
					/prj1-20221115/src/main/java/com/study/controller/member/MemberController.java - @GetMapping("list")
				-->
					<%-- 	<c:forEach items="${memberList }" var="member">
					<option value="${member.id }">${member.nickName }</option>
				</c:forEach> --%>

					<div class="mb-3">
						<label for="" class="form-label">매칭</label> <select
							name="matchType" id="matchType">
							<option value="3">3 vs 3</option>
							<option value="4">4 vs 4</option>
							<option value="5">5 vs 5</option>
						</select>
					</div>

					<div class="mb-3">
						<label for="" class="form-label">실력</label> <select name="level"
							id="level">
							<option value="1">비기너</option>
							<option value="2">아마추어</option>
							<option value="3">챌린저</option>
						</select>
					</div>

					<div class="mb-3">
						<label for="" class="form-label"> 팀 성별</label> <input type="radio"
							name="teamGender" id="male" value="M">남 <input
							type="radio" name="teamGender" id="female" value="F">여
					</div>

					<div class="mb-3">
						<label for="" class="form-label">모집상태</label> <input type="radio"
							name="status" id="status1" value="1">모집 중 <input
							type="radio" name="status" id="status2" value="0">모집 완료
					</div>

					<div class="mb-3">
						<label for="" class="form-label">본문</label>
						<textarea required="required" rows="10" class="form-control"
							name="content"></textarea>
					</div>

					<input type="submit" value="작성 완료"> <input type="button"
						value="작성 취소" onclick="location.href='/main/list'">
				</div>


			</div>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
   $(document).ready(function() {
         $('#region').change(function() {
            var res = $('#region option:selected').val();
            var option = '';
            console.log(res);
            if (res == '1') {
               console.log("1");
               option += '<option value="1">천마 풋살파크</option>';
               option += '<option value="2">아디다스 더베이스</option>';
               option += '<option value="3">도봉 루다 풋살장</option>';
               option += '<option value="4">영등포 SKY 풋살파크 A구장</option>';
               option += '<option value="5">은평 롯데몰 A구장</option>';
            
            } else {
               console.log("2");
               option += '<option value="6">피치 부천 이마트 부천점</option>';
               option += '<option value="7">용인 기흥 낫소 풋살파크</option>';
               option += '<option value="8">칼라힐 풋살파크 B구장</option>';
               option += '<option value="9">인천 더 베스트 풋볼파크 구월점</option>';
               option += '<option value="10">하남 감일 장수천 풋살파크</option>';
            }
            $('#location').empty().append(option);
         });
      });
</script>
</body>
</html>