<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		<!-- ● 노선별OD -->
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
					<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/도</th>				<!-- 광역/도 -->
					<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/군/구</th>			<!-- 시/군 -->
					<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">분석일자</th>			<!-- 분석일자 -->
					<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>				<!-- 요일 -->
					
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">노선구분</th>			<!-- 노선구분 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">노선명</th>			<!-- 노선명 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">노선유형</th>			<!-- 노선유형 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">기점</th>				<!-- 기점 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">종점</th>				<!-- 종점 -->
					
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장ID</th>		<!-- 출발정류장ID -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장명</th>		<!-- 출발정류장명 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장행정동</th>	<!-- 출발정류장행정동 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장ID</th>		<!-- 도착정류장ID -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장명</th>		<!-- 도착정류장명 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장행정동</th>	<!-- 도착정류장행정동 -->
					
					<th class="tg-0pky"  style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>				<!-- 시간 -->
					
					<c:forTokens  var="name" items="${cd_noText}" delims="_">
						<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${name}</th>		<!-- 이용자 유형 -->
					</c:forTokens>
					
					<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">합계</th>			<!-- 합계-->
				</tr>
			
			</thead>
		</table>
      
		<div class="content_wrap">
			<div class="content">
				<table class="tg" style="table-layout: fixed; word-wrap: break-word;">
               		<tbody>
               		
               			<c:set var = "forCnt" value = '${passResultList.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
						
					<%-- 	<c:set var = "dateCnt" value = "${sVO.dateEnd - sVO.dateStart + 1}"/>					<!-- 날짜 종류 갯수 --> --%>
						<c:set var = "dateCnt" value = "${1}"/>														<!-- 날짜 종류 갯수 --> 
						<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
						
						<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 1) }"/>						<!-- 시간 반복 갯수 -->
						
						<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									
					
						<c:set var = "totalSumAdd" value = "${dateCnt/timeCnt}"/>									<!-- 토탈 합계로 인해 달력 rowspan 개수 추가 -->
						<fmt:parseNumber var = "totalSumAdd" value = "${totalSumAdd}"  />							
					
						<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->
					
						<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
						<c:set var = "totalTotalInSum" value = "0"/>												<!-- 합계의 합계 변수 -->
			
					
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
							
								<!-- 시간대 : 1일 -->
								<c:if test="${sVO.tm == 'allDay'}">
									<!-- 날짜 그룹이 시작될 때마다 실행-->
									<c:if test="${(j % dateCnt) == 0}">
										<!-- 시간 * 날짜수  -->	   	
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>									<!-- 광역/도 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>										<!-- 시/군 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[0].opratDate }</div></td>								<!-- 분석일자 --> 
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>${passResultList[0].dy }</div></td>									<!-- 요일 --> 
										
											<c:if test="${passResultList[0].tfcmn == 'B'}">
												<c:set var="t_b_name" value='버스' />
											</c:if>
											<c:if test="${passResultList[0].tfcmn == 'T'}">
												<c:set var="t_b_name" value='지하철' />
											</c:if>
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>													<!-- 노선구분 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeNma}</div></td>								<!-- 노선명 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeType}</div></td>								<!-- 노선유형 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeStart}</div></td>								<!-- 기점 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeEnd}</div></td>								<!-- 종점 -->
										<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
									</c:if>
								
									<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j].getStnId}</div></td>				<!-- 출발정류장ID -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j].getStnNm}</div></td>				<!-- 출발정류장명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j].getStnArea}</div></td>				<!-- 출발정류장행정동 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j].offStnId}</div></td>				<!-- 도착정류장ID -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j].offStnNm}</div></td>				<!-- 도착정류장명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j].offStnArea}</div></td>				<!-- 도착정류장행정동 -->
									
								</c:if>
								
							
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
										<!-- 날짜 그룹이 시작될 때마다 실행-->
										<c:if test="${(j % dateCnt) == 0}">
											<!-- 시간 * 날짜수  -->	   	
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>									<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>										<!-- 시/군 -->
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[dateCnt*indexCnt*columnCnt].opratDate }</div></td>	<!-- 분석일자 --> 
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>${passResultList[dateCnt*indexCnt*columnCnt].dy }</div></td>			<!-- 요일 --> 
											
												<c:if test="${passResultList[0].tfcmn == 'B'}">
													<c:set var="t_b_name" value='버스' />
												</c:if>
												<c:if test="${passResultList[0].tfcmn == 'T'}">
													<c:set var="t_b_name" value='지하철' />
												</c:if>
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${t_b_name}</div></td>													<!-- 노선구분 -->
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeNma}</div></td>								<!-- 노선명 -->
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeType}</div></td>								<!-- 노선유형 -->
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeStart}</div></td>								<!-- 기점 -->
											<td class="tg-0pky" rowspan='${dateCnt+totalSumAdd}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[0].routeEnd}</div></td>								<!-- 종점 -->
											<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
										</c:if>
									
										<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
										<c:if test="${(j % timeCnt) == 0}">	   	
											<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j * columnCnt].getStnId}</div></td>				<!-- 출발정류장ID -->
											<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j * columnCnt].getStnNm}</div></td>				<!-- 출발정류장명 -->
											<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j * columnCnt].getStnArea}</div></td>			<!-- 출발정류장행정동 -->
											<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j * columnCnt].offStnId}</div></td>				<!-- 도착정류장ID -->
											<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j * columnCnt].offStnNm}</div></td>				<!-- 도착정류장명 -->
											<td class="tg-0pky" rowspan='${timeCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${passResultList[j * columnCnt].offStnArea}</div></td>			<!-- 도착정류장행정동 -->
										</c:if>
								</c:if>
								
								
								
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalSum" value = "0"/>			<!-- 합계 변수 -->	
					
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultList[j * columnCnt].tm}</td>	<!-- 시간 -->
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[i].cnt}</td>		<!-- 이용자 유형 -->
									<c:set var = "totalSum" value = '${totalSum + passResultList[i].cnt}'/>	
								</c:forEach>
							
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${totalSum}</td>							<!-- 합계 -->
								<c:set var = "totalTotalInSum" value = '${totalTotalInSum + totalSum}'/>
									
							</tr>
						
							<!-- 시간대 : 시작시간 ~ 끝시간 -->
							<c:if test="${sVO.tm == null}">
								<!-- 최종 열의 합 -->
								<c:if test="${(j % (timeCnt)) == timeCnt-1}">
									<tr>
										<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">합계</td>	
										
										<c:forEach var='k' begin='0' end='${columnCnt-1}' >	    
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${(columnCnt*totalTotalIndexCnt)+k}</td>					<!-- 승차 합계-->
										</c:forEach>
									
									
										<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalInSum}</td>									<!-- 합계의 합계-->
							
										<c:set var = "totalTotalInSum" value = '0'/>
										<c:set var = "totalTotalIndexCnt" value = '${totalTotalIndexCnt + 1}'/>
									
									</tr>
								</c:if>
							</c:if>	
							
						</c:forEach>
						
					
						
						
					</tbody>
				</table>
			</div>
		</div>
