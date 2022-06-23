<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	.popUp-background{
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100vh;
		transition: .3s;
		background: rgba(0, 0, 0, 0.88);
		z-index: 10001;
		display: block; 
	}
	
	.pleaseLogin{
	    width: 438px;
	    height: 148px;
	    margin-top: 11%;
	    border-radius: 5px;
	    box-shadow: 0px 0 16px 0px #0000002e;
	    padding: 34px;
	    padding-right: 42px;
	    position: fixed;
	    top: 18%;
	    left: 40%;
	    background: #fff;
	    z-index: 10002;
	    display: flex;
	    flex-direction: column;
	}
	
	.pleaseLogin span{
		margin-top: 30px;
	    margin-bottom: 30px;
	    font-size: 25px;
	    font-weight: bold;
	}
	
	#pleaseLoginBtn{
	    background-color: #c7e4ff;
	    color: #004281;
	    width: 127px;
	    height: 40px;
	    font-size: 14px;
	    border-radius: 10px;
	    border: none;
	}
	
	#pleaseLoginBtn:hover{
		color: #c7e4ff;
	    background-color: #004281;
	    box-shadow: 0px 2px 5px #000000;
	    font-weight: bold;
	    cursor:pointer;
	}

</style>

</head>
<body>
	<c:if test="${ empty sessionScope.uVO }">
		<div class="popUp-background"></div>
		<div class="pleaseLogin">
			<span>로그인시 제공되는 서비스입니다.</span>
			<button id="pleaseLoginBtn" onclick="location.href='goLoginPage.do'">로그인 하러가기</button>
		</div>
	</c:if>
</body>
</html>