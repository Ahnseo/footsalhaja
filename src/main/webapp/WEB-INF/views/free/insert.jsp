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
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- include libraries(jQuery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>
<body>
	<sec:authentication property="name" var="userIdValue"/>
	<my:navbar></my:navbar>

	<h1>프리보드 글 작성</h1>
	
	<form action="" method="post">
	카테고리 <select name="fb_category">
				<option>매칭후기</option>
				<option>구장후기</option>
				<option>잡담</option>
			</select>
	<br>
	제목 <input type="text" name="fb_title"/><br>
	본문 <textarea id="summernote" name="fb_content" ></textarea> <br>
	첨부파일 <input type="file" name="fb_fileName"/><br>
	작성자 <input
		value="${userIdValue }"
		 readonly type="text" name="member_userId"/><br>
	
	<input type="submit" value="등록" />
	</form>

	
	
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
	        placeholder: '최대 2048자까지 쓸수 있다 함',	//placeholder 설정
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
			enctype : 'multipart/data',
			contentType : false,
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다. ('insertImage', url, filename)
				$(editor).summernote('insertImage', data.url, data.fb_fileName);
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