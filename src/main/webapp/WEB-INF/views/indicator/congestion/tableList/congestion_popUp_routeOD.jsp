<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


		<!-- 행 계산 변수 -->
		
		
		<!-- 공통함수 -->
		<!-- 컬럼 반복 횟수 (합계 포함) -->
		<c:set var="columnCnt" value='${columnCnt+1}' />
		
		<!-- 버스 -->
		<c:set var="forCnt" value='${congestionResultList.size()/columnCnt}' />
		
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
							<%-- 
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px; height: 55px;">광역/도</th>
							광역/도
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>
							시/군
							<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>
							분석일자
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>
							<!-- 요일 -->
							--%>
							
							<th class="tg-0pky" rowspan="2" style="width: 122px; min-width: 122px; max-width: 122px; height: 55px;">노선명</th>
							<!-- 노선명 -->
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">순위</th>
							<!-- 순위 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">출발정류장ID</th>
							<!-- 출발정류장ID -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">출발정류장명</th>
							<!-- 출발정류장명 -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">출발행정동</th>
							<!-- 출발행정동 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">도착정류장ID</th>
							<!-- 도착정류장ID -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">도착정류장명</th>
							<!-- 도착정류장명 -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">도착행정동</th>
							<!-- 도착행정동 -->
							
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
							
								<%-- 							
								<!-- 전체 row 수 -->
								<c:if test="${j == 0}">
								<td class="tg-c3ow" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>
								<!-- 광역/도 -->
								<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>
								<!-- 시/군 -->
								
								<td class="tg-0pky"  rowspan='${forCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${congestionResultList[j*columnCnt].opratDate }</div></td>
								<!-- 분석일자 -->
								<td class="tg-0pky"  rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${congestionResultList[j*columnCnt].dy }</div></td>
								<!-- 요일 -->
								</c:if> 
								--%>
								
								<c:if test="${j == 0}">
									<td class="tg-0pky" rowspan='${congestionResultList[0].cnt}' style="width: 122px; min-width: 122px; max-width: 122px;"><div class="lavel-2">${congestionResultList[0].routeNma}</div></td>
								</c:if>
								<c:if test="${j > 0}">
									<c:if test="${((congestionResultList[j-1].sttnRank+1) != (congestionResultList[j].sttnRank)) }">
										<td class="tg-0pky" rowspan='${congestionResultList[j].cnt}' style="width: 122px; min-width: 122px; max-width: 122px;"><div class="lavel-2">${congestionResultList[j * columnCnt].routeNma}</div></td>
										<!-- 노선명 -->
									</c:if>
								</c:if>
								
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].sttnRank}</div></td>
								<!-- 순위 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].stSttnId}</div></td>
								<!-- 출발정류장ID -->
								<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].stSttnNma}</div></td>
								<!-- 출발정류장명 -->
								<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].stSttnHjd}</div></td>
								<!-- 출발행정동 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].edSttnId}</div></td>
								<!-- 도착정류장ID -->
								<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].edSttnNma}</div></td>
								<!-- 도착정류장명 -->
								<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].edSttnHjd}</div></td>
								<!-- 도착행정동 -->
		
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
						<c:if test="${sVO.anal_type == 'congestionTopRouteOD_DOC_max'}">
							<tr>
								<th class="tg-0pky" colspan= "25" style="width: 100px; min-width: 100px; max-width: 100px;">최대 혼잡도</th>
							<tr>
						</c:if>
						<c:if test="${sVO.anal_type == 'congestionTopRouteOD_DOC_avg'}">
							<tr>
								<th class="tg-0pky" colspan= "25" style="width: 100px; min-width: 100px; max-width: 100px;">평균 혼잡도</th>
							<tr>
						</c:if>
						<tr>
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">00</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">01</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">02</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">03</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">04</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">05</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">06</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">07</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">08</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">09</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">10</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">11</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">12</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">13</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">14</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">15</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">16</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">17</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">18</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">19</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">20</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">21</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">22</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;">23</th>		<!-- 시간대 -->
							<c:if test="${sVO.anal_type == 'congestionTopRouteOD_DOC_max'}">
								<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">최대</th>			<!-- 평균-->
							</c:if>
							<c:if test="${sVO.anal_type == 'congestionTopRouteOD_DOC_avg'}">
								<th class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;">평균</th>			<!-- 평균-->
							</c:if>
						</tr>
					</thead>
					<!--헤더 끝▲-->
		
				</table>
			</div>
		
			<div class="tableright02">
				<table style="border-collapse: collapse;">
		
					<!--바디 시작▼-->
					<tbody>
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
								<c:if test="${sVO.anal_type == 'congestionTopRouteOD_DOC_max'}">
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max00}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max01}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max02}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max03}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max04}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max05}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max06}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max07}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max08}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max09}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max10}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max11}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max12}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max13}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max14}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max15}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max16}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max17}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max18}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max19}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max20}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max21}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max22}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].max23}</div></td>  
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].conRateMax}</div></td>
								</c:if> 
								<c:if test="${sVO.anal_type == 'congestionTopRouteOD_DOC_avg'}">
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg00}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg01}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg02}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg03}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg04}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg05}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg06}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg07}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg08}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg09}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg10}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg11}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg12}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg13}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg14}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg15}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg16}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg17}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg18}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg19}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg20}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg21}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg22}</div></td>
									<td class="tg-0pky" style="width: 50px; min-width: 50px; max-width: 50px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].avg23}</div></td> 
									<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].conRateAvg}</div></td>
								</c:if> 
							</tr>
						</c:forEach>
					</tbody>
					<!--바디 끝▲-->
		
				</table>
			</div>
		
		</div>
		