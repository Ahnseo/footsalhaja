<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- c커스텀 태그 사용하기 위해 --%>
<%@ attribute name="active" required="false" %> <%-- narvar active 초기값 false --%>
<style>
ul{
list-style: none;
}
#footerWhole {
	position: relative;
	display: flex;
	padding: 20px;
	color: 	#C0C0C0; 		
}
#footerWhole > a{
	color: black; 
}

hr {
    background:#F8F8F8;
    height:2px;
    border:0;
}
</style>
<footer>

	<hr>
	<!-- border-top: solid; border-color:#F8F8F8; -->
	<div class="container-md" id="footerWhole" style="position: absolute; left: 350px; height: 180px;">
			<div id="introduction" style="position: absolute; left: 50px; bottom: 160px; font-size:15px;font-weight: bold; color: black;">
				<a href="/main/list" style="color:#C0C0C0">
					풋살하자			
				</a>				
			</div>
			<div style="font-size:12px;">
				<ul>
		           <li>소개</li>
		           <li>채용</li>
		           <li>공지사항</li>
		           <li><a href='tel:010-XXXX-XXXX' style="color:#C0C0C0">고객센터</a></li>
		        </ul>
			</div>
	 	
	  
    
	       <div id="sns" style="font-size: 15px; font-weight: bold; position: absolute; left:130px; bottom: 160px;" >
	       SNS
	      </div>
	      <div style="font-size: 20px;">
	       <ul>
	       		<li>
		       		<a href="https://www.instagram.com" style="color:#C0C0C0"/>
					<i class="fa-brands fa-instagram"></i>	
					</a>	
				</li>		
				<li>
					<a href="https://ko-kr.facebook.com/" style="color:#C0C0C0">
					<i class="fa-brands fa-facebook"></i>
					</a>
				</li>		
			</ul>							
	       </div>
	
	     
	    
	       <div id="companyInfo" style="font-size:12px; position: absolute; right: -40px; bottom: 37px;">
	       <ul>
		      <li>주소: 서울특별시 강남구 역삼동 하나로</li>	 
		      <li>대표메일: contact@futsalhaja.com</li>
		      <li>마케팅 제안: team@futsalhaja.com | 02-xxx-xxxx</li>
		      <li>사업자 번호: 000-11-xxxx | 대표: 하나로</li>
		      <li>통신판매업 신고 2020</li>
		      <li>Copyright PLAB All rights reserved.</li>
		      <li>이용약관 | 개인정보 처리방침 | 사업자 정보 확인</li>
		    </ul>   
	       </div>        
	</div>
 	
</footer>