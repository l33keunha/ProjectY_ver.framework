	// [1] 분석지표 change
	$('.cell1').change(function(){
		disabledTrue(2)
		searchAnal()
	})
	
	// 분석지표 및 유형에 따른 선택박스 활성화
	function selectBoxOpen(jsonArray){
		if(jsonArray['anal_group'] == 'timeDistn_avg_day'
	     || jsonArray['anal_group'] == 'timeDistn_avg_purpose'
		 || jsonArray['anal_group'] == 'timeDistn_avg_method'){
			var addHtml = '';
			addHtml += "<label>시작<input class='date' id='dateStart' name='dateStart'></label>";
			addHtml += "<label>종료<input class='date' id='dateEnd' name='dateEnd'></label>";
			$('.cell3_03').append(addHtml);
			disabledFalse(4);
			validationCd_no();
		}
		
		if(jsonArray['anal_group'] == 'timeDistn_avg_route'){
			var addHtml = '';
			addHtml += "<label>날짜<input class='date' id='dateStart' name='dateStart'></label>";
			$('.cell3_03').append(addHtml);
			disabledFalse(4);
			validationCd_no();
		}
	}