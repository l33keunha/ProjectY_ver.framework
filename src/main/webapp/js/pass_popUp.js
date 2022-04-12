//검색상자 활성화 
var showHiddenDivClass = {
	
	//통행량
	"passCnt_purpose" : "hcell2",	//목적통행
	"passCnt_method" : "hcell1", 	//수단통행
	"passCnt_route" : "hcell1", 	//노선별통행
	"passCnt_station" : "hcell1",	//정류장별통행
	
	//기종점통행량
	"passODCnt_station_purpose" : "hcell2",	//정류장별목적통행
	"passODCnt_station_method" : "hcell2",	//정류장별수단통행
	"passODCnt_dong_purpose" : "hcell2",	//행정동별목적통행
	"passODCnt_dong_method" : "hcell2",		//행정동별수단통행	
	
	//기타
	"passEtc_max_route" : "hcell3",		//최다이용노선
	"passEtc_max_station" :	"hcell3"	//최다이용정류장
	
}


$(document).ready(function () {
		// 분석지표 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
		/*var size1 = document.getElementsByName('passGroup').length;
		for(i=0;i<size1;i++){
			document.getElementsByName('passGroup')[i].checked = false;
			document.getElementsByName('passGroup')[i].disabled = true;
			document.getElementsByName('passGroup')[i].parentNode.style.opacity = '0.3'
		}*/
		
		// 분석유형 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
		var size2 = document.getElementsByName('passType').length;
		for(i=0;i<size2;i++){
			document.getElementsByName('passType')[i].checked = false;
			document.getElementsByName('passType')[i].disabled = true;
			document.getElementsByName('passType')[i].parentNode.style.opacity = '0.3'
		}
		
		//선택박스 초기화
		$('[class=hcell1],[class=hcell2],[class=hcell3]').attr('style', 'display:none');
	
});




/**
  조회 버튼 테스트
 */
$('input[id=buttonTest]').on('click', function () {
	
	var pushArray = [
				[ "passDateStart", 	$("input[name=passDateStart]")[0].value],
				[ "passDateEnd", 	$("input[name=passDateEnd]")[0].value],
				[ "passOwner", 		$("input[name=passOwner]:checked")[0].value],
				[ "passSido",  		$("#PassSido").val()],
				[ "passSigungu", 	$("#PassSigungu").val()],
				[ "passGroup", 		$("input[name=passGroup]:checked")[0].value],
				[ "passType", 		$("input[name=passType]:checked")[0].value],
				[ "passTimeStart", 	$("[name=passTimeStart]").val()],
				[ "passTimeEnd", 	$("[name=passTimeEnd]").val()]
	];
	
	var checkType =  $("input[name=passType]:checked")[0].value;	//분석유형 체크값
	var classType = showHiddenDivClass[checkType];					//분석유형의 해당 클래스값

	//해당 체크된 엘리먼트의 이름과 값을 배열에 넣어준다.
	$("[class="+classType+"]").find("input:checked").each(function(index, item){
		pushArray.push([ $(item)[0].name, $(item)[0].value ] )
	})
	
	
	
	window.open("" ,"newForm", "toolbar=no, width=540, height=467, directories=no, status=no, scrollorbars=no, resizable=no"); 
	
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

/** 
  공통함수 - 선택한 체크박스 index 반환 함수
*/
function getElementIndex(element, range) {
  	if (!!range) return [].indexOf.call(element, range);
  	return [].indexOf.call(element.parentNode.children, element);
}



/**
  분석지표
 */
const buttons1 = document.querySelectorAll("input[name=passGroup]")
for ( button1 of buttons1) {
  button1.addEventListener('click', function(event) {
	
		// 체크박스 전체 체크해제 (=체크박스 초기화)
		var size1 = document.getElementsByName('passGroup').length;
		for(i=0;i<size1;i++){
			document.getElementsByName('passGroup')[i].checked = false;
		}
		
		// 분석유형 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
		var size2 = document.getElementsByName('passType').length;
		for(i=0;i<size2;i++){
			document.getElementsByName('passType')[i].checked = false;
			document.getElementsByName('passType')[i].disabled = true;
			document.getElementsByName('passType')[i].parentNode.style.opacity = '0.3'
		}
		
	  	// 선택한 체크박스 index 반환
	  	var index = getElementIndex(buttons1, this);
		document.getElementsByName('passGroup')[index].checked = true;
		
		//선택한 체크박스의 클래스 찾기
		var className = document.getElementsByName('passGroup')[index].parentNode.parentNode.parentNode.className
		className = className.split("_");
		className = className[1];

		//분석유형
		//해당 선택한 체크박스 하위 유형 활성화 	
		var size6 =  document.getElementsByClassName('cell4_'+className)[0].getElementsByTagName('input').length;
		for(i=0;i<size6;i++){
			document.getElementsByClassName('cell4_'+className)[0].getElementsByTagName('input')[i].disabled = false;
			document.getElementsByClassName('cell4_'+className)[0].getElementsByTagName('label')[i].style.opacity = '';			
		}
	
  })
}




/**
  분석유형
 */
const buttons2 = document.querySelectorAll("input[name=passType]")
for ( button2 of buttons2) {

  	button2.addEventListener('click', function(event) {
		// 체크박스 전체 체크해제 (=체크박스 초기화)
		var size = document.getElementsByName('passType').length;
		for(i=0;i<size;i++){
			document.getElementsByName('passType')[i].checked = false;
		}
		
		// 선택한 체크박스 index 반환
	  	var index = getElementIndex(buttons2, this);
		document.getElementsByName('passType')[index].checked = true;
	})
}

/**
  분석유형 선택시, 해당 검색박스 활성화
 */
$('input[name=passType]').on('change', function () {
    if ($(this).is(':checked')) {
        
        //선택박스 초기화
		$('[class=hcell1],[class=hcell2],[class=hcell3]').attr('style', 'display:none');
	
		var checkValue = $(this).val();
		var className = showHiddenDivClass[checkValue];
		$('[class='+className+']').attr('style', '');
		
    } else {
        console.log($(this).val() + ' is now unchecked');
    }
});


