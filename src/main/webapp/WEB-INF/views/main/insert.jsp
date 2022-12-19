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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');

#wrapper {
	font-family: 'Noto Sans KR', sans-serif;
	display: block;
	width: 100%;
	background-color: #fff;
	max-width: 928px;
	margin: 0 auto;
}

.contents-box {
	padding: 0 16px 32px;
}

.title {
	color: #000;
	font-size: 25px;
	letter-spacing: -.01em;
	font-weight: 500;
	line-height: 1em;
	padding: 25px 5px 25px 5px;
}

.b1 {
	background-color: #6D8B74;
	border-radius: 5px;
	border-color: #6D8B74;
	color: #fff;
	width: 60px;
	height: 30px;
	float: right;
}

.b2 {
	background-color: #D3D3D3;
	border-radius: 5px;
	border-color: #D3D3D3;
	color: #fff;
	width: 60px;
	height: 30px;
}

.btns {
	display: inline-block;
	margin: 0 5px;
}
</style>
</head>
<body>
	<sec:authentication property="name" var="username"/>
	<my:navbar></my:navbar>


<div class="container-md" id="wrapper">
	<div class="row">
		<div class="col">
			
		<form id="insertForm1" action="/main/insert" method="post">
			<input type="hidden" name="userId" value="${member.userId }" disabled="disabled">

			
				<div class="contents-box">
					<div class="title" style="text-align: center;">매치 작성</div>

					<div class="form-floating mb-3">
						<input type="Date" class="form-control" name="bookDate">
						<label for="floatingInput">예약일정</label>
					</div>
					
					<div class="row g-2">
						<div class="col-md">
							<div class="form-floating">
							<!-- <label for="" class="form-label">예약장소</label> -->
					  	 		<select class="form-select" id="region" name="region">
							      <option value="1">서울</option>
							      <option value="2">경기</option>
					   			</select>
					   			<label for="region">활동 지역</label>
					   		</div>
					   	</div>
					   		<div class="col-md">
					   			<div class="form-floating">
						   			<select class="form-select" name="location_locationId" id="location">
								      <option value="1">천마 풋살파크</option>
								      <option value="2">아디다스 더베이스</option>
								      <option value="3">도봉 루다 풋살장</option>
								      <option value="4">영등포 SKY 풋살파크 A구장</option>
								      <option value="5">은평 롯데몰 A구장</option>
						   			</select>
						   			<label for="location">예약장소</label>
					   			</div>
							</div>
						</div>
						
						<div class="form-floating" style="margin: 18px 0;">
							<select class="form-select" id="bookTime" name="bookTime">
								<option value="6">6:00 ~ 8:00</option>
								<option value="9">9:00 ~ 11:00</option>
								<option value="14">14:00 ~ 16:00</option>
								<option value="18">18:00 ~ 20:00</option>
								<option value="21">21:00 ~ 23:00</option>
							</select>
							<label for="">구장 예약 시간</label>
						</div>
						
						
					<div class="row g-2" style="margin: 18 0;">
						<div class="col-md">
							<div class="form-floating">
								<select class="form-select" id="floatingSelect" name="level">
									<option value="1">비기너</option>
									<option value="2">아마추어</option>
									<option value="3">챌린저</option>
								</select>
								<label for="">매칭 레벨</label>
							</div>
						</div>
						
						<div class="col-md">
							<div class="form-floating">
								<select class="form-select" id="floatingSelect" name="matchType" >
									<option value="3">3 vs 3</option>
									<option value="4">4 vs 4</option>
									<option value="5">5 vs 5</option>
								</select>
								<label for="">매칭 인원</label>
							</div>
						</div>
						
					<div class="col-md">
						<div class="form-floating">
							<select class="form-select" name="teamGender" id="floatingSelect">
								<option value="M">남자</option>
								<option value="F">여자</option>
							</select>
							<label for="">매칭 성별</label>
						</div>
					</div>
				</div>
				
				<!-- <div class="form-floating" style="margin: 18px 0;">
					<select class="form-select" name="status" id="floatingSelect">
						<option value="1">모집중</option>
						<option value="0">모집완료</option>
					</select>
					<label for="floatingSelect">모집상태</label>
				</div> -->
				
				<div class="form-floating mb-3"  style="margin: 18px 0;">
					<input class="form-control" name="title" type="text" placeholder="제목을 입력해주세요.">
					<label for="">제목</label>
		  		</div>
				
				<div class="form-floating mb-3">
					<textarea class="form-control" name="content" style="resize: none; height: 150px;"></textarea>
				</div>
					<div class="row">
						<div class="col">
							<div class="row-g-2">
								<input style="position:relative; right: 0;" class="b1" type="submit" value="등록"> 
								<input class="b2" type="button" value="취소" onclick="location.href='/main/list'">
							</div>		
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
  </div>
<my:footer></my:footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
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
<script>
</script>
</body>
</html>