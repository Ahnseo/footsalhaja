<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- c커스텀 태그 사용하기 위해 --%>
<%@ attribute name="active" required="false" %> <%-- narvar active 초기값 false --%>
<style>



footer {
  margin-top: 100px;
  width: 100%;
  height: 90px;
  bottom: 0px;
  border-top: 1px solid #c4c4c4;
  padding-top: 15px;
  color: #808080;
  font-size: 11px;
  background-color: #ecf0f1;
}

footer a {
  margin: 0 20px 10px 20px;
  color: #808080; font-size: 11px;
  text-align: right;
}

footer a:visited {
  color: #808080;
}

footer div {
  margin-top: 0; margin-bottom: 0;
  text-align: center;
}

footer div span {
  margin-left: 20px;

}

#linkNav {
	text-align: center;
}

.spans {
	margin-top: 20px;
	background-color: #ecf0f1;
	margin-bottom: 20px;
}


</style>
<footer>


    <nav id="linkNav">
        <a href='https://cocoder.tistory.com' target='_blank'>공지사항</a> |
        <a href='https://github.com/cocoder16' target='_blank'>고객문의</a> |
        <a href='https://github.com/cocoder16' target='_blank'>소개</a> |
        <a href='https://github.com/cocoder16' target='_blank'>채용</a> 
    </nav>
    
    <div class="spans">
        <span>대표명: 김풋살</span><br/>
        <span>이메일 : futsalhaja@gmail.com</span><br/>
        <span>Copyright 2020. cocoder. All Rights Reserved.</span>
        <address>서울특별시 강남구 역삼동 하나로</address>
    </div>

</footer>

