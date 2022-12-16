<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%-- security 사용하기위해 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Insert title here</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/footsalhaja/src/main/resources/assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
	
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" type="text/css" rel="stylesheet" />
	
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

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

* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

#freeTitle h2 {
	text-align: center;
	padding: 60px;
 }

ul {
   list-style:none;
  }

.container-sm { 
	font-family: 'NanumBarunGothic';
	letter-spacing: -1px;
	font-size: 16px;
}

.post_wrap {
	border: 1px solid #ced4da;
	border-radius: 10px;
	margin: 0 0 30px 0;
}
.reply_wrap {
	border: 1px solid #ced4da;
	border-radius: 10px;
	margin: 0 0 30px 0;
}


/* 상단 버튼부분 */
.topbtnBox {
	margin: 30px 0 15px 0;
	position: relative;
}
.topbtnBox .modifyBtn {
	text-align: right;
	position: absolute;
	top: 0;
	right: 0;
}

/* 상단 제목부분 */
.post_top {
	
}
.post_top .top_category {
	border: 1px solid #ddd;
 	vertical-align: middle;
 	display: inline-block;
 	margin: 20px 20px 0;
 	padding: 0 4px;
 	
 	color: #666;
 	font-size: 14px;
 	font-weight: normal;
}
.post_top .top_title {
	font-size: 20px;
	font-weight: bold;
	margin: 10px 20px;
}
.post_top ul {
	text-align: left;
	padding-left:0;
}
.post_top ul li {
	display: inline-block;
	margin-left: 20px;
	font-size: 13px;
}

.post_wrap .top_content {
	margin: 40px 20px;
	
}
.reply_wrap .reply_content {
	margin: 0px 20px;
	
}
.reply_wrap ul {
	text-align: left;
	padding-left:0;
}
.reply_wrap ul li {
	display: inline-block;
	margin-left: 20px;
	font-size: 13px;
}

.post_wrap .likeBox {
	text-align: center;
}

.likeBox .likeIcon {
	font-size: 26px;
	color: green;
}
.likeBox .likeCount1 {
	font-size: 14px;
	margin-top: -20px;
	color: #333;
}
.likeBox .likeCount2 {
	font-size: 14px;
	margin-top: -15px;
	font-weight: bold;
	color: #333;
	
}


.btn-m5{
	margin : 5px;
}


</style>

</head>
<body>
	<my:navbar active="insert"></my:navbar>
	<sec:authentication property="name" var="userIdValue"/>
	<div id="freeTitle">
		
		<h2><span><i class="fa-solid fa-envelope"></i></span>문의 작성</h2>
	</div>
	<div class="container-sm">
		<form action="" method="post">
		
			<div class="post_wrap">
				<div class="post_top">
					<div class="top_title">
						<div class="d-flex mt-4">
							<div class="col-sm-4 ">
								<select name="category" class="form-select" aria-label="Default select example">
								  <option selected disabled >카테고리</option>
								  <option value="시설문의">시설문의</option>
								  <option value="신고/제재">신고/제재</option>
								  <option value="결제문의">결제문의</option>
								  <option value="기타문의">기타문의</option>
								</select>
							</div>
							<div class="col-sm-4">
							</div>
							<div class="col-sm-4">
								<i class="fa-solid fa-user"></i> ${userIdValue }
							</div>
						</div>
					
						<label for="" class="form-label">제목</label>
						<input id="" class="form-control" name="title" value="" placeholder="제목"/>
					</div><!-- "top_title"  -->
				</div><!-- "post_top" -->
				
				<!-- 문의 본문  -->
				<div class="top_content">
					<label for="" class="form-label">내용</label>
					<textarea id="" class="form-control" name="content"></textarea>
				</div>
				<div class = "d-flex flex-row-reverse">
					
					<button class="btn btn-outline-danger btn-m5" type="button" id="deleteQnABtn" >삭제</button>
					<button class="btn btn-outline-success btn-m5"  type="submit" id="" >수정완료</button>
				</div>
			</div><!-- "post_wrap" -->

		</form>
	</div>
	
	
	
	
	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>