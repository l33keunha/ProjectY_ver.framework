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
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px; height: 55px;">광역/도</th>
							<!-- 광역/도 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>
							<!-- 시/군 -->
							<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>
							<!-- 분석일자 -->
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>
							<!-- 요일 -->
							<th class="tg-0pky" rowspan="2" style="width: 122px; min-width: 122px; max-width: 122px;">노선명</th>
							<!-- 노선명 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">노선유형</th>
							<!-- 노선유형 -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">기점</th>
							<!-- 기점 -->
							<th class="tg-0pky" rowspan="2" style="width: 134px; min-width: 134px; max-width: 134px;">종점</th>
							<!-- 종점 -->
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
							
								<!-- 전체 row 수 -->
								<c:if test="${j == 0}">
									<td class="tg-c3ow" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>
									<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>
									<!-- 시/군 -->
								</c:if>
								
								<td class="tg-0pky"  style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${congestionResultList[j*columnCnt].opratDate }</div></td>
								<!-- 분석일자 -->
								<td class="tg-0pky"  style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${congestionResultList[j*columnCnt].dy }</div></td>
								<!-- 요일 -->
								
								<td class="tg-0pky" style="width: 122px; min-width: 122px; max-width: 122px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].routeNma}</div></td>
								<!-- 노선명 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].routeType}</div></td>
								<!-- 노선유형 -->
								<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].routeStart}</div></td>
								<!-- 기점 -->
								<td class="tg-0pky" style="width: 134px; min-width: 134px; max-width: 134px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].routeEnd}</div></td>
								<!-- 종점 -->
		
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
							<c:if test="${sVO.anal_type == 'congestionRoute_CBP'}">
								<th class="tg-0pky" colspan= "25" style="width: 100px; min-width: 100px; max-width: 100px;">평균 재차인원</th>
							</c:if>
							<c:if test="${sVO.anal_type == 'congestionRoute_DOC'}">
								<th class="tg-0pky" colspan= "25" style="width: 100px; min-width: 100px; max-width: 100px;">평균 혼잡도</th>
							</c:if>
						<tr>
						<tr>
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">00</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">01</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">02</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">03</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">04</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">05</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">06</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">07</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">08</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">09</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">10</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">11</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">12</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">13</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">14</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">15</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">16</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">17</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">18</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">19</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">20</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">21</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">22</th>		<!-- 시간대 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">23</th>		<!-- 시간대 -->
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
						
						<c:if test="${sVO.anal_type == 'congestionRoute_CBP'}">
							<tr style="${scroll_display_none}" class= "show_${showScroll}">
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng00}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng01}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng02}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng03}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng04}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng05}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng06}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng07}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng08}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng09}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng10}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng11}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng12}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng13}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng14}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng15}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng16}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng17}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng18}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng19}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng20}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng21}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng22}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdng23}</div></td> 
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].brdngCntAvg}</div></td> 
							</tr>
						</c:if>
						<c:if test="${sVO.anal_type == 'congestionRoute_DOC'}">
							<tr style="${scroll_display_none}" class= "show_${showScroll}">
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con00}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con01}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con02}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con03}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con04}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con05}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con06}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con07}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con08}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con09}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con10}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con11}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con12}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con13}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con14}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con15}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con16}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con17}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con18}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con19}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con20}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con21}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con22}</div></td>
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].con23}</div></td> 
								<td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><div class="lavel-2  lavel-1">${congestionResultList[j * columnCnt].conRateAvg}</div></td> 
							</tr>
						</c:if>
						</c:forEach>
					</tbody>
					<!--바디 끝▲-->
		
				</table>
			</div>
		
		</div>
		