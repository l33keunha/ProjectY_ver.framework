<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="sVO" value="${sVO}"/>
<c:set var="list" value="${transferResultList }"/>
<!DOCTYPE html>
<html>
    <head>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script type="text/javascript" src="resources/js/indicator/common_popUp.js" async ></script>
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/pass_popup.css">
    </head>
    
    <!-- 코드 텍스트 매칭 -->
    <%@ include file="congestion_popUp_codeNameMatch.jsp" %>
    
    <iframe id="excelDown" name="excelDown" width="0" height="0"></iframe>
    
	<!-- 다운로드 조회조건 -->
	<form id="downloadForm" action="congestionDownload.do" target="excelDown">
		<div class= "sVOvalue">
			<input name="anal_fin" type="hidden" id="anal_finJS" value="${sVO.anal_fin}"/>
			<input name="dateStart" type="hidden" id="dateStartJS" value="${sVO.dateStart}"/>
			<input name="dateEnd" type="hidden" id="dateEndJS" value="${sVO.dateEnd}"/>
			<input name="anal_area_cd_sido" type="hidden" id="anal_area_cd_sidoJS" value="${sVO.anal_area_cd_sido}"/>
			<input name="anal_area_cd_sido_text" type="hidden" id="anal_area_cd_sido_textJS" value="${sVO.anal_area_cd_sido_text}"/>
			<input name="anal_area_cd" type="hidden" id="anal_area_cdJS" value="${sVO.anal_area_cd}"/>
			<input name="anal_area_cd_text" type="hidden" id="anal_area_cd_textJS" value="${sVO.anal_area_cd_text}"/>
			<input name="provider" type="hidden" id="providerJS" value="${sVO.provider}"/>
			<input name="provider_text" type="hidden" id="provider_textJS" value="${sVO.provider_text}"/>
			<input name="anal_group" type="hidden" id="anal_groupJS" value="${sVO.anal_group}"/>
			<input name="anal_type" type="hidden" id="anal_typeJS" value="${sVO.anal_type}"/>
			<input name="tm" type="hidden" id="tmJS" value="${sVO.tm}"/>
			<input name="tmStart" type="hidden" id="tmStartJS" value="${sVO.tmStart}"/>
			<input name="tmEnd" type="hidden" id="tmEndJS" value="${sVO.tmEnd}"/>
			<input name="tfcmn" type="hidden" id="tfcmnJS" value="${sVO.tfcmn}"/>
			<input name="routeId" type="hidden" id="routeIdJS" value="${sVO.routeId}"/>
		</div>
		<input type="submit" id="downloadSubmitBtn" style="display: none;"/>
	</form>

  
    <body>
     	
      	<div class="wrap">
	        <div class="header">
	            <p>혼잡 분석 지표</p>
	            <div class="button">
	                <div class="g"><button type="button" id="graph">그래프</button></div>
	                <div class="d"><button type="button" id="download">다운로드</button></div>
	                <div class="e"><button type="button" id="exit">닫기</button></div>
	            </div> 
	        </div>
	        
	        <div class="dateform">
	          <div>
	          <p>&nbsp;분석날짜 : ${dateText}</p>
	          <p>분석자료 : ${sVO.provider_text}</p>
	          <p style="width:500px;">분석지역 : ${anal_area_cd_sido_text} ${anal_area_cd_text}</p>
	          <p style="width:500px;">&nbsp;분석지표 : ${anal_groupText}</p>
	          </div>
	          <div>
	          <p>&nbsp;${anal_typeText_titleDraw}</p>
	          <p>시간대 : ${tmText}</p> 
	          <p>&nbsp;${tfcmn_titleDraw}</p>
	          </div>
	      	</div>
	      		
      		<div class="infowrap">
	     		<span class="info">(단위 : 명)</span>
		    </div>
	     	
	     	<div class="test">
		     
		     	<div class="content_wrap">
		     	
		     	<c:if test = "${anal_groupText == '노선별'}">
			   		<c:if test = "${anal_typeText == '평균 재차인원'}">
			   			<%@ include file="tableList/congestion_popUp_route.jsp" %>
			   		</c:if>
			   		<c:if test = "${anal_typeText == '평균 혼잡도'}">
			   			<%@ include file="tableList/congestion_popUp_route.jsp" %>
			   		</c:if>
			   	</c:if> 
		   	
		    	<c:if test = "${anal_groupText == '노선별 상위 5개'}">
			   		<c:if test = "${anal_typeText == '최대 혼잡구'}">
			   			<%@ include file="tableList/congestion_popUp_routeOD.jsp" %>
			   		</c:if>
			   		<c:if test = "${anal_typeText == '평균 혼잡구'}">
			   			<%@ include file="tableList/congestion_popUp_routeOD.jsp" %>
			   		</c:if>
			   	</c:if> 
		   	
		   		<c:if test = "${anal_groupText == '정류장간 상위 100개'}">
			   		<c:if test = "${anal_typeText == '최대 혼잡도'}">
			   			<%@ include file="tableList/congestion_popUp_stationOD.jsp" %>
			   		</c:if>
			   		<c:if test = "${anal_typeText == '평균 혼잡도'}">
			   			<%@ include file="tableList/congestion_popUp_stationOD.jsp" %>
			   		</c:if>
			   	</c:if>
		     	</div>
		     </div>
		</div>
		
    </body> 
  
  	<script>
		$('.lavel-1').each(function () {
			if (this.offsetWidth < this.scrollWidth)
			    $(this).attr('title', $(this).text());
		});
    </script> 
</html>