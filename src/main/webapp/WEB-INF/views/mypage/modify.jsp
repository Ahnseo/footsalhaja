<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>      
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
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
	
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" type="text/css" rel="stylesheet" />
	
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500&display=swap');

.page-section {
	font-family: 'Noto Sans KR', sans-serif;
	letter-spacing: -1px;
}

h2 {
	font-family: 'Noto Sans KR', sans-serif;
	text-align: center;
	padding: 1px;
 }
 
  object {
  font-family: 'Noto Sans KR', sans-serif;
  text-align: center;
  max-width: 250px;
  height: 250px;
  object-fit: cover;
  border-radius: 50%;
}

.defaultImg {
	text-align : center; 
	margin-bottom: 12px;
}

</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
</head>

<body>
<my:navbar active=""></my:navbar>

<section class="page-section" id="contact">
            <div class="container">
                <!-- Contact Section Heading-->
                <h2>회원정보 수정</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                
                <!-- Contact Section Form-->
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-7">
                        <form action="${pageContext.request.contextPath}/mypage/modify" method="post" id="contactForm" data-sb-form-api-token="API_TOKEN" enctype="multipart/form-data">
						<%-- 프로필 이미지 출력 --%>

						<div class= "defaultImg">
							<c:if test="${member.profileImg eq null}">
								<img class= "defaultImg" src="${pageContext.request.contextPath}/기본프로필.png">
							</c:if>
							<c:forEach items="${member.profileImg }" var="name">
								<div class= "containerProfile">	
									<object data="${imgUrl }/user_profile/${member.userId }/${name}" type="image/png">
										<img src="${pageContext.request.contextPath}/기본프로필.png">
									</object>
								</div>
							</c:forEach>			

						</div>	
					
						<div class="form-floating mb-3"">
							<input type="file" accept="image/*" class="form-control" name="file">
						</div>


						<!-- ID -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="userId" type="text" name ="userId" value="${member.userId}" data-sb-validations="required" readonly/>
                                <label for="userId">ID</label>
                            </div>
                            
                            <!-- 비밀번호 -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="password" type="password" name="password" value="${member.password}" data-sb-validations="required" />
                                <label for="password">비밀번호</label>
                            <div class="invalid-feedback" data-sb-feedback="password:required">비밀번호는 필수입력해야 합니다.</div>
                           </div>
                           
                            <!-- 이름 -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="name" type="text" name="name" value="${member.name}" data-sb-validations="required" readonly/>
                                <label for="name">이름</label>
                            </div>
                            
                            <!-- 성별 -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="personalGender" type="text" name="personalGender" value="${member.personalGender}" data-sb-validations="required" readonly/>
                                <label for="personalGender">성별</label>
                            </div>
                            
                            <!-- 닉네임 -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="nickName" type="text" name = "nickName" value="${member.nickName}" data-sb-validations="required" />
                                <label for="nickName">닉네임</label>
                            </div>

                            
                            <!-- 이메일 -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="email" type="email" name="email" value="${member.email}"  data-sb-validations="required,email" />
                                <label for="email">메일주소</label>
                                <div class="invalid-feedback" data-sb-feedback="email:required">메일주소는 필수 입력 해야합니다.</div>
                                <div class="invalid-feedback" data-sb-feedback="email:email">유효하지않은 메일 주소입니다.</div>
                            </div>

                            
						<!-- 회원권한 -->
						<input type="hidden" name="auth" value="${member.auth}" readonly>
						<div class="form-floating mb-3">
							<c:if test="${member.auth eq 'user'}">
								<input class="form-control" id="permission" type="text"
									name="permission" value="일반회원" data-sb-validations="required"
									readonly />
							</c:if>
							<c:if test="${member.auth eq 'manager'}">
								<input class="form-control" id="permission" type="text"
									name="permission" value="매니저" data-sb-validations="required"
									readonly />
							</c:if>
							<c:if test="${member.auth eq 'admin'}">
								<input class="form-control" id="permission" type="text"
									name="permission" value="관리자" data-sb-validations="required"
									readonly />
							</c:if>
							<label for="permission">회원권한</label>
						</div>
						<!-- 생년월일 -->
						<div class="form-floating mb-3">
							<c:if test="${member.birthMM < 10}">
								<c:set var="zeroMM" value="0" />
							</c:if>
							<c:if test="${member.birthDD < 10}">
								<c:set var="zeroDD" value="0" />
							</c:if>

							<input class="form-control" type="text" id="birthYYMMDD"
								name="birthYY"
								value="${member.birthYY}${zeroMM}${member.birthMM}${zeroDD}${member.birthDD}"
								readonly /> <label for="birthYYMMDD">생년월일</label>
						</div>

                            
                            <div class="form-floating mb-3">
	                            <input class="form-control" type="text" name="activityArea" value="${member.activityArea}" readonly />
	                            <label for="activityArea">활동지역</label>
                            </div>
                            
                             <div class="form-floating mb-3">
                                <input class="form-control" id="phone" type="text" name ="phone" value="${member.phone}" data-sb-validations="required" />
                                <label for="phone">전화번호</label>
                            </div>
                            <!-- Submit success message-->
                            <!---->
                            <!-- This is what your users will see when the form-->
                            <!-- has successfully submitted-->
                            <div class="d-none" id="submitSuccessMessage">
                                <div class="text-center mb-3">
                                    <div class="fw-bolder">수정되었습니다</div>
                                </div>
                            </div>
                            <!-- Submit error message-->
                            <!---->
                            <!-- This is what your users will see when there is-->
                            <!-- an error submitting the form-->
                            <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">수정에 실패하였습니다.</div></div>
                            <!-- Submit Button-->
                            <input class="btn btn-primary btn-xl" id="submitButton" type="submit" value="수정"/>
                        </form>
						<form action="${pageContext.request.contextPath}/mypage/delete" method="post">
							<%-- 히든 input userId 사용해서 post 방식으로 controller 에게 값 넘기기 !  --%>
							<input type="hidden" name="userId" value="${member.userId}"> 
							<input class="btn btn-danger" id="submitButton" type="submit" value="탈퇴">
							탈퇴하기 : Foreign Key 함께 삭제하는 코드를 작성해야하므로, 나중에 DB통합 할때 수정하겠습니다 .
						</form>
                    </div>
                </div>
            </div>
        </section>


<my:footer></my:footer>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>