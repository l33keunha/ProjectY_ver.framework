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
    <div class="ConName">
        <div class="contents">
            <a onclick="location.href='goPassIndex.do'" id="passCate" style="cursor: pointer;"><span>통행분석</span></a>
            <a onclick="location.href='goTransferIndex.do'" id="transferCate" style="cursor: pointer;"><span>환승분석</span></a>
            <a onclick="location.href='goCongestionIndex.do'" id="congestionCate" style="cursor: pointer;"><span>혼잡분석</span></a>
            <a onclick="location.href='goTimeDistnIndex.do'" id="timeDistnCate" style="cursor: pointer;"><span>시간/거리분석</span></a>
            <a href="#"><span>운행분석</span></a>
            <a href="#"><span>지도분석</span></a>
            <a onclick="location.href='goDownloadIndex.do'" id="downloadcate" style="cursor: pointer;"><span>다운로드</span></a>
        </div>
    </div>
</body>
</html>