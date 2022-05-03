	// [1] 분석지표 change
	$('.cell1').change(function(){
		disabledTrue(2)
		
		if($("input[name=anal_group]:checked").val()=='transferCnt'){
			$('.cell2').css("opacity", 1);
			$('.cell2_01').find('input').prop("disabled",false);
			$('.cell2_01').find('label').css("opacity", 1);
			$('.cell2_02').find('label').css("opacity", 0.3);
			$('.cell2_03').find('label').css("opacity", 0.3);
		} else if($("input[name=anal_group]:checked").val()=='transferTime'){
			$('.cell2').css("opacity", 1);
			$('.cell2_02').find('input').prop("disabled",false);
			$('.cell2_02').find('label').css("opacity", 1);
			$('.cell2_01').find('label').css("opacity", 0.3);
			$('.cell2_03').find('label').css("opacity", 0.3);
		} else if($("input[name=anal_group]:checked").val()=='transferDist'){
			$('.cell2').css("opacity", 1);
			$('.cell2_03').find('input').prop("disabled",false);
			$('.cell2_03').find('label').css("opacity", 1);
			$('.cell2_01').find('label').css("opacity", 0.3);
			$('.cell2_02').find('label').css("opacity", 0.3);
		} 
		
	})
	
	// [2] 분석유형 change
	$('.cell2').change(function(){
		disabledTrue(3)
		searchAnal()
	})
	
	// 분석지표 및 유형에 따른 선택박스 활성화
	function selectBoxOpen(jsonArray){
		// 환승분석 선택박스 case 1
		if(jsonArray['anal_type'] == 'transferCnt_method'
	     || jsonArray['anal_type'] == 'transferCnt_route'
		 || jsonArray['anal_type'] == 'transferCnt_num'
	     || jsonArray['anal_type'] == 'transferTime_method'
         || jsonArray['anal_type'] == 'transferTime_num'
	  	 || jsonArray['anal_type'] == 'transferDist_methjod'
		 || jsonArray['anal_type'] == 'transferDist_num'){
			var addHtml = '';
			addHtml += "<label>시작<input class='date' id='dateStart' name='dateStart'></label>";
			addHtml += "<label>종료<input class='date' id='dateEnd' name='dateEnd'></label>";
			$('.cell3_03').append(addHtml);
			disabledFalse(4);
			validationCd_no();
		}
		
		// 환승분석 선택박스 case 2
		if(jsonArray['anal_type'] == 'transferCnt_station'){
			var addHtml = '';
			addHtml += "<label>날짜<input class='date' id='dateStart' name='dateStart'></label>";
			$('.cell3_03').append(addHtml);
			
			disabledFalse(5);
			validationCd_no();
		}
	}
	