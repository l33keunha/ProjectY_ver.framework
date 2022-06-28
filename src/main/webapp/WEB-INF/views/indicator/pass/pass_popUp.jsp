<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="sVO" value="${sVO }"/>
<c:set var="list" value="${passResultList }"/>
<!DOCTYPE html>
<html>

	<!-- 코드 텍스트 매칭 -->
    <%@ include file="pass_popUp_codeNameMatch.jsp" %>
    
    <head>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script type="text/javascript" src="resources/js/indicator/common_popUp.js" async ></script>
         <c:if test = "${anal_groupText == '상위이용정류장' && anal_typeText == ''}">
     		<script type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=7D1285BF-31DC-3DD8-A3E3-86D92C9568E8&domain=localhost:8080"></script>
     	</c:if>
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/pass_popup.css">
    </head>
    
    	
    
    <iframe id="excelDown" name="excelDown" width="0" height="0"></iframe>
    
	<!-- 다운로드 조회조건 -->
	<form id="downloadForm" action="<%=request.getContextPath()%>/passDownload.do" target="excelDown">
		<div class= "sVOvalue">
			<input name="anal_fin" type="hidden" id="anal_finJS" value="${sVO.anal_fin}"/>
			<input name="dateStart" type="hidden" id="dateStartJS" value="${sVO.dateStart}"/>
			<input name="dateEnd" type="hidden" id="dateEndJS" value="${sVO.dateEnd}"/>
			<input name="anal_area_cd_sido" type="hidden" id="anal_area_cd_sidoJS" value="${sVO.anal_area_cd_sido}"/>
			<input name="anal_area_cd_sido_text" type="hidden" id="anal_area_cd_sido_textJS" value="${sVO.anal_area_cd_sido_text}"/>
			<input name="anal_area_cd" type="hidden" id="anal_area_cdJS" value="${sVO.anal_area_cd}"/>
			<input name="anal_area_cd_text" type="hidden" id="anal_area_cd_textJS" value="${sVO.anal_area_cd_text}"/>
			<input name="provider" type="hidden" id="providerJS" value="${sVO.provider}"/>
			<input name="provider_text" type="hidden" id="provider_textJS" value="${sVO.provider_text}"/>
			<input name="anal_group" type="hidden" id="anal_groupJS" value="${sVO.anal_group}"/>
			<input name="anal_type" type="hidden" id="anal_typeJS" value="${sVO.anal_type}"/>
			<input name="tm" type="hidden" id="tmJS" value="${sVO.tm}"/>
			<input name="tmStart" type="hidden" id="tmStartJS" value="${sVO.tmStart}"/>
			<input name="tmEnd" type="hidden" id="tmEndJS" value="${sVO.tmEnd}"/>
			<input name="tfcmn" type="hidden" id="tfcmnJS" value="${sVO.tfcmn}"/>
			<input name="tcboId" type="hidden" id="tcboIdJS" value="${sVO.tcboId}"/>
			<input name="routeId" type="hidden" id="routeIdJS" value="${sVO.routeId}"/>
		</div>
			<!-- 이용자유형 코드 -->
		<div class="sVOvalue_cd_no">
		    <c:forEach var='j' begin='0' end='${cd_noLength-1}' >
				<input name="cd_no" type="hidden"  value="${sVO.cd_no[j]}"/>
		    </c:forEach>
		</div>
		<input type="submit" id="downloadSubmitBtn" style="display: none;"/>
	</form>
	
	<!-- 행정동OD 다운로드 조회조건 -->
	<form id="downloadForm" action="<%=request.getContextPath()%>/passDownload.do" target="excelDown">
		<div class= "sVOvalue">
			<input name="anal_fin" type="hidden" id="anal_finJS" value="areaODmatrix"/>
			<input name="dateStart" type="hidden" id="dateStartJS" value="${sVO.dateStart}"/>
			<input name="dateEnd" type="hidden" id="dateEndJS" value="${sVO.dateEnd}"/>
			<input name="anal_area_cd_sido" type="hidden" id="anal_area_cd_sidoJS" value="${sVO.anal_area_cd_sido}"/>
			<input name="anal_area_cd_sido_text" type="hidden" id="anal_area_cd_sido_textJS" value="${sVO.anal_area_cd_sido_text}"/>
			<input name="anal_area_cd" type="hidden" id="anal_area_cdJS" value="${sVO.anal_area_cd}"/>
			<input name="anal_area_cd_text" type="hidden" id="anal_area_cd_textJS" value="${sVO.anal_area_cd_text}"/>
			<input name="provider" type="hidden" id="providerJS" value="${sVO.provider}"/>
			<input name="provider_text" type="hidden" id="provider_textJS" value="${sVO.provider_text}"/>
			<input name="anal_group" type="hidden" id="anal_groupJS" value="${sVO.anal_group}"/>
			<input name="anal_type" type="hidden" id="anal_tyajdEpeJS" value="${sVO.anal_type}"/>
		</div>
		<!-- 이용자유형 코드 -->
		<div class="sVOvalue_cd_no">
		    <c:forEach var='j' begin='0' end='${cd_noLength-1}' >
				<input name="cd_no" type="hidden"  value="${sVO.cd_no[j]}"/>
		    </c:forEach>
		</div>
		<input type="submit" id="downloadMatrixSubmitBtn" style="display: none;"/>
	</form>
	
	<!-- 그래프 조회조건 -->
	<form id="graphForm" action="<%=request.getContextPath()%>/passGraph.do" target="graph" method="post">
		
		<input name="anal_fin" type="hidden" id="anal_finJS" value="${sVO.anal_fin}"/>
		<input name="dateStart" type="hidden" id="dateStartJS" value="${sVO.dateStart}"/>
		<input name="dateEnd" type="hidden" id="dateEndJS" value="${sVO.dateEnd}"/>
		<input name="anal_area_cd_sido" type="hidden" id="anal_area_cd_sidoJS" value="${sVO.anal_area_cd_sido}"/>
		<input name="anal_area_cd_sido_text" type="hidden" id="anal_area_cd_sido_textJS" value="${sVO.anal_area_cd_sido_text}"/>
		<input name="anal_area_cd" type="hidden" id="anal_area_cdJS" value="${sVO.anal_area_cd}"/>
		<input name="anal_area_cd_text" type="hidden" id="anal_area_cd_textJS" value="${sVO.anal_area_cd_text}"/>
		<input name="provider" type="hidden" id="providerJS" value="${sVO.provider}"/>
		<input name="provider_text" type="hidden" id="provider_textJS" value="${sVO.provider_text}"/>
		<input name="anal_group" type="hidden" id="anal_groupJS" value="${sVO.anal_group}"/>
		<input name="anal_type" type="hidden" id="anal_typeJS" value="${sVO.anal_type}"/>
		<input name="tm" type="hidden" id="tm" value="${sVO.tm}"/>
		<input name="tmStart" type="hidden" id="tmStartJS" value="${sVO.tmStart}"/>
		<input name="tmEnd" type="hidden" id="tmEndJS" value="${sVO.tmEnd}"/>
		<input name="tfcmn" type="hidden" id="tfcmnJS" value="${sVO.tfcmn}"/>
		<input name="routeId" type="hidden" id="routeIdJS" value="${sVO.routeId}"/>
		
	    <c:forEach var='j' begin='0' end='${cd_noLength-1}' >
			<input name="cd_no" type="hidden"  value="${sVO.cd_no[j]}"/>
	    </c:forEach>
		
		<input name="cd_noText" id="cd_noText" type="hidden"  value="${cd_noText}"/>

		<input type="submit" id="graphSubmitBtn" style="display: none;"/>
	</form>

  
    <body>
   
    
    
    
    
      	<div class="wrap">
	        <div class="header">
	            <p>통행 분석 지표</p>
	            <div class="button">
	            	<c:if test = "${anal_groupText == '통행량' && (anal_typeText == '목적통행' || anal_typeText == '수단통행' || anal_typeText == '노선별통행')}">
	                	<div class="g"><button type="button" id="graph">그래프</button></div>
	                </c:if>
	                <c:if test = "${anal_groupText == '노선별OD' && anal_typeText == ''}">
		                <!-- 표 -->
			     		<c:if test = "${sVO.anal_fin == null || sVO.anal_fin == ''}">
			     			<div class="g" style="width: 115px;"><button type="button" id="matrix" style="width: 109px;">OD매트릭스</button></div>
			     		</c:if>
	                </c:if>
	                <c:if test = "${anal_groupText == '행정동간OD' && (anal_typeText == '목적통행' || anal_typeText == '수단통행')}">
	                	<div class="g" style="width: 226px;"><button type="button" id="downloadMatrix" style="width: 223px;margin-left: 30px;">OD매트릭스형태로 다운로드</button></div>
	                </c:if>
	                <div class="d"><button type="button" id="download" onclick="download();">다운로드</button></div>
	                <div class="e"><button type="button" id="exit" onClick="window.open('','_self').close();">닫기</button></div>
	            </div> 
	        </div>
	        
	        <div class="dateform">
	          <div>
	          <p>&nbsp;분석날짜 : ${dateText}</p>
	          <p>분석자료 : ${sVO.provider_text}</p>
	          <p>분석지역 : ${anal_area_cd_sido_text} ${anal_area_cd_text}</p>
	          <p>&nbsp;분석지표 : ${anal_groupText}</p>
	          </div>
	          <div>
	          <p>&nbsp;${anal_typeText_titleDraw}</p>
	          <p>시간대 : ${tmText}</p> 
	          <p>이용자유형 : ${cd_noText_slash}</p>
	          <p>&nbsp;${tfcmn_titleDraw}</p>
	          </div>
	      	</div>
	      	
	      	<c:if test = "${anal_groupText == '노선별OD' && anal_typeText == ''}">
	      		<div class="routeOD_box" style="border">
					<div class="routeOD_header" style="font-size: 15px;font-weight: bold;text-align: center;">[조회 조건 및 노선 정보]</div>
					<div class="routeOD_body">
						<table>
							<tr>
								<th>광역/도</th>
								<th>시/군</th>
								<th>날짜</th>
								<th>요일</th>
								<th>노선구분</th>
								<th>노선명</th>
								<th>노선유형</th>
								<th>기점</th>
								<th>종점</th>
							</tr>
							
							
							<!-- 표 -->
		     				<c:if test = "${sVO.anal_fin == null || sVO.anal_fin == ''}">
				     			<tr>	
					     			<td>${anal_area_cd_sido_text}</td>
									<td>${anal_area_cd_text}</td>
									<td>${passResultList[0].opratDate}</td>
									<td>${passResultList[0].dy}</td>
									<td>
										<c:if test="${passResultList[0].tfcmn == 'B'}">
											버스
										</c:if>
										<c:if test="${passResultList[0].tfcmn == 'T'}">
											지하철
										</c:if>
									</td>
									<td>${passResultList[0].routeNma}</td>
									<td>${passResultList[0].routeType}</td>
									<td>${passResultList[0].routeStart}</td>
									<td>${passResultList[0].routeEnd}</td>
				     			</tr>
				     		</c:if>
				     		
				     		<!-- OD매트릭스 -->
		     				<c:if test = "${sVO.anal_fin == 'routeODmatrix'}">
				     			<tr>
				     				<td>${anal_area_cd_sido_text}</td>
									<td>${anal_area_cd_text}</td>
									<td>${param.date_yyyymmdd}</td>
									<td>${param.today}</td>
									<td>${param.tfcmnText}</td>
									<td>${param.routeNma}</td>
									<td>${param.routeType}</td>
									<td>${param.routeStart}</td>
									<td>${param.routeEnd}</td>
				     			</tr>
				     		</c:if>
						</table>
					</div>
	      		</div>
	      		
	      		<!-- 노선별OD 매트릭스 -->
	      		<form id="routeODForm" action="routeOD.do" target="itsme">
					<div class= "sVOvalue">
						<input name="dateStart" type="hidden" id="dateStartJS" value="${sVO.dateStart}"/>
						<input name="dateEnd" type="hidden" id="dateEndJS" value="${sVO.dateEnd}"/>
						<input name="anal_area_cd_sido" type="hidden" id="anal_area_cd_sidoJS" value="${sVO.anal_area_cd_sido}"/>
						<input name="anal_area_cd_sido_text" type="hidden" id="anal_area_cd_sido_textJS" value="${sVO.anal_area_cd_sido_text}"/>
						<input name="anal_area_cd" type="hidden" id="anal_area_cdJS" value="${sVO.anal_area_cd}"/>
						<input name="anal_area_cd_text" type="hidden" id="anal_area_cd_textJS" value="${sVO.anal_area_cd_text}"/>
						<input name="provider" type="hidden" id="providerJS" value="${sVO.provider}"/>
						<input name="provider_text" type="hidden" id="provider_textJS" value="${sVO.provider_text}"/>
						<input name="anal_group" type="hidden" id="anal_groupJS" value="${sVO.anal_group}"/>
						<input name="anal_type" type="hidden" id="anal_typeJS" value="${sVO.anal_type}"/>
						<input name="tm" type="hidden" id="tmJS" value="${sVO.tm}"/>
						<input name="tmStart" type="hidden" id="tmStartJS" value="${sVO.tmStart}"/>
						<input name="tmEnd" type="hidden" id="tmEndJS" value="${sVO.tmEnd}"/>
						<input name="tfcmn" type="hidden" id="tfcmnJS" value="${sVO.tfcmn}"/>
						<input name="tcboId" type="hidden" id="tcboIdJS" value="${sVO.tcboId}"/>
						<input name="routeId" type="hidden" id="routeIdJS" value="${sVO.routeId}"/>
						<input name="anal_fin" type="hidden" id="routeIdJS" value="routeODmatrix"/>
						
						<input name="date_yyyymmdd" type="hidden" id="date_yyyymmdd" value="${dateStart}"/> 
						<input name="date_yyyy-mm-dd" type="hidden" id="date_yyyy-mm-dd" value="${dateText}"/> 
						
						<fmt:parseDate value="${dateStart}" var="dateFmt" pattern="yyyyMMdd"/>
						<fmt:formatDate value="${dateFmt}" pattern="E" var="today"/>
						<input name="today" type="hidden" id="today" value="${today}"/>
						
						<c:if test="${passResultList[0].tfcmn == 'B'}">
							<input name="tfcmnText" type="hidden" id="tfcmnText" value="버스"/>
						</c:if>
						<c:if test="${passResultList[0].tfcmn == 'T'}">
							<input name="tfcmnText" type="hidden" id="tfcmnText" value="지하철"/>
						</c:if>
						
						<input name="routeNma" type="hidden" id="routeNma" value="${passResultList[0].routeNma}"/>
						<input name="routeType" type="hidden" id="routeType" value="${passResultList[0].routeType}"/>
						<input name="routeStart" type="hidden" id="routeStart" value="${passResultList[0].routeStart}"/>
						<input name="routeEnd" type="hidden" id="routeEnd" value="${passResultList[0].routeEnd}"/>
					</div>
					<!-- 이용자유형 코드 -->
					<div class="sVOvalue_cd_no">
					    <c:forEach var='j' begin='0' end='${cd_noLength-1}' >
							<input name="cd_no" type="hidden"  value="${sVO.cd_no[j]}"/>
					    </c:forEach>
					</div>
					<input type="submit" id="routeODSubmitBtn" style="display: none;"/>
				</form>
			</c:if>
			
			
	      	<div class="infowrap">
				<span class="info">(단위 : 통행량)</span>
		    </div>
	     	
	     	<div class="test">
		     
		     	<div class="content_wrap">
			     	<c:if test = "${anal_groupText == '통행량' && anal_typeText == '목적통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_purpose.jsp" %>
			     	</c:if> 
			      
			     	<c:if test = "${anal_groupText == '통행량' && anal_typeText == '수단통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_method.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '통행량' && anal_typeText == '노선별통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_route.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '통행량' && anal_typeText == '정류장별통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_station.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '노선별OD' && anal_typeText == ''}">
			     		
			     		<!-- 표 -->
			     		<c:if test = "${sVO.anal_fin == null || sVO.anal_fin == ''}">
			     			<%@ include file="tableList/pass_popUp_passRouteODCnt.jsp" %>
			     		</c:if>
			     		
			     		<!-- OD매트릭스 -->
			     		<c:if test = "${sVO.anal_fin == 'routeODmatrix'}">
			     			<%@ include file="tableList/pass_popUp_passRouteODmatrix.jsp" %>
			     		</c:if>
			     		
			     		<script>
			     			$(".test").css("height", "682px");
			     			$(".content_wrap").css("height", "682px");
			     		</script>
			     	</c:if>
			     	
			     	<c:if test = "${anal_groupText == '행정동간OD' && anal_typeText == '목적통행'}">
			     		<%@ include file="tableList/pass_popUp_passAreaODCnt_purpose.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '행정동간OD' && anal_typeText == '수단통행'}">
			     		<%@ include file="tableList/pass_popUp_passAreaODCnt_method.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '상위이용노선' && anal_typeText == ''}">
			     		<%@ include file="tableList/pass_popUp_passTopRotue.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '상위이용정류장' && anal_typeText == ''}">
			     		<%@ include file="tableList/pass_popUp_passTopStation.jsp" %>
			     	</c:if> 
		     	</div>
		     </div>
		</div>
		
    </body> 
	
	<script>
		$('.lavel-1').each(function () {
			if (this.offsetWidth < this.scrollWidth)
			    $(this).attr('title', $(this).text());
		});
    </script>   
</html>