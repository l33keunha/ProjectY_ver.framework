<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



		<!-- 행 계산 변수 -->
		
		
		<!-- 공통함수 -->
		<c:set var="timeCnt" value="${(sVO.tmEnd - sVO.tmStart + 2) }" />
		<!-- 시간 반복 갯수 (합계 포함) -->
		<fmt:parseNumber var="timeCnt" value="${timeCnt}" />
		<!-- 컬럼 반복 횟수 (합계 포함) -->
		<c:set var="columnCnt" value='${columnCnt+1}' />
		
		<fmt:parseNumber var="busCnt" value='${busCnt/columnCnt}' />
		<fmt:parseNumber var="trainCnt" value='${trainCnt/columnCnt}' />
	
		
		
		<!-- 버스 -->
		<c:set var="forCnt" value='${timeDistnResultList.size()/columnCnt}' />
		<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
		
		<c:set var="dateCnt" value="${1}" />
		<!-- 날짜 종류 갯수 -->
		<fmt:parseNumber var="dateCnt" value="${forCnt/dateCnt}" />
		<!-- 날짜 출력 갯수 -->
	
		<c:set var="indexCnt" value="0" />
		<!-- 날짜 index count -->
	
	
	
		<!-- 보여줄 row 개수 -->
 		<c:set var = "rowShow" value ="500" />													
 
		<script>
			
			var cnt = 1;
			var check = false;
			
			function moreList(){
				 $(".show_"+cnt).show();
				 cnt++;
			}
			
		    function showPage() {
	         	document.getElementById("lds-spinner").style.display = "none";
	        }
		 
		    
		    $(".content_wrap").scroll(function() {
		      
		    	if(check== true){
		    		return;
		    	}
		    	
		        var scrolltop = $(".content_wrap").scrollTop();
		        var height = $(".table-left").height();
		        var height_win = $(".content_wrap").height();
		        var calculation = height - height_win;
		    
		     	//퍼센트 구하기 
		     	var percent = (scrolltop / calculation) *100
		     	
		     	
		     	//if (Math.round(scrolltop/100) ==  Math.round(calculation/100)) {
		       	//	moreList();
		    	//} 
		    	
		     	//80% 이상 일때 스크롤 출력
		    	 if(percent >= 80 && check== false){
		    		check = true;
		    		//	document.getElementById("lds-spinner").style.display = "";
		    		//	setTimeout("showPage()", 10);
		    	 }
		    	
		    	//90% 이상 일때 스크롤 출력
		    	 if(check){
		    	 	moreList();
		    	 	check = false;
		    	 }
		    })
			
		</script>
		
		<!-- ● 노선별통행 -->
		<div class="table-left">
			<div class="table1">
				<table style="border-collapse: collapse;">
		
					<!--thead 시작▼-->
					<thead>
						<tr>
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px; height: 55px;">광역/도</th>
							<!-- 광역/도 -->
							
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>
							<!-- 시/군 -->
							<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>
							<!-- 분석일자 -->
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>
							<!-- 요일 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선구분</th>
							<!-- 노선구분 -->
							<th class="tg-0pky" rowspan="2" style="width: 122px; min-width: 122px; max-width: 122px;">노선명</th>
							<!-- 노선명 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선유형</th>
							<!-- 노선유형 -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">기점</th>
							<!-- 기점 -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">종점</th>
							<!-- 종점 -->
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">시간</th>
							<!-- 시간 -->
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
						<!-- 버스 -->
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							
							<!-- 스크롤 시, 데이터 보여주는 부분 로직-->
							<c:if test="${j == 0}">
								<c:set var="showScroll" value="0" />	
								<c:set var="scroll_display_none" value="" />
							</c:if>
			           		<c:if test="${(j%rowShow == 0) && (j > 0)}">
			           			<c:set var="scroll_display_none" value="display: none;"/>
								<c:set var="showScroll" value="${showScroll+1}" />	
							</c:if>
				    
							<tr style="${scroll_display_none}" class= "show_${showScroll}">	
		
								<!-- 시간대 : 1일 -->
								<c:if test="${sVO.tm == 'allDay'}">
		
						
									<!-- 전체 row 수 -->
									<c:if test="${j == 0}">
										<td class="tg-c3ow" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>
										<!-- 광역/도 -->
										<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>
										<!-- 시/군 -->
									</c:if>
									
									<c:if test="${(j % dateCnt) == 0}">
										<!-- 시간 * 날짜수  -->           
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${timeDistnResultList[j*columnCnt].opratDate }</div></td>
										<!-- 분석일자 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${timeDistnResultList[j*columnCnt].dy }</div></td>
									</c:if>
									
									<c:if test="${j == 0}">
										<td class="tg-0pky" rowspan='${busCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${timeDistnResultList[0].tfcmn}</div></td>
										<!-- 노선구분 -->
									</c:if>
										
									<c:if test="${j == busCnt}">
										<td class="tg-0pky" rowspan='${trainCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${timeDistnResultList[j * columnCnt].tfcmn}</div></td>
									</c:if>
		
									
		
									<td class="tg-0pky" style="width: 122px; min-width: 122px; max-width: 122px;"><div class="lavel-2  lavel-1">${timeDistnResultList[j * columnCnt].routeNma}</div></td>
									<!-- 노선명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2  lavel-1">${timeDistnResultList[j * columnCnt].routeType}</div></td>
									<!-- 노선유형 -->
									<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${timeDistnResultList[j * columnCnt].routeStart}</div></td>
									<!-- 기점 -->
									<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${timeDistnResultList[j * columnCnt].routeEnd}</div></td>
									<!-- 종점 -->
		
		
									<!-- 전체 row 수 -->
									<c:if test="${j == 0}">
										<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">전체</div></td>
										<!-- 시간 -->
									</c:if>
		
								</c:if>
		
		
		
		
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
		
									<!-- 전체 row 수 -->
									<c:if test="${j == 0}">
										<td class="tg-c3ow" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>
										<!-- 광역/도 -->
										<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>
										<!-- 시/군 -->
									</c:if>
									
									<c:if test="${(j % dateCnt) == 0}">
										<!-- 시간 * 날짜수  -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${timeDistnResultList[dateCnt*indexCnt*columnCnt].opratDate }</div></td>
										<!-- 분석일자 -->
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${timeDistnResultList[dateCnt*indexCnt*columnCnt].dy }</div></td>
										<!-- 요일 -->
										<c:set var="indexCnt" value="${indexCnt + 1}" />
									</c:if>
		
									<c:if test="${j == 0}">
										<td class="tg-0pky" rowspan='${busCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${timeDistnResultList[0].tfcmn }</div></td>
										<!-- 노선구분 -->
									</c:if>
									
									<c:if test='${j == busCnt}'>
										<td class="tg-0pky" rowspan='${trainCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${timeDistnResultList[j * columnCnt].tfcmn }</div></td>
									</c:if>
									
									<!-- 노선명 그룹이 시작될 때마다 실행 -->
									<c:if test="${(j % timeCnt) == 0}">
										<td class="tg-0pky" rowspan='${timeCnt}' style="width: 122px; min-width: 122px; max-width: 122px;"><div class="lavel-2 ">${timeDistnResultList[j * columnCnt].routeNma}</div></td>
										<!-- 노선명 -->
										<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${timeDistnResultList[j * columnCnt].routeType}</div></td>
										<!-- 노선유형 -->
										<td class="tg-0pky" rowspan='${timeCnt}' style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2">${timeDistnResultList[j * columnCnt].routeStart}</div></td>
										<!-- 기점 -->
										<td class="tg-0pky" rowspan='${timeCnt}' style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2">${timeDistnResultList[j * columnCnt].routeEnd}</div></td>
										<!-- 종점 -->
									</c:if>
									<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${timeDistnResultList[j * columnCnt].tm}</td>
									<!-- 시간 -->
								</c:if>
							</tr>
		
		
		
						</c:forEach>
		
					</tbody>
					<!--tbody 끝▲-->
		
				</table>
			</div>
		</div>
		
		<div class="tableright" style="float: left; width: 10px;">
			<div class="tableright01">
				<table style="border-collapse: collapse;">
		
					<!--헤더 시작▼-->
					<thead>
							
						<tr>
						
							<th class="tg-0pky" colspan ="${columnCnt}" style="width: ${(columnCnt*70)+30}px; min-width: ${(columnCnt*70)+30}px; max-width: ${(columnCnt*70)+30}px;">통행시간</th>		<!-- 통행시간 -->
							<th class="tg-0pky" colspan ="${columnCnt}" style="width: ${(columnCnt*70)+30}px; min-width: ${(columnCnt*70)+30}px; max-width: ${(columnCnt*70)+30}px;">통행거리</th>		<!-- 통행거리 -->
						</tr>
						<tr>
							<!-- 통행시간 -->
						 	<c:forTokens  var="name" items="${cd_noText}" delims="_">
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${name}</th>		<!-- 이용자 유형 -->
							</c:forTokens>
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">평균</th>			<!-- 평균-->
							
							<!-- 통행거리 -->
							<c:forTokens  var="name" items="${cd_noText}" delims="_">
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${name}</th>		<!-- 이용자 유형 -->
							</c:forTokens>
							<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">평균</th>			<!-- 평균-->
						</tr>
					</thead>
					<!--헤더 끝▲-->
		
				</table>
			</div>
		
			<div class="tableright02">
				<table style="border-collapse: collapse;">
		
					<!--바디 시작▼-->
					<tbody>
		
		
						<!-- 버스 -->
						<c:forEach var='j' begin='0' end='${forCnt-1}'>
							
							<!-- 스크롤 시, 데이터 보여주는 부분 로직-->
							<c:if test="${j == 0}">
								<c:set var="showScroll" value="0" />	
								<c:set var="scroll_display_none" value="" />
							</c:if>
			           		<c:if test="${(j%rowShow == 0) && (j > 0)}">
			           			<c:set var="scroll_display_none" value="display: none;"/>
								<c:set var="showScroll" value="${showScroll+1}" />	
							</c:if>
				    
							<tr style="${scroll_display_none}" class= "show_${showScroll}">	
								<!-- 이용자 유형 갯수에 맞춰 실행 -->
								<c:set var="st" value='${j*columnCnt}' />	<!-- 시작 index -->
								<c:set var="ed" value='${st+columnCnt}' />	<!-- 끝 index -->
		
								<!-- 통행시간 or 통행거리에 따른 표 표출 -->
								<c:forEach var='k' begin='0' end='1' >	    
								
									<!-- 이용자 유형에 따라 유동적으로 적용 -->
									<c:forEach var='i' begin='${st}' end='${ed-1}'>
									
										<!-- 컬럼에 따른 Size 변수 -->
										<c:set var="tdSize" value="${70}" />
										<c:if test="${i == (ed-1)}">
											<c:set var="tdSize" value="${100}" />
										</c:if>
										
										<!-- 통행시간 or 통행 거리에 따른 데이터 컬럼 -->
										<c:set var="timeDistn_value" value="" />
										<c:if test="${k == 0}">
											<c:set var="timeDistn_value" value="${timeDistnResultList[i].brdngTmAvg}" />
										</c:if>
										<c:if test="${k == 1}">
											<c:set var="timeDistn_value" value="${timeDistnResultList[i].useDstAvg}" />
										</c:if>
									
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${timeDistn_value}"/></td>		<!-- 이용자유형-->
									
									</c:forEach>
								
								</c:forEach>
							</tr>
							
						</c:forEach>
		
					</tbody>
					<!--바디 끝▲-->
		
				</table>
			</div>
		
		</div>





