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
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="css/popup.css">
    </head>
    
    <!-- 세로 스크롤에 따른 text 이동 -->
    <style>
    	.level-2 [rowspan] {
		    vertical-align: top;
		}
		.level-2 [rowspan] div {
		    position: sticky;
		    top: 40px;
		}
    </style>
    
    <!-- 코드 텍스트 매칭 -->
    <%@ include file="pass_popUp_codeNameMatch.jsp" %>
  
    <body>
      	<div class="wrap">
	        <div class="header">
	            <p>통행 분석 지표</p>
	            <div class="button">
	                <button type="button">그래프</button>
	                <button type="button">다운로드</button>
	                <button type="button">닫기</button>
	
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
	     	
	     	<c:if test = "${anal_typeText == '행정동목적'}">
	     		<%@ include file="tableList/pass_popUp_passAreaODCnt_purpose.jsp" %>
	     	</c:if> 
	     	
	     	<c:if test = "${anal_typeText == '행정동수단'}">
	     		<%@ include file="tableList/pass_popUp_passAreaODCnt_method.jsp" %>
	     	</c:if> 
	     	
	     	<c:if test = "${anal_groupText == '노선별OD' && anal_typeText == ''}">
	     		<%@ include file="tableList/pass_popUp_passRouteODCnt.jsp" %>
	     	</c:if> 
	     	
	     	<c:if test = "${anal_groupText == '상위이용노선' && anal_typeText == ''}">
	     		<%@ include file="tableList/pass_popUp_passTopRotue.jsp" %>
	     	</c:if> 
	     	
	     	<c:if test = "${anal_groupText == '상위이용정류장' && anal_typeText == ''}">
	     		<%@ include file="tableList/pass_popUp_passTopStation.jsp" %>
	     	</c:if> 
	     	
		</div>
    </body>
    
    
    
    
    
</html>