<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pVO" value="${pVO }"/>
<c:set var="list" value="${passResultList }"/>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="css/popup2.css">
    </head>
    
   <!-- ▼ 코드 텍스트 매칭 -->
        
    <!-- 분석자료 -->
    <c:set var = "passOwnerText" value = "${pVO.passOwner}"/>
    <c:choose>     
         <c:when test = "${passOwnerText == '00'}">
           	 <c:set var = "passOwnerText" value = "국토부"/>
         </c:when>
         <c:when test = "${passOwnerText == '09'}">
           	 <c:set var = "passOwnerText" value = "정산사"/>
         </c:when>
    
         <c:otherwise>
           		<c:set var = "passOwnerText" value = ""/>
         </c:otherwise>
    </c:choose>     
         
    <!-- 분석지표 -->
    <c:set var = "passGroupText" value = "${pVO.passGroup}"/>
    <c:choose>    
         <c:when test = "${passGroupText == 'passCnt'}">
           	 <c:set var = "passGroupText" value = "통행량"/>
         </c:when>
         <c:when test = "${passGroupText == 'passODCnt'}">
           	 <c:set var = "passGroupText" value = "기종점통행량"/>
         </c:when>
    	 <c:when test = "${passGroupText == 'passEtc'}">
           	 <c:set var = "passGroupText" value = "기타"/>
         </c:when>
         <c:otherwise>
           		<c:set var = "passGroupText" value = ""/>
         </c:otherwise>
	</c:choose>   
	
	
	<!-- 분석유형 -->
    <c:set var = "passTypeText" value = "${pVO.passType}"/>
    <c:choose>    
         <c:when test = "${passTypeText == 'passCnt_purpose'}">
           	 <c:set var = "passTypeText" value = "목적통행"/>
         </c:when>
         <c:when test = "${passTypeText == 'passCnt_method'}">
           	 <c:set var = "passTypeText" value = "수단통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passCnt_route'}">
           	 <c:set var = "passTypeText" value = "노선별통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passCnt_station'}">
           	 <c:set var = "passTypeText" value = "정류장별통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passODCnt_station_purpose'}">
           	 <c:set var = "passTypeText" value = "정류장별목적통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passODCnt_station_method'}">
           	 <c:set var = "passTypeText" value = "정류장별수단통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passODCnt_dong_purpose'}">
           	 <c:set var = "passTypeText" value = "행정동별목적통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passODCnt_dong_method'}">
           	 <c:set var = "passTypeText" value = "행정동별수단통행"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passEtc_max_route'}">
           	 <c:set var = "passTypeText" value = "최다이용노선"/>
         </c:when>
    	 <c:when test = "${passTypeText == 'passEtc_max_station'}">
           	 <c:set var = "passTypeText" value = "최다이용정류장"/>
         </c:when>
         <c:otherwise>
           		<c:set var = "passTypeText" value = ""/>
         </c:otherwise>
	</c:choose>
	
	
	<!-- 이용자유형 -->  
    <c:set var = "passUserTypeText" value = ""/>
    
    <c:set var = "passUserTypeLength" value = '${fn:length(pVO.passUserType)}'/>		
    <c:forEach var='j' begin='0' end='${passUserTypeLength-1}' >	
	    <c:choose>
	         <c:when test = "${pVO.passUserType[j] == '00'}">
	           	 <c:set var = "passUserTypeText" value = "_일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '01'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_일반"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '02'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_어린이"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '03'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_청소년"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '04'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_경로"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '05'}">
           	 	<c:set var = "passUserTypeText" value = "${passUserTypeText}_장애인"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '06'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_국가유공자"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '07'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_다자녀부모"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '08'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_동반"/>
	         	</c:when>
	         <c:when test = "${pVO.passUserType[j] == '09'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_대학생"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '10'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_복지"/>
	         </c:when>
	         <c:when test = "${pVO.passUserType[j] == '11'}">
	           	 <c:set var = "passUserTypeText" value = "${passUserTypeText}_기타"/>
	         </c:when>
	         <c:otherwise>
	           		<c:set var = "passUserTypeText" value = ""/>
	         </c:otherwise>
	         
	    </c:choose>  
	    
    </c:forEach>
	<c:set var = "passUserTypeTextLength" value = "${fn:length(passUserTypeText)}"/>	     
	<c:set var = "passUserTypeText" value = "${fn:substring(passUserTypeText,1,passUserTypeTextLength) }"/>
   
    
    <!-- 버스 or 지하철 -->
    <c:set var = "passTransportText" value = "${pVO.passTransport}"/>
    <c:choose>
    	<c:when test = "${passTransportText == 'B'}">
           	 <c:set var = "passTransportText" value = "버스"/>
         </c:when>
         <c:when test = "${passTransportText == 'T'}">
           	 <c:set var = "passTransportText" value = "지하철"/>
         </c:when>
         
         <c:otherwise>
           		<c:set var = "passTransportText" value = "전체"/>
         </c:otherwise>
    </c:choose>
   
    <!-- ▲ 코드 텍스트 매칭 끝 -->
    


    <body>
      <div class="wrap">
        <div class="header">
            <p>통행 분석 지표</p>
            <div class="button">
                <button type="button">그래프</button>
                <button type="button">다운로드</button>
                <button type="button">닫기</button>

            </div>
        </div>
        <div class="dateform">
          <div>
          <p>분석날짜 : ${pVO.passDateStart} ~ ${pVO.passTimeEnd}</p>
          <p>분석자료 : ${passOwnerText}</p>
          <p>분석지역 : 경기도</p>
          <p>분석지표 : ${passGroupText}</p>
          </div>
          <div>
          <p>분석유형 : ${passTypeText}</p>
          <p>시간대 : ${pVO.passTimeStart}시 ~ ${pVO.passTimeEnd}시</p> 
          <p>이용자유형 : ${passUserTypeText}</p>
          <p>교통수단 : 전체</p>
          </div>

      </div>
      
      <!-- 정류장별 통행 -->
      <!-- <div class="content_wrap"> -->
		<table class="tabletitle" style="table-layout: fixed; word-wrap: break-word;">
			<thead>
			
				<!-- 이용자 유형 컬럼 갯수 -->
				<c:choose>
					<c:when test="${pVO.passUserType[0] =='00'}">
						<c:set var = "columnCnt" value = '11'/>						
					</c:when>
					<c:otherwise>
						<c:set var = "columnCnt" value = '${fn:length(pVO.passUserType)}'/>		
					</c:otherwise>
				</c:choose>
				
				
				<tr>
					<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">분석일자</th>			<!-- 분석일자 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">광역/도</th>			<!-- 광역/도 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>				<!-- 시/군 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장구분</th>			<!-- 정류장구분 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장명</th>			<!-- 정류장명 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장행정동</th>		<!-- 정류장행정동 -->
					
					<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>				<!-- 시간 -->
					<c:forTokens  var="name" items="${passUserTypeText}" delims="_">
						<th class="tg-0pky" colspan="3" style="width: 210px; min-width: 210px; max-width: 210px;">${name}</th>	<!-- 이용자 유형 -->
					</c:forTokens>
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">승차합계</th>		<!-- 승차합계-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">하차합계</th>		<!-- 하차합계-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">환승합계</th>		<!-- 환승합계-->
				</tr>
				<tr>
					<c:forEach var='j' begin='0' end='${columnCnt-1}' >	
						<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">승차</th>						<!-- 승차-->
						<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">하차</th>						<!-- 하차 -->
						<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">환승</th>						<!-- 환승 -->	
					</c:forEach>
				</tr>
			</thead>
		</table>
      
		<div class="content_wrap">
			<div class="content">
				<table class="tg" style="table-layout: fixed; word-wrap: break-word;">
               		<tbody>
               		
               			<c:set var = "forCnt" value = '${passResultListB.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
						
						<c:set var = "dateCnt" value = "${pVO.passDateEnd - pVO.passDateStart + 1}"/>				<!-- 날짜 종류 갯수 -->
						<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
						
						<c:set var = "timeCnt" value = "${(pVO.passTimeEnd - pVO.passTimeStart + 1) }"/>			<!-- 노선명 반복 갯수-->
						<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									<!-- 노선명 출력 갯수 -->
						
						<c:set var = "indexCnt" value = "0"/>
					
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr>
								<!-- 날짜 그룹이 시작될 때마다 실행-->
								<c:if test="${(j % dateCnt) == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[dateCnt*indexCnt*columnCnt].passdate }</td>	<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;">경기도</td>														<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[0].passareaKr}</td>							<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;">버스</td>															<!-- 정류장구분 -->
									<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
								</c:if>
							
								<!-- 정류장명 그룹이 시작될 때마다 실행 -->
								<c:if test="${(j % timeCnt) == 0}">	   	
									<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].passstationKr }</td>		<!-- 정류장명 -->
									<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[0].passareaKr} <br> ${passResultListB[j * columnCnt].passstationKr }</td>														<!-- 정류장행정동 -->
								</c:if>
						
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalInSum" value = "0"/>			<!-- 승차합 변수 -->	
								<c:set var = "totalOutSum" value = "0"/>		<!-- 하차합 변수 -->	
								<c:set var = "totalHsSum" value = "0"/>			<!-- 환승합 변수 -->	
								
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultListB[j * columnCnt].passtime}</td>	<!-- 시간 -->
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].passstnbincnt}</td>		<!-- 승차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].passstnboutcnt}</td>	<!-- 하차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].passstnbhscnt}</td>		<!-- 환승 -->
								
									<c:set var = "totalInSum" 	value = '${totalInSum + (passResultListB[i].passstnbincnt)}'/>		<!-- 승차합 계산 -->
									<c:set var = "totalOutSum" 	value = '${totalOutSum + (passResultListB[i].passstnboutcnt)}'/>	<!-- 하차합 계산 -->
									<c:set var = "totalHsSum" 	value = '${totalHsSum + (passResultListB[i].passstnbhscnt)}'/>		<!-- 환승합 계산 -->
								</c:forEach>
								
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum}</td>		<!-- 승차합계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalOutSum}</td>		<!-- 하차합계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalHsSum}</td>		<!-- 환승합계 -->
							</tr>
						</c:forEach>
						
						
					</tbody>
				</table>
			</div>
		</div>
    </body>
    
    
    
    
    
</html>