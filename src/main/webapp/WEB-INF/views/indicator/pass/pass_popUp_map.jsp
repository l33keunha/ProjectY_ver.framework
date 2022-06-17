<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="sVO" value="${sVO}"/>
<c:set var="list" value="${passResultList}"/>
<!DOCTYPE html>
<!-- 
	브이월드 API 2.0 2D 지도 샘플
 -->
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
		<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<script src="http://cdnjs.cloudflare.com/ajax/libs/hammer.js/2.0.8/hammer.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-zoom/1.0.1/chartjs-plugin-zoom.min.js" integrity="sha512-b+q5md1qwYUeYsuOBx+E8MzhsDSZeoE80dPP1VCw9k/KA9LORQmaH3RuXjlpu3u1rfUwh7s6SHthZM3sUGzCkA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/hammer.js/2.0.8/hammer.min.js" integrity="sha512-UXumZrZNiOwnTcZSHLOfcTs0aos2MzBWHXOHOuB0J/R44QB0dwY5JgfbvljXcklVf65Gc4El6RjZ+lnwd2az2g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<link rel="stylesheet" type="text/css" href="resources/css/indicator/chart_popUp.css">
	
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>상위이용정류장 버스정류장 위치</title>
		<script type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=7D1285BF-31DC-3DD8-A3E3-86D92C9568E8&domain=localhost:8080"></script>
	</head>
	
	<body>
	 	<!-- 버스정류장 위치 모달창 -->
		
        <div style=" text-align: center; margin : 7px; font-weight: bolder;">
			정류장명 : <span id="bus_name"></span>
        </div>
      
		<!-- 지도가 그려지는 영역 조정 -->
		<div id="vmap" style="width:100%;height:100%;left:0px;top:0px"></div>
	
	
	</body>
</html>

	
		<script>
		
		
			var bus_x = "${param.bus_x}";
			var bus_y = "${param.bus_y}";
			
			var xy = convertCoordinates(bus_x,bus_y);
	
			var bus_title = ""; 
			var bus_contents = ""; 
			
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
			  , homePosition: vw.ol3.CameraPosition = {
					center : xy,
					zoom : 16
				}
			  , initPosition: vw.ol3.CameraPosition
			}; 
			
			let vmap = new vw.ol3.Map("vmap",  vw.ol3.MapOptions); 
			let markerLayer;
		
			 
			function move(x,y,z){
			   var _center = [ x, y ];
			   
			   var z = z;
			   var pan = ol.animation.pan({
			    duration : 2000,
			    source : (vmap.getView().getCenter())
			   });
			   vmap.beforeRender(pan);
			  
			   //vmap.getView().setCenter(_center);
			   vmap.getView().setCenter(ol.proj.transform(_center,'EPSG:4326', "EPSG:900913")); // 지도 이동
			   
			   setTimeout("fnMoveZoom()", 3000);
			}
			  
			function fnMoveZoom() {
			   zoom = vmap.getView().getZoom();
			   if (16 > zoom) {
			    vmap.getView().setZoom(16);
			   }
			  
			};
			
			// EPSG 4326 경위도 값을 EPSG 3857 좌표계로 변환 함.
			function convertCoordinates(lon, lat) {
				var x = (lon * 20037508.34) / 180;
				var y = Math.log(Math.tan(((90 + lat) * Math.PI) / 360)) / (Math.PI / 180);
				y = (y * 20037508.34) / 180;
				return [x, y];
			}
			
			
			function addMarkerLayer(x, y, tfcmn, sttnNma, sttnHjd){

				//마커 레이어 생성
				markerLayer = new vw.ol3.layer.Marker(vmap); 
				
				if(tfcmn == "B"){
					tfcmn = '<%=request.getContextPath()%>/resources/images/indicator/bus01.png';
				
				}else if (tfcmn == "T"){
					tfcmn = '<%=request.getContextPath()%>/resources/images/indicator/train01.png';
				
				}else if(tfcmn == "Bchoice"){
					tfcmn = '<%=request.getContextPath()%>/resources/images/indicator/marker.png';
				
				}else if (tfcmn == "Tchoice"){
					tfcmn = '<%=request.getContextPath()%>/resources/images/indicator/marker.png';
				
				}
				
				//마커 옵션 설정
				vw.ol3.markerOption = { 
					x : x,
					y : y,
					epsg : "EPSG:4326",
					title : sttnNma,
					contents : sttnHjd,
					iconUrl : tfcmn
				
				}; 
	
				// 마커를 레이어에 등록
				markerLayer.addMarker(vw.ol3.markerOption);
				
				
				//마커를 vmap에 등록
				vmap.addLayer(markerLayer) 
				
			}
			

			function markerChoice(x, y, tfcmn, sttnNma, sttnHjd) {
			
				x = parseFloat(x);
				y = parseFloat(y) + 0.00006;
				
				//마커레이어 초기화 
				markerLayer.getSource().clear();
				
				//마커레이어 추가 
				addMarkerLayer(x, y, tfcmn, sttnNma, sttnHjd);
				
				//지도 확대
				move(x,y);
				
				$("#bus_name").text(sttnNma);
			
			};
			
			//지도에 마커 데이터 매핑하기
			var jsonStringParam = decodeURIComponent("${param.dataList}");
			var arr = JSON.parse(jsonStringParam);
			
			for(var i=0; i<arr.length; i++){
				addMarkerLayer(arr[i].x, arr[i].y, arr[i].tfcmn, arr[i].sttnNma, arr[i].sttnHjd);
			}
			
			
			window.onload = function () {
			  	opener.popup = this;  //자식 창이 뜰때 opener에 popup이라는 변수에 this를 지정해주며, 부모창에서 'popup'으로 자식창의 함수를 호출함.
			  	markerChoice("${param.bus_x}", "${param.bus_y}", "${param.bus_tfcmn}"+"choice", "${param.bus_sttnNma}", "${param.bus_sttnHjd}");
			  
			}
			
			function modalClose(){
				$("#modal-content").removeClass('active');
				$("#modal-content").attr("style","display:none");
			}
		
	    </script>   