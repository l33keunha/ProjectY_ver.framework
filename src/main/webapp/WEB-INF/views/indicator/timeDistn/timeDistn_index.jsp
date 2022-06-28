<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <title>시간거리분석</title>
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/common_index.css"> 
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/timeDistn_index.css"> 
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/jquery-ui.css"> 
 		<script type="text/javascript" src="resources/js/indicator/common_index.js" defer ></script> 
 		<script type="text/javascript" src="resources/js/indicator/timeDistn_index.js" defer ></script> 
        <script src ="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </head>
	
	<body>

    <%@ include file="../../common/conName.jsp"%>
    
    <div class="ConEx" style="background:#fff url(resources/images/indicator/timeDistnB.jpg)"></div>

   
        <div class="selectbox">
            <div class ="cell1" >
                <p>분석지표</p>
                <div class="cell1_01"> 
                    <div>
                        <label><input type="radio" name="anal_group" value="timeDistn_avg_day"> 1일 평균 통행시간/거리</label>
                        <label><input type="radio" name="anal_group" value="timeDistn_avg_purpose"> 목적통행 평균 통행시간/거리</label>
                        <label><input type="radio" name="anal_group" value="timeDistn_avg_method"> 수단통행 평균 통행시간/거리</label>
                        <label><input type="radio" name="anal_group" value="timeDistn_avg_route"> 노선별 평균 통행시간/거리</label>
                    </div>
                </div>

                <div class="cell1_02">
                </div>

                <div class="cell1_03">
                </div>
            </div>
            
            <div class ="cell3">
                <div class="cell3_01">
                    <p>지역</p>
                    
                    <select id="anal_area_cd_sido" name="anal_area_cd_sido" onchange="chngSido">
                        <option>광역/도</option>
                    </select>
                    <select id="anal_area_cd" name="anal_area_cd" onchange="chngSigungu">
                        <option>시/군</option>
                    </select>
                </div>

                <div class ="cell3_02">
                    <p>자료</p>
                    <div>
                        <label><input type="radio" name="provider" id="provider00" value="00" text2="지자체"> 지자체</label>
                        <label><input type="radio" name="provider" id="provider99" value="99" text2="정산사"> 정산사</label>
                    </div>
                </div>

                <div class = "cell3_03"> 
                	<p>날짜</p>
                </div>
            </div>
            <div class ="hcell1">
                <div class ="cell4">
                    <p>시간대</p>
                    <div class="cell4_01">
                        <label><input type="checkbox" name="tm" value="allDay"> 1일</label>
                        <select name="tmStart">
                            <option value="00" >00</option>      
                            <option value="01" >01</option>
                            <option value="02" >02</option>
                            <option value="03" >03</option>
                            <option value="04" >04</option>
                            <option value="05" >05</option>
                            <option value="06" >06</option>
                            <option value="07" >07</option>
                            <option value="08" >08</option>
                            <option value="09" >09</option>
                            <option value="10" >10</option>
                            <option value="11" >11</option>
                            <option value="12" >12</option>
                            <option value="13" >13</option>
                            <option value="14" >14</option>
                            <option value="15" >15</option>
                            <option value="16" >16</option>
                            <option value="17" >17</option>
                            <option value="18" >18</option>
                            <option value="19" >19</option>
                            <option value="20" >20</option>
                            <option value="21" >21</option>
                            <option value="22" >22</option>
                            <option value="23" >23</option>
                        </select> ~
                        <select name="tmEnd">
                            <option value="00" >00</option>
                            <option value="01" >01</option>
                            <option value="02" >02</option>
                            <option value="03" >03</option>
                            <option value="04" >04</option>
                            <option value="05" >05</option>
                            <option value="06" >06</option>
                            <option value="07" >07</option>
                            <option value="08" >08</option>
                            <option value="09" >09</option>
                            <option value="10" >10</option>
                            <option value="11" >11</option>
                            <option value="12" >12</option>
                            <option value="13" >13</option>
                            <option value="14" >14</option>
                            <option value="15" >15</option>
                            <option value="16" >16</option>
                            <option value="17" >17</option>
                            <option value="18" >18</option>
                            <option value="19" >19</option>
                            <option value="20" >20</option>
                            <option value="21" >21</option>
                            <option value="22" >22</option>
                            <option value="23" >23</option>
                        </select>
                    </div>
                </div>

                <div class ="cell5">
                    <p>이용자유형</p>
                    <div class="cell5_01">
                        <div>
                        <label><input type="checkbox" name="cd_no" value="00" onclick="selectAllCd(this)"> 전체</label>
                        <label><input type="checkbox" name="cd_no" value="01"> 일반</label>
                        <label><input type="checkbox" name="cd_no" value="02"> 어린이</label>
                        <label><input type="checkbox" name="cd_no" value="03"> 청소년</label>
                        <label><input type="checkbox" name="cd_no" value="04"> 경로</label>
                        <label><input type="checkbox" name="cd_no" value="05"> 장애인</label>
                        <label><input type="checkbox" name="cd_no" value="06"> 국가유공자</label>
                        <label><input type="checkbox" name="cd_no" value="07"> 다자녀부모</label>
                        <label><input type="checkbox" name="cd_no" value="08"> 동반</label>
                        <label><input type="checkbox" name="cd_no" value="09"> 대학생</label>
                        <label><input type="checkbox" name="cd_no" value="10"> 복지</label>
                        <label><input type="checkbox" name="cd_no" value="11"> 기타</label>
                    </div>
                    </div>
                </div>

                <div class ="cell6">
                    <p>교통수단/노선</p>
                    <div class="cell6_01">
                        <p>수단</p>
                        <div>
                            <label><input type="radio" name="tfcmn" value="00"> 전체</label>
                            <label><input type="radio" name="tfcmn" value="B"> 버스</label>
                            <label><input type="radio" name="tfcmn" value="T"> 지하철</label>
                        </div>
                    </div>

                    <div class="cell6_02">
                        <p>노선</p>
                        <div class="busname_wrap">
                            <div class="search">
                                <div class="input-wrap">
                                    <input type="checkbox" id="modalBtn" name="searchpassRoute">
                                    <label for="modalBtn">노선번호 검색</label>
                                    <!-- 노선번호 확인 modal -->
                             <div class="modalContainer">
                              <div class="modalBox">
                                 <div class="routeNotice">노선번호 검색</div>
                                 <label for="modalBtn">x</label>
                                 <div class="routeBox">
                                    <input type="text" placeholder="(노선번호/노선유형/기점/종점) 검색..." id="searchRouteId">
                                    <div class="routeListBox">
                                        
                                    </div>
                                    <input type="button" id="routeBtn" value="확인">
                                 </div>
                              </div>           
                             </div> 
                                </div>
                            </div>
                              <div class="search-con">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <input class="submit" type="button" id="timeDistnBtn" value="조회" >
       
    </body>
    
</html>
