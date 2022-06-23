<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		
		
		<style>
			.modal-content{
				z-index: 10000;
				position: absolute;
			    /*
			    width: 202px;
			    height: 173px;
			    */
			    width: 700px;
			    height: 400px;
			    background: #c5e4ff;
			    box-shadow: 5px 5px 13px 3px #00000087;
			    color: #1c2e3e;
			    margin-top: 4px;
			    margin-left: 66px;
			}
	
			.modal-content.active{
			   display: block;
			}
			
			.map-choice:visited {
			  color : black;
			}
			.map-choice:hover {
			  color : red;
			  cursor: pointer;
			}
			
		</style>
		
		<!-- 행 계산 변수 -->
		
		<c:set var="columnCnt" value='${columnCnt+1}' />									<!-- 컬럼 반복 횟수 (합계 포함) -->
		<c:set var = "forCnt" value = '${passResultList.size()/columnCnt}'/>				<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
			
		<!-- ● 상위이용정류장  -->
		<div class="table-left">
			<div class="table1">
				<table style="border-collapse: collapse;">
					
					<!--thead 시작▼-->
					<thead>
						 <tr>
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px; height: 55px;">광역/도</th>	<!-- 광역/도 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>			<!-- 시/군 -->
							<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>			<!-- 분석일자 -->
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>				<!-- 요일 -->
							<th class="tg-0pky" rowspan="2" style="width: 30px; min-width: 30px; max-width: 30px;">순위</th>				<!-- 순위 -->
							<th class="tg-0pky" rowspan="2" style="width: 70px; min-width: 70px; max-width: 70px;">정류장구분</th>			<!-- 정류장구분 -->
							<th class="tg-0pky" rowspan="2" style="width: 80px; min-width: 80px; max-width: 80px;">정류장ID</th>			<!-- 정류장ID -->
							<th class="tg-0pky" rowspan="2" style="width: 200px; min-width: 200px; max-width: 200px;" onclick="getXY();">정류장명</th>		<!-- 정류장명 -->
							<th class="tg-0pky" rowspan="2" style="width: 210px; min-width: 210px; max-width: 210px;">정류장행정동</th>		<!-- 정류장행정동 -->
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
								<!-- 날짜 하루 조회므로 첫 시작때만 표출 -->
								<c:if test="${j == 0}">
									<!-- 시간 * 날짜수  -->	   	
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>		<!-- 광역/도 -->
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>				<!-- 시/군 -->
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${passResultList[0].opratDate}</div></td>	<!-- 분석일자 --> 
									<td class="tg-0pky" rowspan='${forCnt}' style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${passResultList[0].dy}</div></td>			<!-- 요일 --> 
								</c:if>
							
								<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">${passResultList[j * columnCnt].r}</td>									<!-- 순위 -->
								
								<c:if test="${passResultList[j * columnCnt].tfcmn == 'B'}">
									<c:set var="t_b_name" value='버스' />
								</c:if>
								<c:if test="${passResultList[j * columnCnt].tfcmn == 'T'}">
									<c:set var="t_b_name" value='지하철' />
								</c:if>
								
								<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2 lavel-1">${t_b_name}</div></td>																							<!-- 정류장구분 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2 lavel-1" id="busTest_${passResultList[j * columnCnt].sttnId}" >${passResultList[j * columnCnt].sttnId}</div></td>		<!-- 정류장ID -->
								<td class="tg-0pky" style="width: 200px; min-width: 200px; max-width: 200px;">
									<!-- 
									<div class="lavel-2 lavel-1" id="mapPage_${j}"     x="${passResultList[j * columnCnt].x}" 
																					   y="${passResultList[j * columnCnt].y}" 
																					   tfcmn="${passResultList[j * columnCnt].tfcmn}" 
																					   bus_hjd="${passResultList[j * columnCnt].sttnHjd}"
																					   bus_name="${passResultList[j * columnCnt].sttnNma}"
																					   bus_id="${passResultList[j * columnCnt].sttnId}" >  
									
												${passResultList[j * columnCnt].sttnNma}
									</div>											
									 -->
									<!-- 정류장명 -->
									<a class="map-choice">
										<div class="lavel-2 lavel-1" onClick="mapPage(${passResultList[j * columnCnt].y}, ${passResultList[j * columnCnt].x}, '${passResultList[j * columnCnt].tfcmn}', '${passResultList[j * columnCnt].sttnNma}', '${passResultList[j * columnCnt].sttnHjd}');">${passResultList[j * columnCnt].sttnNma}</div>	<!-- 정류장명 -->
									</a>	
									<!--  
										<div class="lavel-2 lavel-1 modal" id="modal_${j}" x="${passResultList[j * columnCnt].x}" 
																					   y="${passResultList[j * columnCnt].y}" 
																					   tfcmn="${passResultList[j * columnCnt].tfcmn}" 
																					   bus_hjd="${passResultList[j * columnCnt].sttnHjd}"
																					   bus_name="${passResultList[j * columnCnt].sttnNma}"
																					   bus_id="${passResultList[j * columnCnt].sttnId}" >
											${passResultList[j * columnCnt].sttnNma}
										</div>  
									-->
								</td>							
								<td class="tg-0pky" style="width: 210px; min-width: 210px; max-width: 210px;"><div class="lavel-2 lavel-1">${passResultList[j * columnCnt].sttnHjd}</div></td>															<!-- 정류장행정동 -->
								
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
								<th class="tg-0pky" colspan="3" style="width: 210px; min-width: 210px; max-width: 210px;">${name}</th>	<!-- 이용자 유형 -->
							</c:forTokens>
							<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">승차소계(환승포함)</th><!-- 승차소계-->
							<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">하차소계</th>		<!-- 하차소계-->
							<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">환승소계</th>		<!-- 환승소계-->
							<th class="tg-0pky" rowspan="2" style="width: 100px; min-width: 100px; max-width: 100px;">합계(승차+하차)</th>	<!-- 합계-->
						</tr>
						<tr>
							<c:forEach var='j' begin='0' end='${columnCnt-2}' >	
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">승차</th>					<!-- 승차-->
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">하차</th>					<!-- 하차 -->
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">환승</th>					<!-- 환승 -->	
							</c:forEach>
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
									 
									<!-- 버스일때 -->
									<c:if test="${passResultList[j * columnCnt].tfcmn == 'B'}">
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].ginAgg}"/></td>		<!-- 이용자 유형 (승차) -->
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].gffAgg}"/></td>		<!-- 이용자 유형 (하차) -->
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].trsAgg}"/></td>		<!-- 이용자 유형 (환승) -->
										<c:if test="${i == (ed-1)}">
										   <td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><fmt:formatNumber type="number" value="${passResultList[i].ginGffSum}"/></td>	<!-- 합계(승차+하차) -->
									  	</c:if>
									</c:if>
									
									<!-- 지하철일때 -->
									<c:if test="${passResultList[j * columnCnt].tfcmn == 'T'}">
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].ginAgg}"/></td>		<!-- 이용자 유형 (승차) -->
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].gffAgg}"/></td>		<!-- 이용자 유형 (하차) -->
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px;"><fmt:formatNumber type="number" value="${passResultList[i].trsAgg}"/></td>		<!-- 이용자 유형 (환승) -->
										<c:if test="${i == (ed-1)}">
										   <td class="tg-0pky" style="width: 100px; min-width: 100px; max-width: 100px;"><fmt:formatNumber type="number" value="${passResultList[i].ginGffSum}"/></td>	<!-- 합계(승차+하차) -->
									  	</c:if> 
									</c:if>
									
								</c:forEach>		
								
								
							</tr>
							
						</c:forEach>
						
					</tbody>
					<!--바디 끝▲-->
				
				</table>
			</div>
	
		</div>

	<!-- 지도 조회조건 -->
	<form id="mapForm" action="<%=request.getContextPath()%>/passMap.do" target="map" method="post">
		
		<input name="bus_x" 		type="hidden" id="bus_x" 		value=""/>
		<input name="bus_y" 		type="hidden" id="bus_y" 		value=""/>
		<input name="bus_sttnNma" 	type="hidden" id="bus_sttnNma" 	value=""/>
		<input name="bus_sttnHjd" 	type="hidden" id="bus_sttnHjd" value=""/>
		<input name="bus_tfcmn" 	type="hidden" id="bus_tfcmn" value=""/>
		<input name="dataList" 		type="hidden" id="dataList" value=""/>
	
		<input type="submit" id="mapSubmitBtn" style="display: none;"/>
	</form>

	<script>
   
		//지도 x,y 좌표 데이터 가져오기
		var arr = new Array();
		<c:forEach var='j' begin='0' end='${forCnt-1}'>
		
			arr.push({	
				tfcmn :"${passResultList[j * columnCnt].tfcmn}",
				x:"${passResultList[j * columnCnt].y}",
				y:"${passResultList[j * columnCnt].x}", 		
				sttnNma:"${passResultList[j * columnCnt].sttnNma}", 		
				sttnHjd:"${passResultList[j * columnCnt].sttnHjd}" 		
			});
			
		</c:forEach>
	 
	    
		var openWin;
		function mapPage(x, y, tfcmn, sttnNma, sttnHjd) {
			
			//팝업 존재 유무
			if(typeof openWin == "undefined" || openWin.closed) {
			
				$('#bus_x').val(x);
				$('#bus_y').val(y);
				$('#bus_tfcmn').val(tfcmn);
				$('#bus_sttnNma').val(sttnNma);
				$('#bus_sttnHjd').val(sttnHjd);
				$('#dataList').val(encodeURIComponent(JSON.stringify(arr)));
				
				openWin = window.open("" ,"map", "toolbar=no, width=560, height=275, directories=no, status=no, scrollorbars=no, resizable=no");
				$('#mapSubmitBtn').click();
				
			}else{
				
				openWin.focus();
				popup.markerChoice(x,y,tfcmn+"choice", sttnNma, sttnHjd); // 자식창 함수 호출
			}
			
		}
		
		
	</script>