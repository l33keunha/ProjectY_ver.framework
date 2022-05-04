	// [ 1 ] 페이지 로드 시 비활성화로 시작
	window.onload = function(){
		disabledTrue(2)
	}
	// [ --1 ]
	
	// [ 2 ] 값 받아서 다시 form에 담아 url에 보내줌
	$('.submit').on('click', function () {
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
		
		console.log($(this).attr('id'));
		if($(this).attr('id') == 'passBtn'){
			newForm.attr("action","passTest.do"); 
		} else if ($(this).attr('id') == 'downloadBtn'){
			pushArray.splice(4,2);
			newForm.attr("action","downloadTest.do");
		} else if($(this).attr('id') == 'transferBtn'){
			newForm.attr("action","transferTest.do");
		}
		
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
	// [ --2 ]
	
	// [ 3 ] Ajax-cell3
	var jsonArray = {};
	// [ 3-1 ] Cell3 지역하기 첫 조건 : 1. 시/도 활성화 2. 시/도 리스트를 가져옴 
	function searchAnal(){
		$("[class=selectbox]").find("input:checked").each(function(index, item){
		jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		
		$("select[name=anal_area_cd_sido]").prop("disabled", false);
		$(".cell3").css("opacity", 1); $(".cell3_02").css("opacity", 0.3); $(".cell3_03").css("opacity", 0.3);
		$.ajax({
			url: 'searchAnal.do',
			type: "post",
			traditional: true,
			data: jsonArray,
			dataType: "json",
			success: function (data){
				for(var i in data.passSearchList){
					$("select[name=anal_area_cd_sido]").append("<option value='" + data.passSearchList[i].analAreaCdSido + "'>" 
																+ data.passSearchList[i].analAreaNm + "</option>");
				}
			}
		})
	}
	
	// [ 3-2 ] 시/도를 다시 선택하고 싶은 경우 : 1. cell2_01~ 초기화 2. cell2_02~ 비활성화 3. 시/군 리스트를 가져옴  
	$("select[name=anal_area_cd_sido]").change(function(){
		$("[class=selectbox]").find("input:checked").each(function(index, item){
		jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = "null";
		jsonArray["provider"] = "null";
		
		selectAreaCdSido()
		
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
	
	// [ 3-3 ] 시/군을 다시 선택하고 싶은 경우 : 1. cell2_02~ 초기화 2. cell2_03~ 비활성화 3. 정산사 리스트를 가져옴
	$("select[name=anal_area_cd]").change(function(){
		$("[class=selectbox]").find("input:checked").each(function(index, item){
		jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = $("select[name=anal_area_cd]").val();
		jsonArray["provider"] = "null";
		
		selectAreaCd()
		
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
	
	// [ 3-4 ] 정산사 다시 선택하고 싶은 경우 : 1. 날짜 활성화 2. anal_fin에 따른 선택박스 오픈
	$("input[name=provider]").change(function(){
		$("[class=selectbox]").find("input:checked").each(function(index, item){
		jsonArray[$(item)[0].name] = $(item)[0].value;
		})
		
		jsonArray["anal_area_cd_sido"] = $("select[name=anal_area_cd_sido]").val();
		jsonArray["anal_area_cd"] = $("select[name=anal_area_cd]").val();
		
		selectProvider()
		
		$.ajax({
				url: 'searchAnal.do',
				type: 'post',
				traditional: true,
				data: jsonArray,
				dataType: "json",
				success: function (data){
					selectBoxOpen(jsonArray)
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
							beforeShowDay: disableSomeDay
						})
						
						// 운행일자 ~ 유효일자 사이 날짜 나열
						function getDateRange(startDate, endDate, listDate){
					        var dateMove = new Date(startDate);
					        var strDate = startDate;
					        if (startDate == endDate){
					            var strDate = dateMove.toISOString().slice(0,10);
					            listDate.push(strDate);
						        }else{
						            while (strDate < endDate){
					                var strDate = dateMove.toISOString().slice(0, 10);
					                listDate.push(strDate);
					                dateMove.setDate(dateMove.getDate() + 1);
						            }
						        }
					        return listDate;
					    }
	
						// (yyyy-mm-dd) 형식으로 변환
						var listDate = [];
						var startDate;
						var endDate;
						
						for( var i in data.passSearchList){
							startDate = data.passSearchList[i].opratDate.substr(0,4) + '-' 
							  			  + data.passSearchList[i].opratDate.substr(4,2) + '-'
						                  + data.passSearchList[i].opratDate.substr(6,2);
							endDate   = data.passSearchList[i].sdate.substr(0,4) + '-' 
							  			  + data.passSearchList[i].sdate.substr(4,2) + '-'
						                  + data.passSearchList[i].sdate.substr(6,2);
							getDateRange(startDate, endDate, listDate);
						}
						
						// 0 제거 형식으로 변환
						var abledDays = [];
						
						for(var i in listDate){
							ymd = listDate[i].substr(0,4)
								+ "-" 
								+ Number(listDate[i].substr(5,2))
								+ "-" 
								+ Number(listDate[i].substr(8,2)); 
							abledDays.push(ymd);
						}
						
						// 유효한 날짜만 선택가능하게
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
					$('.date').datepicker("setDate",'2021-3-22');					
				})
			}
		})
	})
	
	
	
	
	
	
	
	// [4] 활성화/비활성화 모음
	
	/* 
		선택박스 비활성화
		num 2 : cell2~ 비활성화 및 초기화 (새로고침 or 분석지표 값이 바뀔 때)
	*/
	function disabledTrue(num){
		for(var i = num; i < 7; i ++){
			$(".cell" + [i]).css("opacity", 1); $(".cell" + [i]).css("opacity", 0.3);
			$(".cell" + [i]).find('input').prop("disabled", true);
			$(".cell" + [i]).find('input').prop("checked", false);
			$(".cell" + [i]).find('select').prop("disabled", true);
			$(".cell" + [i]).find('select option:selected').prop("selected", false);
		}
		
		$('.cell3_03').find('label').remove();
		$(".search-con").children().remove();
		
		$('.submit').prop("disabled",true);
		$('.submit').css("opacity", 0.3);
		$('.submit').css("cursor", "auto");
		
		if(num == 2 || num ==3){
			$("select[name=anal_area_cd_sido]").children('option:not(:first)').remove();
		    jsonArray["anal_area_cd_sido"] = "null";
		    jsonArray["anal_area_cd"] = "null"; 
	    	jsonArray["anal_type"] = "null"; 
		}
	}
	
	/* 시/도를 선택한 경우 */
	function selectAreaCdSido(){
		// 시/군 활성화 및 초기화
		$("select[name=anal_area_cd]").prop("disabled", false);
		$("select[name=anal_area_cd]").children('option:not(:first)').remove();
		
		// 자료 비활성화 및 초기화
		$(".cell3_02").css("opacity", 1); $(".cell3_02").css("opacity", 0.3);
		$("input[name=provider]").prop("disabled", true);
		$("input[name=provider]").prop("checked", false);
		
		// 날짜 비활성화 및 초기화
		disabledTrueDate()
	}
	/* 시/군을 선택한 경우 */
	function selectAreaCd(){
		// 자료 활성화
		$(".cell3_02").css("opacity", 1);
		$("input[name=provider]").prop("checked", false);
		$("input[name=provider]").prop("disabled", false);
		
		// 날짜 비활성화 및 초기화
		disabledTrueDate()
	}
	/* 자료 선택한 경우 */
	function selectProvider(){
		// 날짜 활성화
		$(".cell3_03").css("opacity", 1); 
		$("input[name=dateStart]").prop("disabled", false); 
		$("input[name=dateEnd]").prop("disabled", false); 
	}
	
	/* 날짜 비활성화 및 이후 초기화 */
	function disabledTrueDate(){
		$(".cell3_03").css("opacity", 1); $(".cell3_03").css("opacity", 0.3);
		disabledTrue(4);
	}
	
	/* 선택박스 오픈 */
	function disabledFalse(num){
		for(var i = num; i < 6; i ++){
			$(".cell" + [i]).css("opacity", 1); 
			$(".cell" + [i]).find('input').prop("disabled", false);
			$(".cell" + [i]).find('select').prop("disabled", false);
		}
	}
	
	
	/* 공통 */
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
	
	// 시간대 비활성화
		function disabledTime(){
			$(".cell4").css("opacity", 0.3); 
			$(".cell4").find('input').prop("disabled", true);
			$(".cell4").find('input').prop("checked", true);
			$(".cell4").find('select').prop("disabled", true);
		}
		
		
	// [--4]
	
	// [5] 유효성 검사
	function validationCd_no(){
		// 유효성검사 1 . 이용자유형만 선택하면 조회가능
		$('input:checkbox[name="cd_no"]').change(function(){
			if($('input:checkbox[name="cd_no"]').is(":checked") ==  true){
				$('.submit').prop("disabled",false);
				$('.submit').css("opacity", 1);
				$('.submit').css("cursor", "pointer");
			}else if($('input:checkbox[name="cd_no"]').is(":checked") ==  false){
				$('.submit').prop("disabled",true);
				$('.submit').css("opacity", 0.3);
				$('.submit').css("cursor", "auto");
			}
		})
	}