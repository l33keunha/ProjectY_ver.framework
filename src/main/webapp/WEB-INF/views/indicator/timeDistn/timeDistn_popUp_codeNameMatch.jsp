<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>


   <!-- ▼ 코드 텍스트 매칭 -->
   
         
    <!-- 분석지표 -->
    <c:set var = "anal_groupText" value = "${sVO.anal_group}"/>
    <c:choose>    
         <c:when test = "${anal_groupText == 'timeDistn_avg_day'}">
           	 <c:set var = "anal_groupText" value = "1일 평균 통행시간/거리"/>
         </c:when>
         <c:when test = "${anal_groupText == 'timeDistn_avg_purpose'}">
           	 <c:set var = "anal_groupText" value = "목적통행 평균 통행시간/거리"/>
         </c:when>
         <c:when test = "${anal_groupText == 'timeDistn_avg_method'}">
           	 <c:set var = "anal_groupText" value = "수단통행 평균 통행시간/거리"/>
         </c:when>
         <c:when test = "${anal_groupText == 'timeDistn_avg_route'}">
           	 <c:set var = "anal_groupText" value = "노선별 평균 통행시간/거리"/>
         </c:when>
    	
         <c:otherwise>
           		<c:set var = "anal_groupText" value = ""/>
         </c:otherwise>
	</c:choose>   
	
	
	<!-- 이용자유형 -->  
    <c:set var = "cd_noText" value = ""/>
    <c:set var = "cd_noLength" value = '${fn:length(sVO.cd_no)}'/>		
    <c:forEach var='j' begin='0' end='${cd_noLength-1}' >	 
			<c:choose>
		         <c:when test = "${sVO.cd_no[j] == '01'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_일반"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '02'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_어린이"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '03'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_청소년"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '04'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_경로"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '05'}">
	           	 	<c:set var = "cd_noText" value = "${cd_noText}_장애인"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '06'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_국가유공자"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '07'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_다자녀부모"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '08'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_동반"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '09'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_대학생"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '10'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_복지"/>
		         </c:when>
		         <c:when test = "${sVO.cd_no[j] == '11'}">
		           	 <c:set var = "cd_noText" value = "${cd_noText}_기타"/>
		         </c:when>
		         <c:otherwise>
		           		<c:set var = "cd_noText" value = ""/>
		         </c:otherwise>
	   		 </c:choose>  
    </c:forEach>
	<c:set var = "cd_noTextLength" value = "${fn:length(cd_noText)}"/>	     
	<c:set var = "cd_noText" value = "${fn:substring(cd_noText,1,cd_noTextLength) }"/>
	<c:set var = "cd_noText_slash" value = "${fn:replace(cd_noText, '_' ,'/')}"/>
   
    
    <!-- 버스 or 지하철 -->
    <c:set var = "tfcmnText" value = "${sVO.tfcmn}"/>
    <c:choose>
    	<c:when test = "${tfcmnText == 'B'}">
           	 <c:set var = "tfcmnText" value = "버스"/>
         </c:when>
         <c:when test = "${tfcmnText == 'T'}">
           	 <c:set var = "tfcmnText" value = "지하철"/>
         </c:when>
         
         <c:otherwise>
           		<c:set var = "tfcmnText" value = "전체"/>
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
    
  
    
	<!-- 이용자 유형 컬럼 갯수 -->
	<c:choose>
		<c:when test="${sVO.cd_no[0] =='00'}">
			<c:set var = "columnCnt" value = '${fn:length(sVO.cd_no)-1}'/>				
		</c:when>
		<c:otherwise>
			<c:set var = "columnCnt" value = '${fn:length(sVO.cd_no)}'/>		
		</c:otherwise>
	</c:choose>
	
	
	
	<!-- 분석유형 상단 표출 용-->
    <c:set var = "anal_typeText_titleDraw" value = ""/>
    <c:set var = "tfcmn_titleDraw" value = ""/>
    
    <c:if test = "${anal_groupText == '1일 평균 통행시간/거리'}">
   		<c:set var = "anal_typeText_titleDraw" value = ""/>
   	</c:if>
    <c:if test = "${anal_groupText == '목적통행 평균 통행시간/거리'}">
   		<c:set var = "anal_typeText_titleDraw" value = ""/>
   	</c:if>
    <c:if test = "${anal_groupText == '수단통행 평균 통행시간/거리'}">
   		<c:set var = "anal_typeText_titleDraw" value = ""/>
   	</c:if>
    <c:if test = "${anal_groupText == '노선별 평균 통행시간/거리'}">
   		<c:set var = "anal_typeText_titleDraw" value = ""/>
   	</c:if>
   	
    
	
        <!-- ▲ 코드 텍스트 매칭 끝 -->
