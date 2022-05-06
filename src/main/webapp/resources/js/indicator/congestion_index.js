	// [1] 분석지표 change
	$('.cell1').change(function(){
		disabledTrue(2)
		searchAnal()
	})
	
	// 분석지표 및 유형에 따른 선택박스 활성화
	function selectBoxOpen(jsonArray){
		abledDateStart();
		abledTime();
		abledBtn();
	}