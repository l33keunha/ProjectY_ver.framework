<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pVO" value="${pVO }"/>
<c:set var="list" value="${passResultList }"/>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script src="popup01.js"></script>
        <link rel="stylesheet" type="text/css" href="css/popup.css">
    </head>
    
    
    <!-- ▼ 코드 텍스트 매칭 -->
	     
	    <!-- 분석자료 -->
	    <c:set var = "passOwnerText" value = "${pVO.passOwner}"/>
	    <c:choose>     
	         <c:when test = "${passOwnerText == '00'}">
	           	 <c:set var = "passOwnerText" value = "국토부"/>
	         </c:when>
	         <c:when test = "${passOwnerText == '09'}">
	           	 <c:set var = "passOwnerText" value = "정산사"/>
	         </c:when>
	    
	         <c:otherwise>
	           		<c:set var = "passOwnerText" value = ""/>
	         </c:otherwise>
	    </c:choose>     
	         
	    <!-- 분석지표 -->
	    <c:set var = "passGroupText" value = "${pVO.passGroup}"/>
	    <c:choose>    
	         <c:when test = "${passGroupText == 'passCnt'}">
	           	 <c:set var = "passGroupText" value = "통행량"/>
	         </c:when>
	         <c:when test = "${passGroupText == 'passODCnt'}">
	           	 <c:set var = "passGroupText" value = "기종점통행량"/>
	         </c:when>
	    	 <c:when test = "${passGroupText == 'passEtc'}">
	           	 <c:set var = "passGroupText" value = "기타"/>
	         </c:when>
	         <c:otherwise>
	           		<c:set var = "passGroupText" value = ""/>
	         </c:otherwise>
		</c:choose>   
		
		<!-- 이용자유형 -->
	    <c:set var = "passUserTypeText" value = "${pVO.passUserType}"/>
	    <c:choose>
	         <c:when test = "${passUserTypeText == '00'}">
	           	 <c:set var = "passUserTypeText" value = "전체"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '01'}">
	           	 <c:set var = "passUserTypeText" value = "일반"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '02'}">
	           	 <c:set var = "passUserTypeText" value = "어린이"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '03'}">
	           	 <c:set var = "passUserTypeText" value = "청소년"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '04'}">
	           	 <c:set var = "passUserTypeText" value = "경로"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '05'}">
	           	 <c:set var = "passUserTypeText" value = "장애인"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '06'}">
	           	 <c:set var = "passUserTypeText" value = "국가유공자"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '07'}">
	           	 <c:set var = "passUserTypeText" value = "다자녀부모"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '08'}">
	           	 <c:set var = "passUserTypeText" value = "동반"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '09'}">
	           	 <c:set var = "passUserTypeText" value = "대학생"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '10'}">
	           	 <c:set var = "passUserTypeText" value = "복지"/>
	         </c:when>
	         <c:when test = "${passUserTypeText == '11'}">
	           	 <c:set var = "passUserTypeText" value = "기타"/>
	         </c:when>
	      
	         <c:otherwise>
	           		<c:set var = "passUserTypeText" value = ""/>
	         </c:otherwise>
	    </c:choose>  
	    
    <!-- ▲ 코드 텍스트 매칭 끝 -->
    
    
    <body>
        <div class="header">
            <p>통행 분석 지표</p>
            
            <div class="dateform" style="margin: -33px 16px 1px 12px;">
                <div>날짜 :  ${pVO.passDateStart} </div> 
                <div>분석지역 : 경기도 평택시</div>
                <div>분석자료 : ${passOwnerText}  </div>
                <div>분석지표 : ${passGroupText} </div>
            </div>
            
            <div class="button">
                <button type="button">그래프</button>
                <button type="button">다운로드</button>

            </div>
        </div>
        <div class="content">
            
          		
               
              <!-- ▼ 이용자유형 : 전체 -->
              <c:if test="${pVO.passUserType =='00' }">
			  <table class="tg">         	    
			              	
		              	<!-- ▼ 교통수단 : 전체 -->
		              	<c:if test="${pVO.passTransport=='00'}">
			              	
		              	 <thead>
			                  <tr>
			                    <th class="tg-0pky" rowspan="2">날짜</th>
			                    <th class="tg-0pky" rowspan="2">광역/도</th>
			                    <th class="tg-0pky" rowspan="2">시/군</th>
			                    <th class="tg-0pky" rowspan="2">시간</th>
			                    <th class="tg-0pky" colspan="3">일반</th>
			                    <th class="tg-0pky" colspan="3">어린이</th>
			                    <th class="tg-0pky" colspan="3">청소년</th>
			                    <th class="tg-0pky" colspan="3">경로</th>
			                    <th class="tg-0pky" colspan="3">장애인</th>
			                    <th class="tg-0pky" colspan="3">국가유공자</th>
			                    <th class="tg-0pky" colspan="3">다자녀부모</th>
			                    <th class="tg-0pky" colspan="3">동반</th>
			                    <th class="tg-0pky" colspan="3">대학생</th>
			                    <th class="tg-0pky" colspan="3">복지</th>
			                    <th class="tg-0pky" colspan="3">기타</th>
			                    <th class="tg-0pky" rowspan="2">합계</th>
			                  </tr>
			                  <tr>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>
			                    <th class="tg-0pky">버스</th>
			                    <th class="tg-0pky">지하철</th>
			                    <th class="tg-0pky">소계</th>

			                  </tr>
			                </thead>
			              	
			               <tbody>
			               		<!-- 1번쨰 라인 -->
								<tr>
									<td class="tg-0pky" rowspan="24">${pVO.passDateStart}</td>							<!-- 날짜 -->
									<td class="tg-c3ow" rowspan="24">경기도</td>											<!-- 광역/도 -->
									<td class="tg-0pky" rowspan="24">평택시</td>											<!-- 시/군 -->
									<td class="tg-0pky">${passResultList[0].passtime}</td>								<!-- 시간-->
									
									<td class="tg-0pky">${passResultList[0].passcnt}</td>								<!-- 일반 : 버스 -->	
									<td class="tg-0pky">${passResultList[1].passcnt}</td>								<!-- 일반 : 지하철 -->
									<td class="tg-0pky">${passResultList[0].passcnt + passResultList[1].passcnt}</td>	<!-- 일반 : 소계(버스+지하철) -->
								
									<td class="tg-0pky">${passResultList[2].passcnt}</td>								<!-- 어린이 : 버스 -->	
									<td class="tg-0pky">${passResultList[3].passcnt}</td>								<!-- 어린이 : 지하철 -->
									<td class="tg-0pky">${passResultList[2].passcnt + passResultList[3].passcnt}</td>	<!-- 어린이 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[4].passcnt}</td>								<!-- 청소년 : 버스 -->	
									<td class="tg-0pky">${passResultList[5].passcnt}</td>								<!-- 청소년 : 지하철 -->
									<td class="tg-0pky">${passResultList[4].passcnt + passResultList[5].passcnt}</td>	<!-- 청소년 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[6].passcnt}</td>								<!-- 경로 : 버스 -->	
									<td class="tg-0pky">${passResultList[7].passcnt}</td>								<!-- 경로 : 지하철 -->
									<td class="tg-0pky">${passResultList[6].passcnt + passResultList[7].passcnt}</td>	<!-- 경로 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[8].passcnt}</td>								<!-- 장애인 : 버스 -->	
									<td class="tg-0pky">${passResultList[9].passcnt}</td>								<!-- 장애인 : 지하철 -->
									<td class="tg-0pky">${passResultList[8].passcnt + passResultList[9].passcnt}</td>	<!-- 장애인 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[10].passcnt}</td>								<!-- 국가유공자 : 버스 -->	
									<td class="tg-0pky">${passResultList[11].passcnt}</td>								<!-- 국가유공자 : 지하철 -->
									<td class="tg-0pky">${passResultList[10].passcnt + passResultList[11].passcnt}</td>	<!-- 국가유공자 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[12].passcnt}</td>								<!-- 다자녀부모 : 버스 -->	
									<td class="tg-0pky">${passResultList[13].passcnt}</td>								<!-- 다자녀부모 : 지하철 -->
									<td class="tg-0pky">${passResultList[12].passcnt + passResultList[13].passcnt}</td>	<!-- 다자녀부모 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[14].passcnt}</td>								<!-- 동반 : 버스 -->	
									<td class="tg-0pky">${passResultList[15].passcnt}</td>								<!-- 동반 : 지하철 -->
									<td class="tg-0pky">${passResultList[14].passcnt + passResultList[15].passcnt}</td>	<!-- 동반 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[16].passcnt}</td>								<!-- 대학생 : 버스 -->	
									<td class="tg-0pky">${passResultList[17].passcnt}</td>								<!-- 대학생 : 지하철 -->
									<td class="tg-0pky">${passResultList[16].passcnt + passResultList[17].passcnt}</td>	<!-- 대학생 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[18].passcnt}</td>								<!-- 복지 : 버스 -->	
									<td class="tg-0pky">${passResultList[19].passcnt}</td>								<!-- 복지 : 지하철 -->
									<td class="tg-0pky">${passResultList[18].passcnt + passResultList[19].passcnt}</td>	<!-- 복지 : 소계(버스+지하철) -->
									
									<td class="tg-0pky">${passResultList[20].passcnt}</td>								<!-- 기타 : 버스 -->	
									<td class="tg-0pky">${passResultList[21].passcnt}</td>								<!-- 기타 : 지하철 -->
									<td class="tg-0pky">${passResultList[20].passcnt + passResultList[21].passcnt}</td>	<!-- 기타 : 소계(버스+지하철) -->
									
									<c:set var = "totalSum" value = "0"/>	
									<c:forEach var='j' begin='0' end='21' >	
										<c:set var = "totalSum" value = '${totalSum + (passResultList[j].passcnt)}'/>	<!-- 총 합계(시간 단위 버스+지하철 총합) 작업 -->
									</c:forEach>
									
									<td class="tg-0pky">${totalSum}</td>												<!-- 총 합계(시간 단위 버스+지하철 총합) -->
								</tr>
								
								
								<!-- 2번쨰 라인 이상 ~ 끝 -->
			                 	<c:forEach var='i' begin='2' end='${passResultList.size()}'>
			                 	
			                 		<!-- <tr> 작업  -->
			                 		<!-- 22번째 마다 그려주기 -->
			                 		<c:if test="${passResultList[i].rownum%22 == 1 }">	                
			                 			<tr> 	
					                 		<td class="tg-0pky">${passResultList[i].passtime}</td>			<!-- 시간-->
					                 		
					                 		<!-- <td> 작업  -->
					                 		<!-- i부터, 22번 회전  -->
					                 		<c:set var='index' value='${i+21}' />
					                 		<c:set var = "totalSum" value = "0"/>							<!-- 총 합계(시간 단위 버스+지하철 총합) 초기화 -->
					                 		<c:forEach var='k' begin='${i}' end='${index}' >	
					                 		
					                 			<td class="tg-0pky">${passResultList[k].passcnt}</td>	   															<!-- 버스,지하철 -->
							                 
					                 			<!-- 2번에 걸쳐 실행 -->
					                 			<c:if test="${passResultList[k].rownum%2 == 0 }">	    
						                   			<td class="tg-0pky">${passResultList[k-1].passcnt + passResultList[k].passcnt}</td>								<!-- 소계(버스+지하철) -->
						                   			<c:set var = "totalSum" value = '${totalSum + (passResultList[k-1].passcnt + passResultList[k].passcnt)}'/>		<!--총 합계(시간 단위 버스+지하철 총합) 작업 -->
						                   		</c:if>	
						                   		
				                 			</c:forEach>
			                 				
					                   		<td class="tg-0pky">${totalSum}</td>																					<!-- 총 합계(시간 단위 버스+지하철 총합) -->
					                   	 
				                 		</tr>
				                 	</c:if>	
					                 	
				                </c:forEach>
				            
			               </tbody>
			            </c:if>
			            <!-- ▲ 교통수단 : 전체 끝-->
				            
				        <!-- ▼ 교통수단 : 단일 -->
		              	<c:if test="${pVO.passTransport !='00'}">
		              		<thead>
			                  <tr>
			                    <th class="tg-0pky" rowspan="2">날짜</th>
			                    <th class="tg-0pky" rowspan="2">광역/도</th>
			                    <th class="tg-0pky" rowspan="2">시/군</th>
			                    <th class="tg-0pky" rowspan="2">시간</th>
			                
			                    <!-- 버스 or 지하철 -->
			                 	<c:if test="${pVO.passTransport =='B'}">
				                     <th class="tg-0pky" colspan ="11">버스</th>
			                    </c:if>
			                 	<c:if test="${pVO.passTransport =='T'}">
				                    <th class="tg-0pky" colspan ="11">지하철</th>
			                    </c:if>
			                   	<th class="tg-0pky" rowspan="2">합계</th>
			                   
			                  </tr>
			                  <tr>
			                    <th class="tg-0pky" colspan="1">일반</th>
			                    <th class="tg-0pky" colspan="1">어린이</th>
			                    <th class="tg-0pky" colspan="1">청소년</th>
			                    <th class="tg-0pky" colspan="1">경로</th>
			                    <th class="tg-0pky" colspan="1">장애인</th>
			                    <th class="tg-0pky" colspan="1">국가유공자</th>
			                    <th class="tg-0pky" colspan="1">다자녀부모</th>
			                    <th class="tg-0pky" colspan="1">동반</th>
			                    <th class="tg-0pky" colspan="1">대학생</th>
			                    <th class="tg-0pky" colspan="1">복지</th>
			                    <th class="tg-0pky" colspan="1">기타</th>       
			                  </tr>
			               </thead>
			              	
			               <tbody>
			               		<!-- 1번쨰 라인 -->
								<tr>
									<td class="tg-0pky" rowspan="${passResultList.size()}">${pVO.passDateStart}</td>    <!-- 날짜 -->
									<td class="tg-c3ow" rowspan="${passResultList.size()}">경기도</td>					<!-- 광역/도 -->
									<td class="tg-0pky" rowspan="${passResultList.size()}">평택시</td>					<!-- 시/군 -->
									<td class="tg-0pky">${passResultList[0].passtime}</td>								<!-- 시간-->
			                 		<td class="tg-0pky">${passResultList[0].passcnt}</td>								<!-- 일반-->
			                 		<td class="tg-0pky">${passResultList[1].passcnt}</td>								<!-- 어린이-->
			                 		<td class="tg-0pky">${passResultList[2].passcnt}</td>								<!-- 청소년-->          
			                 		<td class="tg-0pky">${passResultList[3].passcnt}</td>								<!-- 경로-->           
			                 		<td class="tg-0pky">${passResultList[4].passcnt}</td>								<!-- 장애인-->          
			                 		<td class="tg-0pky">${passResultList[5].passcnt}</td>								<!-- 국가유공자-->        
			                 		<td class="tg-0pky">${passResultList[6].passcnt}</td>								<!-- 다자녀부모-->        
			                 		<td class="tg-0pky">${passResultList[7].passcnt}</td>								<!-- 동반-->           
			                 		<td class="tg-0pky">${passResultList[8].passcnt}</td>								<!-- 대학생-->          
			                 		<td class="tg-0pky">${passResultList[9].passcnt}</td>								<!-- 복지-->				
			                 		<td class="tg-0pky">${passResultList[10].passcnt}</td>								<!-- 기타-->			 
			                 		
									<c:set var = "totalSum" value = "0"/>	
									<c:forEach var='j' begin='0' end='21' >	
										<c:set var = "totalSum" value = '${totalSum + (passResultList[j].passcnt)}'/>	<!-- 총 합계(시간 단위 버스+지하철 총합) 작업 -->
									</c:forEach>
									
									<td class="tg-0pky">${totalSum}</td>												<!-- 총 합계(시간 단위 버스+지하철 총합) -->
			                 			                 	
								</tr>
								
								<!-- 2번쨰 라인 이상 ~ 끝 -->
			                 	<c:forEach var='i' begin='2' end='${passResultList.size()-1}'>
		                 			
		                 			<!-- <tr> 그리기  -->
			                 		<!-- 11번째 마다 그려주기 -->
			                 		<c:if test="${passResultList[i].rownum%11 == 1 }">	                
			                 			<tr> 	
			                 				<td class="tg-0pky">${passResultList[i].passtime}</td>								<!-- 시간-->
					                		
					                		<!-- <td> 그리기  -->
					                 		<!-- i부터, 11번 회전  -->
					                 		<c:set var='index' value='${i+10}' />
					                 		<c:set var = "totalSum" value = "0"/>												<!-- 총 합계 초기화 -->
					                 		<c:forEach var='k' begin='${i}' end='${index}' >	
					                 			<td class="tg-0pky">${passResultList[k].passcnt}</td>	    					<!-- 일반,어린이,청소년,경로,장애인,국가유공자,다자녀부모,동반,대학생,복지,기타  -->
				                 				<c:set var = "totalSum" value = '${totalSum + (passResultList[k].passcnt)}'/>	<!-- 총 합계 작업 -->
				                 			</c:forEach>
					                 		<td class="tg-0pky">${totalSum}</td>												<!-- 총 합계 -->		                 	
				                 		</tr>
				                 	</c:if>
				                 	
			                   	</c:forEach>	
							
							</tbody>	
		                </c:if> 
				        <!-- ▲ 교통수단 : 단일 끝-->    
			  </table>
              </c:if>
              <!-- ▲ 이용자유형 : 전체 끝--> 
           
           
           	   <!-- ▼ 이용자유형 : 단일 -->
              <c:if test="${pVO.passUserType!='00' }">
			  <table class="tg" style="width:1363px;">     	    
			              	
		              	<!-- ▼ 교통수단 : 전체 -->
		              	<c:if test="${pVO.passTransport=='00'}">
		              		<colgroup>
				    			<col width="83px;">
				    			<col width="83px;">
				    			<col width="83px;">
				    			<col width="115px;">
				    			<col width="167px;">
				    			<col width="167px;">
				    			<col width="167px;">
				    		</colgroup>
			              	<thead>
			              		<tr>
			                    	<th class="tg-0pky" rowspan="2">날짜</th>
				                    <th class="tg-0pky" rowspan="2">광역/도</th>
				                    <th class="tg-0pky" rowspan="2">시/군</th>
				                    <th class="tg-0pky" rowspan="2">시간</th>
				                    <th class="tg-0pky" colspan="2">${passUserTypeText}</th>
				                    <th class="tg-0pky" rowspan="2">소계</th>
				                </tr>
				                <tr>
				                    <th class="tg-0pky">버스</th>
			                    	<th class="tg-0pky">지하철</th>

				                </tr>
				          	</thead>      
			               <tbody>
			               		<!-- 1번쨰 라인 -->
								<tr>
								   	<td class="tg-0pky" rowspan="24">${pVO.passDateStart}</td>							<!-- 날짜 -->
								   	<td class="tg-c3ow" rowspan="24">경기도</td>											<!-- 광역/도 -->
								   	<td class="tg-0pky" rowspan="24">평택시</td>											<!-- 시/군 -->
								   	<td class="tg-0pky">${passResultList[0].passtime}</td>								<!-- 시간 -->          
									<td class="tg-0pky">${passResultList[0].rownum}</td>                                <!-- 버스 -->          
									<td class="tg-0pky">${passResultList[1].rownum}</td>                                <!-- 지하철 -->         
									<td class="tg-0pky">${passResultList[0].rownum + passResultList[1].rownum}</td>     <!-- 소계(버스+지하철) -->  
								</tr>
								
								
								<!-- 2번쨰 라인 이상 ~ 끝 -->
			                 	<c:forEach var='i' begin='2' end='${passResultList.size()}'>
			                 	
			                 		<!-- <tr> 작업  -->
		                 			<!-- 2번째 마다 그려주기 -->
			                 		<c:if test="${passResultList[i].rownum%2 == 1 }">	                
			                 			<tr> 	
					                 		<td class="tg-0pky">${passResultList[i].passtime}</td>								<!-- 시간 -->
					                 		<td class="tg-0pky">${passResultList[i].passcnt}</td>								<!-- 버스 -->
				                   			<td class="tg-0pky">${passResultList[i+1].passcnt}</td>								<!-- 지하철 -->
				                   			<td class="tg-0pky">${passResultList[i].passcnt + passResultList[i+1].passcnt}</td>	<!-- 소계(버스+지하철) -->
				                 		</tr>
				                 	</c:if>	
				                 	
			                   	</c:forEach>
				            
			               </tbody>
			            </c:if>
			            <!-- ▲ 교통수단 : 전체 끝-->
			            
			            <!-- ▼ 교통수단 : 단일 -->           
			            <c:if test="${pVO.passTransport !='00'}">
			            	<colgroup>
				    			<col width="83px;">
				    			<col width="83px;">
				    			<col width="83px;">
				    			<col width="115px;">
				    			<col width="167px;">
				    		</colgroup>
			            	<thead>
			              		<tr>
			                    	<th class="tg-0pky" rowspan="2">날짜</th>
				                    <th class="tg-0pky" rowspan="2">광역/도</th>
				                    <th class="tg-0pky" rowspan="2">시/군</th>
				                    <th class="tg-0pky" rowspan="2">시간</th>
				                    <th class="tg-0pky" colspan="3">${passUserTypeText}</th>
				                </tr>
				                <tr> <!-- 버스 or 지하철 -->
				                 	<c:if test="${pVO.passTransport =='B'}">
					                    <th class="tg-0pky">버스</th>
				                    </c:if>
				                 	<c:if test="${pVO.passTransport =='T'}">
					                    <th class="tg-0pky">지하철</th>
				                    </c:if>
				                </tr>
				          	</thead>    
			               	<tbody>
			               		<!-- 1번쨰 라인 -->
								<tr>
								   	<td class="tg-0pky" rowspan="${passResultList.size()}">${pVO.passDateStart}</td>	<!-- 날짜 -->
								   	<td class="tg-c3ow" rowspan="${passResultList.size()}">경기도</td>					<!-- 광역/도 -->
								   	<td class="tg-0pky" rowspan="${passResultList.size()}">평택시</td>					<!-- 시/군 -->
								   	<td class="tg-0pky">${passResultList[0].passtime}</td>								<!-- 시간 -->
									<td class="tg-0pky">${passResultList[0].passcnt}</td>								<!-- 버스 or 지하철 -->
								</tr>
								
								
									<!-- 2번쨰 라인 이상 ~ 끝 -->
				                 	<c:forEach var='i' begin='1' end='${passResultList.size()-1}'>
			                 			<tr> 	
					                 		<td class="tg-0pky">${passResultList[i].passtime}</td>						<!-- 시간 -->
					                 		<td class="tg-0pky">${passResultList[i].passcnt}</td> 						<!-- 버스 or 지하철 -->
				                 		</tr>
				                   	</c:forEach>					            
			               	</tbody>
			            </c:if>
             			<!-- ▲ 교통수단 : 단일 끝 -->   
              </table>      
              </c:if>
              <!-- ▲ 이용자유형 : 단일 끝--> 
           
        </table>
    </body>
</html>