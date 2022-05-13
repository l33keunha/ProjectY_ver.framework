<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

		
		
		<!-- 행 계산 변수 -->
		
		<c:set var="columnCnt" value='${columnCnt+1}' />											<!-- 컬럼 반복 횟수 (합계 포함) -->
 		
		<c:set var = "forCnt" value = '${passResultList.size()/columnCnt}'/>						<!-- 컬럼갯수(이용자 유형)에 따른 총 반복횟수 -->
		<fmt:parseNumber var = "forCnt" value = "${forCnt}"  />	
	
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
 	
		<!-- ● 행정동간OD 수단통행 -->
		<div class="table-left">
			<div class="table1">
				<table style="border-collapse: collapse;">
					
					<!--thead 시작▼-->
					<thead>
					 	<tr>
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">광역/도</th>				<!-- 광역/도 -->
							<th class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;">시/군</th>			<!-- 시/군 -->
							<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">날짜</th>			<!-- 분석일자 -->
							<th class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;">요일</th>				<!-- 요일 -->
							<th class="tg-0pky"  style="width: 40px; min-width: 40px; max-width: 40px;">출발존</th>			<!-- 출발존 -->
							<th class="tg-0pky"  style="width: 255px; min-width: 255px; max-width: 255px;">출발행정동</th>		<!-- 출발행정동 -->
							<th class="tg-0pky"  style="width: 40px; min-width: 40px; max-width: 40px;">도착존</th>			<!-- 도착존 -->
							<th class="tg-0pky"  style="width: 255px; min-width: 255px; max-width: 255px;">도착행정동</th>		<!-- 도착행정동 -->
						</tr>
						
					</thead>
					<!--thead 끝▲-->
					
				</table>	
			</div>
			  
			<div class="table2">
				<table style="border-collapse: collapse;">
					
					<!--tbody 시작▼-->	
					<tbody>
						<c:set var="cnt" value='0' />	
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
					
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_sido_text}</div></td>								<!-- 광역/도 -->
								<td class="tg-0pky" style="width: 80px; min-width: 80px; max-width: 80px;"><div class="lavel-2">${anal_area_cd_text}</div></td>					
							 	<td class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;"><div class="lavel-2">${passResultList[0].opratDate}</div></td>							<!-- 분석일자 --> 
							 	<td class="tg-0pky" style="width: 30px; min-width: 30px; max-width: 30px;"><div class="lavel-2">${passResultList[0].dy}</div></td>									<!-- 요일 --> 
								
								<td class="tg-0pky" style="width: 40px; min-width: 40px; max-width: 40px;"><div class="lavel-2 lavel-1">${passResultList[j * columnCnt].getinout}</div></td>		<!-- 출발존 -->
								<td class="tg-0pky" style="width: 255px; min-width: 255px; max-width: 255px;"><div class="lavel-2 lavel-1">${passResultList[j * columnCnt].getinoutnm}</div></td>		<!-- 출발행정동 -->
								<td class="tg-0pky" style="width: 40px; min-width: 40px; max-width: 40px;"><div class="lavel-2 lavel-1">${passResultList[j * columnCnt].offinout}</div></td>		<!-- 도착존 -->
								<td class="tg-0pky" style="width: 255px; min-width: 255px; max-width: 255px;"><div class="lavel-2 lavel-1">${passResultList[j * columnCnt].offinoutnm}</div></td>		<!-- 도착행정동 -->
								
							</tr>
					
						</c:forEach>

					</tbody>
					<!--tbody 끝▲-->	
					
				</table>
			</div>
		</div>
		
		<div class="tableright" style="float: left;width: 10px;">
			<div class="tableright01">
				<table style="border-collapse: collapse;">
				
					<!--헤더 시작▼-->
					<thead>
						<tr>
							<c:forTokens  var="name" items="${cd_noText}" delims="_">
								<th class="tg-0pky" style="width: 70px; min-width: 70px; max-width: 70px;">${name}</th>		<!-- 이용자 유형 -->
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
									
										<td class="tg-0pky" style="width: ${tdSize}px; min-width: ${tdSize}px; max-width: ${tdSize}px; height: 20px;"><fmt:formatNumber type="number" value="${passResultList[i].cnt}"/></td>				<!-- 이용자유형-->
		
									</c:forEach>
									
								</tr>
						
							</c:forEach>
					</tbody>
					<!--바디 끝▲-->
				
				</table>
			</div>
	
		</div>

			
			
		
      
 