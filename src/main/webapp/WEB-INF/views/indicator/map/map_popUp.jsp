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
		  , homePosition: vw.ol3.CameraPosition ={
				  center : convertCoordinates(126.920690, 37.475919),
				  zoom : 13
		  }
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
		
		
		//마커 레이어 생성
		let markerLayer = new vw.ol3.layer.Marker(vmap); 

		vw.ol3.markerOption = {
			x : parseFloat((126.920690 * 20037508.34) / 180),
			y : parseFloat((Math.log(Math.tan(((90 + 37.475919) * Math.PI) / 360)) / (Math.PI / 180))* 20037508.34)/180,
			epsg : "EPSG:900913",
			title : 'this',
			contents : '테스트마커2 본문내용<br>테스트마커2 본문내용',
			iconUrl : 'http://map.vworld.kr/images/ol3/marker_blue.png'
		}; //마커 옵션 설정

		markerLayer.addMarker(vw.ol3.markerOption);			// 마커를 레이어에 등록
		vmap.addLayer(markerLayer) 							// 레이어를 vmap에 등록
		
		
		
		
		
		/* shp파일 띄워보기 */
		// 맵 생성 후, 콜백
    	vw.ws3dInitCallBack = function () {
        // geojson 표현 스타일
		let opt = [
			 {material: new vw.Color(0, 0, 154).ws3dColor.withAlpha(0.3)}
		];
        
        // 불러올 geojson 
        [
            "resources/geojson/NODE.json",
        ].forEach((v, i) => {
            geojson(v, opt[i] !== void 0 ? opt[i] : void 0);
        });
		
        
        
		
        /**
         * @param url - 파일 경로
         * @param opt - geojson 표현 방법
         */
        function geojson(url, opt) {

            // parser 설명.
            var parser = new vw.GMLParser();
            // 아이디 지정. --> parser에 지정이 되면, Feature객체에게도 상속 "sample-0,1,..." 형태로 아이디가 부여됩니다.
            parser.setId(url);
            //var featureInfos = parser.readTemp(vw.GMLParserType.GEOJSON, url, "EPSG:900913");
            // data 읽기. parser.read( 데이터타입, 데이터경로, 데이터좌표계)
            // 전달되는 좌표계를 의미하며, 이 좌표를 웹지엘에서는 EPSG:4326으로 변환하여 사용합니다.
            // 데이터타입. vw.GMLParserType { GEOJSON, GML1, GML2, GML2 }
            var featureInfos = parser.read(vw.GMLParserType.GEOJSON, url, "EPSG:4326");

            console.log("featureInfos :", featureInfos);
            var option = {
                isTerrain: true,      // 지형 따라 출력시 true, 지면에서 위로 출력시 false
                width: 10,         // 선의 경우 크기지정.
                material: new vw.Color(Math.floor(Math.random() * 255), Math.floor(Math.random() * 255), Math.floor(Math.random() * 255)).ws3dColor.withAlpha(0.1),  // RGBA A값만 255이하로 주면 투명 또는 withAlpha(1.0~0.1)로 설정.
                // material: new vw.Color(0, 0, 128).ws3dColor.withAlpha(1),  // RGBA A값만 255이하로 주면 투명 또는 withAlpha(1.0~0.1)로 설정.
                outline: true,         // 아웃라인지정시 true, 아웃라인 미지정 false 지형 결합 시 라인이 생성되지않음
                outlineWidth: 5,       // 아웃라인 너비.
                outlineColor: vw.Color.YELLOW.ws3dColor,       // 아웃라인 색상.
                height: 1.0         // 높이 지정값 meter.
            };
            var options = {...option, ...opt};

            // 출력 색상등 지정.
            featureInfos.setOption(options);

            const promise = new Promise((resolve, reject) => {
                featureInfos.makeCoords();
                resolve('promise');
            });

            promise.then((value) => {
                // console.log(value);
                var result = "";
                featureInfos.objCollection.collectionProp.forEach(function (i) { // objCollection.collectionProp 객체의 속성 값을 가지고 있음
                    // console.log(i);
                    result += i.properties.SIG_KOR_NM + " "
                    $("#features").html(result);
                })
            });

            var selFeature = null;
            // 이벤트
            var featureEventHandler = function (windowPosition, ecefPosition, cartographic, featureInfo) {
                //ws3d.viewer.map.clearAllHighlightedFeatures();
                //featureInfo 가 존재 -> 3D 객체 클릭
                //onsole.log("featureInfo :" , windowPosition, ecefPosition, cartographic, featureInfo);
                if (featureInfo) {
                    var feature = featureInfos.getById(featureInfo.groupId);
                    // console.log("after feature :", featureInfos.objCollection);
                    console.log("feature :", feature);
                    // 그래픽객체 미출력
                    // feature.hide();
                    // FeatureInfo 객체 삭제1.
                    //featureInfos.removeById(feature.id);
                    // FeatureInfo 객체 삭제2.
                    // featureInfos.removeByObj(feature);
                    // feature 정보를 가지고 있는 properties
                    console.log("feature properties:" , feature.getProperties());
                    // console.log("after feature :", featureInfos.objCollection);

                    // 이전 선택 객체 보여주기
                    if(selFeature) {
                        selFeature.show();
                    }
                    // 객체 변경 후, 숨기기
                    selFeature = feature;
                    selFeature.hide();
                }
            };
            // 이벤트 설정.
            featureInfos.addEventListener(featureEventHandler);
            // 출력.
            featureInfos.show();
        }
		
		
		
		
		
		
		
		
		
		
	</script>
	
	
</html>