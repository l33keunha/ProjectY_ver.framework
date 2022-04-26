<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>


		<!-- ● 행정동간OD 수단통행 -->
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
					
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발존</th>			<!-- 출발존 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발행정동</th>		<!-- 출발행정동 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착존</th>			<!-- 도착존 -->
					<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착행정동</th>		<!-- 도착행정동 -->
					
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
				
				
						<c:set var = "totalTotalSum" value = "0"/>												<!-- 승차소계 합계변수 -->	
				
					
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							<tr class="level-2">
								<!-- 날짜 하루 조회므로 첫 시작때만 표출 -->
						<%-- 		<c:if test="${j == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[0].rownum}</div></td>		<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div></div></td>								<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${forCnt+1}' style="width: 80px; min-width: 80px; max-width: 80px;"><div></div></td>								<!-- 시/군 -->
								</c:if>
							 --%>
							 
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_sido_text}</div></td>								<!-- 광역/도 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div>${anal_area_cd_text}</div></td>					
							 	<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;"><div>${passResultList[0].opratDate}</div></td>	<!-- 분석일자 --> 
								
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].getinout}</td>							<!-- 출발존 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].getinoutnm}</td>							<!-- 출발행정동 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].offinout}</td>							<!-- 도착존 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[j * columnCnt].offinoutnm}</td>							<!-- 도착행정동 -->
								
								
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
								
								<c:set var = "totalSum" value = "0"/>			<!-- 승차합 변수 -->	
							
								
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">${passResultList[i].cnt}</td>		<!-- 이용자 유형 -->
								
									<c:set var = "totalSum" 	value = '${totalSum + (passResultList[i].cnt)}'/>							<!-- 합계 계산 -->
								</c:forEach>
								
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalSum}</td>						<!-- 합계 -->
								
								<c:set var = "totalTotalSum" value = '${totalTotalSum + totalSum}'/>	
								
							</tr>
					
						<%-- 	
							<!-- 최종 열의 합 -->
							<c:if test="${ j == (forCnt-1)}">
								<tr>
									<td class="tg-0pky" colspan="4" style="width: 320px; min-width: 320px; max-width: 320px;">합계</td>	
									
									<c:forEach var='k' begin='0' end='${columnCnt-1}' >	    
										<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${k}</td>						<!--  합계-->
									</c:forEach>
				
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">${totalTotalSum}</td>				<!-- 합계의 합계-->
							
									<c:set var = "totalTotalSum" value = "0"/>
									
									
								</tr>
							</c:if> --%>
							
						</c:forEach>
						
					
						
						
					</tbody>
				</table>
			</div>
		</div>
