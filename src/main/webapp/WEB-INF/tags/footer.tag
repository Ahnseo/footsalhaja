<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- c커스텀 태그 사용하기 위해 --%>
<%@ attribute name="active" required="false" %> <%-- narvar active 초기값 false --%>
<style>

ul{
list-style: none;
}

footer {
	width: 100%;
	background: #6D8B74;
}

hr {
    background:#F8F8F8;
    height:2px;
    border:0;
}

#footerWhole {
	color: 	#C0C0C0;
	width: 100%;
	position: relative;
	
}

#footerWhole div {
	display: inline-block; 
	vertical-align: top;
	padding: 0;
	
}

#footerWhole .companyInfo {
	position: absolute;
	right: 0;
}

#footerWhole div ul .first {
	font-size: 20px;
	font-weight: bold;
}

</style>
<footer>

	<hr>
	<!-- border-top: solid; border-color:#F8F8F8; -->
	<div class="container-md" id="footerWhole" >
			<div id="introduction" >
				<ul>
					<li class="first">
						<a href="/main/list" style="color:#C0C0C0">풋살하자</a>
					</li>
		           <li>소개</li>
		           <li>채용</li>
		           <li>공지사항</li>
		           <li><a href='tel:010-XXXX-XXXX' style="color:#C0C0C0">고객센터</a></li>
		        </ul>				
			</div>
	  
    
	      <div>
		       <ul>
		       		<li class="first">SNS</li>
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
	
	    
	       <div class="companyInfo" style="font-size:12px;">
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