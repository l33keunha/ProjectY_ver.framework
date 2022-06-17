	// ※ [1] 분석지표 change
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
	
	// ※ [2] 분석유형 change
	$('.cell2').change(function(){
		disabledTrue(3)
		searchAnal()
	})
	
	// ※ [3] 매개변수에 따른 박스오픈
	function selectBoxOpen(jsonArray){
		// 통행분석 선택박스 case 1
		if(jsonArray['anal_type'] == 'passCnt_purpose'
	     || jsonArray['anal_type'] == 'passCnt_method'){
			abledDateStart_End(); 
			disabledFalse(4);
		}
		
		// 통행분석 선택박스 case 2
		if(jsonArray['anal_type'] == 'passCnt_route'
		 ||jsonArray['anal_type'] == 'passCnt_station'
		 || jsonArray['anal_type'] == 'passAreaODCnt_purpose'
		 || jsonArray['anal_type'] == 'passAreaODCnt_method'
		 || jsonArray['anal_group'] == 'passTopRotue'){
			abledDateStart();
			disabledFalse(4);
			
			if(jsonArray['anal_type'] != 'passCnt_route'){
				disabledTime()
			}
		}
		
		// 통행분석 선택박스 case 3
		if(jsonArray['anal_group'] == 'passRouteODCnt'){
			abledDateStart();
			disabledFalse(4);
			
			// 국토부-정산사 재선택시 전에 선택했던 노선박스 비우고 체크박스 해제 + 조회버튼 유효성검사
			$('.search-con').text("");
			$('input:radio[name="routeId"]').prop("checked", false);
			
			$('.cell6').css("opacity", 1);
			$('.cell6_01').css("opacity", 0.3);
			$("input[name=searchpassRoute]").prop("disabled", false);
			$("label[for='modalBtn']").css("cursor","pointer");
			
			 // 노선별OD는 2시간씩만 선택가능하게끔
	         /*$("select[name=tmEnd] option:eq(2)").prop("selected", true);*/
	         var addHtml = "<div style='width: 199px; background:rgb(253 240 240);height: 23px;margin: 10px 0px 0px -16px; text-align:center; border-radius:5px;padding: 4px;'>";
	         addHtml += "<span style='color:red;font-size: 14px;font-weight: bolder;'> ! </span>";
	         addHtml += "<span style='font-size: 10px;'> 노선별OD는 2시간씩 조회가 가능합니다. </span>";
	         addHtml += "</div>";
	         $('.timeNotice').append(addHtml);
			
			// 디폴트 값 설정
			$("select[name=tmEnd]").empty();
			$("select[name=tmEnd]").append("<option value='00'> 00 </option>");
			$("select[name=tmEnd]").append("<option value='01'> 01 </option>");
			$("select[name=tmEnd]").append("<option value='02'> 02 </option>");
			$("select[name=tmEnd] option:last").prop("selected",true);
			
			// tmStart 누를 때마다 tmEnd 2시간 간격으로 변경하기
			$("select[name=tmStart]").on('change',function(){
				var Html = [];
				var value = "";
				var index = $("select[name=tmStart] option").index($("select[name=tmStart] option:selected"));
				if(index == 22){
					for(var i = index; i < index + 2; i++){
						if(i<10){
							value = "0" + i ;
						} else {
							value = i ;
						}
						Html[i] = "<option value="+value+">"+value+"</option>";
					}
				} else if(index == 23){
					for(var i = index; i < index + 1; i++){
						if(i<10){
							value = "0" + i ;
						} else {
							value = i ;
						}
						tml[i] = "<option value="+value+">"+value+"</option>";
					}
				}else {
					for(var i = index; i < index + 3; i++){
						if(i<10){
							value = "0" + i ;
						} else {
							value = i ;
						}
						Html[i] = "<option value="+value+">"+value+"</option>";
					}
				}
				$("select[name=tmEnd]").find("option").remove().end().append(Html);
				$("select[name=tmEnd] option:last").prop("selected",true);
			})
			
		}
		
		// 통행분석 선택박스 case 4 : 상위이용정류장 조회조건 - 서울은 버스,지하철 다르게 표출
		if(jsonArray['anal_group'] == 'passTopStation'){
			abledDateStart();
			disabledFalse(5);
			
			if(jsonArray['anal_area_cd'] == 11){
				$('.cell6').css("opacity", 1);
				$('.cell6_01').css("opacity", 1);
				$('.cell6_02').css("opacity", 0.3);
				$("input[name=tfcmn]").prop("disabled", false);
			} 
		}
	}
	
	
	// ※ [4] 매개변수에 따른 유효성검사
	function validation(jsonArray){
		// 1. 노선별OD 선택 시
		if(jsonArray['anal_group'] == 'passRouteODCnt'){
			$(document).on("change", "input:checkbox[name='cd_no']",function(){
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
		} else if(jsonArray['anal_group'] == 'passTopStation'){
			if(jsonArray['anal_area_cd'] == 11){
				$(document).on("change", "input:checkbox[name='cd_no']",function(){
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
			} else{
				validationCd_no()
			}
		} else{
			validationCd_no()
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
			         document.getElementById("lds-spinner").style.display = "none";

					for(var i in data.passRouteIdList){
						var list = data.passRouteIdList[i];
						
						var addHtml = "";
						
						addHtml += "<div class='routeList'>";
						addHtml += "<div class='routeNm'><input type='radio' value='" + list.routeId + "' name='routeId'><span class='lavel-1'>" + list.routeNma + "</span></div>";
						addHtml += "<div class='routeType'>" + list.routeType + "</div>";
						addHtml += "<div class='routeStart'>" + list.routeStart + "</div>";
						addHtml += "<div class='routeEnd'>" + list.routeEnd + "</div>";
						addHtml += "<input type='hidden' name='tcboId' value='" + list.tcboId + "'</>";
						addHtml += "</div>";
								
						$('.routeLists').append(addHtml);
					}
				}
				
			})	
		}
	})
	
	
	
	// 노선명 말줄임표
	$('.lavel-1').each(function () {
		if (this.offsetWidth < this.scrollWidth)
		    $(this).attr('title', $(this).text());
	});

	
	
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
	
	
	
	
	
	
