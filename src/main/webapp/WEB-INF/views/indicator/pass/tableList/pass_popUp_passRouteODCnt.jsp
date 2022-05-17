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
 	
 	
		<!-- ● 노선별OD -->
		<div class="table-left">
			<div class="table1">
				<table style="border-collapse: collapse;">
					
					<!--thead 시작▼-->
					<thead>
						<tr>
							
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장ID</th>		<!-- 출발정류장ID -->
							<th class="tg-0pky"  style="width: 150px; min-width: 150px; max-width: 150px;">출발정류장명</th>	<!-- 출발정류장명 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장행정동</th>	<!-- 출발정류장행정동 -->
							<th class="tg-0pky"  style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장ID</th>		<!-- 도착정류장ID -->
							<th class="tg-0pky"  style="width: 150px; min-width: 150px; max-width: 150px;">도착정류장명</th>	<!-- 도착정류장명 -->
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
									<!-- 날짜 그룹이 시작될 때마다 실행-->
								
									<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].getStnId}</div></td>					<!-- 출발정류장ID -->
									<td class="tg-0pky" style="width: 150px; min-width: 150px; max-width: 150px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].getStnNm}</div></td>				<!-- 출발정류장명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].getStnArea}</div></td>				<!-- 출발정류장행정동 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].offStnId}</div></td>					<!-- 도착정류장ID -->
									<td class="tg-0pky" style="width: 150px; min-width: 150px; max-width: 150px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].offStnNm}</div></td>				<!-- 도착정류장명 -->
									<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1">${passResultList[j*columnCnt].offStnArea}</div></td>				<!-- 도착정류장행정동 -->
									
									<c:if test="${(j % dateCnt) == 0}">
										<td class="tg-0pky" rowspan='${dateCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">전체</div></td>			<!-- 시간 -->
									</c:if>
								
								</c:if>
								
							
								<!-- 시간대 : 시작시간 ~ 끝시간 -->
								<c:if test="${sVO.tm == null}">
										<!-- 날짜 그룹이 시작될 때마다 실행-->
									
										<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
										<c:if test="${(j % timeCnt) == 0}">	   	
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].getStnId}</div></td>				<!-- 출발정류장ID -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 150px; min-width: 150px; max-width: 150px;"><div class="lavel-2">${passResultList[j * columnCnt].getStnNm}</div></td>				<!-- 출발정류장명 -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].getStnArea}</div></td>				<!-- 출발정류장행정동 -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${passResultList[j * columnCnt].offStnId}</div></td>				<!-- 도착정류장ID -->
											<td class="tg-0pky" rowspan='${timeCnt}' style="width: 150px; min-width: 150px; max-width: 150px;"><div class="lavel-2">${passResultList[j * columnCnt].offStnNm}</div></td>				<!-- 도착정류장명 -->
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
								<c:set var = "st" value = '${j*columnCnt}'/>	<!-- 시작 index -->
								<c:set var = "ed" value = '${st+columnCnt}'/>	<!-- 끝 index -->
							
								<!-- 이용자 유형에 따라 유동적으로 적용 -->
								<c:forEach var='i' begin='${st}' end='${ed-1}' >
									
									<!-- 컬럼에 따른 Size 변수 -->
									<c:set var="tdSize" value="${70}" />
									<c:if test="${i == (ed-1)}">
										<c:set var="tdSize" value="${100}" />
									</c:if>
									
									<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].cnt}"/></td>		<!-- 이용자 유형 -->
									
								</c:forEach>
							
							</tr>
						
							
						</c:forEach>
						
					</tbody>
					<!--바디 끝▲-->
				
				</table>
			</div>
	
		</div>

			
		
		
      
 