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
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/pass_popup.css">
    </head>
    
 
    <!-- 코드 텍스트 매칭 -->
    <%@ include file="pass_popUp_codeNameMatch.jsp" %>
    
  
    <body onload="showPage();">
	<script>
         function showPage() {
         	document.getElementById("lds-spinner").style.display = "none";
         }
     </script>
     <div id="lds-spinner">
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
         <div></div>
     </div> 
     
      	<div class="wrap">
	        <div class="header">
	            <p>통행 분석 지표</p>
	            <div class="button">
	                <div class="g"><button type="button">그래프</button></div>
	                <div class="d"><button type="button">다운로드</button></div>
	                <div class="e"><button type="button">닫기</button></div>
	            </div>
	        </div>
	        
	        <div class="dateform">
	          <div>
	          <p>분석날짜 : ${dateText}</p>
	          <p>분석자료 : ${providerText}</p>
	          <p>분석지역 : ${anal_area_cd_sido_text} ${anal_area_cd_text}</p>
	          <p>분석지표 : ${anal_groupText}</p>
	          </div>
	          <div>
	          <p>분석유형 : ${anal_typeText}</p>
	          <p>시간대 : ${tmText}</p> 
	          <p>이용자유형 : ${cd_noText}</p>
	          <p>교통수단 : 전체</p>
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
								<c:if test="${passResultList[0].tfcmn == 'B'}">
									<c:set var="t_b_name" value='버스' />
								</c:if>
								<c:if test="${passResultList[0].tfcmn == 'T'}">
									<c:set var="t_b_name" value='지하철' />
								</c:if>
								<td>${passResultList[0].t_b_name}</td>
								<td>${passResultList[0].routeNma}</td>
								<td>${passResultList[0].routeType}</td>
								<td>${passResultList[0].routeStart}</td>
								<td>${passResultList[0].routeEnd}</td>
							</tr>
						</table>
					</div>
	      		</div>
	      	</c:if>
	      	
	      	<div class="infowrap">
				<span class="info">(단위 : 통행량)</span>
		    </div>
	     	
	     	<div class="test">
		     
		     	<div class="content_wrap">
			     	<c:if test = "${anal_typeText == '목적통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_purpose.jsp" %>
			     	</c:if> 
			      
			     	<c:if test = "${anal_typeText == '수단통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_method.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_typeText == '노선별통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_route.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_typeText == '정류장별통행'}">
			     		<%@ include file="tableList/pass_popUp_passCnt_station.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_groupText == '노선별OD' && anal_typeText == ''}">
			     		<%@ include file="tableList/pass_popUp_passRouteODCnt.jsp" %>
			     		<script>
			     			$(".test").css("height", "682px");
			     			$(".content_wrap").css("height", "682px");
			     		</script>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_typeText == '행정동목적'}">
			     		<%@ include file="tableList/pass_popUp_passAreaODCnt_purpose.jsp" %>
			     	</c:if> 
			     	
			     	<c:if test = "${anal_typeText == '행정동수단'}">
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
</html>