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
    <div class="ConEx" style="background:#fff url(resources/images/indicator/downloadB.jpg)"></div>
   
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
          		<div style="background-color: #32689b;width: 100%;height: 42px;">
                    <span class="cell2_alret">다운로드 가능한 목록이 제공됩니다.</span>
	                <p style="width: 73px;float: left;margin-left: 32.5%;">분석유형</p>
	                <div class="cell2_icon" onclick="downloadList();"></div>
                </div>
                
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
        
		<input class="submit2" type="button" id="nextBtn" value="조회" style="cursor: pointer;">
        <input class="submit" type="button" id="downloadBtn" value="다운로드" style="cursor: pointer;">
        
        
		<div class="test-modal-wrap">
		
           <div class="modal-content-background"></div>
         
           <div class="modal-content">
              <div class="modal-content-wrap">
                     <div class="modal-header">
                         <div class ="headers" id="header_1" table="PIVOT_정류장별통행">정류장별 통행</div>        
                         <div class ="headers" id="header_2" table="PIVOT_정류장별OD_목적통행_SMALL">정류장간 목적통행</div>        
                         <div class ="headers" id="header_3" table="PIVOT_정류장별OD_수단통행_SMALL">정류장간 수단통행</div>        
                         <div class ="headers" id="header_4" table="정류장별 운행지표">정류장별 운행지표</div>        
                         <div class ="headers" id="header_5" table="정류장간 운행/혼잡지표">정류장간 운행/혼잡지표</div>        
                         <div class ="headers" id="header_6" table="PIVOT_노선별통행">노선별통행</div>        
                         <div class ="headers" id="header_7" table="PIVOT_노선별OD_SMALL">노선별 기종점통행</div>        
                         <div class ="headers" id="header_8" table="혼잡_노선별_재차인원혼잡도">노선별 재차인원</div>        
                         <div class ="headers" id="header_9" table="PIVOT_행정동별OD_목적통행">행정동간 목적통행</div>        
                         <div class ="headers" id="header_10" table="PIVOT_행정동별OD_수단통행">행정동간 수단통행</div>        
                     </div>
                     <div class="modal-body">
                     
                        <div class="body-notice">
                           현재 준비중입니다.
                        </div>
                       
                         <div class="body-content">
                             <div class ="modalHead">
                                 <select name="dlHeader" id="dlHeader_1" class="dlHeader">
                                    <option value="1">광역/도</option>
                                 </select>
                                 <select name="dlHeader" id="dlHeader_2" class="dlHeader">
                                    <option value="1">시/군</option>
                                 </select>
                                 <select name="dlHeader" id="dlHeader_4" class="dlHeader">
                                     <option value="1">분석자료</option>
                                     <option value="지자체">지자체</option>
                                     <option value="정산사">정산사</option>
                                 </select>
                                 <select name="dlHeader" id="dlHeader_3" class="dlHeader">
                                    <option value="1">제공날짜</option>
                                 </select>
                                 <select name="dlHeader" id="dlHeader_5" class="dlHeader">
                                    <option value="1">가능여부</option>
                                    <option value="O">O</option>
                                    <option value="X">X</option>
                                 </select>
                             </div>
                             <span class="resetBtn_alret">새로고침</span>
                             <button id="resetBtn"></button>
                         </div>
                         
                         
                         <div class="body-sub-content">
                             
                         </div>
                     </div>
                  </div>
           </div>
        
        </div>
        
        
        
        
        
        
    </body>

</html>