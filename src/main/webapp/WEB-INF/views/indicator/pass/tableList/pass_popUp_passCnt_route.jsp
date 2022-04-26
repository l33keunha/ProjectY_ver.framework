<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		<!-- ● 노선별통행 -->
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
				
				<tr>
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/도</th>				<!-- 광역/도 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군/구</th>			<!-- 시/군 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선구분</th>			<!-- 노선구분 -->
					<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">분석일자</th>			<!-- 분석일자 -->
					
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선명</th>			<!-- 노선명 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선유형</th>			<!-- 노선유형 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">기점</th>				<!-- 기점 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">종점</th>				<!-- 종점 -->
					<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>				<!-- 시간 -->
					<c:forTokens  var="name" items="${cd_noText}" delims="_">
						<th class="tg-0pky" colspan="3" style="width: 210px; min-width: 210px; max-width: 210px;">${name}</th>	<!-- 이용자 유형 -->
					</c:forTokens>
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">승차소계(환승포함)</th><!-- 승차소계-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">하차소계</th>		<!-- 하차소계-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">환승소계</th>		<!-- 환승소계-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">합계(승차+하차)</th>	<!-- 합계-->
				</tr>
				<tr>
					<c:forEach var='j' begin='0' end='${columnCnt-1}' >	
						<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">승차</th>					<!-- 승차-->
						<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">하차</th>					<!-- 하차 -->
						<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">환승</th>					<!-- 환승 -->	
					</c:forEach>
				</tr>
			</thead>
		</table>
      
		<div class="content_wrap">
			<div class="content">
				<table class="tg" style="table-layout: fixed; word-wrap: break-word;">
               		<tbody>
               		
               			<c:set var = "forCnt" value = '${passResultListB.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
						
						<c:set var = "dateCnt" value = "${dateEnd - dateStart + 1}"/>								<!-- 날짜 종류 갯수 -->
						<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
						
						<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 1) }"/>						<!-- 시간 반복 갯수 -->
						<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									
					
						<c:set var = "totalSumAdd" value = "${forCnt/timeCnt}"/>									<!-- 토탈 합계로 인해 달력 광역/도 시/군 개수 추가 -->
						<fmt:parseNumber var = "totalSumAdd" value = "${totalSumAdd}"  />							
					
										
						<c:set var = "totalTimeSumAdd" value = "${dateCnt/timeCnt}"/>								<!-- 토탈 합계로 인해 달력 날짜 개수 추가 -->
						<fmt:parseNumber var = "totalTimeSumAdd" value = "${totalTimeSumAdd}"  />							
					
						<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->
					
						<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
						<c:set var = "totalTotalInSum" value = "0"/>												<!-- 승차소계 합계변수 -->	
						<c:set var = "totalTotalOutSum" value = "0"/>												<!-- 하차소계 합계변수 -->	
						<c:set var = "totalTotalHsSum" value = "0"/>												<!-- 환승소계의 합계변수 -->	
			
					
					
						<!-- 버스 -->
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
								<%-- <!-- 날짜 그룹이 시작될 때마다 실행-->
								<c:if test="${(j % dateCnt) == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListB[dateCnt*indexCnt*columnCnt].opratDate }</div></td>	<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div></div></td>															<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[0].passareaKr}</div></td>							<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[0].tfcmn}</div></td>								<!-- 노선구분 -->
									<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
								</c:if>
							
								<!-- 노선명 그룹이 시작될 때마다 실행 -->
								<c:if test="${(j % timeCnt) == 0}">	   	
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].routeNma}</td>			<!-- 노선명 -->
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].routeType}</td>			<!-- 노선유형 -->
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].routeStart}</td>			<!-- 기점 -->
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].routeEnd}</td>			<!-- 종점 -->
								</c:if>
						 --%>
						 
						 
						 
						 
								<!-- 시간대 : 1일 -->
								<c:if test="${sVO.tm == 'allDay'}">
									
									<c:if test="${(j % dateCnt) == 0}">
									
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-c3ow" rowspan='${forCnt}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>			<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->												
												
											<c:if test="${passResultListB[0].tfcmn == 'B'}">
												<c:set var="t_b_name" value='버스' />
											</c:if>
											<c:if test="${passResultListB[0].tfcmn == 'T'}">
												<c:set var="t_b_name" value='지하철' />
											</c:if>
											
											<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>				<!-- 노선구분 -->
										</c:if> 
									   	<!-- 시간 * 날짜수  -->
										<td class="tg-0pky"   rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListB[j*columnCnt].opratDate }</div></td>			<!-- 분석일자 --> 
									</c:if>
								
								
										
									
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeNma}</div></td>			<!-- 노선명 -->
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeType}</div></td>			<!-- 노선유형 -->
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeStart}</div></td>		<!-- 기점 -->
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeEnd}</div></td>			<!-- 종점 -->
									
									
									<!-- 전체 row 수 -->
									<c:if test = "${j == 0}">
										<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>전체</div></td>	<!-- 시간 -->
									</c:if>
									
								</c:if>
								
								
								
								
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
								
									<c:if test="${(j % dateCnt) == 0}">
										
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-c3ow" rowspan='${forCnt+totalSumAdd}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>			<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt+totalSumAdd}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->												
										</c:if>   	
											
										<c:if test="${passResultListB[0].tfcmn == 'B'}">
											<c:set var="t_b_name" value='버스' />
										</c:if>
										<c:if test="${passResultListB[0].tfcmn == 'T'}">
											<c:set var="t_b_name" value='지하철' />
										</c:if>
										
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-0pky" rowspan='${forCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>				<!-- 노선구분 -->
										</c:if>   
										
										<!-- 시간 * 날짜수  -->	
										<td class="tg-0pky" rowspan='${dateCnt+totalTimeSumAdd}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListB[dateCnt*indexCnt*columnCnt].opratDate }</div></td>	<!-- 분석일자 --> 
										<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
									</c:if>
								
									<!-- 노선명 그룹이 시작될 때마다 실행 -->
									<c:if test="${(j % timeCnt) == 0}">	   	
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeNma}</div></td>			<!-- 노선명 -->
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeType}</div></td>			<!-- 노선유형 -->
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeStart}</div></td>			<!-- 기점 -->
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListB[j * columnCnt].routeEnd}</div></td>			<!-- 종점 -->
									</c:if>
									<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultListB[j * columnCnt].tm}</td>	<!-- 시간 -->
								</c:if>
						
						
						
						 
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalInSum" value = "0"/>			<!-- 승차합 변수 -->	
								<c:set var = "totalOutSum" value = "0"/>		<!-- 하차합 변수 -->	
								<c:set var = "totalHsSum" value = "0"/>			<!-- 환승합 변수 -->	
								
								
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].routeBusGinAgg}</td>		<!-- 승차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].routeBusGffAgg}</td>		<!-- 하차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].routeBusTrsAgg}</td>		<!-- 환승 -->
								
									<c:set var = "totalInSum" 	value = '${totalInSum + (passResultListB[i].routeBusGinAgg)}'/>		<!-- 승차합 계산 -->
									<c:set var = "totalOutSum" 	value = '${totalOutSum + (passResultListB[i].routeBusGffAgg)}'/>	<!-- 하차합 계산 -->
									<c:set var = "totalHsSum" 	value = '${totalHsSum + (passResultListB[i].routeBusTrsAgg)}'/>		<!-- 환승합 계산 -->
								</c:forEach>
								
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum}</td>			<!-- 승차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalOutSum}</td>			<!-- 하차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalHsSum}</td>			<!-- 환승소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum+totalOutSum}</td><!-- 합계(승차+하차) -->
								
								<c:set var = "totalTotalInSum" value = '${totalTotalInSum + totalInSum}'/>	
								<c:set var = "totalTotalOutSum" value = '${totalTotalOutSum + totalOutSum}'/>	
								<c:set var = "totalTotalHsSum" value = '${totalTotalHsSum + totalHsSum}'/>	
							</tr>
					
								
							<!-- 시간대 : 시작시간 ~ 끝시간 -->
							<c:if test="${sVO.tm == null}">	
								<!-- 최종 열의 합 -->
								<c:if test="${(j % (timeCnt)) == timeCnt-1}">
									<tr>
										<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">합계</td>	
										
										<c:forEach var='k' begin='0' end='${columnCnt-1}' >	    
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 승차 합계-->
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 하차 합계-->
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 환승 합계-->
										</c:forEach>
									
									
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalInSum}</td>						<!-- 승차 총 소계-->
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalOutSum}</td>						<!-- 하차 총 소계-->
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalHsSum}</td>						<!-- 환승 총 소계-->
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalInSum+totalTotalOutSum}</td>		<!-- 합계(승차+하차)-->
										
										<c:set var = "totalTotalInSum" value = "0"/>
										<c:set var = "totalTotalOutSum" value = "0"/>
										<c:set var = "totalTotalHsSum" value = "0"/>
										<c:set var = "totalTotalIndexCnt" value = '${totalTotalIndexCnt + 1}'/>
									</tr>
								</c:if>
							</c:if>
							
							
						</c:forEach>
						
						
						
						<!-- 지하철 -->
						
						
						<c:set var = "forCnt" value = '${passResultListT.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
						
						<c:set var = "dateCnt" value = "${dateEnd - dateStart + 1}"/>								<!-- 날짜 종류 갯수 -->
						<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
						
						<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 1) }"/>						<!-- 시간 반복 갯수 -->
						<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									
					
						<c:set var = "totalSumAdd" value = "${forCnt/timeCnt}"/>									<!-- 토탈 합계로 인해 달력 광역/도 시/군 개수 추가 -->
						<fmt:parseNumber var = "totalSumAdd" value = "${totalSumAdd}"  />							
					
										
						<c:set var = "totalTimeSumAdd" value = "${dateCnt/timeCnt}"/>								<!-- 토탈 합계로 인해 달력 날짜 개수 추가 -->
						<fmt:parseNumber var = "totalTimeSumAdd" value = "${totalTimeSumAdd}"  />							
					
						<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->
					
						<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
						<c:set var = "totalTotalInSum" value = "0"/>												<!-- 승차소계 합계변수 -->	
						<c:set var = "totalTotalOutSum" value = "0"/>												<!-- 하차소계 합계변수 -->	
						<c:set var = "totalTotalHsSum" value = "0"/>												<!-- 환승소계의 합계변수 -->	
			
						
						
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
								<%-- <!-- 날짜 그룹이 시작될 때마다 실행-->
								<c:if test="${(j % dateCnt) == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListT[dateCnt*indexCnt*columnCnt].opratDate }</div></td>	<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div></div></td>															<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[0].passareaKr}</div></td>							<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[0].tfcmn}</div></td>								<!-- 노선구분 -->
									<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
								</c:if>
							
								<!-- 노선명 그룹이 시작될 때마다 실행 -->
								<c:if test="${(j % timeCnt) == 0}">	   	
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].routeNma}</td>			<!-- 노선명 -->
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].routeType}</td>			<!-- 노선유형 -->
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].routeStart}</td>			<!-- 기점 -->
									<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].routeEnd}</td>			<!-- 종점 -->
								</c:if>
							--%>
						 
						 
						 
						 
								<!-- 시간대 : 1일 -->
								<c:if test="${sVO.tm == 'allDay'}">
									
									<c:if test="${(j % dateCnt) == 0}">
									
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-c3ow" rowspan='${forCnt}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>			<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->												
												
											<c:if test="${passResultListT[0].tfcmn == 'B'}">
												<c:set var="t_b_name" value='버스' />
											</c:if>
											<c:if test="${passResultListT[0].tfcmn == 'T'}">
												<c:set var="t_b_name" value='지하철' />
											</c:if>
											
											<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>				<!-- 노선구분 -->
										</c:if> 
									   	<!-- 시간 * 날짜수  -->
										<td class="tg-0pky"   rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListT[j*columnCnt].opratDate }</div></td>			<!-- 분석일자 --> 
									</c:if>
								
								
										
									
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeNma}</div></td>			<!-- 노선명 -->
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeType}</div></td>			<!-- 노선유형 -->
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeStart}</div></td>		<!-- 기점 -->
									<td class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeEnd}</div></td>			<!-- 종점 -->
									
									
									<!-- 전체 row 수 -->
									<c:if test = "${j == 0}">
										<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>전체</div></td>	<!-- 시간 -->
									</c:if>
									
								</c:if>
								
								
								
								
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
								
									<c:if test="${(j % dateCnt) == 0}">
										
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-c3ow" rowspan='${forCnt+totalSumAdd}' 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>			<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${forCnt+totalSumAdd}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->												
										</c:if>   	
											
										<c:if test="${passResultListT[0].tfcmn == 'B'}">
											<c:set var="t_b_name" value='버스' />
										</c:if>
										<c:if test="${passResultListT[0].tfcmn == 'T'}">
											<c:set var="t_b_name" value='지하철' />
										</c:if>
										
										<!-- 전체 row 수 -->
										<c:if test = "${j == 0}">
											<td class="tg-0pky" rowspan='${forCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>				<!-- 노선구분 -->
										</c:if>   
										
										<!-- 시간 * 날짜수  -->	
										<td class="tg-0pky" rowspan='${dateCnt+totalTimeSumAdd}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListT[dateCnt*indexCnt*columnCnt].opratDate }</div></td>	<!-- 분석일자 --> 
										<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
									</c:if>
								
									<!-- 노선명 그룹이 시작될 때마다 실행 -->
									<c:if test="${(j % timeCnt) == 0}">	   	
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeNma}</div></td>			<!-- 노선명 -->
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeType}</div></td>			<!-- 노선유형 -->
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeStart}</div></td>			<!-- 기점 -->
										<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultListT[j * columnCnt].routeEnd}</div></td>			<!-- 종점 -->
									</c:if>
									<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultListT[j * columnCnt].tm}</td>	<!-- 시간 -->
								</c:if>
						
						
						
						 
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalInSum" value = "0"/>			<!-- 승차합 변수 -->	
								<c:set var = "totalOutSum" value = "0"/>		<!-- 하차합 변수 -->	
								<c:set var = "totalHsSum" value = "0"/>			<!-- 환승합 변수 -->	
								
								
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListT[i].routeTrainGinAgg}</td>		<!-- 승차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListT[i].routeTrainGffAgg}</td>		<!-- 하차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListT[i].routeTrainTrsAgg}</td>		<!-- 환승 -->
								
									<c:set var = "totalInSum" 	value = '${totalInSum + (passResultListT[i].routeTrainGinAgg)}'/>		<!-- 승차합 계산 -->
									<c:set var = "totalOutSum" 	value = '${totalOutSum + (passResultListT[i].routeTrainGffAgg)}'/>	<!-- 하차합 계산 -->
									<c:set var = "totalHsSum" 	value = '${totalHsSum + (passResultListT[i].routeTrainTrsAgg)}'/>		<!-- 환승합 계산 -->
								</c:forEach>
								
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum}</td>			<!-- 승차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalOutSum}</td>			<!-- 하차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalHsSum}</td>			<!-- 환승소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum+totalOutSum}</td><!-- 합계(승차+하차) -->
								
								<c:set var = "totalTotalInSum" value = '${totalTotalInSum + totalInSum}'/>	
								<c:set var = "totalTotalOutSum" value = '${totalTotalOutSum + totalOutSum}'/>	
								<c:set var = "totalTotalHsSum" value = '${totalTotalHsSum + totalHsSum}'/>	
							</tr>
					
								
							<!-- 시간대 : 시작시간 ~ 끝시간 -->
							<c:if test="${sVO.tm == null}">	
								<!-- 최종 열의 합 -->
								<c:if test="${(j % (timeCnt)) == timeCnt-1}">
									<tr>
										<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">합계</td>	
										
										<c:forEach var='k' begin='0' end='${columnCnt-1}' >	    
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 승차 합계-->
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 하차 합계-->
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 환승 합계-->
										</c:forEach>
									
									
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalInSum}</td>						<!-- 승차 총 소계-->
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalOutSum}</td>						<!-- 하차 총 소계-->
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalHsSum}</td>						<!-- 환승 총 소계-->
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalInSum+totalTotalOutSum}</td>		<!-- 합계(승차+하차)-->
										
										<c:set var = "totalTotalInSum" value = "0"/>
										<c:set var = "totalTotalOutSum" value = "0"/>
										<c:set var = "totalTotalHsSum" value = "0"/>
										<c:set var = "totalTotalIndexCnt" value = '${totalTotalIndexCnt + 1}'/>
									</tr>
								</c:if>
							</c:if>
							
							
						</c:forEach>
					
					
						
						
					</tbody>
				</table>
			</div>
		</div>
    </body>
    
    
    
    
    
</html>