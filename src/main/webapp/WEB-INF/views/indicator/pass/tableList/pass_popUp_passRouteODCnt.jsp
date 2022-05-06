<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		
		
		<!-- 행 계산 변수 -->
		
 		<c:set var="columnCnt" value='${columnCnt+1}' />											<!-- 컬럼 반복 횟수 (합계 포함) -->
		
		<c:set var = "forCnt" value = '${passResultList.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
	
		<c:set var = "dateCnt" value = "${1}"/>														<!-- 날짜 종류 갯수 --> 
		<fmt:parseNumber var = "dateCnt" value = "${forCnt/dateCnt}"  />							<!-- 날짜 출력 갯수 -->
		
		<c:set var = "timeCnt" value = "${(sVO.tmEnd - sVO.tmStart + 2) }"/>						<!-- 시간 반복 갯수 -->
		
		<fmt:parseNumber var = "timeCnt" value = "${timeCnt}"  />									
	
		<c:set var = "indexCnt" value = "0"/>														<!-- 날짜 index count -->
	
 	
		<!-- ● 노선별OD -->
		<div class="table-left">
			<div class="table1">
				<table style="border-collapse: collapse;">
					
					<!--thead 시작▼-->
					<thead>
						<tr>
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px; height: 34px;">시/도</th>				<!-- 광역/도 -->
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/군/구</th>			<!-- 시/군 -->
							<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">분석일자</th>			<!-- 분석일자 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>				<!-- 요일 -->
							
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">노선구분</th>			<!-- 노선구분 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">노선명</th>			<!-- 노선명 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">노선유형</th>			<!-- 노선유형 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">기점</th>				<!-- 기점 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">종점</th>				<!-- 종점 -->
							
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장ID</th>		<!-- 출발정류장ID -->
							<th class="tg-0pky"  style="width: 120px; min-width: 120px; max-width: 120px;">출발정류장명</th>	<!-- 출발정류장명 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장행정동</th>	<!-- 출발정류장행정동 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장ID</th>		<!-- 도착정류장ID -->
							<th class="tg-0pky"  style="width: 120px; min-width: 120px; max-width: 120px;">도착정류장명</th>	<!-- 도착정류장명 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장행정동</th>	<!-- 도착정류장행정동 -->
							
							<th class="tg-0pky"  style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>				<!-- 시간 -->
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
									<!-- 날짜 그룹이 시작될 때마다 실행-->
									<c:if test="${(j % dateCnt) == 0}">
										<!-- 시간 * 날짜수  -->	   	
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>									<!-- 광역/도 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>										<!-- 시/군 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${passResultList[0].opratDate }</div></td>								<!-- 분석일자 --> 
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${passResultList[0].dy }</div></td>									<!-- 요일 --> 
										
											<c:if test="${passResultList[0].tfcmn == 'B'}">
												<c:set var="t_b_name" value='버스' />
											</c:if>
											<c:if test="${passResultList[0].tfcmn == 'T'}">
												<c:set var="t_b_name" value='지하철' />
											</c:if>
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${t_b_name}</div></td>													<!-- 노선구분 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[0].routeNma}</div></td>								<!-- 노선명 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[0].routeType}</div></td>								<!-- 노선유형 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[0].routeStart}</div></td>										<!-- 기점 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[0].routeEnd}</div></td>										<!-- 종점 -->
										<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
									</c:if>
								
									<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].getStnId}</div></td>					<!-- 출발정류장ID -->
									<td class="tg-0pky" style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].getStnNm}</div></td>				<!-- 출발정류장명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].getStnArea}</div></td>				<!-- 출발정류장행정동 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].offStnId}</div></td>					<!-- 도착정류장ID -->
									<td class="tg-0pky" style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].offStnNm}</div></td>				<!-- 도착정류장명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].offStnArea}</div></td>				<!-- 도착정류장행정동 -->
									
									<c:if test="${(j % dateCnt) == 0}">
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">전체</div></td>			<!-- 시간 -->
									</c:if>
								
								</c:if>
								
							
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
										<!-- 날짜 그룹이 시작될 때마다 실행-->
										<c:if test="${(j % dateCnt) == 0}">
											<!-- 시간 * 날짜수  -->	   	
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>									<!-- 광역/도 -->
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>										<!-- 시/군 -->
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${passResultList[dateCnt*indexCnt*columnCnt].opratDate }</div></td>	<!-- 분석일자 --> 
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${passResultList[dateCnt*indexCnt*columnCnt].dy }</div></td>			<!-- 요일 --> 
											
												<c:if test="${passResultList[0].tfcmn == 'B'}">
													<c:set var="t_b_name" value='버스' />
												</c:if>
												<c:if test="${passResultList[0].tfcmn == 'T'}">
													<c:set var="t_b_name" value='지하철' />
												</c:if>
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${t_b_name}</div></td>													<!-- 노선구분 -->
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[0].routeNma}</div></td>								<!-- 노선명 -->
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[0].routeType}</div></td>								<!-- 노선유형 -->
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[0].routeStart}</div></td>								<!-- 기점 -->
											<td class="tg-0pky" rowspan='${dateCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[0].routeEnd}</div></td>								<!-- 종점 -->
											<c:set var = "indexCnt" value = "${indexCnt + 1}"/>
										</c:if>
									
										<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
										<c:if test="${(j % timeCnt) == 0}">	   	
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].getStnId}</div></td>				<!-- 출발정류장ID -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2">${passResultList[j * columnCnt].getStnNm}</div></td>				<!-- 출발정류장명 -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].getStnArea}</div></td>				<!-- 출발정류장행정동 -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].offStnId}</div></td>				<!-- 도착정류장ID -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2">${passResultList[j * columnCnt].offStnNm}</div></td>				<!-- 도착정류장명 -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].offStnArea}</div></td>				<!-- 도착정류장행정동 -->
										</c:if>
										<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultList[j * columnCnt].tm}</td>			<!-- 시간 -->
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
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px; height: 34px;">${name}</th>		<!-- 이용자 유형 -->
							</c:forTokens>
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">합계</th>			<!-- 합계-->
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
							
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
							
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									
									<!-- 컬럼에 따른 Size 변수 -->
									<c:set var="tdSize" value="${70}" />
									<c:if test="${i == (ed-1)}">
										<c:set var="tdSize" value="${100}" />
									</c:if>
									
									<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;">${passResultList[i].cnt}</td>		<!-- 이용자 유형 -->
									
								</c:forEach>
							
							</tr>
						
							
						</c:forEach>
						
					</tbody>
					<!--바디 끝▲-->
				
				</table>
			</div>
	
		</div>

			
			
		
      
 