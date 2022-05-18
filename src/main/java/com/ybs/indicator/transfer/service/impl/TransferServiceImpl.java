package com.ybs.indicator.transfer.service.impl;

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
import com.ybs.indicator.transfer.service.TransferService;

@Service("transferService")
@Transactional(rollbackFor = {Exception.class})
public class TransferServiceImpl extends EgovAbstractServiceImpl implements TransferService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="transferMapper")
	private TransferMapper mapper;

	@Override
	public List<EgovMap> selectTransferResultList(SearchVO sVO) {
		List<EgovMap> transferResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "transferCnt_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별통행_일별");
				transferResultList = mapper.selectTransferResultListMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별통행");
				transferResultList = mapper.selectTransferResultListMethod(sVO); break;
			}
			
		case "transferCnt_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별통행_일별");
				transferResultList = mapper.selectTransferResultListNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별통행");
				transferResultList = mapper.selectTransferResultListNum(sVO); break;
			}
			
		case "transferTime_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행시간_일별");
				transferResultList = mapper.selectTransferResultListTimeMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별 환승통행시간");
				transferResultList = mapper.selectTransferResultListTimeMethod(sVO); break;
			}
			
		case "transferTime_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행시간_일별");
				transferResultList = mapper.selectTransferResultListTimeNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별 환승통행시간");
				transferResultList = mapper.selectTransferResultListTimeNum(sVO); break;
			}
			
		case "transferDistn_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행거리_일별");
				transferResultList = mapper.selectTransferResultListDistnMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별 환승통행거리");
				transferResultList = mapper.selectTransferResultListDistnMethod(sVO); break;
			}
			
		case "transferDistn_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행거리_일별");
				transferResultList = mapper.selectTransferResultListDistnNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별 환승통행거리");
				transferResultList = mapper.selectTransferResultListDistnNum(sVO); break;
			}
			
		}
		
		
		return transferResultList;
	}
	
	@Override
	public List<EgovMap> selectTransferResultListB(SearchVO sVO) {
		List<EgovMap> transferResultListB = new ArrayList<EgovMap>();
		switch(sVO.getAnal_type()) {
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행");
			transferResultListB = mapper.selectTransferResultListStationB(sVO);break;
			
		case "transferCnt_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_노선별통행_일별");
				transferResultListB = mapper.selectTransferResultListRouteB_d(sVO); break;
			} else {
				System.out.println("환승_노선별통행");
				transferResultListB = mapper.selectTransferResultListRouteB(sVO); break;
			}	
		}
		
		return transferResultListB;
	}




	@Override
	public List<EgovMap> selectTransferResultListT(SearchVO sVO) {
		List<EgovMap> transferResultListT = new ArrayList<EgovMap>();
		switch(sVO.getAnal_type()) {
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행");
			transferResultListT = mapper.selectTransferResultListStationT(sVO);break;
			
		case "transferCnt_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_노선별통행_일별");
				transferResultListT = mapper.selectTransferResultListRouteT_d(sVO); break;
			} else {
				System.out.println("환승_노선별통행");
				transferResultListT = mapper.selectTransferResultListRouteT(sVO); break;
			}	
		}
		
		return transferResultListT;
	}

	
	
	
	/********************** 화면용 다운로드 **********************/
	
	
	
	
	@Override
	public void downloadTransferResultList(SearchVO sVO, HttpServletResponse res) {
		List<EgovMap> transferResultList = new ArrayList<EgovMap>();
		
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

		
		String cdnoStr = "";			// ▶ get컬럼 리스트
		
		// get컬럼 리스트
		for(int i=0; i<sVO.getCd_no().length; i++) {
			if("00".equals(sVO.getCd_no()[i])) {
				continue;
			}
			cdnoMatch.get(sVO.getCd_no()[i]);
			cdnoStr += ","+cdnoMatch.get(sVO.getCd_no()[i]);
		}
		
		// ▶ 파일 이름 
		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
		
		// [수단별 일별]
		// ▶ 수단별 헤더_일별 
		String methodHeader_d =  "분석지역광역도"
									+",분석지역시군"
									+",분석자료"
									+",운행일자"
									+",요일"
									+",수단"
									+ cdnoStr;
									
		
		// ▶ 수단별 get 컬럼_일별 
		String methodStr_d = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tfcmn"
								+ cdnoStr;
		
		// [수단별 시간대별]
		// ▶ 수단별 헤더
		String methodHeader =  "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",수단"
								+",시간"
								+ cdnoStr;
		
		// ▶ 수단별 get 컬럼 
		String methodStr = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",tfcmn"
							+",tm"
							+ cdnoStr;
		
		// [횟수별 헤더 일별] 
		// ▶ 횟수별 헤더_일별
		String numHeader_d = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",환승횟수"
								+ cdnoStr;
		
		// ▶ 횟수별 get 컬럼_일별
		String numStr_d = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",transferNum"
							+ cdnoStr;
		
		// [횟수별 헤더] 
		// ▶ 횟수별 헤더 
		String numHeader = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",환승횟수"
								+",시간"
								+ cdnoStr;
		
		// ▶ 횟수별 get 컬럼 
		String numStr = "analAreaSidoCdText"
							+",analAreaCdText"
							+",provider"
							+",opratDate"
							+",dy"
							+",transferNum"
							+",tm"
							+ cdnoStr;
		
		System.out.println("시간확인");
		long sdt = System.currentTimeMillis();
		
		switch(sVO.getAnal_type()) {
		case "transferCnt_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별통행_일별 다운로드");
				
				// ● 인자값 : 데이터 리스트
				transferResultList = mapper.downloadTransferResultListMethod_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별통행_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = methodHeader_d + ",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = methodStr_d + ",합계";
				
				break;
			} else {
				System.out.println("환승_수단별통행 다운로드");
				transferResultList = mapper.downloadTransferResultListMethod(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별통행_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = methodHeader + ",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = methodStr + ",합계";
				
				break;
			}
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행 다운로드");
			transferResultList = mapper.downloadTransferResultListStation(sVO);
			
			System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
			
			// ● 인자값 : 시트명
			excelName = "환승_정류장별통행_"+date_SidoText;
			
			// ● 인자값 : 헤더명
			headerListSt = "분석지역광역도"
							+",분석지역시군"
							+",분석자료"
							+",운행일자"
							+",요일"
							+",수단"
							+",정류장Id"
							+",정류장명"
							+",행정동"
							+ cdnoStr
							+",합계";
			
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
							+ cdnoStr
							+",합계";
			
			break;
		case "transferCnt_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_노선별통행_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListRoute_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_노선별통행_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",수단"
								+",노선Id"
								+",노선명"
								+",노선유형"
								+",기점"
								+",종점"
								+ cdnoStr
								+",합계";
				
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
								+ cdnoStr
								+",합계";
				
				break;
			} else {
				System.out.println("환승_노선별통행 다운로드");
				transferResultList = mapper.downloadTransferResultListRoute(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_노선별통행_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",수단"
								+",노선Id"
								+",노선명"
								+",노선유형"
								+",기점"
								+",종점"
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
								+",routeId"
								+",routeNma"
								+",routeType"
								+",routeStart"
								+",routeEnd"
								+",tm"
								+ cdnoStr
								+",합계";
				
				break;
			}	
			
		case "transferCnt_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별통행_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListNum_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_횟수별통행_일별"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = numHeader_d + ",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = numStr_d + ",합계";
				
				break;
			} else {
				System.out.println("환승_횟수별통행 다운로드");
				transferResultList = mapper.downloadTransferResultListNum(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_횟수별통행_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = numHeader + ",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = numStr + ",합계";
				
				break;
			}
			
		case "transferTime_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행시간_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeMethod_d(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별_환승통행시간_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = methodHeader_d + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = methodStr_d + ",평균";
				
				break;
			} else {
				System.out.println("환승_수단별 환승통행시간 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeMethod(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별_환승통행시간_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = methodHeader + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = methodStr + ",평균";
				
				break;
			}
			
		case "transferTime_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행시간_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeNum_d(sVO);
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_횟수별_환승통행시간_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = numHeader_d + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = numStr_d + ",평균";
				
				break;
			} else {
				System.out.println("환승_횟수별 환승통행시간 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeNum(sVO);
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_횟수별_환승통행시간_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = numHeader + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = numStr + ",평균";
				
				break;
			}
			
		case "transferDistn_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행거리_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnMethod_d(sVO);
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별_환승통행거리_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = methodHeader_d + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = methodStr_d + ",평균";
				
				break;
			} else {
				System.out.println("환승_수단별 환승통행거리 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnMethod(sVO);
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별_환승통행거리_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = methodHeader + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = methodStr + ",평균";
				
				break;
			}
			
		case "transferDistn_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행거리_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnNum_d(sVO);
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_횟수별_환승통행거리_일별_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = numHeader_d + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = numStr_d + ",평균";
				
				break;
			} else {
				System.out.println("환승_횟수별_환승통행거리 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnNum(sVO);	
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_횟수별_환승통행거리_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = numHeader + ",평균";
				
				// ● 인자값 : 컬럼명
				columnListSt = numStr + ",평균";
				
				break;
			}
			
		}
		
		writeCsvOutput(res, transferResultList, excelName, headerListSt, columnListSt);
		
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
