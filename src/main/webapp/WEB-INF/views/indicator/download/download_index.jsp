<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <title>다운로드</title>
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/common_index.css"> 
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/download_index.css"> 
        <link rel="stylesheet" type="text/css" href="resources/css/indicator/jquery-ui.css"> 
        <script type="text/javascript" src="resources/js/indicator/common_index.js" defer ></script> 
        <script type="text/javascript" src="resources/js/indicator/download_index.js" defer ></script>
        <script src ="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </head>

    <body>
    <%@ include file="../../common/MainHeader.jsp"%>

	<%@ include file="../../common/ConName.jsp"%>
    <div class="ConEx"></div>
   
        <div class="selectbox">
            <div class ="cell1" >
                <p>분석지표</p>
                <div class="cell1_01"> 
                    <div>
                        <label><input type="radio" name="anal_group" value="dlStation"> 정류장</label>
                    </div>
                </div>

                <div class="cell1_02">
                    <div>
                        <label><input type="radio" name="anal_group" value="dlRoute"> 노선</label>
                    </div>
                </div>

                <div class="cell1_03">
                    <div>
                        <label><input type="radio" name="anal_group" value="dlArea"> 행정동</label>
                    </div>
                </div>
            </div>

            <div class ="cell2">
                <p>분석유형</p>
                <div class="cell2_01">
                    <div>
                        <label><input type="radio" name="anal_type" value="dlStation_stationCnt" text2="정류장별_통행"> 정류장별 통행</label>
                        <label><input type="radio" name="anal_type" value="dlStation_station_purpose" text2="정류장간_목적통행"> 정류장간 목적통행</label>
                        <label><input type="radio" name="anal_type" value="dlStation_station_method" text2="정류장간_수단통행"> 정류장간 수단통행</label>
                        <label><input type="radio" name="anal_type" value="dlStation_station_run" text2="정류장별_운행지표"> 정류장별 운행지표</label>
                        <label><input type="radio" name="anal_type" value="dlStation_station_runCongestion" text2="정류장간_운행/혼잡지표"> 정류장간 운행/혼잡지표</label>
                    </div>
                </div>
                <div class="cell2_02">
                    <div>
                        <label><input type="radio" name="anal_type" value="dlRoute_routeCnt" text2="노선별통행"> 노선별통행</label>
                        <label><input type="radio" name="anal_type" value="dlRoute_routeODCnt" text2="노선별_기종점통행"> 노선별 기종점통행</label>
                        <label><input type="radio" name="anal_type" value="dlRoute_routeCBP" text2="노선별_재차인원"> 노선별 재차인원</label>
                    </div>
                </div>

                <div class="cell2_03">
                    <div>
                        <label><input type="radio" name="anal_type" value="dlArea_areaOD_purpose" text2="행정동간_목적통행"> 행정동간 목적통행</label>
                        <label><input type="radio" name="anal_type" value="dlArea_areaOD_method" text2="행정동간_수단통행"> 행정동간 수단통행</label>
                    </div>
                </div>
            </div>
            
            <div class ="cell3">
                <div class="cell3_01">
                    <p>지역</p>
                    
                    <select id="anal_area_cd_sido" name="anal_area_cd_sido">
                        <option>광역/도</option>
                        <option value="11">서울특별시</option>
                    </select>
                    <select id="anal_area_cd" name="anal_area_cd">
                        <option>시/군</option>
                        <option value="11">전체</option>
                    </select>
                </div>

                <div class ="cell3_02">
                    <p>자료</p>
                    <div>
                        <label><input type="radio" name="provider" id="provider00" value="00" text2 ="지자체"> 지자체</label>
                        <label><input type="radio" name="provider" id="provider99" value="99" text2 ="정산사"> 정산사</label>
                    </div>
                </div>

                <div class = "cell3_03"> 
                   <p>날짜</p>
                </div>
            </div>
            <div class ="hcell1">
                <div class ="cell4">
                    <p>제공 자료</p>
                    <div class="cell4_01_01">
                    </div> 
                  	<div class="cell4_01_02">
                    </div>
                </div>
            </div>
        </div>
        
		<input class="submit2" type="button" id="nextBtn" value="조회" style="cursor: pointer;" >
        <input class="submit" type="button" id="downloadBtn" value="다운로드" style="cursor: pointer;" >
        
    </body>

</html>