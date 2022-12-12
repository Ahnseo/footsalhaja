<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
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
</head>
<body>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
<my:navbar active="getMyQnA"></my:navbar>
<sec:authentication property="name" var="userIdValue"/>	
<div class="container mt-3 mb-3">
	<div class="d-flex">
		<div class="mr-auto p-2"><h1>문의수정</h1></div> 
    </div>
	<div class="row">
		<div class="col">		
			<form action="" method="post" class="form-control row g-3 mb-3">
				<div class="row d-flex">
					<div class="col-md-2">
						<label for="formControlInput1" class="form-label">문의번호</label>
						<input id="formControlInput1" class="form-control" type="hidden" name="qnaId" value="${qna.qnaId}"readonly>						
						<span class="badge bg-primary rounded-pill">${qna.qnaId}</span>
					</div>
					<div class="col-md-2">
						<label for="formControlInput2" class="form-label">카테고리</label>
						<input id="formControlInput2" class="form-control" type="hidden" name="category" value="${qna.category}" readonly>
						<span class="badge bg-primary rounded-pill">${qna.category}</span>
					</div>
				</div>
				<div class="row d-flex">
					<div class="col-md-4">
						<label for="formControlInput5" class="form-label"><i class="fa-solid fa-user"></i></label>
						<input id="formControlInput5" class="form-control" type="hidden" name="" value="" readonly >
						<span class="badge bg-primary rounded-pill">${qna.userId}</span>
					</div>
					<div class="col-md-4">
						<label for="formControlInput6" class="form-label"><i class="fa-regular fa-clock"></i></label>						
						<input id="formControlInput6" class="form-control" type="hidden" name="insertDatetime" value="">						
						<span class="badge bg-primary rounded-pill">${qna.insertDatetime}</span>
					</div>
					<div class="col-md-4">
						<label for="formControlInput7" class="form-label">처리상태</label>	
						<input id="formControlInput7" class="form-control" type="hidden" name="status" value="${qna.status} " readonly >
						<c:if test="${qna.status == '답변대기'}">
							<span class="badge bg-danger rounded-pill">${qna.status}</span>
						</c:if>
						<c:if test="${qna.status != '답변대기'}">
							<span class="badge bg-success rounded-pill">${qna.status}</span>
						</c:if>
					</div>
				</div>
				<div class="mb-3">
					<label for="formControlInput3" class="form-label">제목</label>
					<input id="formControlInput3" class="form-control" type="text" name="title" value="${qna.title}"  >
				</div>	
				<div class="mb-3">
					<label for="formControlInput4" class="form-label">내용</label>
					<textarea id="formControlInput4" class="form-control" name="content">${qna.content}</textarea>
				</div>
			
				<div class = "d-flex flex-row-reverse">
    		    	<!-- 삭제 / 수정 완료버튼  -->
					<div>
						<button class="btn btn-outline-danger" type="submit" id="deleteReqBtn" >삭제</button>
					</div>	
					<div>
						<button class="btn btn-outline-success"  type="submit" id="" >수정완료</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";




</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>