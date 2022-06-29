<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

	<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"></meta>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <!-- <script src="popup01.js"></script> -->
        <!-- <link rel="stylesheet" type="text/css" href="popup.css"> -->
        <link rel="stylesheet" type="text/css" href="resources/css/common/error.css"></link>
    </head>

	<body>
        <div class="wrap">
        	<div class="d"><button type="button" id="exit">메인으로</button></div>
            <div class="e"><button type="button" name="Close" onclick="closeMe()" value=" 창닫기 ">닫기</button></div>
            <div class="img"></div>
        </div>
        <script>
        
            function closeMe() {
                var win=window.open("","_self");
                win.close();
            }
            
        	document.getElementById('exit').onclick = function(){
        		var win=window.open("","_self");
                win.close();
                window.open('goMainPage.do');
        	}
        </script>
    </body>
</html>