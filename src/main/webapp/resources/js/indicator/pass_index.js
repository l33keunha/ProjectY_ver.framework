	// [1] 분석지표 change
	$('.cell1').change(function(){
		disabledTrue(2)
		
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
	
	// [2] 분석유형 change
	$('.cell2').change(function(){
		disabledTrue(3)
		searchAnal()
	})
	
	// 분석지표 및 유형에 따른 선택박스 활성화
	function selectBoxOpen(jsonArray){
		// 통행분석 선택박스 case 1
		if(jsonArray['anal_type'] == 'passCnt_purpose'
	     || jsonArray['anal_type'] == 'passCnt_method'){
			var addHtml = '';
			addHtml += "<label>시작<input class='date' id='dateStart' name='dateStart'></label>";
			addHtml += "<label>종료<input class='date' id='dateEnd' name='dateEnd'></label>";
			$('.cell3_03').append(addHtml);
			disabledFalse(4);
			validationCd_no();
		}
		
		// 통행분석 선택박스 case 2
		if(jsonArray['anal_type'] == 'passCnt_route'
		 ||jsonArray['anal_type'] == 'passCnt_station'
		 || jsonArray['anal_type'] == 'passAreaODCnt_purpose'
		 || jsonArray['anal_type'] == 'passAreaODCnt_method'
		 || jsonArray['anal_group'] == 'passTopRotue'){
			var addHtml = '';
			addHtml += "<label>날짜<input class='date' id='dateStart' name='dateStart'></label>";
			$('.cell3_03').append(addHtml);
			
			disabledFalse(5);
			validationCd_no();
			
		}
		
		// 통행분석 선택박스 case 4 : 상위이용정류장 조회조건 - 서울은 버스,지하철 다르게 표출
		if(jsonArray['anal_group'] == 'passTopStation'){
			var addHtml = '';
			addHtml += "<label>날짜<input class='date' id='dateStart' name='dateStart'></label>";
			$('.cell3_03').append(addHtml);
			
			disabledFalse(5);
			
			if(jsonArray['anal_area_cd'] == 11){
				$('.cell6').css("opacity", 1);
				$('.cell6_01').css("opacity", 1);
				$('.cell6_02').css("opacity", 0.3);
				$("input[name=tfcmn]").prop("disabled", false);
				
				// 유효성검사 2. 서울일 경우, 교통수단도 선택해야 조회가능
				$('input:checkbox[name="cd_no"]').change(function(){
					if($('input:checkbox[name="cd_no"]').is(":checked") ==  true
					  && $('input:radio[name="tfcmn"]').is(":checked") ==  true){
						$('.submit').prop("disabled",false);
						$('.submit').css("opacity", 1);
						$('.submit').css("cursor", "pointer");
					} else{
						$('.submit').prop("disabled",true);
						$('.submit').css("opacity", 0.3);
						$('.submit').css("cursor", "auto");
					}
				})
				$('input:radio[name="tfcmn"]').change(function(){
					if($('input:checkbox[name="cd_no"]').is(":checked") ==  true
					  && $('input:radio[name="tfcmn"]').is(":checked") ==  true){
						$('.submit').prop("disabled",false);
						$('.submit').css("opacity", 1);
						$('.submit').css("cursor", "pointer");
					} else{
						$('.submit').prop("disabled",true);
						$('.submit').css("opacity", 0.3);
						$('.submit').css("cursor", "auto");
					}
				})
			} else {
				validationCd_no();
			}
			
		}
			
			
		
		// 통행분석 선택박스 case 3
		if(jsonArray['anal_group'] == 'passRouteODCnt'){
			var addHtml = '';
			addHtml += "<label>날짜<input class='date' id='dateStart' name='dateStart'></label>";
			$('.cell3_03').append(addHtml);
			
			disabledFalse(4);
			
			$('.cell6').css("opacity", 1);
			$('.cell6_01').css("opacity", 0.3);
			$("input[name=searchpassRoute]").prop("disabled", false);
			$("label[for='modalBtn']").css("cursor","pointer");
			
			// 유효성검사 3. 노선번호 선택해야 조회가능
			$('input:checkbox[name="cd_no"]').change(function(){
				if($('input:checkbox[name="cd_no"]').is(":checked") ==  true
				  && $('input:radio[name="routeId"]').is(":checked") ==  true){
					$('.submit').prop("disabled",false);
					$('.submit').css("opacity", 1);
					$('.submit').css("cursor", "pointer");
				} else{
					$('.submit').prop("disabled",true);
					$('.submit').css("opacity", 0.3);
					$('.submit').css("cursor", "auto");
				}
			})
			$('#routeBtn').click(function(){
				if($('input:checkbox[name="cd_no"]').is(":checked") ==  true
				  && $('input:radio[name="routeId"]').is(":checked") ==  true){
					$('.submit').prop("disabled",false);
					$('.submit').css("opacity", 1);
					$('.submit').css("cursor", "pointer");
				} else{
					$('.submit').prop("disabled",true);
					$('.submit').css("opacity", 0.3);
					$('.submit').css("cursor", "auto");
				}
			})
			
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
	}
	
	/* 노선번호 검색 선택 */
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
	