package com.ybs.indicator.congestion.service.impl;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.congestion.service.CongestionService;
import com.ybs.indicator.pass.service.impl.PassServiceImpl;

@Service("congestionService")
@Transactional(rollbackFor = {Exception.class})
public class CongestionServiceImpl extends EgovAbstractServiceImpl implements CongestionService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="congestionMapper")
	private CongestionMapper mapper;

	@Override
	public List<EgovMap> selectCongestionResultList(SearchVO sVO) {
		List<EgovMap> congestionResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "congestionRoute_CBP" :
			System.out.println("노선별 재차인원");
			congestionResultList = mapper.selectCongestionResultListRouteCBP(sVO); break;
			
		case "congestionRoute_DOC" :
			System.out.println("노선별 혼잡도");
			congestionResultList = mapper.selectCongestionResultListRouteDOC(sVO); break;
			
		case "congestionTopRouteOD_DOC_max" :
			System.out.println("노선별 최대 혼잡구간");
			congestionResultList = mapper.selectCongestionResultListRouteDOC_max(sVO); break;
			
		case "congestionTopRouteOD_DOC_avg" :
			System.out.println("노선별 평균 혼잡구간");
			congestionResultList = mapper.selectCongestionResultListRouteDOC_avg(sVO); break;
			
		case "congestionTopStationOD_DOC_max" :
			System.out.println("정류장간 최대 혼잡도");
			congestionResultList = mapper.selectCongestionResultListStationDOC_max(sVO); break;
			
		case "congestionTopStationOD_DOC_avg" :
			System.out.println("정류장간 평균 혼잡도");
			congestionResultList = mapper.selectCongestionResultListStationDOC_avg(sVO); break;
			
		}
		return congestionResultList;
	}

	
	
	
	/********************** 화면용 다운로드 **********************/

	
	
	
	@Override
	public void downloadCongestionResultList(SearchVO sVO, HttpServletResponse res) {
		List<EgovMap> congestionResultList = new ArrayList<EgovMap>();
		
		String headerListSt = "";
		String columnListSt = "";
		String excelName = "";
		
		// ▶ 파일 이름
		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
		
		// ▶ 헤더 컬럼 
		String headerStr = ",00시"
							+",01시"
							+",02시"
							+",03시"
							+",04시"
							+",05시"
							+",06시"
							+",07시"
							+",08시"
							+",09시"
							+",10시"
							+",11시"
							+",12시"
							+",13시"
							+",14시"
							+",15시"
							+",16시"
							+",17시"
							+",18시"
							+",19시"
							+",20시"
							+",21시"
							+",22시"
							+",23시";
		
		// ▶ 재차인원 컬럼 
		String brdngStr =  ",brdng00"
							+",brdng01"
							+",brdng02"
							+",brdng03"
							+",brdng04"
							+",brdng05"
							+",brdng06"
							+",brdng07"
							+",brdng08"
							+",brdng09"
							+",brdng10"
							+",brdng11"
							+",brdng12"
							+",brdng13"
							+",brdng14"
							+",brdng15"
							+",brdng16"
							+",brdng17"
							+",brdng18"
							+",brdng19"
							+",brdng20"
							+",brdng21"
							+",brdng22"
							+",brdng23";
		
		// ▶ 혼잡도 컬럼 
		String conStr = ",con00"
						+",con01"
						+",con02"
						+",con03"
						+",con04"
						+",con05"
						+",con06"
						+",con07"
						+",con08"
						+",con09"
						+",con10"
						+",con11"
						+",con12"
						+",con13"
						+",con14"
						+",con15"
						+",con16"
						+",con17"
						+",con18"
						+",con19"
						+",con20"
						+",con21"
						+",con22"
						+",con23";
		
		// ▶ 최대 컬럼 
		String maxStr = ",max00"
						+",max01"
						+",max02"
						+",max03"
						+",max04"
						+",max05"
						+",max06"
						+",max07"
						+",max08"
						+",max09"
						+",max10"
						+",max11"
						+",max12"
						+",max13"
						+",max14"
						+",max15"
						+",max16"
						+",max17"
						+",max18"
						+",max19"
						+",max20"
						+",max21"
						+",max22"
						+",max23";	
		
		// ▶ 평균 컬럼 
		String avgStr = ",avg00"
						+",avg01"
						+",avg02"
						+",avg03"
						+",avg04"
						+",avg05"
						+",avg06"
						+",avg07"
						+",avg08"
						+",avg09"
						+",avg10"
						+",avg11"
						+",avg12"
						+",avg13"
						+",avg14"
						+",avg15"
						+",avg16"
						+",avg17"
						+",avg18"
						+",avg19"
						+",avg20"
						+",avg21"
						+",avg22"
						+",avg23";
		
		System.out.println("시간확인");
		long sdt = System.currentTimeMillis();
		
		switch(sVO.getAnal_type()) {
		case "congestionRoute_CBP" :
			System.out.println("PIVOT 노선별 재차인원");
			congestionResultList = mapper.selectCongestionResultListRouteCBP(sVO); 
			
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "노선별_재차인원_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",노선명"
							+",노선유형"
							+",기점"
							+",종점"
							+ headerStr
							+",평균";
			
			// ● 인자값 : 컬럼명
			columnListSt = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",routeNma"
							+",routeType"
							+",routeStart"
							+",routeEnd"
							+ brdngStr
							+",brdngCntAvg";
			
			break;
		case "congestionRoute_DOC" :
			System.out.println("PIVOT 노선별 혼잡도");
			congestionResultList = mapper.selectCongestionResultListRouteDOC(sVO);

			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "노선별_혼잡도_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",노선명"
							+",노선유형"
							+",기점"
							+",종점"
							+ headerStr
							+",평균";
			
			// ● 인자값 : 컬럼명
			columnListSt = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",routeNma"
							+",routeType"
							+",routeStart"
							+",routeEnd"
							+ conStr
							+",conRateAvg";
			
			break;
		case "congestionTopRouteOD_DOC_max" :
			System.out.println("PIVOT 노선별 최대 혼잡구간");
			congestionResultList = mapper.selectCongestionResultListRouteDOC_max(sVO); 

			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "노선별_상위5개_최대혼잡구간_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",노선명"
							+",순위"
							+",출발정류장ID"
							+",출발정류장명"
							+",출발행정동"
							+",도착정류장ID"
							+",도착정류장명"
							+",도착행정동"
							+ headerStr
							+",최대";
			
			// ● 인자값 : 컬럼명
			columnListSt = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",routeNma"
							+",sttnRank"
							+",stSttnId"
							+",stSttnNma"
							+",stSttnHjd"
							+",edSttnId"
							+",edSttnNma"
							+",edSttnHjd"
							+ maxStr
							+",conRateMax";
			
			break;
		case "congestionTopRouteOD_DOC_avg" :
			System.out.println("PIVOT 노선별 평균 혼잡구간");
			congestionResultList = mapper.selectCongestionResultListRouteDOC_avg(sVO); 
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "노선별_상위5개_평균혼잡구간_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",노선명"
							+",순위"
							+",출발정류장ID"
							+",출발정류장명"
							+",출발행정동"
							+",도착정류장ID"
							+",도착정류장명"
							+",도착행정동"
							+ headerStr
							+",평균";
			
			// ● 인자값 : 컬럼명
			columnListSt = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",routeNma"
							+",sttnRank"
							+",stSttnId"
							+",stSttnNma"
							+",stSttnHjd"
							+",edSttnId"
							+",edSttnNma"
							+",edSttnHjd"
							+ avgStr
							+",conRateAvg";
			break;
		case "congestionTopStationOD_DOC_max" :
			System.out.println("PIVOT 정류장간 최대 혼잡도");
			congestionResultList = mapper.selectCongestionResultListStationDOC_max(sVO); 
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "노선정류장간_상위100개_최대혼잡도_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",순위"
							+",출발정류장ID"
							+",출발정류장명"
							+",출발행정동"
							+",도착정류장ID"
							+",도착정류장명"
							+",도착행정동"
							+ headerStr
							+",최대";
			
			// ● 인자값 : 컬럼명
			columnListSt = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",sttnRank"
							+",stSttnId"
							+",stSttnNma"
							+",stSttnHjd"
							+",edSttnId"
							+",edSttnNma"
							+",edSttnHjd"
							+ maxStr
							+",conRateMax";
			break;
		case "congestionTopStationOD_DOC_avg" :
			System.out.println("PIVOT 정류장간 평균 혼잡도");
			congestionResultList = mapper.selectCongestionResultListStationDOC_avg(sVO); 
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "노선정류장간_상위100개_최대혼잡도_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",순위"
							+",출발정류장ID"
							+",출발정류장명"
							+",출발행정동"
							+",도착정류장ID"
							+",도착정류장명"
							+",도착행정동"
							+ headerStr
							+",최대";
			
			// ● 인자값 : 컬럼명
			columnListSt = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",sttnRank"
							+",stSttnId"
							+",stSttnNma"
							+",stSttnHjd"
							+",edSttnId"
							+",edSttnNma"
							+",edSttnHjd"
							+ avgStr
							+",conRateAvg";
			break;
		}
		
		writeCsvOutput(res, congestionResultList, excelName, headerListSt, columnListSt);
	}

	
	private void writeCsvOutput(HttpServletResponse res, List<EgovMap> excelList, String excelName, String headerListSt, String columnListSt) {
		try {

			if(excelList.size() == 0) {
				return;
			}
			
			res.setCharacterEncoding("utf-8");
			res.setContentType("text/csv");
			res.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(excelName + ".csv", "UTF-8"));
			res.setHeader("Content-Type", "text/csv; charset=MS949");

			PrintWriter printWriter = res.getWriter();

			long std = System.currentTimeMillis();

			String[] columnList = columnListSt.split(","); // 인자값 String를 배열 형태로 만들어줌.
			Object dataValue = "";
			
			// 헤더 생성
			printWriter.append(headerListSt);
			printWriter.append("\r\n");

			// 데이터 생성
			// 1. list 한 줄씩 도는 for문.
			// ex) {분석지역Cd=31101, analAreaSidoCdText=경기도, analAreaCdText=고양시, provider=국토부,
			// 운행일자=20210322}
			for (Map<String, Object> data : excelList) {
				String separator = ",";
				// 2. list 한 줄에 해당하는 map의 key값을 도는 for문.
				// ex) {분석지역Cd=31101, analAreaSidoCdText=경기도, , , }
				// analAreaSidoCdText=경기도
				// analAreaCdText=고양시
				// provider=국토부
				// 운행일자=20210322
				for (int i = 0; i < columnList.length; i++) {

					if (i == 0) {
						separator = "";
					} else {
						separator = ",";
					}

					 try {
						 dataValue = data.get(columnList[i]);
						 printWriter.append(separator + dataValue.toString());
				     }catch (Exception e) {
				    	 printWriter.append(separator + "null");
				    	 continue;
					}	

					
						
				}
				printWriter.append("\r\n");

			}

			printWriter.flush();

			System.out.println("csv 걸린시간 : " + ((System.currentTimeMillis() - std) / 1000));
			
		} catch (Exception e) {

			e.printStackTrace();
		}
	}


}
