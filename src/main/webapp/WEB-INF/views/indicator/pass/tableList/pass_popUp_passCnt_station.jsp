<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		<!-- ● 정류장별통행 -->
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
					<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">분석일자</th>			<!-- 분석일자 -->
					<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>				<!-- 요일 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장구분</th>			<!-- 정류장구분 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장ID</th>			<!-- 정류장ID -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장명</th>			<!-- 정류장명 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">행정동</th>			<!-- 행정동 -->
					<c:forTokens  var="name" items="${cd_noText}" delims="_">
						<th class="tg-0pky" colspan="3" style="width: 210px; min-width: 210px; max-width: 210px;">${name}</th>	<!-- 이용자 유형 -->
					</c:forTokens>
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">승차소계(환승포함)</th>	<!-- 승차-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">하차소계</th>			<!-- 하차-->
					<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">환승소계</th>			<!-- 환승-->
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
					
						<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
						<c:set var = "totalTotalInSum" value = "0"/>												<!-- 승차소계 합계변수 -->	
						<c:set var = "totalTotalOutSum" value = "0"/>												<!-- 하차소계 합계변수 -->	
						<c:set var = "totalTotalHsSum" value = "0"/>												<!-- 환승소계의 합계변수 -->	
			
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
								
								<!-- 날짜 하루 조회므로 첫 시작때만 표출 -->
								<c:if test="${j == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>				<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListB[0].opratDate}</div></td>		<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>${passResultListB[0].dy}</div></td>				<!-- 요일 --> 
									
									<c:if test="${passResultListB[0].tfcmn == 'B'}">
										<c:set var="t_b_name" value='버스' />
									</c:if>
									<c:if test="${passResultListB[0].tfcmn == 'T'}">
										<c:set var="t_b_name" value='지하철' />
									</c:if>
							
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>						<!-- 노선구분 -->
								</c:if>
							
							
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalInSum" value = "0"/>			<!-- 승차합 변수 -->	
								<c:set var = "totalOutSum" value = "0"/>		<!-- 하차합 변수 -->	
								<c:set var = "totalHsSum" value = "0"/>			<!-- 환승합 변수 -->	
								
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].sttnId}</td>							<!-- 정류장ID -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].sttnNma}</td>							<!-- 정류장명 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListB[j * columnCnt].sttnHjd}</td>							<!-- 행정동 -->
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
								 	<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].sttnBusGinAgg}</td>	<!-- 승차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].sttnBusGffAgg}</td>	<!-- 하차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListB[i].sttnBusTrsAgg}</td>	<!-- 환승 -->
								
								
									<c:set var = "totalInSum" 	value = '${totalInSum + (passResultListB[i].sttnBusGinAgg)}'/>		<!-- 승차합 계산 -->
									<c:set var = "totalOutSum" 	value = '${totalOutSum + (passResultListB[i].sttnBusGffAgg)}'/>		<!-- 하차합 계산 -->
									<c:set var = "totalHsSum" 	value = '${totalHsSum + (passResultListB[i].sttnBusTrsAgg)}'/>		<!-- 환승합 계산 -->
								</c:forEach>
								
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum}</td>			<!-- 승차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalOutSum}</td>			<!-- 하차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalHsSum}</td>			<!-- 환승소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum+totalOutSum}</td><!-- 합계(승차+하차) -->
								
								<c:set var = "totalTotalInSum" value = '${totalTotalInSum + totalInSum}'/>	
								<c:set var = "totalTotalOutSum" value = '${totalTotalOutSum + totalOutSum}'/>	
								<c:set var = "totalTotalHsSum" value = '${totalTotalHsSum + totalHsSum}'/>	
							</tr>
					
					
							<!-- 최종 열의 합 -->
							<c:if test="${ j == (forCnt-1)}">
								<tr>
									<td class="tg-0pky" colspan="3" style="width: 210px; min-width: 210px; max-width: 210px;">합계</td>	
									
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
							
						</c:forEach>
						
					
					
						<!-- 지하철 -->					
						<c:set var = "forCnt" value = '${passResultListT.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
				
						<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
						<c:set var = "totalTotalInSum" value = "0"/>												<!-- 승차소계 합계변수 -->	
						<c:set var = "totalTotalOutSum" value = "0"/>												<!-- 하차소계 합계변수 -->	
						<c:set var = "totalTotalHsSum" value = "0"/>												<!-- 환승소계의 합계변수 -->	
			
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
								
								<!-- 날짜 하루 조회므로 첫 시작때만 표출 -->
								<c:if test="${j == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>				<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultListT[0].opratDate}</div></td>		<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>${passResultListT[0].dy}</div></td>				<!-- 요일 --> 
									
									<c:if test="${passResultListT[0].tfcmn == 'B'}">
										<c:set var="t_b_name" value='버스' />
									</c:if>
									<c:if test="${passResultListT[0].tfcmn == 'T'}">
										<c:set var="t_b_name" value='지하철' />
									</c:if>
							
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>						<!-- 노선구분 -->
								</c:if>
							
							
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalInSum" value = "0"/>			<!-- 승차합 변수 -->	
								<c:set var = "totalOutSum" value = "0"/>		<!-- 하차합 변수 -->	
								<c:set var = "totalHsSum" value = "0"/>			<!-- 환승합 변수 -->	
								
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].sttnId}</td>							<!-- 정류장ID -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].sttnNma}</td>							<!-- 정류장명 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultListT[j * columnCnt].sttnHjd}</td>							<!-- 행정동 -->
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListT[i].sttnTrainGinAgg}</td>	<!-- 승차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListT[i].sttnTrainGffAgg}</td>	<!-- 하차 -->
									<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultListT[i].sttnTrainTrsAgg}</td>	<!-- 환승 -->
								
								
									<c:set var = "totalInSum" 	value = '${totalInSum + (passResultListT[i].sttnTrainGinAgg)}'/>		<!-- 승차합 계산 -->
									<c:set var = "totalOutSum" 	value = '${totalOutSum + (passResultListT[i].sttnTrainGffAgg)}'/>		<!-- 하차합 계산 -->
									<c:set var = "totalHsSum" 	value = '${totalHsSum + (passResultListT[i].sttnTrainTrsAgg)}'/>		<!-- 환승합 계산 -->
								</c:forEach>
								
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum}</td>			<!-- 승차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalOutSum}</td>			<!-- 하차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalHsSum}</td>			<!-- 환승소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum+totalOutSum}</td><!-- 합계(승차+하차) -->
								
								<c:set var = "totalTotalInSum" value = '${totalTotalInSum + totalInSum}'/>	
								<c:set var = "totalTotalOutSum" value = '${totalTotalOutSum + totalOutSum}'/>	
								<c:set var = "totalTotalHsSum" value = '${totalTotalHsSum + totalHsSum}'/>	
							</tr>
					
					
							<!-- 최종 열의 합 -->
							<c:if test="${ j == (forCnt-1)}">
								<tr>
									<td class="tg-0pky" colspan="4" style="width: 240px; min-width: 240px; max-width: 240px;">합계</td>	
									
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
							
						</c:forEach>
						
						
					</tbody>
				</table>
			</div>
		</div>
    </body>
    
    
    
    
    
</html>