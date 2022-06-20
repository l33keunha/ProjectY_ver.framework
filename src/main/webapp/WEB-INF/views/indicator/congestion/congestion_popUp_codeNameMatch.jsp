<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../../common/sessionCheck_popUp.jsp"%>

   <!-- ▼ 코드 텍스트 매칭 -->
   
         
    <!-- 분석지표 -->
    <c:set var = "anal_groupText" value = "${sVO.anal_group}"/>
    <c:choose>    
         <c:when test = "${anal_groupText == 'congestionRoute'}">
           	 <c:set var = "anal_groupText" value = "노선별"/>
         </c:when>
         <c:when test = "${anal_groupText == 'congestionTopRouteOD'}">
           	 <c:set var = "anal_groupText" value = "노선별 상위 5개"/>
         </c:when>
         <c:when test = "${anal_groupText == 'congestionTopStationOD'}">
           	 <c:set var = "anal_groupText" value = "노선 정류장간 상위 100개"/>
         </c:when>
    	
         <c:otherwise>
           		<c:set var = "anal_groupText" value = ""/>
         </c:otherwise>
	</c:choose>   
	
	
	<!-- 분석유형 -->
    <c:set var = "anal_typeText" value = "${sVO.anal_type}"/>
    <c:choose>    
         <c:when test = "${anal_typeText == 'congestionRoute_CBP'}">
           	 <c:set var = "anal_typeText" value = "평균 재차인원"/>
         </c:when>
         <c:when test = "${anal_typeText == 'congestionRoute_DOC'}">
           	 <c:set var = "anal_typeText" value = "평균 혼잡도"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'congestionTopRouteOD_DOC_max'}">
           	 <c:set var = "anal_typeText" value = "최대 혼잡구간"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'congestionTopRouteOD_DOC_avg'}">
           	 <c:set var = "anal_typeText" value = "평균 혼잡구간"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'congestionTopStationOD_DOC_max'}">
           	 <c:set var = "anal_typeText" value = "최대 혼잡도"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'congestionTopStationOD_DOC_avg'}">
           	 <c:set var = "anal_typeText" value = "평균 혼잡도"/>
         </c:when>
    
         <c:otherwise>
           		<c:set var = "anal_typeText" value = ""/>
         </c:otherwise>
	</c:choose>
	

	
    <!-- 날짜 -->
    <c:set var = "dateStart" value = "${fn:replace(sVO.dateStart, '-' ,'')}"/>
    <c:set var = "dateEnd" value = "${fn:replace(sVO.dateEnd, '-' ,'')}"/>
    
    <!-- 시/도 -->
    <c:set var="anal_area_cd_sido_text" value="${param.anal_area_cd_sido_text}" />

	<!-- 시/군/구 -->
    <c:set var="anal_area_cd_text" value="${param.anal_area_cd_text}" />
        
    <!-- 시간대 -->
    <c:set var = "tmText" value = "${sVO.tm}"/>
    <c:if test="${tmText == 'allDay'}">
    	<c:set var = "tmText" value = "1일"/>
    </c:if>
    <c:if test="${tmText == null}">
    	<c:set var = "tmText" value = "${sVO.tmStart}시 ~ ${sVO.tmEnd}시"/>
    </c:if>
  
  
	
    
    <!-- 날짜 -->
    <c:set var = "dateText" value = "${sVO.dateStart} ~ ${sVO.dateEnd}"/>
    <c:if test="${sVO.dateStart == sVO.dateEnd}">
    	<c:set var = "dateText" value = "${sVO.dateStart}"/>
    </c:if>
    
  
    
	<!-- 분석유형 상단 표출 용-->
    <c:set var = "anal_typeText_titleDraw" value = ""/>
    <c:set var = "tfcmn_titleDraw" value = ""/>
    
    <c:if test = "${anal_groupText == '노선별'}">
   		
   		<c:if test = "${anal_typeText == '평균 재차인원'}">
   			<c:set var = "anal_typeText_titleDraw" value = "분석유형 : 평균 재차인원"/>
		   	<c:set var = "tmText" value = "1일"/>
		    <c:set var = "dateText" value = "${sVO.dateStart}"/>
   		</c:if>
   		<c:if test = "${anal_typeText == '평균 혼잡도'}">
   			<c:set var = "anal_typeText_titleDraw" value = "분석유형 : 평균 혼잡도"/>
		   	<c:set var = "tmText" value = "1일"/>
		    <c:set var = "dateText" value = "${sVO.dateStart}"/>
   		</c:if>
   		
   	</c:if> 
   	
    <c:if test = "${anal_groupText == '노선별 상위 5개'}">
   		
   		<c:if test = "${anal_typeText == '최대 혼잡구간'}">
   			<c:set var = "anal_typeText_titleDraw" value = "분석유형 : 최대 혼잡구간"/>
		   	<c:set var = "tmText" value = "1일"/>
		    <c:set var = "dateText" value = "${sVO.dateStart}"/>
   		</c:if>
   		<c:if test = "${anal_typeText == '평균 혼잡구간'}">
   			<c:set var = "anal_typeText_titleDraw" value = "분석유형 : 평균 혼잡구간"/>
		   	<c:set var = "tmText" value = "1일"/>
		    <c:set var = "dateText" value = "${sVO.dateStart}"/>
   		</c:if>
   		
   	</c:if> 
   	
    <c:if test = "${anal_groupText == '노선 정류장간 상위 100개'}">
   		
   		<c:if test = "${anal_typeText == '최대 혼잡도'}">
   			<c:set var = "anal_typeText_titleDraw" value = "분석유형 : 최대 혼잡도"/>
		   	<c:set var = "tmText" value = "1일"/>
		    <c:set var = "dateText" value = "${sVO.dateStart}"/>
   		</c:if>
   		<c:if test = "${anal_typeText == '평균 혼잡도'}">
   			<c:set var = "anal_typeText_titleDraw" value = "분석유형 : 평균 혼잡도"/>
		   	<c:set var = "tmText" value = "1일"/>
		    <c:set var = "dateText" value = "${sVO.dateStart}"/>
   		</c:if>
   		
   	</c:if> 
   	
  
   	
    
	
        <!-- ▲ 코드 텍스트 매칭 끝 -->
