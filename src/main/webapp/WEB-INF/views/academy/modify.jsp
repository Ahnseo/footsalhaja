<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- include libraries(jQuery, bootstrap) -->

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.js"></script>

</head>
<body>
	<h1>${board.ab_number }번 게시물 수정</h1>
	
	<form id="modifyForm" action="" method="post" enctype="multipart/form-data">
	<input type="hidden" name="ab_number" value="${board.ab_number }">
	
	제목 <input type="text" name="ab_title" value="${board.ab_title }"> <br>
	  
	말머리 <select name="ab_category">
        <option value="lesson">레슨</option>
        <option value="tip">꿀팁</option>
        <option value="recruitment">팀원모집</option>
        <option value="qna">질문/답변</option>
    </select>
    
    <br>
	
	본문 <textarea id="summernote" name="ab_content">${board.ab_content }</textarea> <br>
	
	<!-- 파일 -->
	<div>
		<c:forEach items="${board.ab_fileName }" var="fileName">
			<div>
				<i class="fa-solid fa-paperclip"></i>
				<c:out value="${fileName.substring(36)}" />
				삭제 <input type="checkbox" name ="removeFiles" value="${fileName}" >
				<br>
			</div>
		</c:forEach>
	</div>
	
		<div class="mb-3">
			<input multiple type="file" class="form-control" name="files">
		</div>
	
	닉네임 <input type ="text" value="${board.nickName }" readonly> <br>
	작성일시 <input type = "datetime-local" value = "${board.ab_insertDatetime }" readonly>
	</form>
	
	<input type="submit" value="수정" data-bs-toggle="modal"
		data-bs-target="#modifyModal">
	
	<!-- 삭제버튼 -->
	<c:url value ="/academy/remove" var="removeLink"></c:url>
	
	<form  id="removeForm" action="${removeLink }" method="post">
		<input type="hidden" name="ab_number" value="${board.ab_number }">
	</form>
	
	<input type="submit" value="삭제" data-bs-toggle="modal"
		data-bs-target="#removeModal">
	
	

	<!-- modify Modal 수정 확인 -->
	<div class="modal fade" id="modifyModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">수정하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button id="modifyConfirmButton" type="button"
						class="btn btn-primary">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- remove Modal 삭제확인 -->
	<div class="modal fade" id="removeModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button id="removeConfirmButton" type="button"
						class="btn btn-danger">확인</button>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>


<!-- 수정&삭제 확인 모달  -->
	 <script>
	
		document.querySelector("#modifyConfirmButton").addEventListener(
				"click", function() {
					document.querySelector("#modifyForm").submit();
				})

		document.querySelector("#removeConfirmButton").addEventListener(
				"click", function() {
					document.querySelector("#removeForm").submit();
				})
	</script>
	
    <script type="text/javascript"> 
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
        

		/**
		* 이미지 파일 업로드
		*/
 		function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			$.ajax({
				data : data,
				type : "POST",
				url : `\${ctx}/academy/uploadSummernoteImageFile`,
				contentType : false,
				enctype : 'multipart/data',
				processData : false,
				success : function(data) {
	            	//항상 업로드된 파일의 url이 있어야 한다. ('insertImage', url, filename)
					$(editor).summernote('insertImage', data.url, data.ab_image);
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