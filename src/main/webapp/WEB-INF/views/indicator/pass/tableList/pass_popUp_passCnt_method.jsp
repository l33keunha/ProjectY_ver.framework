<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		<!-- ● 수단통행 -->
		<table class="tabletitle" style="table-layout: fixed; word-wrap: break-word;">
			<thead>
			
						<!-- 이용자 유형 컬럼 갯수 -->
						<c:choose>
							<c:when test="${sVO.cd_no[0] =='00'}">
								<c:set var = "columnCnt" value = '11'/>						
							</c:when>
							<c:otherwise>
								<c:set var = "columnCnt" value = '${fn:length(sVO.cd_no)}'/>		
							</c:otherwise>
						</c:choose>
						
						
						<!-- 버스 and 지하철 (전체) 일떄 -->
						<%-- <c:if test="${sVO.passTransport =='00'}"> --%>
							<tr>
								<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/도</th>						<!-- 광역/도 -->
								<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군/구</th>					<!-- 시/군 -->
								<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>						<!-- 날짜 -->
								<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>						<!-- 시간 -->	
								<c:forTokens  var="name" items="${cd_noText}" delims="_">
									<th class="tg-0pky" colspan="3" style="width: 210px; min-width: 210px; max-width: 210px;">${name}</th>			<!-- 이용자 유형 -->
								</c:forTokens>
								<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">버스소계</th>				<!-- 버스소계-->
								<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">지하철소계</th>				<!-- 지하철소계-->
								<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">합계</th>					<!-- 합계-->
							</tr>
							<tr>
								<c:forEach var='j' begin='0' end='${columnCnt-1}' >	
									<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">버스</th>								<!-- 버스-->
									<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">지하철</th>							<!-- 지하철 -->
									<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">소계</th>								<!-- 소계 -->							
								</c:forEach>
							</tr>
						<%-- </c:if> --%>
					
			</thead>	
		</table>
      
		<div class="content_wrap">
			<div class="content">
				<table class="tg" style="table-layout: fixed; word-wrap: break-word;">
               		<tbody>
               			
               			
               			
               				<!-- 시간대 : 1일 -->
	               			<c:if test ="${sVO.tm == 'allDay'}">
	               					<c:set var = "forCnt" value = '${passResultList.size()/columnCnt/2}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->	
	               					<c:set var = "allDay" value = "2"/>															<!-- 시간대에 따른 연산 ( 시작시간 ~ 종료시간: 버스/지하철 * 2 ||  1일: 버스/지하철 * 1   )  -->
	               			</c:if>
	               			
	               			<!-- 시간대 : 시작시간 ~ 끝시간 -->
							<c:if test ="${sVO.tm == null}">
	               					<c:set var = "forCnt" value = '${passResultList.size()/columnCnt/2}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->	
	               					<c:set var = "allDay" value = "2"/>															<!-- 시간대에 따른 연산 ( 시작시간 ~ 종료시간: 버스/지하철 * 2 ||  1일: 버스/지하철 * 1   )  -->
	               			</c:if>
							
	    					<c:set var = "dateCnt" value = "${dateEnd - dateStart + 1}"/>								<!-- 날짜 종류 갯수 -->
							<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
							
							<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 1)}"/>							<!-- 시간 반복 갯수-->
							<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									<!-- 시간 출력 갯수 -->
							
							<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->
							
							<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
							<c:set var = "totalTotalSum" value = "0"/>													<!-- 합계의 합계변수 -->	
							<c:set var = "busTotalSum" value = "0"/>													<!-- 버스합계의 합계변수 -->	
							<c:set var = "metroTotalSum" value = "0"/>													<!-- 지하철합계의 합계변수 -->	
							
							
							
							<c:set var = "totalSumAdd" value = "${forCnt/dateCnt}"/>									<!-- 토탈 합계로 인해 달력 rowspan 개수 추가 -->
							<fmt:parseNumber var = "totalSumAdd" value = "${totalSumAdd}"  />							
							
							<c:forEach var='j' begin='0' end='${forCnt-1}'>
								<tr class="level-2">
								
 									<!-- 시간대 : 1일 -->
									<c:if test="${sVO.tm == 'allDay'}">
										<c:if test="${(j % forCnt) == 0}">	   
											<td class="tg-c3ow" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>		<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>				<!-- 시/군 -->
													
										</c:if>				
										<td class="tg-0pky"  style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[dateCnt*indexCnt*columnCnt].opratDate}</td>			<!-- 날짜 -->
										
										<c:if test="${(j % forCnt) == 0}">	   
											<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;">전체</td>											<!-- 시간 -->
										</c:if>				
										<c:set var = "indexCnt" value = "${indexCnt + 1}"/>				
									</c:if>
									
 									
 									<!-- 시간대 : 시작시간 ~ 끝시간 -->
									<c:if test="${sVO.tm == null}">
										<!-- 조회한 시간에 따라 실행 -->
										<c:if test="${(j % timeCnt) == 0}">	   
											<!-- 전체 row 수 -->
											<c:if test = "${j == 0}">
												<td class="tg-c3ow" rowspan='${forCnt+totalSumAdd}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>				<!-- 광역/도 -->
												<td class="tg-0pky" rowspan='${forCnt+totalSumAdd}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>						<!-- 시/군 -->												
											</c:if>
											<td class="tg-0pky" rowspan='${timeCnt+1}' 	style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[dateCnt*indexCnt*columnCnt*2].opratDate}</div></td>	<!-- 날짜 -->
											<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
										</c:if>
										<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultList[j*columnCnt*2].tm}</td>		<!-- 시간 -->
									</c:if>
 
												
									<!-- 컬럼 갯수대로 실행 -->
									<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
									<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
									<c:set var = "totalSum" value = "0"/>			<!-- 합계변수 -->	
									<c:set var = "busSum" value = "0"/>				<!-- 버스 합계변수 -->	
									<c:set var = "metroSum" value = "0"/>			<!-- 지하철 합계변수 -->	
									
									<c:forEach var='i' begin='${st}' end='${ed-1}' >	    
										<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[i*allDay].userCntAgg}</td>												<!-- 버스-->
										<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[(i*allDay)+1].userCntAgg}</td>											<!-- 지하철-->
										<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[(i*allDay)].userCntAgg + passResultList[(i*allDay)+1].userCntAgg}</td>	<!-- 소계(버스+지하철) -->	
										<c:set var = "totalSum" value = '${totalSum + (passResultList[(i*allDay)].rownum + passResultList[(i*allDay)+1].userCntAgg)}'/>	
										<c:set var = "busSum" value = '${busSum + passResultList[i*allDay].userCntAgg}'/>	
										<c:set var = "metroSum" value = '${metroSum + passResultList[(i*allDay)+1].userCntAgg}'/>	
									</c:forEach>
									
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${busSum}</td>															<!-- 버스소계 -->
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${metroSum}</td>															<!-- 지하철소계 -->
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalSum}</td>															<!-- 합계 -->
									
									<c:set var = "busTotalSum" value = '${busTotalSum + busSum}'/>	
									<c:set var = "metroTotalSum" value = '${metroTotalSum + metroSum}'/>	
									<c:set var = "totalTotalSum" value = '${totalTotalSum + totalSum}'/>	
								</tr>
								
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
								
									<!-- 최종 열의 합 -->
									<c:if test="${(j % (timeCnt)) == timeCnt-1}">
										<tr> 
											<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">합계</td>	
											
											<c:forEach var='k' begin='0' end='${columnCnt-1}' >	    
												<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultCntList[(columnCnt*totalTotalIndexCnt)+k].suma}</td>					<!-- 이용자유형 버스 합계-->
												<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultCntList[(columnCnt*totalTotalIndexCnt)+k].suma}</td>					<!-- 이용자유형 지하철 합계-->
												<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultCntList[(columnCnt*totalTotalIndexCnt)+k].suma}</td>					<!-- 소계의 합계-->
											</c:forEach>
										
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${busTotalSum}</td>											<!-- 버스 총 소계-->
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${metroTotalSum}</td>										<!-- 지하철 총 소계-->
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${totalTotalSum}</td>										<!-- 총 합계-->
										
											<c:set var = "busTotalSum" value = "0"/>
											<c:set var = "metroTotalSum" value = "0"/>
											<c:set var = "totalTotalSum" value = "0"/>
											<c:set var = "totalTotalIndexCnt" value = '${totalTotalIndexCnt + 1}'/>
											
										</tr>
									</c:if>
								
								</c:if>
	
							</c:forEach>
							
							
               		</tbody>
				</table>
			</div>
		</div>
		