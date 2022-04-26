<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>


   <!-- ▼ 코드 텍스트 매칭 -->
        
    <!-- 분석자료 -->
    <c:set var = "providerText" value = "${sVO.provider}"/>
    <c:choose>     
         <c:when test = "${providerText == '00'}">
           	 <c:set var = "providerText" value = "국토부"/>
         </c:when>
         <c:when test = "${providerText == '09'}">
           	 <c:set var = "providerText" value = "정산사"/>
         </c:when>
    
         <c:otherwise>
           		<c:set var = "providerText" value = ""/>
         </c:otherwise>
    </c:choose>     
         
    <!-- 분석지표 -->
    <c:set var = "anal_groupText" value = "${sVO.anal_group}"/>
    <c:choose>    
         <c:when test = "${anal_groupText == 'passCnt'}">
           	 <c:set var = "anal_groupText" value = "통행량"/>
         </c:when>
         <c:when test = "${anal_groupText == 'passODCnt'}">
           	 <c:set var = "anal_groupText" value = "기종점통행량"/>
         </c:when>
    	 <c:when test = "${anal_groupText == 'passEtc'}">
           	 <c:set var = "anal_groupText" value = "기타"/>
         </c:when>
    	 <c:when test = "${anal_groupText == 'passRouteODCnt'}">
           	 <c:set var = "anal_groupText" value = "노선별OD"/>
         </c:when>
    	 <c:when test = "${anal_groupText == 'passTopRotue'}">
           	 <c:set var = "anal_groupText" value = "상위이용노선"/>
         </c:when>
    	 <c:when test = "${anal_groupText == 'passTopStation'}">
           	 <c:set var = "anal_groupText" value = "상위이용정류장"/>
         </c:when>
         
         <c:otherwise>
           		<c:set var = "anal_groupText" value = ""/>
         </c:otherwise>
	</c:choose>   
	
	
	<!-- 분석유형 -->
    <c:set var = "anal_typeText" value = "${sVO.anal_type}"/>
    <c:choose>    
         <c:when test = "${anal_typeText == 'passCnt_purpose'}">
           	 <c:set var = "anal_typeText" value = "목적통행"/>
         </c:when>
         <c:when test = "${anal_typeText == 'passCnt_method'}">
           	 <c:set var = "anal_typeText" value = "수단통행"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'passCnt_route'}">
           	 <c:set var = "anal_typeText" value = "노선별통행"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'passCnt_station'}">
           	 <c:set var = "anal_typeText" value = "정류장별통행"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'passAreaODCnt_purpose'}">
           	 <c:set var = "anal_typeText" value = "행정동목적"/>
         </c:when>
    	 <c:when test = "${anal_typeText == 'passAreaODCnt_method'}">
           	 <c:set var = "anal_typeText" value = "행정동수단"/>
         </c:when>
    
         <c:otherwise>
           		<c:set var = "anal_typeText" value = ""/>
         </c:otherwise>
	</c:choose>
	
	
	<!-- 이용자유형 -->  
    <c:set var = "cd_noText" value = ""/>
    <c:set var = "cd_noLength" value = '${fn:length(sVO.cd_no)}'/>		
    <c:forEach var='j' begin='0' end='${cd_noLength-1}' >	 
	    <c:if test="${sVO.cd_no[0] =='00'}">
			<c:set var = "cd_noText" value = "_일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타"/>			
		</c:if>
		<c:if test="${sVO.cd_no[0] !='00'}">
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
		</c:if>   
    </c:forEach>
	<c:set var = "cd_noTextLength" value = "${fn:length(cd_noText)}"/>	     
	<c:set var = "cd_noText" value = "${fn:substring(cd_noText,1,cd_noTextLength) }"/>
   
    
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
    
    <c:if test="${anal_typeText == '정류장별통행'}">
    	<c:set var = "tmText" value = "1일"/>
    	<c:set var = "dateText" value = "${sVO.dateStart}"/>
    </c:if>
    <c:if test="${anal_typeText == '행정동목적'}">
    	<c:set var = "tmText" value = "1일"/>
    	<c:set var = "dateText" value = "${sVO.dateStart}"/>
    </c:if>         
    <c:if test="${anal_typeText == '행정동수단'}">
    	<c:set var = "tmText" value = "1일"/>
    	<c:set var = "dateText" value = "${sVO.dateStart}"/>
    </c:if>
    <c:if test="${anal_typeText == '상위이용노선'}">
    	<c:set var = "tmText" value = "1일"/>
    	<c:set var = "dateText" value = "${sVO.dateStart}"/>
    </c:if>
    <c:if test="${anal_typeText == '상위이용정류장'}">
    	<c:set var = "tmText" value = "1일"/>
    	<c:set var = "dateText" value = "${sVO.dateStart}"/>
    </c:if>
    
            
        <!-- ▲ 코드 텍스트 매칭 끝 -->
