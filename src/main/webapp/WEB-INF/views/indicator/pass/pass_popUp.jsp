<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="sVO" value="${sVO }"/>
<c:set var="list" value="${passResultList }"/>
<!DOCTYPE html>
<html>
    <head>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"><meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script type="text/javascript" src="resources/js/indicator/common_popUp.js" async ></script>
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/pass_popup.css">
    </head>
    
    	
    <!-- 코드 텍스트 매칭 -->
    <%@ include file="pass_popUp_codeNameMatch.jsp" %>
    
    <iframe id="excelDown" name="excelDown" width="0" height="0"></iframe>
    
	<!-- 다운로드 조회조건 -->
	<form id="downloadForm" action="passDownload.do" target="excelDown">
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

  
    <body>
      	<div class="wrap">
	        <div class="header">
	            <p>통행 분석 지표</p>
	            <div class="button">
	            	<c:if test = "${anal_groupText != '노선별OD' && anal_typeText != ''}">
	                	<div class="g"><button type="button" id="graph">그래프</button></div>
	                </c:if>
	                <c:if test = "${anal_groupText == '노선별OD' && anal_typeText == ''}">
		                <div class="g"><button type="button" id="matrix">OD매트릭스</button></div>
	                </c:if>
	                <div class="d"><button type="button" id="download">다운로드</button></div>
	                <div class="e"><button type="button" id="exit">닫기</button></div>
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
					<div class="routeOD_header" style="font-size: 18px;font-weight: bold;text-align: center;">[조회 조건 및 노선 정보]</div>
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
			     		<%@ include file="tableList/pass_popUp_passRouteODCnt.jsp" %>
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