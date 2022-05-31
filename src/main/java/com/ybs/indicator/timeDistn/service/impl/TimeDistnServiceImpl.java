package com.ybs.indicator.timeDistn.service.impl;

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
import com.ybs.indicator.pass.service.impl.PassServiceImpl;
import com.ybs.indicator.timeDistn.service.TimeDistnService;

@Service("timeDistnService")
@Transactional(rollbackFor = {Exception.class})
public class TimeDistnServiceImpl extends EgovAbstractServiceImpl implements TimeDistnService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="timeDistnMapper")
	private TimeDistnMapper mapper;

	@Override
	public List<EgovMap> selectTimeDistnResultList(SearchVO sVO) {
		List<EgovMap> timeDistnResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("1일 평균 통행시간_일별 다운로드");
				timeDistnResultList = mapper.selectTimeDistnResultListDay_d(sVO); break;
			} else {
				System.out.println("1일 평균 통행시간");
				timeDistnResultList = mapper.selectTimeDistnResultListDay(sVO); break;
			}
			
		case "timeDistn_avg_purpose" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("목적통행 평균 통행시간_일별 다운로드");
				timeDistnResultList = mapper.selectTimeDistnResultListPurpose_d(sVO); break;
			} else {
				System.out.println("목적통행 평균 통행시간");
				timeDistnResultList = mapper.selectTimeDistnResultListPurpose(sVO); break;
			}
			
		case "timeDistn_avg_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("수단통행 평균 통행시간_일별 다운로드");
				timeDistnResultList = mapper.selectTimeDistnResultListMethod_d(sVO); break;
			} else {
				System.out.println("수단통행 평균 통행시간");
				timeDistnResultList = mapper.selectTimeDistnResultListMethod(sVO); break;
			}
			
		case "timeDistn_avg_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("노선별 평균 통행시간_일별 다운로드");
				timeDistnResultList = mapper.selectTimeDistnResultListRoute_d(sVO); break;
			} else {
				System.out.println("노선별 평균 통행시간");
				timeDistnResultList = mapper.selectTimeDistnResultListRoute(sVO); break;
			}
		}
		
		return timeDistnResultList;
	}

	
	/********************** 화면용 다운로드 **********************/
	
	
	
	@Override
	public void downloadTimeDistnResultList(SearchVO sVO, HttpServletResponse res) {
		List<EgovMap> timeDistnResultList = new ArrayList<EgovMap>();
		
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

		
		String cdnoStr = "";				// ▶ get컬럼 리스트
		String cdnoTimeHeader = "";			// ▶ 헤더 시간리스트
		String cdnoDistnHeader = "";		// ▶ 헤더 거리리스트
		
		String cdnoTime = "";			// ▶ get컬럼 시간리스트
		String cdnoDistn = "";			// ▶ get컬럼 거리리스트
		
		// get컬럼 리스트
		for(int i=0; i<sVO.getCd_no().length; i++) {
			if("00".equals(sVO.getCd_no()[i])) {
				continue;
			}
			cdnoStr += ","+cdnoMatch.get(sVO.getCd_no()[i]);
			cdnoTimeHeader += ","+cdnoMatch.get(sVO.getCd_no()[i])+"_시간";
			cdnoDistnHeader += ","+cdnoMatch.get(sVO.getCd_no()[i])+"_거리";
			cdnoTime += ","+cdnoMatch.get(sVO.getCd_no()[i])+"시간";
			cdnoDistn += ","+cdnoMatch.get(sVO.getCd_no()[i])+"거리";
		}
		
		// ▶ 파일 이름 
		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
		
		System.out.println("시간확인");
		long sdt = System.currentTimeMillis();
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("1일 평균 통행시간_일별 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListDay_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "1일평균_통행시간거리_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
					
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				
				break;
			} else {
				System.out.println("1일 평균 통행시간 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListDay(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "1일평균_통행시간거리_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",시간"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tm"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				break;
			}
			
		case "timeDistn_avg_purpose" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("목적통행 평균 통행시간_일별 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListPurpose_d(sVO); 
				

				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "목적통행_평균통행시간거리_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
					
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				
				break;
			} else {
				System.out.println("목적통행 평균 통행시간 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListPurpose(sVO); 

				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "목적통행_평균통행시간거리_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",시간"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tm"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				
				break;
			}
			
		case "timeDistn_avg_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("수단통행 평균 통행시간_일별 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListMethod_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "수단통행_평균통행시간거리_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",교통수단"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tfcmn"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				
				break;
			} else {
				System.out.println("수단통행 평균 통행시간 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListMethod(sVO); 

				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "수단통행_평균통행시간거리_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",교통수단"
								+",시간"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tfcmn"
								+",tm"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				
				break;
			}
			
		case "timeDistn_avg_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("노선별 평균 통행시간_일별 다운로드");
				
				// ● 인자값 : 데이터 리스트
				timeDistnResultList = mapper.downloadTimeDistnResultListRoute_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "노선별통행_평균통행시간거리_일별"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",교통수단"
								+",노선ID"
								+",노선명칭"
								+",노선유형"
								+",기점"
								+",종점"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
				
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
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				
				break;
			} else {
				System.out.println("노선별 평균 통행시간 다운로드");
				timeDistnResultList = mapper.downloadTimeDistnResultListRoute(sVO); 

				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "노선별통행_평균통행시간거리_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",교통수단"
								+",노선ID"
								+",노선명칭"
								+",노선유형"
								+",기점"
								+",종점"
								+",시간"
								+ cdnoTimeHeader
								+ ",평균_시간"
								+ cdnoDistnHeader
								+ ",평균_거리";
				
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
								+",tm"
								+ cdnoTime
								+ ",평균시간"
								+ cdnoDistn
								+ ",평균거리";
				break;
			}
		}
		
		writeCsvOutput(res, timeDistnResultList, excelName, headerListSt, columnListSt);
		
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

	
	
	/********************** 그래프 쿼리 **********************/
	
	

	@Override
	public List<EgovMap> graphTimeDistnResultList(SearchVO sVO, HttpServletResponse res) {
		
		List<EgovMap> timeDistnResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
				System.out.println("1일 평균 통행시간_그래프");
				timeDistnResultList = mapper.graphTimeDistnResultListDay(sVO); break;
			
		case "timeDistn_avg_purpose" :
				System.out.println("목적통행 평균 통행시간_그래프");
				timeDistnResultList = mapper.graphTimeDistnResultListPurpose(sVO); break;
				
		case "timeDistn_avg_method" :
				System.out.println("수단통행 평균 통행시간_그래프");
				timeDistnResultList = mapper.graphTimeDistnResultListMethod(sVO); break;
			
		case "timeDistn_avg_route" :
				System.out.println("노선별 평균 통행시간_그래프");
				timeDistnResultList = mapper.graphTimeDistnResultListRoute(sVO); break;
		}
		
		return timeDistnResultList;
	}

	

}
