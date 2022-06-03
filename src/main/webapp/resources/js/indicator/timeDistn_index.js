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
			abledDateStart_End();
			disabledFalse(4);
			validationCd_no();
			
			if(jsonArray['anal_group'] == 'timeDistn_avg_day'){
				disabledTime()
			}
			
		}
		
		if(jsonArray['anal_group'] == 'timeDistn_avg_route'){
			abledDateStart();
			disabledFalse(4);
			validationCd_no();
		}
	}