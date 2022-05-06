	// 원하는 결과에 따라 맞는 조회조건 활성화
	$(document).ready(function(){
		// 1. 통행량 선택시
		$('.cell1').change(function(){
			disabledTrue(2)
			
			if($("input[name=anal_group]:checked").val()=='dlStation'){
				$('.cell2').css("opacity", 1);
				$('.cell2_01').find('input').prop("disabled",false);
				$('.cell2_01').find('label').css("opacity", 1);
				$('.cell2_02').find('label').css("opacity", 0.3);
				$('.cell2_03').find('label').css("opacity", 0.3);
				
				// 환승&혼잡 지표 하기 전
				$('.cell2_01').find('input').eq(3).prop("disabled",true);
				$('.cell2_01').find('label').eq(3).css("opacity", 0.3);
				$('.cell2_01').find('input').eq(4).prop("disabled",true);
				$('.cell2_01').find('label').eq(4).css("opacity", 0.3);
			} else if($("input[name=anal_group]:checked").val()=='dlRoute'){
				$('.cell2').css("opacity", 1);
				$('.cell2_02').find('input').prop("disabled",false);
				$('.cell2_02').find('label').css("opacity", 1);
				$('.cell2_01').find('label').css("opacity", 0.3);
				$('.cell2_03').find('label').css("opacity", 0.3);
				
				// 환승&혼잡 지표 하기 전
				$('.cell2_02').find('input').eq(2).prop("disabled",true);
				$('.cell2_02').find('label').eq(2).css("opacity", 0.3);
			} else if($("input[name=anal_group]:checked").val()=='dlArea'){
				$('.cell2').css("opacity", 1);
				$('.cell2_03').find('input').prop("disabled",false);
				$('.cell2_03').find('label').css("opacity", 1);
				$('.cell2_01').find('label').css("opacity", 0.3);
				$('.cell2_02').find('label').css("opacity", 0.3);
			} 
		})
	})
	
	$(document).ready(function(){
		$('.cell2').change(function(){
			disabledTrue(3)
			searchAnal()
		})
	})
	
	function selectBoxOpen(jsonArray){
		abledDateStart();
		disabledFalse(4);
		
		$('.submit').prop("disabled",false);
		$('.submit').css("opacity", 1);
		$('.submit').css("cursor", "pointer");
	}