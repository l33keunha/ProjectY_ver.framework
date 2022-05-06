	// [1] 분석지표 change
	$('.cell1').change(function(){
		disabledTrue(2)
		searchAnal()
	})
	
	// 분석지표 및 유형에 따른 선택박스 활성화
	function selectBoxOpen(jsonArray){
		var addHtml = '';
		addHtml += "<label>날짜<input class='date' id='dateStart' name='dateStart'></label>";
		$('.cell3_03').append(addHtml);
		abledTime();
		abledBtn();
	}