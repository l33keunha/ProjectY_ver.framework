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
			
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행");
			transferResultList = mapper.selectTransferResultListStation(sVO);break;
			
		case "transferCnt_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_노선별통행_일별");
				transferResultList = mapper.selectTransferResultListRoute_d(sVO); break;
			} else {
				System.out.println("환승_노선별통행");
				transferResultList = mapper.selectTransferResultListRoute(sVO); break;
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

		
		String cdnoSt = "";			// get컬럼 리스트
		String cdnoStLong = "";     // get컬럼 리스트 (노선별, 정류장별)
		
		// get컬럼 리스트
		for(int i=0; i<sVO.getCd_no().length; i++) {
			if("00".equals(sVO.getCd_no()[i])) {
				continue;
			}
			cdnoMatch.get(sVO.getCd_no()[i]);
			cdnoSt += ","+cdnoMatch.get(sVO.getCd_no()[i]);
		}
		
		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
		
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
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",수단"
								+ cdnoSt 
								+",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tfcmn"
								+ cdnoSt 
								+",합계";
				
				break;
			} else {
				System.out.println("환승_수단별통행 다운로드");
				transferResultList = mapper.downloadTransferResultListMethod(sVO); 
				
				System.out.println("query 조회 시간 : " + ((System.currentTimeMillis() - sdt) / 1000));
				
				// ● 인자값 : 시트명
				excelName = "환승_수단별통행_"+date_SidoText;
				
				// ● 인자값 : 헤더명
				headerListSt = "분석지역광역도"
								+",분석지역시군"
								+",분석자료"
								+",운행일자"
								+",요일"
								+",수단"
								+",시간"
								+ cdnoSt 
								+",합계";
				
				// ● 인자값 : 컬럼명
				columnListSt = "analAreaSidoCdText"
								+",analAreaCdText"
								+",provider"
								+",opratDate"
								+",dy"
								+",tfcmn"
								+",tm"
								+ cdnoSt 
								+",합계";
				
				break;
			}
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행 다운로드");
			transferResultList = mapper.downloadTransferResultListStation(sVO);break;
			
		case "transferCnt_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_노선별통행_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListRoute_d(sVO); break;
			} else {
				System.out.println("환승_노선별통행 다운로드");
				transferResultList = mapper.downloadTransferResultListRoute(sVO); break;
			}	
			
		case "transferCnt_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별통행_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별통행 다운로드");
				transferResultList = mapper.downloadTransferResultListNum(sVO); break;
			}
			
		case "transferTime_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행시간_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별 환승통행시간 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeMethod(sVO); break;
			}
			
		case "transferTime_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행시간_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별 환승통행시간 다운로드");
				transferResultList = mapper.downloadTransferResultListTimeNum(sVO); break;
			}
			
		case "transferDistn_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행거리_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별 환승통행거리 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnMethod(sVO); break;
			}
			
		case "transferDistn_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행거리_일별 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별 환승통행거리 다운로드");
				transferResultList = mapper.downloadTransferResultListDistnNum(sVO); break;
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
