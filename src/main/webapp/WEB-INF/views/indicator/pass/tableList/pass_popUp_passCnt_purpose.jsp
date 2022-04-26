<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		<!-- ● 목적통행 -->
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
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/도</th>								<!-- 광역/도 -->
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/군/구</th>							<!-- 시/군 -->
							<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>								<!-- 날짜 -->
							
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>								<!-- 시간 -->	
							<c:forTokens  var="name" items="${cd_noText}" delims="_">
								<th class="tg-0pky" colspan="3" style="width: 70px; min-width: 70px; max-width: 70px;">${name}</th>			<!-- 이용자 유형 -->
							</c:forTokens>
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">합계</th>							<!-- 합계-->
						</tr>
					
				
			</thead>	
		</table>
      
		<div class="content_wrap">
			<div class="content">
				<table class="tg" style="table-layout: fixed; word-wrap: break-word;">
               		<tbody>
               			
               			
							<c:set var = "forCnt" value = '${passResultList.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
							
	    					<c:set var = "dateCnt" value = "${dateEnd - dateStart + 1}"/>								<!-- 날짜 종류 갯수 -->
							<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
							
							<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 1)}"/>							<!-- 시간 반복 갯수-->
							<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									<!-- 시간 출력 갯수 -->
							
							<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->
							<c:set var = "totalTotalIndexCnt" value = "0"/>												<!-- 합계의 합계 index count -->
							<c:set var = "totalTotalSum" value = "0"/>													<!-- 합계의 합계변수 -->	
							
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
										<td class="tg-0pky"  style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[j*columnCnt].opratDate}</td>							<!-- 날짜 -->
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
												<td class="tg-0pky" rowspan='${forCnt+totalSumAdd}'	 	style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->												
											</c:if>
											 
											<td class="tg-0pky" rowspan='${timeCnt+1}' 	style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[dateCnt*indexCnt*columnCnt].opratDate}</div></td>	<!-- 날짜 -->
											<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
										</c:if>
										<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultList[j*columnCnt].tm}</td>		<!-- 시간 -->
									</c:if>
							
									<!-- 컬럼 갯수대로 실행 -->
									<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
									<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
									<c:set var = "totalSum" value = "0"/>			<!-- 합계변수 -->	
									
									<c:forEach var='i' begin='${st}' end='${ed-1}' >	    
									
										<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[i].userCntAgg}</td>							<!-- 이용자유형-->
										<c:set var = "totalSum" value = '${totalSum + passResultList[i].userCntAgg}'/>	
									
									</c:forEach>
									
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalSum}</td>												<!-- 합계 -->
									<c:set var = "totalTotalSum" value = '${totalTotalSum + totalSum}'/>	
								</tr>
								
							
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
									<!-- 최종 열의 합 -->
									<c:if test="${(j % (timeCnt)) == timeCnt-1}">
										<tr> 
											<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">합계</td>	
											
											
											<c:forEach var='k' begin='0' end='${columnCnt-1}' >	    
												<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultCntList[(columnCnt*totalTotalIndexCnt)+k].suma}</td>					<!-- 이용자유형 합계-->
											</c:forEach>
											
											<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${totalTotalSum}</td>	
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
 