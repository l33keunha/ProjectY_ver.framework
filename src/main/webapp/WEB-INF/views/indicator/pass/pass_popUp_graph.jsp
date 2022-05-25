<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="sVO" value="${sVO}"/>
<c:set var="list" value="${passResultList}"/>
<!DOCTYPE html>
<html>
    <head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<script src="http://cdnjs.cloudflare.com/ajax/libs/hammer.js/2.0.8/hammer.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-zoom/1.0.1/chartjs-plugin-zoom.min.js" integrity="sha512-b+q5md1qwYUeYsuOBx+E8MzhsDSZeoE80dPP1VCw9k/KA9LORQmaH3RuXjlpu3u1rfUwh7s6SHthZM3sUGzCkA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/hammer.js/2.0.8/hammer.min.js" integrity="sha512-UXumZrZNiOwnTcZSHLOfcTs0aos2MzBWHXOHOuB0J/R44QB0dwY5JgfbvljXcklVf65Gc4El6RjZ+lnwd2az2g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<link rel="stylesheet" type="text/css" href="resources/css/indicator/chart_popUp.css">
	</head>
    
    	
    <!-- 코드 텍스트 매칭 -->
    <%@ include file="pass_popUp_codeNameMatch.jsp" %>
    
    <body>
      	<div class="wrap">
	        <div class="header">
	            <p>통행 분석 지표</p>
	            <div class="button">
	                <div class="d"><button type="button" id="download">다운로드</button></div>
	                <div class="e"><button type="button" id="exit">닫기</button></div>
	            </div> 
	        </div>
	        
	        <div class="dateform">
				<div>
					<p>&nbsp;분석날짜 : ${dateText}</p>
					<p>분석자료 : ${sVO.provider_text}</p>
					<p>분석지역 : ${anal_area_cd_sido_text} ${anal_area_cd_text}</p>
					<p>&nbsp;분석지표 : ${anal_groupText}</p>
					</div>
					<div>
					<p>&nbsp;${anal_typeText_titleDraw}</p>
					<p>시간대 : ${tmText}</p> 
					<p>이용자유형 : ${cd_noText_slash}</p>
					<p>&nbsp;${tfcmn_titleDraw}</p>
				</div>
	      	</div>
	      	
	      	<div class="infowrap">
				<span class="info">(단위 : 통행량)</span>
		    </div>
	     	
	     	<div class="test">
		     	<div class="content_wrap">
			     	
			     		<%@ include file="graphList/pass_graph.jsp" %>
			     	
		     	</div>
		     </div>
		     
		</div>
    </body> 
  
</html>