<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.nanumbarungothic * {
 font-family: 'NanumBarunGothic', sans-serif;
}

.container-sm { 
	font-family: 'NanumBarunGothic';
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
<my:navbar></my:navbar>
<input type="hidden" value="${board.fb_number }" />
<input type="hidden" value="${board.member_userId }"  />

<!-- 전체 컨테이너 -->
<div class="container-sm" >

	<form id="modifyForm" action="" method="post" enctype="multipart/form-data">
		<input type="hidden" name="fb_number" value="${board.fb_number}"/>
		<div class="categorySelectBox">
			<p>카테고리</p>
			<select class="categorySelect" name="fb_category">
				<option name="matching">매칭후기</option>
				<option name="stadium">구장후기</option>
				<option name="talk">잡담</option>
			</select>
		</div>
		<div class="row">
			<input class="titleInput" type="text" name="fb_title" value="${board.fb_title }"/>
		</div>
		<div>
			<textarea id="summernote" name="fb_content">${board.fb_content }</textarea>
		</div>
		<div>
			<c:forEach items="${board.fb_fileName }" var="fileName">
				<div>
					<i class="fa-solid fa-paperclip"></i>
					<c:out value="${fileName.substring(36)}" />
					삭제 <input type="checkbox" name ="removeFiles" value="${fileName}" >
					<br>
				</div>
			</c:forEach>
			<input class="form-control" multiple="multiple" type="file" name="files"/>
		</div>
	</form>
			
	<div class="submitBox">
		<input class="btn btn-success" type="submit" value="게시글 수정하기" data-bs-toggle="modal" data-bs-target="#modifyModal">
	</div>
	
</div> <!-- 전체컨테이너 -->
	
	
	<!-- 수정 모달 -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        수정하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="modifyConfirmButton" type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	



	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
	// 수정확인 버튼 클릭하면 수정 form 전송
	document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
		document.querySelector("#modifyForm").submit();
	});
	
	<!-- summernote 게시판 에디터 -->
	const ctx = "${pageContext.request.contextPath}";

	$(document).ready(function() {
		  $('#summernote').summernote({
			minHeight: 370,
		        maxHeight: null,
		        focus: true, 
		        lang : "ko-KR",
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










