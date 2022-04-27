<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <title>통행지표</title>
        <link rel="stylesheet" type="text/css" href="css/indexCSS.css"> 
 		<!-- <script type="text/javascript" src="js/pass_popUp.js" defer ></script> --> 
        <script src ="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    </head>

    <body>
        <div class = " header">
            <div class="logo">
                <svg id="레이어_2" data-name="레이어 2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200"><defs><style>.cls-1{fill:#1f2958;}.cls-2{fill:#545e93;}.cls-3{fill:none;stroke:#1f2958;stroke-miterlimit:10;stroke-width:7px;}.cls-4{fill:#98a4d1;}</style></defs><title>로고</title><path class="cls-1" d="M143.29,9.11c-14.86,1.49-19.16,4.12-27.56,16.7-8.8,13.35-16.23,25.49-27.24,45C86.37,74.54,85.7,77,85.7,82V107c0,17.35,1.88,18.17,21.16,20.13V134H38.14v-6.86C56.84,125,58.41,124.46,58.41,107V82.73c0-4.32-.9-6.28-3.18-10.18-7-12.39-15.06-25.69-28.07-46.2C18.69,13,15.71,10.4,1.89,9.11V2.25H64V9.11C48.58,11,49.19,13.64,53.09,20.67c8.12,14,18.09,31,27,45.9,7.21-12.13,18.7-32.52,25-44.46,4.59-8.82,3.18-11.25-13.55-13V2.25h51.81Z"/><path class="cls-1" d="M123.09,84.16l-14.22,0V77.51l37.18.06V84.2l-14.22,0L131.76,122H123Z"/><path class="cls-1" d="M149.09,77.58l15.75,0c10.13,0,17.56,2.83,17.55,11a10,10,0,0,1-6.86,9.61v.27C181,99.6,185,103,185,109c0,8.89-8.1,13-18.95,13l-17,0Zm16,38.33c7.23,0,11.27-2.32,11.28-7.32,0-4.68-3.9-6.72-11.25-6.74h-7.39l0,14.06ZM164,96c6.87,0,9.8-2.4,9.8-6.26,0-4.3-3.21-5.93-9.6-5.94l-6.42,0,0,12.21Z"/><path class="cls-1" d="M185.94,116.39,191,111a20.4,20.4,0,0,0,12.83,5.09c5.54,0,8.59-2.25,8.6-5.72,0-3.66-3.17-4.83-7.64-6.55l-6.73-2.65c-4.85-1.83-9.95-5.3-9.94-11.8,0-7.08,7-12.52,16.56-12.5a22.81,22.81,0,0,1,15.17,5.69l-4.49,5a16.79,16.79,0,0,0-10.69-3.83c-4.67,0-7.72,2-7.72,5.2,0,3.5,3.74,4.79,7.82,6.31l6.64,2.53c5.85,2.21,10,5.56,9.93,12,0,7.2-6.65,13.2-17.7,13.18A26.91,26.91,0,0,1,185.94,116.39Z"/><path class="cls-2" d="M283.74,117l8.22-8.68c1.34-1.42,3-2.21,4.28-2l9.91,1.69c1.35.23,1.86,1.59,1.21,3.32-1.64,4.37-5.52,12.24-12.79,14.15a2.93,2.93,0,0,1-1.52,0l-9.88-2.81C281.28,122.18,281.56,119.31,283.74,117Z"/><line class="cls-3" x1="41.94" y1="130.61" x2="258.58" y2="130.61"/><path class="cls-1" d="M258.26,134.06c-4-1.08-2.74-19.6,14.26-30.52.5-.32,11.05-7,13.76-5.51C291.67,101.05,264.29,135.66,258.26,134.06Z"/><path class="cls-4" d="M275.63,124.93a6.08,6.08,0,0,0-4.06,2.68,11.55,11.55,0,0,1-5.46,4.81,22.55,22.55,0,0,1-5.26,1.72c-.77.16-.55.84.29.91L298,137.86c.61,0,1-.31.74-.64C296,134.14,285.36,122.61,275.63,124.93Z"/></svg>
            </div>
            <span class="logo02"></span>
            <div class="mtap">
                <a href="#"><p>Home</p></a>
                <a href="#"><p>로그아웃</p></a>
                <p>Contact Us</p>
                <div class="dropdown">
                    <button class="dropbtn">전체 메뉴</button>
                </div>
            </div>
        </div>

    <div class="ConName">
        <div class="contents">
            <a href="#"><span>이용분석</span></a>
            <div><span>통행분석</span></div>
            <a href="#"><span>환승분석</span></a>
            <a href="#"><span>혼잡분석</span></a>
            <a href="#"><span>시간분석</span></a>
            <a href="#"><span>거리분석</span></a>
            <a href="#"><span>운행분석</span></a>
            <a href="#"><span>지도분석</span></a>
            <a href="#"><span>다운로드</span></a>
        </div>
    </div>
    <div class="ConEx"></div>

   
        <div class="selectbox">
            <div class ="cell1" >
                <p>분석지표</p>
                <div class="cell1_01"> 
                    <div>
                        <label><input type="radio" name="anal_group" value="passCnt"> 통행량</label>
                    </div>
                </div>

                <div class="cell1_02">
                    <div>
                        <div class="OD">
                            <label><input type="radio" name="anal_group" value="passRouteODCnt"> 노선별OD</label>
                        </div>
                        <label><input type="radio" name="anal_group" value="passAreaODCnt"> 행정동간OD</label>
                    </div>
                </div>

                <div class="cell1_03">
                    <div>
                        <!-- <label><input type="checkbox" name="anal_group" value="passEtc"> 기타</label> -->
                        <label><input type="radio" name="anal_group" value="passTopRotue"> 상위이용노선</label>
                        <label><input type="radio" name="anal_group" value="passTopStation"> 상위이용정류장</label>
                    </div>
                </div>
            </div>
            <div class ="cell2">
                <p>분석유형</p>
                <div class="cell2_01">
                    <div>
                        <label><input type="radio" name="anal_type" value="passCnt_purpose"> 목적통행</label>
                        <label><input type="radio" name="anal_type" value="passCnt_method"> 수단통행</label>
                        <label><input type="radio" name="anal_type" value="passCnt_route"> 노선별통행</label>
                        <label><input type="radio" name="anal_type" value="passCnt_station"> 정류장별통행</label>
                    </div>
                </div>
                <div class="cell2_02">
                    <div>
                        <label><input type="radio" name="anal_type" value="passAreaODCnt_purpose"> 목적통행</label>
                        <label><input type="radio" name="anal_type" value="passAreaODCnt_method"> 수단통행</label>
                    </div>
                </div>

                <div class="cell2_03">
                </div>
            </div>
            
            <div class ="cell3">
                <div class="cell3_01">
                    <p>지역</p>
                    
                    <select id="anal_area_cd_sido" name="anal_area_cd_sido">
                        <option>시/도</option>
                    </select>
                    <select id="anal_area_cd" name="anal_area_cd">
                        <option>시/군/구</option>
                    </select>
                </div>

                <div class ="cell3_02">
                    <p>분석자료</p>
                    <div>
                        <label><input type="checkbox" name="provider" id="provider00" value="00"> 국토부</label>
                        <label><input type="checkbox" name="provider" id="provider99" value="99"> 정산사</label>
                    </div>
                </div>

                <div class = "cell3_03"> 
                	<p>날짜</p>
                    <label>시작<input class="date" id="dateStart" name="dateStart"></label>
                    <label>종료<input class="date" id="dateEnd" name="dateEnd"></label>
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
                    <p>교통 수단/노선</p>
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
													<div class='routeListTh' style='width:100%;'>
														<p style="width: 21%; float:left;"> 노선명 </p>
														<p style="width: 11%; float:left;margin-left: 23px;"> 노선유형 </p>
														<p style="width: 7%; float:left;margin-left: 61px;"> 기점 </p>
														<p style="width:30%; float:left;margin-left: 61px;"> 종점 </p>
													</div>
													<div class="routeLists">
													</div>
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

        <input class="submit" type="button" id="buttonTest" value="조회" style="cursor: pointer;" >
        
    </body>
	
	<script>
	// [1] 페이지 로드 시 비활성화로 시작
	window.onload = function(){
		diabledFalseType(2)
	}
	
	
	$(function(){
	 	$('.date').datepicker({
          	dateFormat: 'yy-mm-dd' //달력 날짜 형태
             ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
             ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
             ,changeYear: true //option값 년 선택 가능
             ,changeMonth: true //option값  월 선택 가능                
             ,buttonText: "선택" //버튼 호버 텍스트              
             ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
             ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
             ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
             /* ,beforeShowDay: available */
 	 })
		
		$( "#dateStart" ).datepicker("setDate" ,'2021-03-22');	
		$( "#dateEnd" ).datepicker("setDate" ,'2021-03-22');	
	})
	// [--1]
	
	// [2] 값 받아서 다시 form에 담아 url에 보내줌
	$('input[id=buttonTest]').on('click', function () {
		var pushArray = [
					[ "dateStart", 	$("input[name=dateStart]").val()],
					[ "dateEnd", 	$("input[name=dateEnd]").val()],
					[ "anal_area_cd_sido",  		$("select[name=anal_area_cd_sido]").val()],
					[ "anal_area_cd", 	$("select[name=anal_area_cd]").val()],
					[ "tmStart", 	$("select[name=tmStart]").val()],
					[ "tmEnd", 	$("select[name=tmEnd]").val()],
					[ "anal_area_cd_sido_text", 	$("[name=anal_area_cd_sido] option:selected").text()],
					[ "anal_area_cd_text", 	$("select[name=anal_area_cd] option:selected").text()]
		]
		

		//해당 체크된 엘리먼트의 이름과 값을 배열에 넣어준다.
		$("[class=selectbox]").find("input:checked").each(function(index, item){
			pushArray.push([ $(item)[0].name, $(item)[0].value ] )
		})

		window.open("" ,"newForm", "toolbar=no, width=1200, height=800, directories=no, status=no, scrollorbars=no, resizable=no"); 
		
		//set attribute (form) 
		var newForm = $('<form></form>'); 
		newForm.attr("name","newForm"); 
		newForm.attr("method","post"); 
		newForm.attr("action","passTest.do"); 
		newForm.attr("target","newForm"); 

		// create element & set attribute (input) 
		for(var i=0; i<pushArray.length; i++){
			newForm.append($('<input/>', {type: 'hidden', name: pushArray[i][0], value: pushArray[i][1] })); 
			console.log("이름:"+ pushArray[i][0] +"    값:"+pushArray[i][1]);
		}
		console.log("---------------------------------------------------------------------------------------------");

		// append form (to body) 
		newForm.appendTo('body'); 
		
		// submit form 
		newForm.submit();
	});
	// [--2]
	
	
	// [3] 원하는 결과에 따라 맞는 조회조건 활성화
	$(document).ready(function(){
		// 1. 통행량 선택시
		$('.cell1').change(function(){
		diabledFalseType(2)
			
			if($("input[name=anal_group]:checked").val()=='passCnt'){
				$('.cell2').css("opacity", 1);
				$('.cell2_01').find('input').prop("disabled",false);
				$('.cell2_01').find('label').css("opacity", 1);
				$('.cell2_02').find('label').css("opacity", 0.3);
			} else if($("input[name=anal_group]:checked").val()=='passAreaODCnt'){
				$('.cell2').css("opacity", 1);
				$('.cell2_02').find('input').prop("disabled",false);
				$('.cell2_02').find('label').css("opacity", 1);
				$('.cell2_01').find('label').css("opacity", 0.3);
			} else if($("input[name=anal_group]:checked").val()=='passRouteODCnt' || 'passTopRotue' || 'passTopStation'){
				searchAnal()
			} 
		})
	})
	
	$(document).ready(function(){
		$('.cell2').change(function(){
			diabledFalseType(3)
			searchAnal()
		})
	})
	// [--3]
	
	// [4] 존재하는 조회조건 가져오기 (cell3 구역)
	var jsonArray = {};
	
	function searchAnal(){
		$(".cell3").css("opacity", 1);
		$(".cell3_02").css("opacity", 0.3);
		$(".cell3_03").css("opacity", 0.3);
		$("select[name=anal_area_cd_sido]").prop("disabled", false);
		
		$("[class=selectbox]").find("input:checked").each(function(index, item){
			jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		
		console.log(jsonArray);
		// [4-1] 분석지표에 따른 조회 가능한 지역 가져오기
		$.ajax({
			url: 'searchAnal.do',
			type: "post",
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				for(var i in data.passSearchList){
					$("select[name=anal_area_cd_sido]").append("<option value='" + data.passSearchList[i].analAreaCd + "'>" 
																+ data.passSearchList[i].analareanm + "</option>");
				}
			}
		})
	}
	
	$("select[name=anal_area_cd_sido]").change(function(){
		disabledFalse()
		$("select[name=anal_area_cd]").prop("disabled", false);
		$("select[name=anal_area_cd]").children('option:not(:first)').remove();
		$('.cell3').find('input').prop("checked", false);
		$('.cell3').find('input').prop("disabled", true);
		
		$("[class=selectbox]").find("input:checked").each(function(index, item){
			jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = "null";
		
		$.ajax({
			url: 'searchAnal.do',
			type: "post",
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				for(var i in data.passSearchList){
					$("select[name=anal_area_cd]").append("<option value='" + data.passSearchList[i].analAreaCd + "'>" 
																+ data.passSearchList[i].analareanm + "</option>");
				}
			}
		})
	})
		
	$("select[name=anal_area_cd]").change(function(){
		$(".cell3_02").css("opacity", 1);
		$("input[name=provider]").prop("disabled", false);
		$("input[name=provider]").prop("checked", false);
		
		$("[class=selectbox]").find("input:checked").each(function(index, item){
			jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = $("select[name=anal_area_cd]").val();
		
		$.ajax({
			url: 'searchAnal.do',
			type: "post",
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				if(data.passSearchList.length == 1 && data.passSearchList[0].provider == '00'){
					$('#provider99').prop("disabled", true);
				}
			}
		})
	})
	
	// 정산사 선택 시, 조회 조건 활성화
	$("input[name=provider]").change(function(){
		$("[class=selectbox]").find("input:checked").each(function(index, item){
			jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = $("select[name=anal_area_cd]").val();
		
		$.ajax({
			url: 'searchAnal.do',
			type: 'post',
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				var abledDays = [];
	 			for(var i in data.passSearchList){
	 				var date = new Date(data.passSearchList[i].opratDate.substr(0,4)
							,data.passSearchList[i].opratDate.substr(4,2)-1
							,data.passSearchList[i].opratDate.substr(6,2)); 
					var date = data.passSearchList[i].opratDate.substr(0,4);
					date    += '-';
					date    += data.passSearchList[i].opratDate.substr(4,2);
					date    += '-';
					date    += data.passSearchList[i].opratDate.substr(6,2);
					
					abledDays.push(date);
				} 
				$('.date').datepicker({
					beforeShowDay: available
				})
				console.log(abledDays);
				
				function available(date) {
				    ymd = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
				    if ($.inArray(ymd, abledDays) >= 0) {
				        return [true,""];
				    } else {
				        return [false,""];
				    }
				}
			}
		})
		
		$(".cell3_03").css("opacity", 1);
		$(".cell3_03").find("label").eq(1).css("opacity", 0.3);
		$("input[name=dateStart]").prop("disabled", false);
		
		// 목적통행, 수단통행은 시작~종료일 설정 가능
		if($("input[name=anal_type]:checked").val() =='passCnt_purpose' 
			|| $("input[name=anal_type]:checked").val() =='passCnt_method'){
				$(".cell3_03").find("label").eq(1).css("opacity", 1);
				$("input[name=dateEnd]").prop("disabled", false);
		}
		
		// cell4, cell5, cell6 활성화
		disabledTrue()
		
		// 시간대 비활성화
		if($("input[name=anal_type]:checked").val() =='passCnt_station'
			|| $("input[name=anal_group]:checked").val() =='passAreaODCnt'
			|| $("input[name=anal_group]:checked").val() =='passTopRotue'){
			disabledTime()
		}
		
		// 노선별OD 조회조건 : 시간대는 2시간씩만, 노선번호 검색 활성화
		if($("input[name=anal_group]:checked").val() =='passRouteODCnt'){
			$('.cell6').css("opacity", 1);
			$('.cell6_01').css("opacity", 0.3);
			$("input[name=searchpassRoute]").prop("disabled", false);
			$("label[for='modalBtn']").css("cursor","pointer");
			
			// 노선별OD는 2시간씩만 선택가능하게끔
			$("select[name=tmEnd] option:eq(2)").prop("selected", true);
			
			$("select[name=tmStart]").change(function(){
				var index = $("select[name=tmStart] option").index($("select[name=tmStart] option:selected")) + 2;
				console.log(index);
				if((index == 24) || (index == 25)) $("select[name=tmEnd] option:eq(23)").prop("selected", true);
				else $('select[name=tmEnd] option:eq('+ index + ')').prop("selected", true);
			})
			
			$("select[name=tmEnd]").change(function(){
				var index = $("select[name=tmEnd] option").index($("select[name=tmEnd] option:selected")) - 2;
				if((index == -2) || (index == -1)) $("select[name=tmStart] option:eq(0)").prop("selected", true);
				else $('select[name=tmStart] option:eq('+ index + ')').prop("selected", true);
			})
		}
		
		// 상위이용정류장 조회조건 : 서울은 버스,지하철 다르게 표출
		if($("input[name=anal_group]:checked").val() =='passTopStation'){
			disabledTime()
			if($("select[name=anal_area_cd] option:selected").val() =='11'){
				$('.cell6').css("opacity", 1);
				$('.cell6_02').css("opacity", 0.3);
				$("input[name=tfcmn]").prop("disabled", false);
			}
		}
	})
	// [--4]
	
	// [5] 노선번호 조회 (Ajax)
	// 노선번호 검색 버튼 누르면 조건에 맞는 노선번호 리스트 가져옴
	$("input[name=searchpassRoute]").change(function(){
		$(".routeBox").find('input').prop("checked", false);
		$(".routeBox").find('input').prop("disabled", false);
		$("#searchRouteId").val("");
		$('.routeLists').empty();
		
		if($("input[name=searchpassRoute]").is(":checked")==true){
			jsonArray["anal_area_cd"] = $("select[name=anal_area_cd]").val();
			jsonArray["provider"] = $("input[name=provider]:checked").val();
			jsonArray["dateStart"] = $("input[name=dateStart]").val();
			
			$.ajax({
				url: "searchRouteId.do",
				type: "post",
				traditional: true,
				data: jsonArray,
				dataType: "json",
				success: function(data){
					for(var i in data.passRouteIdList){
						var list = data.passRouteIdList[i];
						
						var addHtml = "";
						
						addHtml += "<div class='routeList'>";
						addHtml += "<div class='routeNm'><input type='radio' value='" + list.routeId + "' name='routeId'>" + list.routeNma + "</div>";
						addHtml += "<div class='routeType'>" + list.routeType + "</div>";
						addHtml += "<div class='routeStart'>" + list.routeStart + "</div>";
						addHtml += "<div class='routeEnd'>" + list.routeEnd + "</div>";
						addHtml += "</div>";
								
						$('.routeLists').append(addHtml);
					}
				}
				
			})	
		}
	})
	
	// 검색기능 : keyup때 마다 값이 포함된 리스트만 보여줌
	$(document).ready(function(){
		$("#searchRouteId").keyup(function(){
			var k = $(this).val();
			$(".routeList").hide();
			var temp = $(".routeList:contains('" + k + "')");
			$(temp).show();
		})
	})
	
	// 확인버튼 클릭 시, 라디오버튼이 선택된 값을 받아와 선택박스에 출력
	$("#routeBtn").on('click',function(){
		console.log($("input[name=routeId]:checked").val());
		var routeNm = $("input[name=routeId]:checked").parent().parent().find('.routeNm').text();		
		var routeType = $("input[name=routeId]:checked").parent().parent().find('.routeType').text();		
		var routeStart = $("input[name=routeId]:checked").parent().parent().find('.routeStart').text();		
		var routeEnd = $("input[name=routeId]:checked").parent().parent().find('.routeEnd').text();
		
		// 모달창 끄기
		$("#modalBtn").prop("checked", false);
		
		// 선택박스 클리어
		var addHtml = "";
		$('.search-con').text("");
		
		addHtml += "<div> <p>노선명</p><span>" + routeNm + "</span></div>";
		addHtml += "<div> <p>노선유형</p><span>" + routeType + "</span></div>";
		addHtml += "<div> <p>기점</p><span>" + routeStart + "</span></div>";
		addHtml += "<div> <p>종점</p><span>" + routeEnd + "</span></div>";
		
		$('.search-con').append(addHtml);

	})
	// [--5]
	
	// [6] 활성화/비활성화 모음
	// 1일 - 시간대 비활성화
	$("input[name=tm]").change(function(){
		if($("input[name=tm]").is(":checked") == true){
			$('.cell4').find('select').prop("disabled", true);
		} else if($("input[name=tm]").is(":checked") == false){
			$('.cell4').find('select').prop("disabled", false);
		}
	})
	
	// 이용자유형 전체선택/해제
	function selectAllCd(selectAll){
		 const checkboxes 
	       = document.getElementsByName('cd_no');
	  
	 	 checkboxes.forEach((checkbox) => {
	  	  checkbox.checked = selectAll.checked;
	  })
	}
	
	// 분석유형부터 초기화
	function diabledFalseType(num){
		for(var i = num; i < 7; i++){
			$(".cell" + [i]).css("opacity", 0.3);
			$(".cell" + [i]).find('input').prop("disabled", true);
			$(".cell" + [i]).find('input').prop("checked", false);
			$(".cell" + [i]).find('select').prop("disabled", true);
			$(".cell" + [i]).find('select option:selected').prop("selected", false);
		}
		$("select[name=anal_area_cd_sido]").children('option:not(:first)').remove();
		$("select[name=anal_area_cd]").children('option:not(:first)').remove();
 	    jsonArray["anal_area_cd_sido"] = "null";
	    jsonArray["anal_area_cd"] = "null"; 
	    jsonArray["anal_type"] = "null"; 
	    
	    $( "#dateStart" ).datepicker("setDate" ,'2021-03-22');	
		$( "#dateEnd" ).datepicker("setDate" ,'2021-03-22');	
	    
		$(".search-con").children().remove();
	}
	
	
	// 상세 조회조건 체크박스부터 초기화
	function disabledFalse(){
		
		for(var i = 4; i < 7; i++){
			$(".cell" + [i]).css("opacity", 0.3);
			$(".cell" + [i]).find('input').prop("disabled", true);
			$(".cell" + [i]).find('input').prop("checked", false);
		}
		
		$(".search-con").children().remove();
	}
	
	// 지역, 자료, 날짜, 시간대, 이용자유형 활성화
	function disabledTrue(){
		for(var i = 3; i < 6; i++){
			$(".cell" + [i]).css("opacity", 1);
			$(".cell" + [i]).find('input').prop("disabled", false);
			$(".cell" + [i]).find('select').prop("disabled", false);
		}
	}

	// 시간대 비활성화
	function disabledTime(){
		$(".cell4").css("opacity", 0.3); 
		$(".cell4").find('input').prop("disabled", true);
		$(".cell4").find('input').prop("checked", true);
		$(".cell4").find('select').prop("disabled", true);
	}
	// [--6]
	
		
	</script>
</html>