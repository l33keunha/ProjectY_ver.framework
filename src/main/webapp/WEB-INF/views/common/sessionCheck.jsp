<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<c:if test="${ empty sessionScope.uVO }">
		<div class="ConName-background"></div>
		<div class="pleaseLogin">
			<span>로그인시 제공되는 서비스입니다.</span>
			<button id="pleaseLoginBtn" onclick="location.href='goLoginPage.do'">로그인 하러가기</button>
		</div>
	</c:if>
</body>
</html>