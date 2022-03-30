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
    <body>
        <div class="header">
            <p>통행 분석 지표</p>
            <div class="dateform">
                <span>날짜 : </span> <div class="date">2020-01-01</div>
                <span>분석지역 :</span>
                <span>분석자료 :</span>
                <div>분석지표 :</div>
            </div>
            <div class="button">
                <button type="button">그래프</button>
                <button type="button">다운로드</button>

            </div>
        </div>
        <div class="content">
            <table class="tg">
              <c:if test="${pVO.passUserType=='전체' }">
                <thead>
                  <tr>
                    <th class="tg-0pky" rowspan="2">시간</th>
                    <th class="tg-0pky" rowspan="2">광역/도</th>
                    <th class="tg-0pky" rowspan="2">시/군</th>
                    <th class="tg-0pky" rowspan="2">분석지표</th>
                    <th class="tg-0pky" rowspan="2">시간</th>
                    <th class="tg-0pky" colspan="3">경로</th>
                    <th class="tg-0pky" colspan="3">국가유공자</th>
                    <th class="tg-0pky" colspan="3">기타</th>
                    <th class="tg-0pky" colspan="3">다자녀부모</th>
                    <th class="tg-0pky" colspan="3">대학생</th>
                    <th class="tg-0pky" colspan="3">동반</th>
                    <th class="tg-0pky" colspan="3">복지</th>
                    <th class="tg-0pky" colspan="3">어린이</th>
                    <th class="tg-0pky" colspan="3">일반</th>
                    <th class="tg-0pky" colspan="3">장애인</th>
                    <th class="tg-0pky"colspan="3">소계</th>
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
              </c:if>
              
              <c:if test="${pVO.passUserType!='전체' }">
              	<thead>
              		<tr>
                    	<th class="tg-0pky" rowspan="2">시간</th>
	                    <th class="tg-0pky" rowspan="2">광역/도</th>
	                    <th class="tg-0pky" rowspan="2">시/군</th>
	                    <th class="tg-0pky" rowspan="2">분석지표</th>
	                    <th class="tg-0pky" rowspan="2">시간</th>
	                    <th class="tg-0pky" colspan="3">${pVO.passUserType}</th>
	                </tr>
	                <tr>
	                    <th class="tg-0pky">버스</th>
                    	<th class="tg-0pky">지하철</th>
                    	<th class="tg-0pky">소계</th>
	                </tr>
	          	</thead>          
              </c:if>
                
              <c:if test="${pVO.passTime=='allDay'}">
               <tbody>
	                 <c:forEach var="list" items="${passResultList}"> 
	                 	<c:if test="${list.rownum==1 }">
	                 		<tr>
			                   <td class="tg-0pky" rowspan="24"></td>
			                   <td class="tg-c3ow" rowspan="24"></td>
			                   <td class="tg-0pky" rowspan="24"></td>
			                   <td class="tg-0pky" rowspan="24"></td>
			                   <td class="tg-0pky">0</td>
			                   <c:if test="${list.passTransport=='B' }">
			                   		<td class="tg-0pky">${list.passcnt}</td>
			                   </c:if>
			                 </tr>
	                 	</c:if>
	                 	<c:if test="${list.rownum>1 }">
	                 		<tr>
                   				<td class="tg-0pky">0</td>
			                   <c:if test="${list.passTransport=='B' }">
			                   		<td class="tg-0pky">${list.passcnt}</td>
			                   </c:if>
                   			</tr>
	                 	</c:if>
	                 </c:forEach>
               </tbody>
              </c:if>
              
	         <c:if test="${pVO.passTime!='allDay'}">
	               <tbody>
		                 <tr>
		                   <td class="tg-0pky" rowspan="${pVO.passTimeEnd+1}"></td>
		                   <td class="tg-c3ow" rowspan="${pVO.passTimeEnd+1}"></td>
		                   <td class="tg-0pky" rowspan="${pVO.passTimeEnd+1}"></td>
		                   <td class="tg-0pky" rowspan="${pVO.passTimeEnd+1}"></td>
		                   <td class="tg-0pky">${pVO.passTimeStart }</td>
		                 </tr>
		                   <c:forEach var='i' begin='${ pVO.passTimeStart +1}' end='${pVO.passTimeEnd }'>
		                   		<tr>
		                   			<td class="tg-0pky">${i}</td>
		                   		</tr>
		                   </c:forEach>
	               </tbody>
              </c:if>
              
             <%--  <c:if test="${pVO.passTime!='allDay'}">
               <tbody>
                 <tr>
                   <td class="tg-0pky" rowspan="24"></td>
                   <td class="tg-c3ow" rowspan="24"></td>
                   <td class="tg-0pky" rowspan="24"></td>
                   <td class="tg-0pky" rowspan="24"></td>
                   <td class="tg-0pky">00</td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                   <td class="tg-0pky"></td>
                 </tr>
               </tbody>
              </c:if> --%>
               </table>
    </body>
</html>