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
	본문 <textarea id="fb_content" name="fb_content"></textarea><br>
	첨부파일 <input type="file" name="fb_fileName"/><br>
	작성자 <input
		value="${userIdValue }"
		 readonly type="text" name="member_userId"/><br>
	
	<input type="submit" value="등록" />
	</form>

	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>

/* const $el = document.querySelector(".box");
const newText = $el.innerHTML.replace(/<[^>]*>?/g, ''); */

<!-- 게시판 에디터 -->
/* $(document).ready(function() {
	$('#summernote').summernote({
		  height: 100,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",				// 한글 설정
        
	});
}); */


</script>
</body>
</html>