/**
 * 
 *//*$(document).ready(function () {

});
*/



//전체 초기화 작업
document.addEventListener("DOMContentLoaded", function(){
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
	
	// 시간대 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
	var size3 = document.getElementsByName('passTime').length;
	
	document.getElementsByName('passTime')[0].checked = false;
	document.getElementsByName('passTime')[0].disabled = true;
	document.getElementsByName('passTime')[0].parentNode.style.opacity = '0.3'
	document.getElementsByName('passTimeStart')[0].disabled = true;
	document.getElementsByName('passTimeEnd')[0].disabled = true;
	
	document.getElementsByName('passTime1')[0].checked = false;
	document.getElementsByName('passTime1')[0].disabled = true;
	document.getElementsByName('passTime1')[0].parentNode.style.opacity = '0.3'
	document.getElementsByName('passTimeStart1')[0].disabled = true;
	document.getElementsByName('passTimeEnd1')[0].disabled = true;
	
	
	// 이용자유형 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
	var size4 = document.getElementsByName('passUserType').length;

	document.getElementsByName('passUserType')[0].disabled = true;
	document.getElementsByName('passUserType1')[0].disabled = true;
	
	
	// 교통수단 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
	var size5 = document.getElementsByName('passTransport').length;
	
	document.getElementsByName('passTransport')[0].disabled = true;
	document.getElementsByName('passTransport1')[0].disabled = true;
	

});


function getElementIndex(element, range) {
  	if (!!range) return [].indexOf.call(element, range);
  	return [].indexOf.call(element.parentNode.children, element);
}



/**
  분석자료
 */
const buttons0 = document.querySelectorAll("input[name=passOwner]")
for ( button0 of buttons0) {

  	button0.addEventListener('click', function(event) {
		// 체크박스 전체 체크해제 (=체크박스 초기화)
		var size = document.getElementsByName('passOwner').length;
		for(i=0;i<size;i++){
			document.getElementsByName('passOwner')[i].checked = false;
		}
		
		// 선택한 체크박스 index 반환
	  	var index = getElementIndex(buttons0, this);
		document.getElementsByName('passOwner')[index].checked = true;
	})
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
		
		// 시간대 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
		var size3 = document.getElementsByName('passTime').length;
		for(i=0;i<2;i++){
			document.getElementsByName('passTime')[0].checked = false;
			document.getElementsByName('passTime')[0].disabled = true;
			document.getElementsByName('passTime')[0].parentNode.style.opacity = '0.3'
			document.getElementsByName('passTimeStart')[0].disabled = true;
			document.getElementsByName('passTimeEnd')[0].disabled = true;
			
			document.getElementsByName('passTime1')[0].checked = false;
			document.getElementsByName('passTime1')[0].disabled = true;
			document.getElementsByName('passTime1')[0].parentNode.style.opacity = '0.3'
			document.getElementsByName('passTimeStart1')[0].disabled = true;
			document.getElementsByName('passTimeEnd1')[0].disabled = true;
		}
		

		// 이용자유형 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
		document.getElementsByName('passUserType')[0].disabled = true;
		document.getElementsByName('passUserType1')[0].disabled = true;
	
		
		// 교통수단 체크박스 전체 체크해제/비활성화 (=체크박스 초기화)
		document.getElementsByName('passTransport')[0].disabled = true;
		document.getElementsByName('passTransport1')[0].disabled = true;
		

	  	// 선택한 체크박스 index 반환
	  	var index = getElementIndex(buttons1, this);
		document.getElementsByName('passGroup')[index].checked = true;
		
		
		//선택한 체크박스의 클래스 찾기
		var className = document.getElementsByName('passGroup')[index].parentNode.parentNode.className
		className = className.split("_");
		className = className[1];

		//분석유형
		//해당 선택한 체크박스 하위 유형 활성화 	
		var size6 =  document.getElementsByClassName('cell4_'+className)[0].getElementsByTagName('input').length;
		for(i=0;i<size6;i++){
			document.getElementsByClassName('cell4_'+className)[0].getElementsByTagName('input')[i].disabled = false;
			document.getElementsByClassName('cell4_'+className)[0].getElementsByTagName('label')[i].style.opacity = '';			
		}
		
		//시간대
		//해당 선택한 체크박스 하위 유형 활성화 	
		//var size7 =  document.getElementsByClassName('cell5_'+className)[0].getElementsByTagName('input').length;
		
		if(className != "03"){
			
			document.getElementsByClassName('cell5_'+className)[0].getElementsByTagName('input')[0].disabled = false;
			document.getElementsByClassName('cell5_'+className)[0].getElementsByTagName('label')[0].style.opacity = '';			
			document.getElementsByClassName('cell5_'+className)[0].getElementsByTagName('select')[0].disabled = false;			
			document.getElementsByClassName('cell5_'+className)[0].getElementsByTagName('select')[1].disabled = false;						
			
			
			//이용자 유형
			//해당 선택한 체크박스 하위 유형 활성화 	
			
			
				document.getElementsByClassName('cell6_'+className)[0].getElementsByTagName('select')[0].disabled = false;								
			
			
			//교통수단 유형
			//해당 선택한 체크박스 하위 유형 활성화 	
			
		
				document.getElementsByClassName('cell7_'+className)[0].getElementsByTagName('select')[0].disabled = false;								
			
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

