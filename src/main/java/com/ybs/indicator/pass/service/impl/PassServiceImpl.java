package com.ybs.indicator.pass.service.impl;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.pass.service.PassService;

@Service("passService")
@Transactional(rollbackFor = {Exception.class})
public class PassServiceImpl extends EgovAbstractServiceImpl implements PassService{

	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="passMapper")
	private PassMapper mapper;

	@Override
	public List<EgovMap> selectPassResultList(SearchVO sVO) {
	List<EgovMap> passResultList = new ArrayList<EgovMap>();
		if(sVO.getAnal_type()!=null) { 															// # 분석유형이 있음 : 통행량, 행정동간OD
			switch(sVO.getAnal_type()) {
			case "passCnt_purpose": 														    // 통행량_목적통행
				System.out.println("목적통행");
				if("allDay".equals(sVO.getTm())) {
					passResultList = mapper.selectPassResultListPurpose_d(sVO); break;
				} else {
					passResultList = mapper.selectPassResultListPurpose(sVO); break;
				}
				
			case "passCnt_method":                                                              // 통행량_수단통행
				System.out.println("수단통행");
				if("allDay".equals(sVO.getTm())) {
					passResultList = mapper.selectPassResultListMethod_d(sVO); break;
				} else {
				passResultList = mapper.selectPassResultListMethod(sVO); break;
				}
				
			case "passAreaODCnt_purpose":                                                       // 행정동간OD_ 목적통행
				System.out.println("행정동목적");
				passResultList = mapper.selectPassResultListAreaODPurpose(sVO); break;
				
			case "passAreaODCnt_method":                                                        // 행정동간OD_ 수단통행
				System.out.println("행정동수단");
				passResultList = mapper.selectPassResultListAreaODMethod(sVO); break;
				
			}
		} else if(sVO.getAnal_type()==null){                                                    // # 분석유형이 없음 : 노선별OD, 상위...
			switch(sVO.getAnal_group()) {
			case "passRouteODCnt":                                                              // 노선별OD
				System.out.println("노선별od");if("allDay".equals((String)sVO.getTm())) {
					passResultList = mapper.selectPassResultListRouteOD_d(sVO); break;
				}
				passResultList = mapper.selectPassResultListRouteOD(sVO); break;
				
			case "passTopRotue":                                                                // 상위이용노선
				System.out.println("상위이용노선");
				passResultList = mapper.selectPassResultListTopRoute(sVO); break;
				
			case "passTopStation":                                                              // 상위이용정류장
				if("B".equals(sVO.getTfcmn())) {
					System.out.println("상위이용정류장 버스");
					passResultList = mapper.selectPassResultListTopStationB(sVO); break;
				} else if("T".equals(sVO.getTfcmn())){
					System.out.println("상위이용정류장 지하철");
					passResultList = mapper.selectPassResultListTopStationT(sVO); break;
				} else {
					System.out.println("상위이용정류장 전체");
					passResultList = mapper.selectPassResultListTopStation(sVO); break;
				}
				
			}
		}
		return passResultList;
	}

	@Override
	public List<EgovMap> selectPassResultListB(SearchVO sVO) {
		List<EgovMap> passResultListB = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "passCnt_route":
			if("allDay".equals(sVO.getTm())) {
				passResultListB = mapper.selectPassResultListRouteB_d(sVO); break;
			} else {
				passResultListB = mapper.selectPassResultListRouteB(sVO); break;                //노선버스
			}
			
		case "passCnt_station":
			passResultListB = mapper.selectPassResultListStationB(sVO); break;                  //정류장버스
			
		}
		return passResultListB;
	}

	@Override
	public List<EgovMap> selectPassResultListT(SearchVO sVO) {
		List<EgovMap> passResultListT = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "passCnt_route":
			if("allDay".equals(sVO.getTm())) {
				passResultListT = mapper.selectPassResultListRouteT_d(sVO); break;
			} else {
				passResultListT = mapper.selectPassResultListRouteT(sVO); break;                //노선지하철
			}
			
		case "passCnt_station":
			passResultListT = mapper.selectPassResultListStationT(sVO); break;                  //정류장지하철
			
		}
		return passResultListT;
	}

	
	
	
	/********************** 화면용 다운로드 **********************/
	
	
	
	@Override
	public void downloadPassResultList(SearchVO sVO, HttpServletResponse res) {
		List<EgovMap> passResultList = new ArrayList<EgovMap>();
		
		String headerListSt = "";
		String columnListSt = "";
		String excelName = "";
		
		// 이용자유형 선택에 따른 get컬럼 로직
		Map<String,Object> cdnoMatch = new HashMap<String,Object>();
		cdnoMatch.put("01","일반");
		cdnoMatch.put("02","어린이");
		cdnoMatch.put("03","청소년");
		cdnoMatch.put("04","경로");
		cdnoMatch.put("05","장애인");
		cdnoMatch.put("06","국가유공자");
		cdnoMatch.put("07","다자녀부모");
		cdnoMatch.put("08","동반");
		cdnoMatch.put("09","대학생");
		cdnoMatch.put("10","복지");
		cdnoMatch.put("11","기타");

		
		String cdnoStr = "";			// get컬럼 리스트
		String cdnoStrLong = "";     // get컬럼 리스트 (노선별, 정류장별)
		
		// get컬럼 리스트
		for(int i=0; i<sVO.getCd_no().length; i++) {
			if("00".equals(sVO.getCd_no()[i])) {
				continue;
			}
			cdnoMatch.get(sVO.getCd_no()[i]);
			cdnoStr += ","+cdnoMatch.get(sVO.getCd_no()[i]);
		}
		
		// get컬럼 리스트 (노선별, 정류장별)
		for(int i=0; i<sVO.getCd_no().length; i++) {
			if("00".equals(sVO.getCd_no()[i])) {
				continue;
			}
			cdnoMatch.get(sVO.getCd_no()[i]);
			cdnoStrLong += "," + cdnoMatch.get(sVO.getCd_no()[i]) + "승차";
			cdnoStrLong += "," + cdnoMatch.get(sVO.getCd_no()[i]) + "하차";
			cdnoStrLong += "," + cdnoMatch.get(sVO.getCd_no()[i]) + "환승";
			cdnoStrLong += "," + cdnoMatch.get(sVO.getCd_no()[i]) + "승하차합계";
		}
		
		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
		
		System.out.println("시간확인");
		long sdt = System.currentTimeMillis();
		
		if(sVO.getAnal_type()!=null && !"".equals(sVO.getAnal_type())) { 															// # 분석유형이 있음 : 통행량, 행정동간OD
			switch(sVO.getAnal_type()) {
			case "passCnt_purpose": 														    // 통행량_목적통행
				if("allDay".equals(sVO.getTm())) {
					System.out.println("목적통행 일별 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListPurpose_d(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "목적통행_일별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+ cdnoStr 
									+",합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+ cdnoStr 
									+",합계";
					
					break;
				} else {
					System.out.println("목적통행 시간대별 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListPurpose(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "목적통행_시간대별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",시간"
									+ cdnoStr 
									+",합계";
			
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tm"
									+ cdnoStr 
									+",합계";
					
					break;
				}
				
			case "passCnt_method":                                                              // 통행량_수단통행
				if("allDay".equals(sVO.getTm())) {
					System.out.println("수단통행 일별 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListMethod_d(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "수단통행_일별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+ cdnoStr 
									+",합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+ cdnoStr 
									+",합계";
					
					break;
				} else {
					System.out.println("수단통행 시간대별 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListMethod(sVO);  
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "수단통행_시간대별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",시간"
									+ cdnoStr 
									+",합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",tm"
									+ cdnoStr 
									+",합계";
					
					break;
				}
			case "passCnt_route":
				if("allDay".equals(sVO.getTm())) {
					System.out.println("노선별통행 일별 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListRoute_d(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "노선별통행_일별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",노선ID"
									+",노선명"
									+",노선유형"
									+",기점"
									+",종점"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",routeId"
									+",routeNma"
									+",routeType"
									+",routeStart"
									+",routeEnd"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계";
					
					break;
				} else {
					System.out.println("노선별통행 시간대 다운로드");
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListRoute(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "노선별통행_시간대별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",시간"
									+",노선ID"
									+",노선명"
									+",노선유형"
									+",기점"
									+",종점"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",tm"
									+",routeId"
									+",routeNma"
									+",routeType"
									+",routeStart"
									+",routeEnd"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계"; 
					
					break;              
				}
				
			case "passCnt_station":
				System.out.println("정류장별통행 일별 다운로드");
				
				// ● 인자값 : 데이터 리스트
				passResultList = mapper.downloadPassResultListStation(sVO);
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "정류장별통행_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",교통수단"
								+",정류장ID"
								+",정류장명"
								+",행정동"
								+ cdnoStrLong
								+",전체승차"
								+",전체하차"
								+",전체환승"
								+",전체승하차합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tfcmn"
								+",sttnId"
								+",sttnNma"
								+",sttnHjd"
								+ cdnoStrLong
								+",전체승차"
								+",전체하차"
								+",전체환승"
								+",전체승하차합계"; 
					
				break;
				
			case "passAreaODCnt_purpose":                                                       // 행정동간OD_ 목적통행
				System.out.println("행정동목적 다운로드");
				
				// ● 인자값 : 데이터 리스트
				passResultList = mapper.downloadPassResultListAreaODPurpose(sVO);
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "행정동간OD_목적통행_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",출발존"
								+",출발행정동"
								+",도착존"
								+",도착행정동"
								+ cdnoStr
								+",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",getinout"
								+",getinoutnm"
								+",offinout"
								+",offinoutnm"
								+ cdnoStr
								+",합계";
				
				break;
			case "passAreaODCnt_method":                                                        // 행정동간OD_ 수단통행
				System.out.println("행정동수단 다운로드");
				
				// ● 인자값 : 데이터 리스트
				passResultList = mapper.downloadPassResultListAreaODMethod(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "행정동간OD_수단통행_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",출발존"
								+",출발행정동"
								+",도착존"
								+",도착행정동"
								+ cdnoStr
								+",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",getinout"
								+",getinoutnm"
								+",offinout"
								+",offinoutnm"
								+ cdnoStr
								+",합계";
				
				break;
			}
		} else if("".equals((String)sVO.getAnal_type()) || sVO.getAnal_type()==null){           // # 분석유형이 없음 : 노선별OD, 상위...
			
			switch(sVO.getAnal_group()) {
			case "passRouteODCnt":                                                              // 노선별OD
				if("allDay".equals((String)sVO.getTm())) {
					System.out.println("노선별od 일별 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListRouteOD_d(sVO);
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "노선별OD_일별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",노선명"
									+",노선유형"
									+",기점"
									+",종점"
									+",출발정류장ID"
									+",출발정류장명"
									+",출발행정동"
									+",도착정류장ID"
									+",도착정류장명"
									+",도착행정동"
									+ cdnoStr
									+",합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",routeNma"
									+",routeType"
									+",routeStart"
									+",routeEnd"
									+",getStnId"
									+",getStnNm"
									+",getStnArea"
									+",offStnId"
									+",offStnNm"
									+",offStnArea"
									+ cdnoStr
									+",합계";
					
					break;
				} else {
					System.out.println("노선별od 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListRouteOD(sVO);
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "노선별OD_시간대별_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",노선명"
									+",노선유형"
									+",기점"
									+",종점"
									+",출발정류장ID"
									+",출발정류장명"
									+",출발행정동"
									+",도착정류장ID"
									+",도착정류장명"
									+",도착행정동"
									+",시간"
									+ cdnoStr
									+",합계";
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",routeNma"
									+",routeType"
									+",routeStart"
									+",routeEnd"
									+",getStnId"
									+",getStnNm"
									+",getStnArea"
									+",offStnId"
									+",offStnNm"
									+",offStnArea"
									+",tm"
									+ cdnoStr
									+",합계"; 
					
					break;
				}
				
			case "passTopRotue":                                                                // 상위이용노선
				System.out.println("상위이용노선 다운로드");
				
				// ● 인자값 : 데이터 리스트
				passResultList = mapper.downloadPassREsultListTopRoute(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "상위이용노선_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",순위"
								+",노선ID"
								+",노선명"
								+",노선유형"
								+",기점"
								+",종점"
								+ cdnoStrLong
								+",전체승차"
								+",전체하차"
								+",전체환승"
								+",전체승하차합계"; 
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",순위"
								+",routeId"
								+",routeNma"
								+",routeType"
								+",routeStart"
								+",routeEnd"
								+ cdnoStrLong
								+",전체승차"
								+",전체하차"
								+",전체환승"
								+",전체승하차합계";  
				
				break;
				
			case "passTopStation":                                                              // 상위이용정류장
				if("B".equals(sVO.getTfcmn())) {
					System.out.println("상위이용정류장 버스 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListTopStationB(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "상위이용정류장_버스_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",순위"
									+",정류장ID"
									+",정류장명"
									+",행정동"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계"; 
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",순위"
									+",sttnId"
									+",sttnNma"
									+",sttnHjd"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계";  
					
					break;
				} else if("T".equals(sVO.getTfcmn())){
					System.out.println("상위이용정류장 지하철 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListTopStationT(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "상위이용정류장_지하철_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",순위"
									+",정류장ID"
									+",정류장명"
									+",행정동"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계"; 
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",순위"
									+",sttnId"
									+",sttnNma"
									+",sttnHjd"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계";  
					
					
					break;
				} else {
					System.out.println("상위이용정류장 전체 다운로드");
					
					// ● 인자값 : 데이터 리스트
					passResultList = mapper.downloadPassResultListTopStation(sVO); 
					
					System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
					
					// ● 인자값 : 시트명
					excelName = "상위이용정류장_"+date_SidoText;
					
					// ● 인자값 : 헤더명
					headerListSt = "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",교통수단"
									+",순위"
									+",정류장ID"
									+",정류장명"
									+",행정동"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계"; 
					
					// ● 인자값 : 컬럼명
					columnListSt = "analAreaSidoCdText"
									+",analAreaCdText"
									+",provider"
									+",opratDate"
									+",dy"
									+",tfcmn"
									+",순위"
									+",sttnId"
									+",sttnNma"
									+",sttnHjd"
									+ cdnoStrLong
									+",전체승차"
									+",전체하차"
									+",전체환승"
									+",전체승하차합계";  
					
					break;
				}
				
			}
		}
		
		writeCsvOutput(res, passResultList, excelName, headerListSt, columnListSt);
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
	
	
	
	
	
	/********************** 노선별OD 매트릭스  **********************/
	
	
	
	

	@Override
	public List<EgovMap> selectStationNmList(SearchVO sVO) {
		List<EgovMap> stationNmList = new ArrayList<EgovMap>(); // 정류장명칭 리스트
		System.out.println("서비스도착");
		stationNmList = mapper.selectStationNmList(sVO);
		return stationNmList;
	}

	@Override
	public ArrayList<ArrayList<Object>> selectRouteOD(SearchVO sVO) {
		List<EgovMap> routeOD = new ArrayList<EgovMap>(); // routeOD
		ArrayList<Object> routeODarr = new ArrayList<Object>();
		ArrayList<ArrayList<Object>> routeODList = new ArrayList<ArrayList<Object>>(); // routeOD
		
		int stCnt = mapper.selectStatioCnt(sVO);
		System.out.println(stCnt);
		
		Object dataValue = null;
		routeOD = mapper.selectRouteOD(sVO);
		for (int i = 0; i < routeOD.size(); i++) {
			routeODarr = new ArrayList<Object>();
			for(int j = 0; j < routeOD.size(); j++) {
				dataValue = routeOD.get(i).get(j+"번정류장");
				routeODarr.add(dataValue);
			}
			routeODList.add(routeODarr);
		}
		
		return routeODList;
	}


	
	
	/********************** 그래프 쿼리 **********************/
	
	
	
	@Override
	public List<EgovMap> graphPassResultList(SearchVO sVO, HttpServletResponse res) {
		List<EgovMap> passResultList = new ArrayList<EgovMap>();
		switch(sVO.getAnal_type()) {
		case "passCnt_purpose": 														    // 통행량_목적통행
			System.out.println("목적통행_그래프");
			if("allDay".equals(sVO.getTm())) {
				passResultList = mapper.graphPassResultListPurpose_d(sVO); break;
			} else {
				passResultList = mapper.graphPassResultListPurpose(sVO); break;
			}
			
		case "passCnt_method":                                                              // 통행량_수단통행
			System.out.println("수단통행_그래프");
			if("allDay".equals(sVO.getTm())) {
				passResultList = mapper.graphPassResultListMethod_d(sVO); break;
			} else {
			passResultList = mapper.graphPassResultListMethod(sVO); break;
			}
			
		case "passCnt_route":                                                       		// 통행량_노선별통행
			System.out.println("노선별통행_그래프");
			if("allDay".equals(sVO.getTm())) {
				passResultList = mapper.graphPassResultListRoute_d(sVO); break;
			} else {
				passResultList = mapper.graphPassResultListRoute(sVO); break;
			}
			
		}
		
		return passResultList;
		
	}

	
}