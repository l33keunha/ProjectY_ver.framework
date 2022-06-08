package com.ybs.indicator.download.service.impl;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.download.service.DownloadService;

@Service("DownloadService")
@Transactional(rollbackFor = { Exception.class })
public class DownloadServiceImpl extends EgovAbstractServiceImpl implements DownloadService {

	private static final Logger LOGGER = LoggerFactory.getLogger(DownloadServiceImpl.class);

	@Resource(name = "DownloadMapper")
	private DownloadMapper mapper;

	@Override
	public void selectdownloadResultList(SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		List<EgovMap> downloadResultList = new ArrayList<EgovMap>();
		String headerListSt = "";
		String columnListSt = "";
		String excelName = "";

		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
	
		System.out.println("시간확인");
		long sdt = System.currentTimeMillis();

		switch (sVO.getAnal_type()) {
		case "dlStation_stationCnt": // 정류장별통행
			System.out.println("정류장별통행");

			// ● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListStationCnt(sVO);
		
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
		

			// ● 인자값 : 시트명
			excelName = "정류장별통행_"+date_SidoText;
			
			if(sVO.getProvider().equals("03")) {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "정류장구분," + "정류장ID," + "정류장명," + "행정동," + "시간,"
						+ "일반_승차,일반_하차,일반_환승," + "어린이_승차,어린이_하차,어린이_환승," + "청소년_승차,청소년_하차,청소년_환승," + "경로_승차,경로_하차,경로_환승,"
						+ "대학생_승차,대학생_하차,대학생_환승," + "복지_승차,복지_하차,복지_환승,";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",opratDate"
						+",tfcmn"
						+",sttnId"
						+",sttnNma"
						+",sttnHjd"
						+",시간"
						+",일반GinAgg"
						+",일반GffAgg"
						+",일반TrsAgg"
						+",어린이GinAgg"
						+",어린이GffAgg"
						+",어린이TrsAgg"
						+",청소년GinAgg"
						+",청소년GffAgg"
						+",청소년TrsAgg"
						+",경로GinAgg"
						+",경로GffAgg"
						+",경로TrsAgg"
						+",대학생GinAgg"
						+",대학생GffAgg"
						+",대학생TrsAgg"
						+",복지GinAgg"
						+",복지GffAgg"
						+",복지TrsAgg"
						;
				
			} else {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "정류장구분," + "정류장ID," + "정류장명," + "행정동," + "시간,"
						+ "일반_승차,일반_하차,일반_환승," + "어린이_승차,어린이_하차,어린이_환승," + "청소년_승차,청소년_하차,청소년_환승," + "경로_승차,경로_하차,경로_환승,"
						+ "장애인_승차,장애인_하차,장애인_환승," + "국가유공자_승차,국가유공자_하차,국가유공자_환승," + "다자녀부모_승차,다자녀부모_하차,다자녀부모_환승,"
						+ "동반_승차,동반_하차,동반_환승," + "대학생_승차,대학생_하차,대학생_환승," + "복지_승차,복지_하차,복지_환승," + "기타_승차,기타_하차,기타_환승";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",opratDate"
						+",tfcmn"
						+",sttnId"
						+",sttnNma"
						+",sttnHjd"
						+",시간"
						+",일반GinAgg"
						+",일반GffAgg"
						+",일반TrsAgg"
						+",어린이GinAgg"
						+",어린이GffAgg"
						+",어린이TrsAgg"
						+",청소년GinAgg"
						+",청소년GffAgg"
						+",청소년TrsAgg"
						+",경로GinAgg"
						+",경로GffAgg"
						+",경로TrsAgg"
						+",장애인GinAgg"
						+",장애인GffAgg"
						+",장애인TrsAgg"
						+",국가유공자GinAgg"
						+",국가유공자GffAgg"
						+",국가유공자TrsAgg"
						+",다자녀부모GinAgg"
						+",다자녀부모GffAgg"
						+",다자녀부모TrsAgg"
						+",동반GinAgg"
						+",동반GffAgg"
						+",동반TrsAgg"
						+",대학생GinAgg"
						+",대학생GffAgg"
						+",대학생TrsAgg"
						+",복지GinAgg"
						+",복지GffAgg"
						+",복지TrsAgg"
						+",기타GinAgg"
						+",기타GffAgg"
						+",기타TrsAgg";
				
			}
			break;
		case "dlStation_station_purpose": // 정류장간목적통행
			System.out.println("정류장간목적통행");

			// ● 인자값 : 데이터 리스트
			if(sVO.getAnal_area_cd().equals("11") || sVO.getAnal_area_cd().equals("23")) {
				downloadResultList = mapper.selectdownloadResultListStationOD_purpose_small(sVO);
			} else {
				downloadResultList = mapper.selectdownloadResultListStationOD_purpose(sVO);
			}
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));

			// ● 인자값 : 시트명
			excelName = "정류장간목적통행_"+date_SidoText;
			
			if(sVO.getProvider().equals("03")) {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "승차내외부," + "승차역ID," + "승차지역명," + "하차내외부," + "하차역ID,"
						+ "하차지역명," + "시간," + "일반," + "어린이," + "청소년," + "경로," + "대학생," + "복지";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",운행일자"
						+",승차내외부"
						+",승차역id"
						+",승차지역명"
						+",하차내외부"
						+",하차역id"
						+",하차지역명"
						+",시간"
						+",일반"
						+",어린이"
						+",청소년"
						+",경로"
						+",대학생"
						+",복지"
						;
				
			} else {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "승차내외부," + "승차역ID," + "승차지역명," + "하차내외부," + "하차역ID,"
						+ "하차지역명," + "시간," + "일반," + "어린이," + "청소년," + "경로," + "장애인," + "국가유공자," + "다자녀부모," + "동반," + "대학생,"
						+ "복지," + "기타";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",운행일자"
						+",승차내외부"
						+",승차역id"
						+",승차지역명"
						+",하차내외부"
						+",하차역id"
						+",하차지역명"
						+",시간"
						+",일반"
						+",어린이"
						+",청소년"
						+",경로"
						+",장애인"
						+",국가유공자"
						+",다자녀부모"
						+",동반"
						+",대학생"
						+",복지"
						+",기타";
				
			}


			break;
		case "dlStation_station_method": // 정류장간수단통행
			System.out.println("정류장간수단통행");

			// ● 인자값 : 데이터 리스트
			if(sVO.getAnal_area_cd().equals("11") || sVO.getAnal_area_cd().equals("23")) {
				downloadResultList = mapper.selectdownloadResultListStationOD_method_small(sVO);				
			} else {
				downloadResultList = mapper.selectdownloadResultListStationOD_method(sVO);
			}
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));

			// ● 인자값 : 시트명
			excelName = "정류장간수단통행_"+date_SidoText;
			
			if(sVO.getProvider().equals("03")) {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "승차내외부," + "승차역ID," + "승차지역명," + "하차내외부," + "하차역ID,"
						+ "하차지역명," + "시간," + "일반," + "어린이," + "청소년," + "경로," + "대학생," + "복지";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",운행일자"
						+",승차내외부"
						+",승차역id"
						+",승차지역명"
						+",하차내외부"
						+",하차역id"
						+",하차지역명"
						+",시간"
						+",일반"
						+",어린이"
						+",청소년"
						+",경로"
						+",대학생"
						+",복지"
						;
				
			} else {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "승차내외부," + "승차역ID," + "승차지역명," + "하차내외부," + "하차역ID,"
						+ "하차지역명," + "시간," + "일반," + "어린이," + "청소년," + "경로," + "장애인," + "국가유공자," + "다자녀부모," + "동반," + "대학생,"
						+ "복지," + "기타";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",운행일자"
						+",승차내외부"
						+",승차역id"
						+",승차지역명"
						+",하차내외부"
						+",하차역id"
						+",하차지역명"
						+",시간"
						+",일반"
						+",어린이"
						+",청소년"
						+",경로"
						+",장애인"
						+",국가유공자"
						+",다자녀부모"
						+",동반"
						+",대학생"
						+",복지"
						+",기타";
				
			}


			break;
		case "dlStation_station_run": // 정류장간운행지표 (x)
			System.out.println("정류장간운행지표 (x)");
			break;
		case "dlStation_station_runCongestion": // 정류장간운행/혼잡지표 (x)
			System.out.println("정류장간운행/혼잡지표 (x)");
			break;
		case "dlRoute_routeCnt": // 노선별통행
			System.out.println("노선별통행");
			
			  // ● 인자값 : 데이터 리스트
			  downloadResultList = mapper.selectdownloadResultListRouteCnt(sVO);
			  System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			  // ● 인자값 : 시트명
			 excelName = "노선별통행_"+date_SidoText;
			 
			 if(sVO.getProvider().equals("03")) {
				 
				 // ● 인자값 : 헤더명
				 headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," +  "노선구분," + "노선명," + "노선유형," + "기점," + "종점," + "시간,"
						 + "일반_승차,일반_하차,일반_환승," + "어린이_승차,어린이_하차,어린이_환승," + "청소년_승차,청소년_하차,청소년_환승," + "경로_승차,경로_하차,경로_환승,"
						 + "대학생_승차,대학생_하차,대학생_환승," + "복지_승차,복지_하차,복지_환승,";
				 
				 
				 // ● 인자값 : 컬럼명
				 columnListSt = "분석지역광역도"
						 +",분석지역시군"
						 +",분석자료"
						 +",opratDate"
						 +",tfcmn"
						 +",routeNma"
						 +",routeType"
						 +",routeStart"
						 +",routeEnd"
						 +",시간"
						 +",일반GinAgg"
						 +",일반GffAgg"
						 +",일반TrsAgg"
						 +",어린이GinAgg"
						 +",어린이GffAgg"
						 +",어린이TrsAgg"
						 +",청소년GinAgg"
						 +",청소년GffAgg"
						 +",청소년TrsAgg"
						 +",경로GinAgg"
						 +",경로GffAgg"
						 +",경로TrsAgg"
						 +",대학생GinAgg"
						 +",대학생GffAgg"
						 +",대학생TrsAgg"
						 +",복지GinAgg"
						 +",복지GffAgg"
						 +",복지TrsAgg"
						 ;
				 
			 } else {
				 
				 // ● 인자값 : 헤더명
				 headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," +  "노선구분," + "노선명," + "노선유형," + "기점," + "종점," + "시간,"
						 + "일반_승차,일반_하차,일반_환승," + "어린이_승차,어린이_하차,어린이_환승," + "청소년_승차,청소년_하차,청소년_환승," + "경로_승차,경로_하차,경로_환승,"
						 + "장애인_승차,장애인_하차,장애인_환승," + "국가유공자_승차,국가유공자_하차,국가유공자_환승," + "다자녀부모_승차,다자녀부모_하차,다자녀부모_환승,"
						 + "동반_승차,동반_하차,동반_환승," + "대학생_승차,대학생_하차,대학생_환승," + "복지_승차,복지_하차,복지_환승," + "기타_승차,기타_하차,기타_환승";
				 
				 
				 // ● 인자값 : 컬럼명
				 columnListSt = "분석지역광역도"
						 +",분석지역시군"
						 +",분석자료"
						 +",opratDate"
						 +",tfcmn"
						 +",routeNma"
						 +",routeType"
						 +",routeStart"
						 +",routeEnd"
						 +",시간"
						 +",일반GinAgg"
						 +",일반GffAgg"
						 +",일반TrsAgg"
						 +",어린이GinAgg"
						 +",어린이GffAgg"
						 +",어린이TrsAgg"
						 +",청소년GinAgg"
						 +",청소년GffAgg"
						 +",청소년TrsAgg"
						 +",경로GinAgg"
						 +",경로GffAgg"
						 +",경로TrsAgg"
						 +",장애인GinAgg"
						 +",장애인GffAgg"
						 +",장애인TrsAgg"
						 +",국가유공자GinAgg"
						 +",국가유공자GffAgg"
						 +",국가유공자TrsAgg"
						 +",다자녀부모GinAgg"
						 +",다자녀부모GffAgg"
						 +",다자녀부모TrsAgg"
						 +",동반GinAgg"
						 +",동반GffAgg"
						 +",동반TrsAgg"
						 +",대학생GinAgg"
						 +",대학생GffAgg"
						 +",대학생TrsAgg"
						 +",복지GinAgg"
						 +",복지GffAgg"
						 +",복지TrsAgg"
						 +",기타GinAgg"
						 +",기타GffAgg"
						 +",기타TrsAgg";
				 
			 }
				
				
			break;
		case "dlRoute_routeODCnt": // 노선별기종점통행
			System.out.println("노선별기종점통행");

			// ● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListRouteOD(sVO);
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));

			// ● 인자값 : 시트명
			excelName = "노선별기종점통행_"+date_SidoText;
			
			if(sVO.getProvider().equals("03")) {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "노선구분," + "노선명," + "노선유형," + "기점," + "종점,"
						+ "출발정류장순번, 출발정류장ID, 출발정류장명, 출발정류장행정동, 도착정류장순번, 도착정류장ID, 도착정류장명, 도착정류장행정동, 시간," + "일반," + "어린이," + "청소년," + "경로," + "대학생," + "복지";
		
				columnListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",opratDate"
								+",tfcmn"
								+",routeNma"
								+",routeType"
								+",routeStart"
								+",routeEnd"
								+",출발정류장순번"
								+",출발정류장id"
								+",출발정류장명"
								+",출발정류장행정동"
								+",도착정류장순번"
								+",도착정류장id"
								+",도착정류장명"
								+",도착정류장행정동"
								+",시간"
								+",일반"
								+",어린이"
								+",청소년"
								+",경로"
								+",대학생"
								+",복지"
								;
				
			} else {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "노선구분," + "노선명," + "노선유형," + "기점," + "종점,"
						+ "출발정류장순번, 출발정류장ID, 출발정류장명, 출발정류장행정동, 도착정류장순번, 도착정류장ID, 도착정류장명, 도착정류장행정동, 시간," + "일반," + "어린이," + "청소년," + "경로," + "장애인,"
						+ "국가유공자," + "다자녀부모," + "동반," + "대학생," + "복지," + "기타";
		
				columnListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",opratDate"
								+",tfcmn"
								+",routeNma"
								+",routeType"
								+",routeStart"
								+",routeEnd"
								+",출발정류장순번"
								+",출발정류장id"
								+",출발정류장명"
								+",출발정류장행정동"
								+",도착정류장순번"
								+",도착정류장id"
								+",도착정류장명"
								+",도착정류장행정동"
								+",시간"
								+",일반"
								+",어린이"
								+",청소년"
								+",경로"
								+",장애인"
								+",국가유공자"
								+",다자녀부모"
								+",동반"
								+",대학생"
								+",복지"
								+",기타";
				
			}

			break;

		case "dlRoute_routeCBP": // 노선별 재차인원 (x)
			System.out.println("dlRoute_routeCBP");
			
			// ● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListRouteCBP(sVO);
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			System.out.println(downloadResultList.get(0).toString());
	
			// ● 인자값 : 시트명
			excelName = "노선별재차인원_"+date_SidoText;
			
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
							+",00시"
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
							+",23시"
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
							+",brdng00"
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
							+",brdng23"
							+",brdngCntAvg";
			
			break;
		case "dlArea_areaOD_purpose": // 행정동간목적통행
			System.out.println("행정동간목적통행");

			// ● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListAreaOD_purpose(sVO);
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));

			// ● 인자값 : 시트명
			excelName = "행정동간목적통행_"+date_SidoText;
			
			if(sVO.getProvider().equals("03")) {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "출발존," + "출발행정동," + "도착존," + "도착행정동," + "시간," + "일반,"
						+ "어린이," + "청소년," + "경로," + "대학생," + "복지";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",운행일자"
						+",승차내외부"
						+",승차지역명"
						+",하차내외부"
						+",하차지역명"
						+",시간"
						+",일반"
						+",어린이"
						+",청소년"
						+",경로"
						+",대학생"
						+",복지"
						;
				
			} else {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "출발존," + "출발행정동," + "도착존," + "도착행정동," + "시간," + "일반,"
						+ "어린이," + "청소년," + "경로," + "장애인," + "국가유공자," + "다자녀부모," + "동반," + "대학생," + "복지," + "기타";
				
				// ● 인자값 : 컬럼명
				columnListSt = "분석지역광역도"
						+",분석지역시군"
						+",분석자료"
						+",운행일자"
						+",승차내외부"
						+",승차지역명"
						+",하차내외부"
						+",하차지역명"
						+",시간"
						+",일반"
						+",어린이"
						+",청소년"
						+",경로"
						+",장애인"
						+",국가유공자"
						+",다자녀부모"
						+",동반"
						+",대학생"
						+",복지"
						+",기타";
				
			}

			break;

		case "dlArea_areaOD_method": // 행정동간수단통행
			System.out.println("행정동간수단통행");

			// ● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListAreaOD_method(sVO);
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));

			// ● 인자값 : 시트명
			excelName = "행정동간수단통행_"+date_SidoText;
			
			if(sVO.getProvider().equals("03")) {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "출발존," + "출발행정동," + "도착존," + "도착행정동," + "시간," + "일반,"
						+ "어린이," + "청소년," + "경로," + "동반," + "대학생," + "복지" ;

				// ● 인자값 : 컬럼명
				columnListSt ="분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",승차내외부"
							+",승차지역명"
							+",하차내외부"
							+",하차지역명"
							+",시간"
							+",일반"
							+",어린이"
							+",청소년"
							+",경로"
							+",대학생"
							+",복지"
							;
				
			} else {
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도," + "분석지역시도," + "분석자료," + "분석일자," + "출발존," + "출발행정동," + "도착존," + "도착행정동," + "시간," + "일반,"
						+ "어린이," + "청소년," + "경로," + "장애인," + "국가유공자," + "다자녀부모," + "동반," + "대학생," + "복지," + "기타";

				// ● 인자값 : 컬럼명
				columnListSt ="분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",승차내외부"
							+",승차지역명"
							+",하차내외부"
							+",하차지역명"
							+",시간"
							+",일반"
							+",어린이"
							+",청소년"
							+",경로"
							+",장애인"
							+",국가유공자"
							+",다자녀부모"
							+",동반"
							+",대학생"
							+",복지"
							+",기타";
				
			}

			break;
		
		}
		writeCsvOutput(res, downloadResultList, excelName, headerListSt, columnListSt);

	}

	

	/**
	 * csv 다운로드
	 */
	@Override
	public void writeCsvOutput(HttpServletResponse res, List<EgovMap> excelList, String excelName, String headerListSt, String columnListSt) {
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
