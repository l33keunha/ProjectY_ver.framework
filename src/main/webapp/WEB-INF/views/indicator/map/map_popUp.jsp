<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=7D1285BF-31DC-3DD8-A3E3-86D92C9568E8&domain=localhost:8080"></script>
	
</head>
<body>


	<div id="vmap" style="width:100%;height:100%;left:0px;top:0px"></div>
	<!-- 지도가 그려지는 영역 조정 -->
	
	
	
</body>


	<script type="text/javascript">
	
		window.onload = function () {
		  	opener.popup = this;  
		}

		//vworld 로고 지우기
		vw.ol3.Map.prototype._createNotice = function(){
			var element = document.createElement('div');
			element.style.display= "none";    
			var _noticeControl = _noticeControl = new ol.control.Control({element: element});  
			return _noticeControl;
		}
		
		//vworld 로고 지우기
		vw.ol3.Map.prototype._createLogo = function(){
			var element = document.createElement('div');
			element.style.display= "none";    
			var _noticeControl = _noticeControl = new ol.control.Control({element: element});  
			return _noticeControl;
		} 
		
		
		vw.ol3.MapOptions = {
		    basemapType: vw.ol3.BasemapType.GRAPHIC
		  , controlDensity: vw.ol3.DensityType.EMPTY
		  , interactionDensity: vw.ol3.DensityType.BASIC
		  , controlsAutoArrange: true
		  , homePosition: vw.ol3.CameraPosition
		  , initPosition: vw.ol3.CameraPosition
		}; 
		let vmap = new vw.ol3.Map("vmap",  vw.ol3.MapOptions); //div id = vmap 영역에 지도 생성
		
		// EPSG 4326 경위도 값을 EPSG 3857 좌표계로 변환 함.
		function convertCoordinates(lon, lat) {
			var x = (lon * 20037508.34) / 180;
			var y = Math.log(Math.tan(((90 + lat) * Math.PI) / 360)) / (Math.PI / 180);
			y = (y * 20037508.34) / 180;
			return [x, y];
		}
		
		
		
		let markerLayer = new vw.ol3.layer.Marker(vmap); 
		//마커 레이어 생성

		vw.ol3.markerOption = {
			x : parseFloat((126.920690 * 20037508.34) / 180),
			y : parseFloat((Math.log(Math.tan(((90 + 37.475919) * Math.PI) / 360)) / (Math.PI / 180))* 20037508.34)/180,
			epsg : "EPSG:900913",
			title : '당신네집',
			contents : '테스트마커2 본문내용<br>테스트마커2 본문내용',
			iconUrl : 'http://map.vworld.kr/images/ol3/marker_blue.png'
		}; //마커 옵션 설정

		markerLayer.addMarker(vw.ol3.markerOption);// 마커를 레이어에 등록
		vmap.addLayer(markerLayer) //마커를 vmap에 등록
		
		
	</script>
	
	
</html>