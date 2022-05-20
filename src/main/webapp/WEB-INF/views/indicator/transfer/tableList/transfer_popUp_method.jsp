<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		
		<!-- 행 계산 변수 -->
		
 		
		<c:set var="columnCnt" value='${columnCnt+1}' />											<!-- 컬럼 반복 횟수 (합계 포함) -->
 		
		<c:set var = "forCnt" value = '${transferResultList.size()/columnCnt}'/>					<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
		
		<c:set var = "dateCnt" value = "${dateEnd - dateStart + 1}"/>								<!-- 날짜 종류 갯수 -->
		<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
		
		<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 2)}"/>							<!-- 시간 반복 갯수-->
		<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									<!-- 시간 출력 갯수 -->
		
		<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->

 		<!-- 보여줄 row 개수 -->
 		<c:set var = "rowShow" value ="500" />	
 
 
 
 
 
 
 		<!-- ● 수단별통행 -->
		<div class="table-left">
			<div class="table1">
				<table style="border-collapse: collapse;">
					
					<!--thead 시작▼-->
					<thead>
						 <tr>
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">광역/도</th>							<!-- 광역/도 -->
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>								<!-- 시/군 -->
							<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>								<!-- 날짜 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>								<!-- 요일 -->								
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">수단</th>								<!-- 수단 -->								
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>								<!-- 시간 -->	
						 </tr>
					</thead>
					<!--thead 끝▲-->
					
				</table>	
			</div>
			
			
			<div class="table2">
				<table style="border-collapse: collapse;">
					
					<!--tbody 시작▼-->	
					<tbody>
					
						<!-- 데이터 뿌려주는 부분 -->
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr>
								<!-- 시간대 : 1일 -->
								<c:if test="${sVO.tm == 'allDay'}">
									<c:if test = "${j == 0}">
											<td class="tg-0pky" rowspan='${forCnt}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>				<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>						<!-- 시/군 -->												
										</c:if>
										
										<c:if test="${(j % dateCnt) == 0}">	   
											<td class="tg-0pky" rowspan='${dateCnt}' 	style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${transferResultList[j*columnCnt].opratDate}</div></td>			<!-- 날짜 -->
											<td class="tg-0pky" rowspan='${dateCnt}' 	style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${transferResultList[j*columnCnt].dy}</div></td>					<!-- 요일 -->
										</c:if>
										
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><div class="lavel-2">${transferResultList[j*columnCnt].tfcmn}</div></td>				<!-- 수단 -->
									
									<c:if test="${(j % forCnt) == 0}">	 
										<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;">전체</td>															<!-- 시간 -->
									</c:if>
								</c:if>
								
								
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
									<!-- 조회한 시간에 따라 실행 -->
									<c:if test="${(j % timeCnt) == 0}">	   												
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-0pky" rowspan='${forCnt}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>				<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>						<!-- 시/군 -->												
										</c:if>
										
										<c:if test="${(j % dateCnt) == 0}">	   
											<td class="tg-0pky" rowspan='${timeCnt*4}' 	style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${transferResultList[j*columnCnt].opratDate}</div></td>			<!-- 날짜 -->
											<td class="tg-0pky" rowspan='${timeCnt*4}' 	style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${transferResultList[j*columnCnt].dy}</div></td>					<!-- 요일 -->
										</c:if>
										
										<td class="tg-0pky" rowspan='${timeCnt}' 	style="width: 100px; min-width: 100px; max-width: 100px;"><div class="lavel-2">${transferResultList[j*columnCnt].tfcmn}</div></td>				<!-- 수단 -->
										 
										<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
									</c:if>
									<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${transferResultList[j*columnCnt].tm}</td>		<!-- 시간 -->
								</c:if>
							</tr>
						</c:forEach>

					</tbody>
					<!--tbody 끝▲-->	
					
				</table>
			</div>
		</div>
		
		
		
		
		
		<div class="tableright"></div>	
		<div class="tableright" style="float: left;width: 10px;">
			<div class="tableright01">
				<table style="border-collapse: collapse;">
				
					<!--헤더 시작▼-->
					<thead>
						<tr>
						 	<c:forTokens  var="name" items="${cd_noText}" delims="_">
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${name}</th>		<!-- 이용자 유형 -->
							</c:forTokens>
							<c:if test="${sVO.anal_type == 'transferCnt_method'}">
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">합계</th>			<!-- 합계-->
							</c:if>
							<c:if test="${sVO.anal_type == 'transferTime_method'}">
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">평균</th>			<!-- 합계-->
							</c:if>
							<c:if test="${sVO.anal_type == 'transferDistn_method'}">
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">평균</th>			<!-- 합계-->
							</c:if>
						</tr>
					</thead>
					<!--헤더 끝▲-->
					
				</table>
			</div>
			
			<div class="tableright02" >
				<table  style="border-collapse: collapse;">
				
					<!--바디 시작▼-->
					<tbody>
						
						
						<!-- 데이터 뿌려주는 부분 -->
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
						
							<tr>
								<!-- 컬럼 갯수대로 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:forEach var='i' begin='${st}' end='${ed-1}' >	    
								
									<!-- 컬럼에 따른 Size 변수 -->
									<c:set var="tdSize" value="${70}" />
									<c:if test="${i == (ed-1)}">
										<c:set var="tdSize" value="${100}" />
									</c:if>
									<c:if test="${sVO.anal_type == 'transferCnt_method'}">
									<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${transferResultList[i].userCntAgg}"/></td>				<!-- 이용자유형-->
									</c:if>
									<c:if test="${sVO.anal_type == 'transferTime_method'}">
									<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${transferResultList[i].userTimeAvg}"/></td>				<!-- 이용자유형-->
									</c:if>
									<c:if test="${sVO.anal_type == 'transferDistn_method'}">
									<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${transferResultList[i].userDistAvg}"/></td>				<!-- 이용자유형-->
									</c:if>
								</c:forEach>
							</tr>
							
						</c:forEach>
						
					</tbody>
					<!--바디 끝▲-->
				
				</table>
			</div>
	
		</div>