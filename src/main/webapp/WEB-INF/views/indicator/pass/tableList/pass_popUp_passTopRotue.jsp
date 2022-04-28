<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		<!-- ● 상위이용노선  -->
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
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">광역/도</th>			<!-- 광역/도 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>				<!-- 시/군 -->
					<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">분석일자</th>			<!-- 분석일자 -->
					<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>				<!-- 요일 -->
					<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">순위</th>				<!-- 순위 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선명</th>			<!-- 노선명 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선유형</th>			<!-- 노선유형 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">기점</th>				<!-- 기점 -->
					<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">종점</th>				<!-- 종점 -->
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
               		
               			
               			<c:set var = "forCnt" value = '${passResultList.size()/columnCnt}'/>					<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
				
				
						<c:set var = "totalTotalSum" value = "0"/>												<!-- 승차소계 합계변수 -->	
				
					
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
								<!-- 날짜 하루 조회므로 첫 시작때만 표출 -->
								<c:if test="${j == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>			<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[0].opratDate}</div></td>		<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div>${passResultList[0].dy}</div></td>				<!-- 요일 --> 
								</c:if>
							
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultList[j * columnCnt].r}</td>							<!-- 순위 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].routeNma}</td>					<!-- 노선명 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].routeType}</td>					<!-- 노선유형 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].routeStart}</td>					<!-- 기점 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].routeEnd}</td>					<!-- 종점 -->
								
								
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
							
								<c:set var = "totalInSum" value = "0"/>			<!-- 승차합 변수 -->	
								<c:set var = "totalOutSum" value = "0"/>		<!-- 하차합 변수 -->	
								<c:set var = "totalHsSum" value = "0"/>			<!-- 환승합 변수 -->	
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
		                        <c:forEach var='i' begin='${st}' end='${ed-1}' >
		                           <c:if test="${passResultList[j * columnCnt].tfcmn == 'B'}">
		                              <td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[i].routeBusGinAgg}</td>      <!-- 이용자 유형 (승차) -->
		                              <td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[i].routeBusGffAgg}</td>      <!-- 이용자 유형 (하차) -->
		                              <td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${passResultList[i].routeBusTrsAgg}</td>      <!-- 이용자 유형 (환승) -->
		                           
		                              <c:set var = "totalInSum"    value = '${totalInSum + (passResultList[i].routeBusGinAgg)}'/>                  				<!-- 승차합 계산 -->
		                              <c:set var = "totalOutSum"    value = '${totalOutSum + (passResultList[i].routeBusGffAgg)}'/>                  			<!-- 하차합 계산 -->
		                              <c:set var = "totalHsSum"    value = '${totalHsSum + (passResultList[i].routeBusTrsAgg)}'/>                 	 			<!-- 환승합 계산 -->
		                           </c:if>
		                        </c:forEach>      
									
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum}</td>								<!-- 승차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalOutSum}</td>								<!-- 하차소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalHsSum}</td>								<!-- 환승소계 -->
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalInSum+totalOutSum}</td>					<!-- 합계(승차+하차) -->
								
								<c:set var = "totalTotalSum" value = '${totalTotalSum + totalSum}'/>	
								
							</tr>
					
						
							
						</c:forEach>
						
					
						
						
					</tbody>
				</table>
			</div>
		</div>
