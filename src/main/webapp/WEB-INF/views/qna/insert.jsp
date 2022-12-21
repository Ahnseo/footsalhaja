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

<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');


.container-sm { 
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
	font-size: 16px;
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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

</head>
<body>
	<my:navbar active="insert"></my:navbar>
	<sec:authentication property="name" var="userIdValue"/>
	<div id="freeTitle">
		
		<h2><span><i class="fa-solid fa-envelope"></i></span>문의 작성</h2>
	</div>
	<div class="container-sm">
		<form id="form" action="" method="post"  enctype="multipart/form-data">
			<div class="post_wrap">
				<div class="post_top">
					<div class="top_content">
						<div class="d-flex mt-4">
							<div class="col-sm-4 ">
								<select id="categories" name="category" class="form-select" aria-label="Default select example">
								  <option value="" selected disabled >카테고리</option>
								  <option value="신고/제재">신고/제재</option>
								  <option value="결제문의">결제문의</option>
								  <option value="시설문의">시설문의</option>
								  <option value="기타문의">기타문의</option>
								</select>
							</div>
							<div class="col-sm-4">
							</div>
							<div class="col-sm-4">
								<input type="hidden" name="userId" value="${userIdValue}">
								<i class="fa-solid fa-user"></i> ${userIdValue }
							</div>
						</div>
					
						<label for="" class="form-label mt-3">제목</label>
						<input id="title" class="form-control" name="title" value="" placeholder="제목"/>
					</div><!-- "top_title"  -->
				</div><!-- "post_top" -->
				
				<!-- 문의 본문  -->
				<div class="top_content">
				
					<label for="" class="form-label">내용</label>
					<textarea id="content" class="form-control" name="content"></textarea>
	
					<label for="" class="form-label">파일</label>
					<input multiple type="file" accept="image/*" class="form-control" name="files">
				</div>
				
				<c:set value="false" var="emptyCategory" />
				<c:if test="${not empty category}">
					<c:set value="true" var="emptyCategory" />
				</c:if>
				<div class = "d-flex flex-row-reverse">
					<button class="btn btn-success btn-m5" 
						type="button" id="insertSubmitBtn"
								${ emptyCategory ? 'data-bs-toggle="modal" data-bs-target="#exampleModal"' :''}	>
					등록
					</button>
				</div>
			</div><!-- "post_wrap" -->

		</form>
		
	</div>
	
	
	<!-- Button trigger failModalCategories -->
	<!-- ####### hidden ####### -->
	<input type="hidden" id="failModalCategoriesBtn" class="btn btn-primary" value="카테고리실패모달" data-bs-toggle="modal" data-bs-target="#failModalCategories"/>
	 
	<!-- failModalcategories -->
	<div class="modal fade" id="failModalCategories" tabindex="-1" aria-labelledby="failModalCategoriesLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="failModalCategoriesLabel">문의 등록 실패</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>카테고리를 선택하세요.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">돌아가기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Button trigger failModalTitle -->
	<!-- ####### hidden ####### -->
	<input type="hidden" id="failModalTitleBtn" class="btn btn-primary" value="제목실패모달" data-bs-toggle="modal" data-bs-target="#failModalTitle"/>
	 
	<!-- failModalcategories -->
	<div class="modal fade" id="failModalTitle" tabindex="-1" aria-labelledby="failModalTitleLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="failModalTitleLabel">문의 등록 실패</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>제목을 입력하세요.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">돌아가기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Button trigger failModalContent -->
	<!-- ####### hidden ####### -->
	<input type="hidden" id="failModalContentBtn" class="btn btn-primary" value="본문실패모달" data-bs-toggle="modal" data-bs-target="#failModalContent"/>
	 
	<!-- failModalcategories -->
	<div class="modal fade" id="failModalContent" tabindex="-1" aria-labelledby="failModalContentLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="failModalContentLabel">문의 등록 실패</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>문의내용을 입력하세요.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">돌아가기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<my:footer></my:footer>	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script>
	const form = document.querySelector("#form");
	const insertSubmitBtn = document.querySelector("#insertSubmitBtn");
	var categories = document.querySelector("#categories");
	const title = document.querySelector("#title");
	const content = document.querySelector("#content");
	
	insertSubmitBtn.addEventListener("click", function(e){
		/* 버튼 submit 중지  */
		e.preventDefault();
		
		if(categories.value.trim() != "" &&
		   title.value.trim() != "" &&
		   content.value.trim() != "" ) {
			
			form.submit();
			
		}else if(categories.value.trim() == "") {
			/* 카테고리 value="" => 모달띄우기 */
			document.querySelector("#failModalCategoriesBtn").click();
		}else if(title.value.trim() == "") {
			/* 제목 value="" => 모달띄우기 */
			document.querySelector("#failModalTitleBtn").click();
		}
		else if(content.value.trim() == "") {
			/* 본문내용 value="" => 모달띄우기 */
			document.querySelector("#failModalContentBtn").click();
		}
	});

function failModal() {
	
}




</script>

</body>
</html>