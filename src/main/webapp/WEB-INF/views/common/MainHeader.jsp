<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/css/common/mainHeader.css">
<title>Insert title here</title>
</head>
<body>
	<div class = " header">
	    <div class="logo">
	        <a onclick="location.href='goMainPage.do'" style="cursor:pointer;"><svg id="레이어_2" data-name="레이어 2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 300"><defs><style>.cls-1{fill:#1f2958;}.cls-2{fill:#545e93;}.cls-3{fill:none;stroke:#1f2958;stroke-miterlimit:10;stroke-width:7px;}.cls-4{fill:#98a4d1;}</style></defs><path class="cls-1" d="M143.29,9.11c-14.86,1.49-19.16,4.12-27.56,16.7-8.8,13.35-16.23,25.49-27.24,45C86.37,74.54,85.7,77,85.7,82V107c0,17.35,1.88,18.17,21.16,20.13V134H38.14v-6.86C56.84,125,58.41,124.46,58.41,107V82.73c0-4.32-.9-6.28-3.18-10.18-7-12.39-15.06-25.69-28.07-46.2C18.69,13,15.71,10.4,1.89,9.11V2.25H64V9.11C48.58,11,49.19,13.64,53.09,20.67c8.12,14,18.09,31,27,45.9,7.21-12.13,18.7-32.52,25-44.46,4.59-8.82,3.18-11.25-13.55-13V2.25h51.81Z"/><path class="cls-1" d="M123.09,84.16l-14.22,0V77.51l37.18.06V84.2l-14.22,0L131.76,122H123Z"/><path class="cls-1" d="M149.09,77.58l15.75,0c10.13,0,17.56,2.83,17.55,11a10,10,0,0,1-6.86,9.61v.27C181,99.6,185,103,185,109c0,8.89-8.1,13-18.95,13l-17,0Zm16,38.33c7.23,0,11.27-2.32,11.28-7.32,0-4.68-3.9-6.72-11.25-6.74h-7.39l0,14.06ZM164,96c6.87,0,9.8-2.4,9.8-6.26,0-4.3-3.21-5.93-9.6-5.94l-6.42,0,0,12.21Z"/><path class="cls-1" d="M185.94,116.39,191,111a20.4,20.4,0,0,0,12.83,5.09c5.54,0,8.59-2.25,8.6-5.72,0-3.66-3.17-4.83-7.64-6.55l-6.73-2.65c-4.85-1.83-9.95-5.3-9.94-11.8,0-7.08,7-12.52,16.56-12.5a22.81,22.81,0,0,1,15.17,5.69l-4.49,5a16.79,16.79,0,0,0-10.69-3.83c-4.67,0-7.72,2-7.72,5.2,0,3.5,3.74,4.79,7.82,6.31l6.64,2.53c5.85,2.21,10,5.56,9.93,12,0,7.2-6.65,13.2-17.7,13.18A26.91,26.91,0,0,1,185.94,116.39Z"/><path class="cls-2" d="M283.74,117l8.22-8.68c1.34-1.42,3-2.21,4.28-2l9.91,1.69c1.35.23,1.86,1.59,1.21,3.32-1.64,4.37-5.52,12.24-12.79,14.15a2.93,2.93,0,0,1-1.52,0l-9.88-2.81C281.28,122.18,281.56,119.31,283.74,117Z"/><line class="cls-3" x1="41.94" y1="130.61" x2="258.58" y2="130.61"/><path class="cls-1" d="M258.26,134.06c-4-1.08-2.74-19.6,14.26-30.52.5-.32,11.05-7,13.76-5.51C291.67,101.05,264.29,135.66,258.26,134.06Z"/><path class="cls-4" d="M275.63,124.93a6.08,6.08,0,0,0-4.06,2.68,11.55,11.55,0,0,1-5.46,4.81,22.55,22.55,0,0,1-5.26,1.72c-.77.16-.55.84.29.91L298,137.86c.61,0,1-.31.74-.64C296,134.14,285.36,122.61,275.63,124.93Z"/></svg></a>
	    </div>
	    <span class="logo02"></span>
	    
	    <c:if test="${ !empty sessionScope.uVO }">
	        <span style="position: absolute;float: right;bottom: 2px;right: 289px;color: #001687;font-size: 11px;padding: 1px 6px;"><span>${sessionScope.uVO.name}</span>님 환영합니다.</span>
	        <div class="mtap">
	        <a onclick="location.href='logout.do'" style="cursor:pointer;"><p>로그아웃</p></a>
	    </c:if>
	    
	    <c:if test="${ empty sessionScope.uVO }">
	        <div class="mtap">
	        <a onclick="location.href='goLoginPage.do'" style="cursor:pointer;"><p>로그인</p></a>
	    </c:if>
	    
	        <a onclick="location.href='goMainPage.do'" style="cursor:pointer;"><p>Home</p></a>
	        <p>Contact Us</p>
	        <div class="dropdown">
	            <button class="dropbtn">전체 메뉴</button>
	        </div>
	    </div>
	</div>
	<div style="width: 1336px;margin-top: -2px;">
		<div class="nav">
			<div class="nav__content">
				<ul class="nav__list">
					<!-- 선택항목에 addclass active-nav 추가 -->
					<li class="nav__list-item"><a onclick="location.href='goMainPage.do'" class="hover-target">Home</a></li>
					<li class="nav__list-item"><a href="../indicator/pass/pass_index.jsp" class="hover-target">교통카드 빅데이터 분석</a></li>
					<li class="nav__list-item"><a href="#" class="hover-target">승용차 경로탐색</a></li>
					<li class="nav__list-item"><a href="#" class="hover-target">대중교통 경로탐색</a></li>
					<li class="nav__list-item"><a href="#" class="hover-target">버스수요/노선 개편</a></li>
					<li class="nav__list-item"><a href="#" class="hover-target">고위험군 위험형태</a></li>
					<li class="nav__list-item"><a href="#" class="hover-target">HVI 차량분석</a></li>
					<li class="nav__list-item"><a href="#" class="hover-target">교통예측 정보</a></li>
				</ul>
			</div>
		</div>
	</div>
	<script>

		(function ($) {
			var app = function () {
				var body = undefined;
				var menu = undefined;
				var menuItems = undefined;
				var init = function init() {
					body = document.querySelector('body');
					menu = document.querySelector('.dropbtn');
					menuItems = document.querySelectorAll('.nav__list-item');
					applyListeners();
				};
				var applyListeners = function applyListeners() {
					menu.addEventListener('click', function () {
						return toggleClass(body, 'nav-active');
						return toggleClass(this, '.visit');
					});
				};
				var toggleClass = function toggleClass(element, stringClass) {
					if (element.classList.contains(stringClass)) element.classList.remove(stringClass); else element.classList.add(stringClass);
				};
				init();
			}();
		})(jQuery);

	</script>
</body>

</html>