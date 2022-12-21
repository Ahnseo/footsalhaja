<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');


.container-sm { 
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
	font-size: 16px;
}
.categorySelectBox {
	text-align: left;
}

.categorySelectBox p {
	display: inline-block;
	color: #333;
	font-size: 20px;
	padding-left: 5px;
}

.categorySelectBox .categorySelect {
	display: inline-block;
	width : 100px;
	height: 40px;
	border: 0;
	outline:none;
	margin: 30px 0 15px 10px;
	font-size: 20px;
	font-weight: bold;
}

.categorySelectBox .categorySelect option {
	font-size: 16px;
	color: #666;
	font-weight: normal;
}

.row {
	margin: 15px auto;
	padding: 0 16px;
}

.row .titleInput {
	height: 50px;
	border: 0;
	border-radius: 5px;
	outline: 1px solid #ced4da;
	
	color: #333;
	font-size:16px;
}

.form-control {
 margin: 30px auto;
}

.submitBox {
	text-align: center;
	
}

.submitBox .btn {
	font-size: 20px;
	padding: 5px 30px;
}


</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

<!-- include libraries(jQuery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
<body>
	<sec:authentication property="name" var="userIdValue"/>
	<my:navbar></my:navbar>

<!-- 전체 컨테이너 -->
<div class="container-sm" >

	<form action="" method="post" enctype="multipart/form-data">
		<div class="categorySelectBox">
			<p>카테고리</p>
			<select class="categorySelect" name="fb_category">

				<option name="매칭후기">매칭후기</option>
				<option name="구장후기">구장후기</option>
				<option name="잡담">잡담</option>

			</select>
		</div>
		<div class="row">
			<input class="titleInput" type="text" name="fb_title" placeholder="제목을 입력해주세요."/><br>
		</div>
		<div>
			<textarea id="summernote" name="fb_content" ></textarea>
		</div>
		<div>
			<input multiple="multiple" type="file" class="form-control" name="files"/>
		</div>
	<input
		value="${userIdValue }"
		readonly type="hidden" name="member_userId"/><br>
		<div class="submitBox">
			<input class="btn btn-success" type="submit" value="게시글 등록" />
		</div>
	</form>
	
</div><!-- 전체 컨테이너 -->
	
<my:footer></my:footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>

<!-- summernote 게시판 에디터 -->
const ctx = "${pageContext.request.contextPath}";

$(document).ready(function() {
	  $('#summernote').summernote({
		minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : "ko-KR",
	        placeholder: '내용을 입력해주세요.',	//placeholder 설정
		callbacks: {	//여기 부분이 이미지를 첨부하는 부분
			onImageUpload: function(files, editor) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            	uploadSummernoteImageFile(files[i], this);
	            }
			}
		}
	});
    

	/* 이미지 파일 업로드*/
		function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : `\${ctx}/free/uploadSummernoteImageFile`,
			contentType : false,
			enctype : 'multipart/data',
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다. ('insertImage', url, filename)
				$(editor).summernote('insertImage', data.url, data.fb_image);
            	/* //이미지가 업로드 되면, 하위에 테스트 확인차 추가하도록 해놓은 부분
				$('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>'); */
			}
		});
	} 

 $("<textarea />").html($("#summernote").summernote("code")).text().replace(/(<([^>]+)>)/ig,"");

})


</script>
</body>
</html>