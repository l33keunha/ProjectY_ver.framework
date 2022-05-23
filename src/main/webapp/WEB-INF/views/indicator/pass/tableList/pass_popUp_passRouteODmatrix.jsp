<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src ="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/indicator/pass_popup_routeODmatrix.css">
	
		<!-- 공통함수 -->
		<!-- 컬럼 반복 횟수 (합계 포함) -->
		<c:set var="columnCnt" value='${columnCnt+1}' />
		
		<!-- 버스 -->
		<c:set var="forCnt" value='${routeOD.size()/columnCnt}' />

 	
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
 	
 	
		<!-- ● 노선별OD matrix -->
		<div class="table-left">
			<div class="table1" style="position: fixed;left: 0;">
				<table style="border-collapse: collapse;">
					
					<!--thead 시작▼-->
					<thead>
						<tr>
							
							<th class="tg-0pky"  style="width: 120px; min-width: 120px; max-width: 120px; height: 41px;">정류장명칭</th>		<!-- 빈칸 -->
							
						</tr>
					</thead>
					<!--thead 끝▲-->
					
				</table>	
			</div>
			  
			<div class="table2" style="position: sticky;left: 0;">
				<table style="border-collapse: collapse;">
					
					<!--tbody 시작▼-->	
					<tbody>
					
						<!-- 데이터 뿌려주는 부분 -->
						<c:forEach var='j' begin='0' end='${stationNmList.size()-1}'>
							
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
							
							<!-- 출발정류장ID 그룹이 시작될 때마다 실행 -->
							<td class="tg-0pky" style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2 lavel-1">${stationNmList[j*columnCnt].sttnNma}</div></td>
								
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
				
					<thead>
					
						<tr>
							<c:forEach var='j' begin='0' end='${stationNmList.size()-1}'>
								<th class="tg-0pky" style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2 lavel-1">${stationNmList[j*columnCnt].sttnNma}</div></th>				
							</c:forEach>
						</tr>
						
					</thead>
					
				</table>
			</div>
			<div class="tableright02">
				<table style="border-collapse: collapse;">
		
					<tbody>
					
						<c:forEach var='j' begin='0' end='${routeOD.size()-1}'>
							<tr>
								<c:forEach var='k' begin='0' end='${routeOD.size()-1}'>
									<td class="tg-0pky" style="width: 120px; min-width: 120px; max-width: 120px;"><div class="lavel-2 lavel-1">${routeOD[j*columnCnt][k]}</div></td>				
								</c:forEach>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
			</div>
		</div>
		
		
 		<script>
			$('.lavel-1').each(function () {
				if (this.offsetWidth < this.scrollWidth)
				    $(this).attr('title', $(this).text());
			});
        </script>  	
 