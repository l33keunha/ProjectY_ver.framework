	
	
	$("#download").on('click',function(){
		$('#downloadSubmitBtn').click();
	})
	
	$("#downloadMatrix").on('click',function(){
		$('#downloadMatrixSubmitBtn').click();
	})
	
	$("#matrix").on('click',function(){
		window.open("" ,"itsme", "toolbar=no, width=1800, height=1000, directories=no, status=no, scrollorbars=no, resizable=no");
		$('#routeODSubmitBtn').click();
	})
	
	$("#graph").on('click',function(){
		window.open("" ,"graph", "toolbar=no, width=1800, height=1000, directories=no, status=no, scrollorbars=no, resizable=no");
		$('#graphSubmitBtn').click();
	})
	
	function closeWin() {
         var nvua = navigator.userAgent;
         if (nvua.indexOf('MSIE') >= 0){
            if(nvua.indexOf('MSIE 5.0') == -1) {
               top.opener = '';
            }
         } else if (nvua.indexOf('Gecko') >= 0){
            top.name = 'CLOSE_WINDOW';
            wid = window.open('','CLOSE_WINDOW');
         }
         top.close();
    }