<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
     <link rel="stylesheet" type="text/css" href="resources/css/user/login.css">
     <script src ="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<div class="wrap">
            <!-- 해더 -->
            <div class="lodcon">
	            <div class="bg-illust"></div>
	            <div class="wraplog">
	           <div class="logo03">
	           	<h1>Log-In</h1>
	           </div>
	            <section class="login-input-section-wrap">
		            <form action="login.do" method="post">
		                <div class="login_wrap">
		                    <div class="login-input-wrap">
		                        <input placeholder="Username" type="text" name="id"></input>
		                    </div>
		                    <div class="login-input-wrap password-wrap">
		                        <input placeholder="Password" type="password" name="pwd"></input>
		                    </div>
		                </div>
		                <input type='submit'style='display: none;'>
	               </form> 
	               
	                <div class="login-button-wrap">
	                     <button style="cursor:pointer;" onclick="checkUser();">Sign in</button>
	                </div>
	            </section>
	            </div>
	            
               </div>
        </div>
        <footer>
         <span>(주)와이비에스[서울] 서울시 관악구 관악로 122, 401호(봉천동, 평창빌딩) 2호선 서울대입구역 2번 출구 관악구청 방향 도보 500M</span>
         <span> 2017 YBS CO., LTD. ALL RIGHT RESERVED.</span>
        </footer>
</body>

<script>
	function checkUser(){
		var jsonArray = {};
		var id = $("input[name=id]").val();
		var pwd = $("input[name=pwd]").val();
		
		jsonArray["id"] = id;
		jsonArray["pwd"] = pwd;
		
		$.ajax({
			url: 'checkUser.do',
			type: 'post',
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				if(data.uList != null){
					if(data.uList[0].state == "idOK") {
						$("input[name=pwd]").focus();
						alert("비밀번호가 틀렸습니다.");
					} else if(data.uList[0].state == "exist"){
						$("form").submit();
					} 
				} else {
					$("input[name=id]").focus();
					alert("계정이 없는 사용자입니다.");
				} 
			}
		})
	}


</script>
</html>
