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
	
	// 날짜 오픈 및 조회버튼 활성화
	function selectBoxOpen(jsonArray){
		abledDateStart();
		
		$('.submit2').prop("disabled",false);
		$('.submit2').css("opacity", 1);
		$('.submit2').css("cursor", "pointer");
	}
	
	// 제공 자료 오픈 후 다운로드 가능
	$('.submit2').on('click',function(){
		$('.submit2').prop("disabled",true);
		$('.submit2').css("opacity", 0.3);
		$('.submit2').css("cursor", "default");
						
		var analType = $("input[name=anal_type]:checked").attr("text2");
		var analAreaCdSido = $("select[name=anal_area_cd_sido] option:selected").text();
		var analAreaCd = $("select[name=anal_area_cd] option:selected").text();
		var dateStart = $("input[name=dateStart]").val();
		
		jsonArray["anal_type"] = $("input[name=anal_type]:checked").val();
		jsonArray["anal_area_cd"] = $("select[name=anal_area_cd]").val();
		jsonArray["dateStart"] = dateStart;
		
		$.ajax({
			url: 'searchStatus.do',
			type: 'post',
			traditional: true,
			data: jsonArray,
			async: false,
			dataType: "json",
			success: function (data){
					$(document).on("change", "input[name='dateStart']",function(){
						$('.cell4_01_01').text("");
						$('.cell4_01_02').text("");
						$('.cell4').css("opacity", 0.3);
						
						$('.submit2').prop("disabled",false);
						$('.submit2').css("opacity", 1);
						$('.submit2').css("cursor", "pointer");
		
						$('.submit').prop("disabled",true);
						$('.submit').css("opacity", 0.3);
						$('.submit').css("cursor", "default");
					})
						
				
					if(data.searchStatusList[0].status == 'N'){
						var addHtml = "";
						$('.cell4').css("opacity", 1);
						$('.cell4_01_02').text("");
						
						addHtml += "<div class='cell4_01_01_N'>";
						addHtml += "<span>!</span>";
						addHtml += "<p>조회하고자 하시는 지역은 대용량 자료로 인해 웹 다운로드가 불가합니다.";
						addHtml += "다운받기를 원하시는 경우 관리자에게 문의해주세요.</p>";
						addHtml += "</div>";
						
						$('.cell4_01_02').append(addHtml);
						
					} else{
						disabledFalse(4);
		
						var addHtml = "";
						$('.cell4_01_01').text("");
						
						addHtml += "<div class='cell4_01_01_Y'>";
						addHtml += "<table>";
						addHtml += "<tr>";
						addHtml += "<th>파일명</th>";
						addHtml += "<td>"+analType+"_"+analAreaCdSido+"_"+analAreaCd+"_"+dateStart+"</td>";
						addHtml += "</tr>";
						addHtml += "<tr>";
						addHtml += "<th>파일설명</th>";
						
						if(analType == "정류장별_통행"){
							addHtml += "<td>분석지역 내에 존재하는 정류장별의 통행량입니다.</td>";
						} else if(analType == "정류장간_목적통행" || analType == "정류장간_수단통행"){
							if(analType == "정류장간_목적통행"){
								addHtml += "<td>분석지역 내에 존재하는 정류장간의 목적 통행량입니다.</td>";
							} else{
								addHtml += "<td>분석지역 내에 존재하는 정류장간의 수단 통행량입니다.</td>";
							}
						} else if(analType == "노선별통행"){
							addHtml += "<td>분석지역 내에 노선별 통행량입니다.</td>";
						} else if(analType == "노선별_기종점통행"){
							addHtml += "<td>분석지역 내에 노선별 정류장간의 기종점 통행량입니다.</td>";
						} else if(analType == "노선별_재차인원"){
							addHtml += "<td>분석지역 내에 노선별 재차인원입니다.</td>";
						} else if(analType == "행정동간_목적통행" || analType == "행정동간_수단통행"){	
							if(analType == "행정동간_목적통행"){
								addHtml += "<td>분석지역 내에 행정동간의 목적 통행량입니다.</td>";
							} else{
								addHtml += "<td>분석지역 내에 행정동간의 수단 통행량입니다.</td>";
							}
						}
						
						addHtml += "</tr>";
						addHtml += "<tr>";
						addHtml += "<th>파일구조</th>";
						
						if(analType == "정류장별_통행"){
							addHtml += "<td>광역/도, 시/군, 분석자료, 분석일자, 정류장구분, 정류장ID, 정류장명, 행정동, 시간";
							addHtml += ", 일반_승차, 일반_하차, 일반_환승, 어린이_승차, 어린이_하차, 어린이_환승, 청소년_승차, 청소년_하차, 청소년_환승";
							addHtml += ", 경로_승차, 경로_하차, 경로_환승, 장애인_승차, 장애인_하차, 장애인_환승, 국가유공자_승차, 국가유공자_하차, 국가유공자_환승";
							addHtml += ", 다자녀부모_승차, 다자녀부모_하차, 다자녀부모_환승, 동반_승차, 동반_하차, 동반_환승, 대학생_승차, 대학생_하차, 대학생_환승";
							addHtml += ", 복지_승차, 복지_하차, 복지_환승, 기타_승차, 기타_하차, 기타_환승</td>";
						} else if(analType == "정류장간_목적통행" || analType == "정류장간_수단통행"){
							addHtml += "<td>광역/도, 시/군, 분석자료, 분석일자, 승차내외부, 승차역ID, 승차지역명, 하차내외부, 하차역ID";
							addHtml += "하차지역명, 시간, 일반, 어린이, 청소년, 경로, 장애인, 국가유공자, 다자녀부모, 동반, 대학생복지, 기타</td>";
						} else if(analType == "노선별통행"){
							addHtml += "<td>광역/도, 시/군, 분석자료, 분석일자, 노선구분, 노선명, 노선유형, 기점, 종점, ";
							addHtml += "일반_승차, 일반_하차, 일반_환승, 어린이_승차, 어린이_하차, 어린이_환승, 청소년_승차, 청소년_하차, 청소년_환승, 경로_승차, 경로_하차, 경로_환승, ";
							addHtml += "장애인_승차, 장애인_하차, 장애인_환승, 국가유공자_승차, 국가유공자_하차, 국가유공자_환승, 다자녀부모_승차, 다자녀부모_하차, 다자녀부모_환승, ";
							addHtml += "동반_승차, 동반_하차, 동반_환승, 대학생_승차, 대학생_하차, 대학생_환승, 복지_승차, 복지_하차, 복지_환승, 기타_승차, 기타_하차, 기타_환승</td>";
						} else if(analType == "노선별_기종점통행"){
							addHtml += "<td>광역/도, 시/군, 분석자료, 분석일자, 노선구분, 노선명, 노선유형, 기점, 종점,";
							addHtml += "출발정류장ID, 출발정류장명, 출발정류장행정동, 도착정류장ID, 도착정류장명, 도착정류장행정동, 시간, 일반, 어린이, 청소년, 경로, 장애인, ";
							addHtml += "국가유공자, 다자녀부모, 동반, 대학생, 복지, 기타</td>";
						} else if(analType == "노선별_재차인원"){
							addHtml += "<td>분석지역광역도, 분석지역시군, 분석자료, 운행일자, 요일, 노선명, 노선유형, 기점, 종점, ";
							addHtml += ",00시, 01시, 02시, 03시, 04시, 05시, 06시, 07시, 08시, 09시, 10시, 11시, 12시, 13시, 14시, 15시, 16시, 17시, 18시, 19시, 20시, 21시, 22시, 23시, 평균</td>"
						} else if(analType == "행정동간_목적통행" || analType == "행정동간_수단통행"){	
							addHtml += "<td>광역/도, 시/군, 분석자료, 분석일자, 출발존, 출발행정동, 도착존, 도착행정동, 시간, 일반,";
							addHtml += "어린이, 청소년, 경로, 장애인, 국가유공자, 다자녀부모, 동반, 대학생, 복지, 기타</td>";
						}
						
						addHtml += "</tr>";
						addHtml += "</table>";
						addHtml += "</div>";
						
						
						$('.cell4_01_01').append(addHtml);
						
						$('.submit').prop("disabled",false);
						$('.submit').css("opacity", 1);
						$('.submit').css("cursor", "pointer");
					}
			}
		})
		
	})