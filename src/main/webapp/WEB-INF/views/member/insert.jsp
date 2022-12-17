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

<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" type="text/css" rel="stylesheet" />
<!-- Font awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- Bootswatch -- >
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<!--  Google font -->
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap" rel="stylesheet">

<style>
/* 글씨폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');
.container-sm { 
	font-family: 'NanumBarunGothic';
	letter-spacing: -1px;
	font-size: 16px;
}
#freeTitle h2 {
	text-align: center;
	padding: 60px;
}	
.btn-m5{
	margin : 5px;
}
</style>


</head>
<body>
<!--현재 member테이블 의 컬럼들 ( userId, name, password, nickName, email, birthYY, birthMM, birthDD, activityArea, phone, personalGender, permission ) -->
<my:navbar active="insert"></my:navbar>

<!-- 전체 컨테이너 -->
<div class="container-sm pt-5 pb-5">
	<div class="row ">
		<div class="col-5  m-auto">
			<h3>회원가입</h3>
			
			<form action="" method="post">
			 	<div class="mb-3">
				   아이디
					<div class="input-group mb-3">
					    <input id="userIdInput1" type="text" class="form-control" name="userId"  placeholder="ID" aria-describedby="button-addon1">
					    <button class="btn btn-primary" type="button" id="userIdExist">중복확인</button>
					 </div>
				   	<div id="userIdText1" class="form-text">아이디 중복확인을 해주세요.</div>
			 	 </div>  
   			
   			 	<div class="mb-3">
			   	 비밀번호
				    <div class="input-group mb-3">
				      <input type="password" id="passwordInput1" class="form-control" name="password"  placeholder="Password">
				    </div>
				      <div id="passwordText1" class="form-text"></div>
			  	</div>  
			   
			    <div class="mb-3">
			   	 비밀번호 확인
				    <div class="input-group mb-3">
				      <input type="password" id="passwordInput2" class="form-control" >
				    </div>
			  	</div>  
			   
			    <div class="mb-3">
				    이름
				    <div class="input-group mb-3">
				      <input type="text" class="form-control" name="name"  placeholder="Name" aria-label="" >
				    </div>
				</div>  
				
				<div class="mb-3">
				닉네임 
				<div class="input-group mb-3">
				   <input id="nickNameInput1" type="text" class="form-control" name="nickName"  placeholder="Nickname" aria-describedby="button-addon1">
			       <button class="btn btn-primary" type="button" id="nickNameExist">중복확인</button>
			    </div>
			    	<div id="nickNameText1" class="form-text">별명 중복확인을 해주세요.</div>
			   </div>   
			   
			   <div class="mb-3">
					이메일
					<div class="input-group mb-3">
					   <input id="emailInput1" type="email" class="form-control" name="email"  placeholder="Email" aria-describedby="button-addon1">
				       <button class="btn btn-primary" type="button" id="emailExist">중복확인</button>
				    </div>	
				    	<div id="emailText1" class="form-text">이메일 중복확인을 해주세요.</div>	
				</div>   
				
				생년월일 
				<div class="d-flex">
					<select class="input-group mb-3 form-control mr-2" id="birthYY" name="birthYY" >
					  <option value="">YY</option>
					  <c:forEach var="i" begin="1990" end="2023">
					    <option value="${i}">${i}</option>
					  </c:forEach>
					</select>
					  
					<select class="input-group mb-3 form-control mr-2" id="birthMM" name="birthMM" >
					  <option value="">MM</option>
					  <c:forEach var="i" begin="1" end="12">
						  <c:choose>
						      <c:when test="${i lt 10 }">
						          <option value="0${i}">0${i}</option>
						      </c:when>
						      <c:otherwise>
						          <option value="${i}">${i}</option>
						      </c:otherwise>
						  </c:choose>
					  </c:forEach>
					</select>
					  
					<select class="input-group mb-3 form-control  mr-2" id="birthDD" name="birthDD" >
					  <option value="">DD</option>
					  <c:forEach var="i" begin="1" end="31">
					  <c:choose>
					      <c:when test="${i lt 10 }">
					          <option value="0${i}">0${i}</option>
					      </c:when>
					      <c:otherwise>
					          <option value="${i}">${i}</option>
					      </c:otherwise>
					  </c:choose>
					  </c:forEach>
					</select>
				</div>	
				
				
				성별
				<select class="input-group mb-3 form-control" name="personalGender" >
					<option value="M" selected="selected">남자(M)</option>
					<option value="F">여자(F)</option>
				</select>

				활동지역 
				<div class="input-group mb-3">
			      <input type="text" class="form-control" name="activityArea"  placeholder="Activity Area" aria-label="" >
			    </div>
				
 			<div class="mb-3">
					전화번호 
					<div class="input-group mb-3">
					   <input id="phoneInput1" type="text" class="form-control" name="phone"  placeholder="Phone Number" aria-describedby="button-addon1">
				    </div>
				</div>
			 	
			
				<div class="d-flex flex-row-reverse">
					<input disabled id="signUpButton" class="btn btn-primary" type="submit" value="회원가입">
				</div>
				
			</form>
		</div>
	</div>
</div>	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
//아이디 사용 가능
let availableId = false;
//패스워드 사용 가능
let availablePassword = false;
//별명 사용 가능
let availableNickName = false;
//이메일 사용 가능
let availableEmail = false;

function enableSubmitButton() {
	const button = document.querySelector("#signUpButton");
	if (availableId && availableEmail && availablePassword && availableNickName) {
		button.removeAttribute("disabled")
	} else {
		button.setAttribute("disabled", "");
	}
}

//id input 변경시 submit 버튼 비활성화
document.querySelector("#userIdInput1").addEventListener("keyup", function() {
	availableId = false;
	enableSubmitButton();
});

// 이메일 input 변경시 submit 버튼 비활성화
document.querySelector("#emailInput1").addEventListener("keyup", function() {
	availableEmail = false;
	enableSubmitButton();
});

//비밀번호 input 변경시 submit 버튼 비활성화
document.querySelector("#passwordInput1").addEventListener("keyup", function() {
	availablePassword = false;
	enableSubmitButton();
});

//이메일 중복확인
document.querySelector("#emailExist").addEventListener("click", function() {
	availableEmail = false;
	const email = document.querySelector("#emailInput1").value;
	
	fetch(`\${ctx}/member/existEmail`, {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify({email})
	})
		.then(res => res.json())
		.then(data => {
			document.querySelector("#emailText1").innerText = data.message;
			
			if (data.status == "not exist") {
				availableEmail = true;
				enableSubmitButton();
			}
		});
});


//아이디 중복확인
document.querySelector("#userIdExist").addEventListener("click", function() {
	availableId = false;
	// 입력된 userId를
	const userId = document.querySelector("#userIdInput1").value;
	
	// fetch 요청 보내고
	fetch(ctx + "/member/existId/" + userId)
		.then(res => res.json())
		.then(data => {
			// 응답 받아서 메세지 출력
			document.querySelector("#userIdText1").innerText = data.message;
			
			if (data.status == "not exist") {
				availableId = true;
				enableSubmitButton();
			}
		}); 
	
});

//별명 중복확인
document.querySelector("#nickNameExist").addEventListener("click", function() {
	availableNickName = false;
	// 입력된 별명을
	const userId = document.querySelector("#nickNameInput1").value;
	
	// fetch 요청 보내고
	fetch(ctx + "/member/existNickName/" + userId)
		.then(res => res.json())
		.then(data => {
			// 응답 받아서 메세지 출력
			document.querySelector("#nickNameText1").innerText = data.message;
			
			if (data.status == "not exist") {
				availableNickName = true;
				enableSubmitButton();
			}
		}); 
	
});

/* 패스워드 일치하는 지 확인 시작 */
const passwordInput1 = document.querySelector("#passwordInput1");
const passwordInput2 = document.querySelector("#passwordInput2");
const passwordText1 = document.querySelector("#passwordText1");

function matchPassword() {
	availablePassword = false;
	
	const value1 = passwordInput1.value;
	const value2 = passwordInput2.value;
	
	if (value1 == value2) {
		passwordText1.innerText = "패스워드가 일치합니다.";
		availablePassword = true;
	} else {
		passwordText1.innerText = "패스워드가 일치하지 않습니다.";
	}
	
	enableSubmitButton();

}

passwordInput1.addEventListener("keyup", matchPassword);
passwordInput2.addEventListener("keyup", matchPassword);
/* 패스워드 일치하는 지 확인 끝 */
</script>

</body>
</html>