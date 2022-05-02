	// [1] 페이지 로드 시 비활성화로 시작
	window.onload = function(){
		diabledFalseType(2)
	}
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
		$( "#dateStart" ).val('');	
		$( "#dateEnd" ).val('');
	
		
		$("[class=selectbox]").find("input:checked").each(function(index, item){
			jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = "null";
		jsonArray["provider"] = "null";
		
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
		jsonArray["provider"] = "null";
		
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
		
		if($("input[name=provider]").val() == '00'){
			$('#provider99').prop("disabled", true);
		}
		
		$.ajax({
			url: 'searchAnal.do',
			type: 'post',
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				$(function(){
					$(".date").datepicker({
					   dateFormat: 'yy-mm-dd',
					    prevText: '이전 달',
					    nextText: '다음 달',
					    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					    dayNames: ['일','월','화','수','목','금','토'],
					    dayNamesShort: ['일','월','화','수','목','금','토'],
					    dayNamesMin: ['일','월','화','수','목','금','토'],
					    showMonthAfterYear: true,
					    changeMonth: true,
					    changeYear: true,
					    yearSuffix: '년',
					    beforeShowDay: disableSomeDay
					}); 
					
					$( "#dateStart" ).datepicker("setDate" ,'2021-03-22');
						if($("input[name=anal_type]:checked").val() =='passCnt_purpose' 
							|| $("input[name=anal_type]:checked").val() =='passCnt_method'
							|| $("input[name=anal_type]:checked").val() =='passCnt_route'){
							$( "#dateEnd" ).datepicker("setDate" ,'2021-03-22');
						}
					})
						   
					var abledDays = [];
				
					for(var i in data.passSearchList){
						var ymd; 
						
						var y = data.passSearchList[i].opratDate.substr(0,4);
						var m;
						console.log(data.passSearchList[i].opratDate.substr(4,2));
						if(Number(data.passSearchList[i].opratDate.substr(4,2)) < 10){
							m = data.passSearchList[i].opratDate.substr(5,1);
						} else {
							m = data.passSearchList[i].opratDate.substr(4,2);
						}
						var d;
						if(Number(data.passSearchList[i].opratDate.substr(6,2)) < 10){
							d = data.passSearchList[i].opratDate.substr(7,1);
						} else {
							d = data.passSearchList[i].opratDate.substr(6,2);
						}
						
						ymd = y + "-" + m + "-" + d; 
						abledDays.push(ymd);
					}
					
					console.log(abledDays);
					
					function disableSomeDay(date) {
					    var month = date.getMonth();
					    var dates = date.getDate();
					    var year = date.getFullYear();
					    for (i = 0; i < abledDays.length; i++) {
					        if($.inArray(year + '-' +(month+1) + '-' + dates,abledDays) != -1) {
					            return [true];
					        } else{
					        	return [false];
					        }
					    }
					    var noWeekend = jQuery.datepicker.noWeekends(date);
					    return noWeekend[0] ? [true] : noWeekend;
					}
			}
		})
		
		$(".cell3_03").css("opacity", 1);
		$(".cell3_03").find("label").eq(1).css("opacity", 0.3);
		$("input[name=dateStart]").prop("disabled", false);
		
		// 목적통행, 수단통행은 시작~종료일 설정 가능
		if($("input[name=anal_type]:checked").val() =='passCnt_purpose' 
			|| $("input[name=anal_type]:checked").val() =='passCnt_method'
			|| $("input[name=anal_type]:checked").val() =='passCnt_route'){
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
	    
	    $( "#dateStart" ).val('');	
		$( "#dateEnd" ).val('');	
	    
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
		for(var i = 4; i < 6; i++){
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