package com.ybs.indicator.transfer.controller;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.google.gson.Gson;
import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.common.service.YbsUtil;
import com.ybs.indicator.transfer.service.TransferService;

@Controller
public class TransferController {
	
	@Resource(name = "transferService")
	private TransferService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/transferTest.do")
	public ModelAndView selectTransferResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.toString());
		
		List<EgovMap> transferResultList = new ArrayList<EgovMap>();
		List<EgovMap> transferResultListB = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 버스 리스트
		List<EgovMap> transferResultListT = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 지하철 리스트
		
		if(sVO.getAnal_type().equals("transferCnt_station")
			|| sVO.getAnal_type().equals("transferCnt_route")) {
			transferResultListB = service.selectTransferResultListB(sVO);
			if(transferResultListB.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(transferResultListB.get(i).toString());
				}
				mv.addObject("transferResultListB", transferResultListB);
				mv.setViewName("indicator/transfer/transfer_popUp");
			}  
			
			transferResultListT = service.selectTransferResultListT(sVO);
			if(transferResultListT.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(transferResultListT.get(i).toString());
				}
				mv.addObject("transferResultListT", transferResultListT);
				mv.setViewName("indicator/transfer/transfer_popUp");
			}
		} else {
			transferResultList = service.selectTransferResultList(sVO);
			
			if(transferResultList.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(transferResultList.get(i).toString());
				}
				mv.addObject("transferResultList", transferResultList);
				mv.setViewName("indicator/transfer/transfer_popUp");
			}
		} 
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		
		return mv;
	}
	
	@RequestMapping(value="/transferDownload.do")
	public void donwloadTransferResultList(@ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		System.out.println(sVO.toString());
		service.downloadTransferResultList(sVO, res);
	}

	
	@RequestMapping(value="/transferGraph.do")
	public ModelAndView graphPassResultList(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
			//날짜 사이 날짜리스트 출력
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			
				List<String> dateList = new ArrayList<String>();	//yyyy-MM-dd 형식
				List<String> dateListSt = new ArrayList<String>();		//yyyyMMdd 형식
			

				// 1일 조회 일떄 (통행량_노선별 통행)
				if("transferCnt_route".equals(sVO.getAnal_type()) ) {
					
					dateList.add(sVO.getDateStart());
					dateListSt.add((sVO.getDateStart()).replaceAll("-", ""));
					
					
					//여러 날 조회 일때 
				}else {
					dateList =YbsUtil.getDayBetween( sVO.getDateStart(), sVO.getDateEnd(), "yyyy-MM-dd");
					dateListSt =YbsUtil.getDayBetween( (sVO.getDateStart()).replace("-", ""), (sVO.getDateEnd()).replace("-", ""), "yyyyMMdd");
				}
				
				
				
				//시간 사이 시간리스트 출력 
				List<Object> timeList = new ArrayList<Object>();
				//시간 1일 일때,
				if("allDay".equals(sVO.getTm()) ) {
				
					timeList.add("1일");
					
				}else {
				//시작시간 ~ 끝 시간 일때
					
					//시간 사이 시간리스트 출력 
					int stTm = sVO.getTmStart();
					int edTm = sVO.getTmEnd();
				
					for(int k=stTm;  k<=edTm;  k++) {
						timeList.add(k);
					}
				}
				
				
				
				List<EgovMap> dataList = service.graphTransferResultList(sVO, res); // 그래프 데이터 리스트
				List<String> routeNmaList = new ArrayList<String>();
				List<Double> userCntAggList = new ArrayList<Double>();
			
				System.out.println("dataList:"+dataList);
				
				
			    //이용자 유형 코드 값 
				Map<String, Object[]> codeMap = new HashMap<String, Object[]>(); 
				codeMap.put("01",  new Object[] {"일반", 		"#ffb6b6", "rgb(255, 99, 132)"});
				codeMap.put("02",  new Object[] {"어린이", 	"#b6bcff", "rgb(255, 99, 132)"});
				codeMap.put("03",  new Object[] {"청소년", 	"#86d7b9", "rgb(255, 99, 132)"});
				codeMap.put("04",  new Object[] {"경로", 		"#f9e76a", "rgb(255, 99, 132)"});
				codeMap.put("05",  new Object[] {"장애인", 	"#f96a6a", "rgb(255, 99, 132)"});
				codeMap.put("06",  new Object[] {"국가유공자", "#cbb1ff", "rgb(255, 99, 132)"});
				codeMap.put("07",  new Object[] {"다자녀부모", "#8ec2cb", "rgb(255, 99, 132)"});
				codeMap.put("08",  new Object[] {"동반", 		"#9f3838", "rgb(255, 99, 132)"});
				codeMap.put("09",  new Object[] {"대학생", 	"#532981", "rgb(255, 99, 132)"});
				codeMap.put("10",  new Object[] {"복지", 		"#1d6c36", "rgb(255, 99, 132)"});
				codeMap.put("11",  new Object[] {"기타", 		"#6c1d54", "rgb(255, 99, 132)"});
				
				codeMap.put("B_B",  new Object[] {"버스_버스", 	"#ffb6b6", "rgb(255, 99, 132)"});
				codeMap.put("B_T",  new Object[] {"버스_지하철", 	"#b6bcff", "rgb(255, 99, 132)"});
				codeMap.put("T_B",  new Object[] {"지하철_버스", 	"#86d7b9", "rgb(255, 99, 132)"});

				codeMap.put("0",  new Object[] {"0회", 	"#ffb6b6", "rgb(255, 99, 132)"});
				codeMap.put("1",  new Object[] {"1회", 	"#b6bcff", "rgb(255, 99, 132)"});
				codeMap.put("2",  new Object[] {"2회", 	"#86d7b9", "rgb(255, 99, 132)"});
				codeMap.put("3",  new Object[] {"3회", 	"#f9e76a", "rgb(255, 99, 132)"});
				codeMap.put("4",  new Object[] {"4회", 	"#f96a6a", "rgb(255, 99, 132)"});
				codeMap.put("5",  new Object[] {"5회", 	"#cbb1ff", "rgb(255, 99, 132)"});
				codeMap.put("6",  new Object[] {"6회", 	"#8ec2cb", "rgb(255, 99, 132)"});
			
				
				String dateColumn ="";
				String jsonDataColumn = "";
				String dataCodeColumn = "";
				String labels = "";
				List<String> labelsArray = new ArrayList<String>();
				String x = "";
				String y = "";
				
				Gson gson = new Gson();
				
				
				
				//환승_노선별통행_그래프 (행 수가 너무 많은 관계로 for 문으로 데이터를 차트형식에 맞춰준다. )
				if("transferCnt_route".equals(sVO.getAnal_type()) ) {
					
					EgovMap routeMap =  new EgovMap();
					
					for(int i=0; i<dataList.size(); i++) {
						
						routeNmaList.add((String) dataList.get(i).get("routeNma"));
						userCntAggList.add(Double.parseDouble(dataList.get(i).get("userCntAgg").toString()));
					}
			
					routeMap.put("opratDate", dataList.get(0).get("opratDate"));
					routeMap.put("routeNma", routeNmaList);
					routeMap.put("userCntAgg", userCntAggList);
					
					dataList = new ArrayList<EgovMap>();
					dataList.add(routeMap);
				
				//환승_수단,횟수 그래프
				}else {
					
					//횟수 구하기
					//labelsArray = (dataList.get(0).get("userDistnAvg").toString()).split(",");
					//for(int i=0; i<labelsArray.length; i++) {
					//	labelsArray[i] = i+"회";
					//}
					
					//수단 구하기
					//labelsArray = ("버스_버스,버스_지하철,지하철_버스").split(",");
					
					for(int v=0; v<sVO.getCd_no().length; v++) {
						if("00".equals(sVO.getCd_no()[v])) {
							continue;
						}
						labelsArray.add((String)codeMap.get(sVO.getCd_no()[v])[0]);
					}
				}
				
				
				
				// 해당 그래프 페이지에 표출된 값
				switch(sVO.getAnal_type()) {
				case "transferCnt_method" :
						//System.out.println("환승_수단별통행_그래프");
					 
						dateColumn = "opratDate";						// 날짜 컬럼
						jsonDataColumn = "userCntAgg";					// 표출 데이터 컬럼
						dataCodeColumn = "tfcmn";						// 그래프 속성 컬럼
						labels = gson.toJson(labelsArray);				// x축 표출 이름
						x = "이용자유형(수단)";			// x축
						y = "합계통행량";			// y축 
						
						break;
						
				case "transferCnt_route" :
						//System.out.println("환승_노선별통행_그래프");

						dateColumn = "opratDate";									// 날짜 컬럼
						jsonDataColumn = "userCntAgg";								// 표출 데이터 컬럼
						labels = gson.toJson(dataList.get(0).get("routeNma"));		// x축 표출 이름
						x = "이용자유형(노선)";			// x축
						y = "합계통행량";			// y축 
						
						break;
					
				case "transferCnt_num" :
						//System.out.println("환승_횟수별통행_그래프");
						
						dateColumn = "opratDate";						// 날짜 컬럼
						jsonDataColumn = "userCntAgg";					// 표출 데이터 컬럼
						dataCodeColumn = "transferNum";					// 그래프 속성 컬럼
						labels = gson.toJson(labelsArray);				// x축 표출 이름
						x = "이용자유형(횟수)";								// x축
						y = "합계통행량";									// y축 
						
						break;
					
				case "transferTime_method" :
						//System.out.println("환승_수단별 환승통행시간_그래프");
			
						dateColumn = "opratDate";						// 날짜 컬럼
						jsonDataColumn = "userTimeAvg";					// 표출 데이터 컬럼
						dataCodeColumn = "tfcmn";						// 그래프 속성 컬럼
						labels = gson.toJson(labelsArray);				// x축 표출 이름
						x = "이용자유형(수단)";								// x축
						y = "평균시간(분)";								// y축 
						
						break;
					
				case "transferTime_num" :
						//System.out.println("환승_횟수별 환승통행시간_그래프");
						
						dateColumn = "opratDate";						// 날짜 컬럼
						jsonDataColumn = "userTimeAvg";					// 표출 데이터 컬럼
						dataCodeColumn = "transferNum";					// 그래프 속성 컬럼
						labels = gson.toJson(labelsArray);				// x축 표출 이름
						x = "이용자유형(횟수)";								// x축
						y = "평균시간(분)";								// y축 
						
						break;
					
				case "transferDistn_method" :
						//System.out.println("환승_수단별 환승통행거리_그래프");

						dateColumn = "opratDate";						// 날짜 컬럼
						jsonDataColumn = "userDistnAvg";				// 표출 데이터 컬럼
						dataCodeColumn = "tfcmn";						// 그래프 속성 컬럼
						labels = gson.toJson(labelsArray);				// x축 표출 이름
						x = "이용자유형(수단)";								// x축
						y = "평균거리(km)";								// y축 
						
						break;
					
				case "transferDistn_num" :
					//System.out.println("환승_횟수별 환승통행거리_그래프");
						
						dateColumn = "opratDate";						// 날짜 컬럼
						jsonDataColumn = "userDistnAvg";				// 표출 데이터 컬럼
						dataCodeColumn = "transferNum";					// 그래프 속성 컬럼
						labels = gson.toJson(labelsArray);				// x축 표출 이름
						x = "이용자유형(횟수)";								// x축
						y = "평균거리(km)";								// y축 
						
						break;
				}
				
				
				
				
				Map allDay = new HashMap();
				
				List<int[]> sumDataList = new ArrayList<int[]>();
						
				//1. 가져온 데이터 횟수대로 돌린다.
				for(int i=0;i<dataList.size();i++) {
					
					//2. list 한 행을 map에 넣어준다.
					Map tempItem = (Map) dataList.get(i);
					List<Map<String, Object>> listOfDay = null;
					
					//3.allDay 맵 변수에 해당 키의 날짜가 있는지 확인한다.
					//  - 있다면, listOfDay에 날짜를 넣어준다.
					if(allDay.containsKey(tempItem.get(dateColumn))) {
						listOfDay = (List) allDay.get(tempItem.get(dateColumn));  //[{backgroundColor=#ffb6b6, borderColor=rgb(255, 99, 132), data=[470,68,3,0], label=일반}]
						
					}else {
					//  - 없다면, listOfDay를 초기화 하고 
					//        allDay에 해당 날짜키로 데이터를 넣어준다.
						listOfDay = new ArrayList();
						allDay.put(tempItem.get(dateColumn), listOfDay);
					}
					
					//string 배열 -> int 배열 변환
					double[] data;
					
					//환승_노선별통행_그래프
					if("transferCnt_route".equals(sVO.getAnal_type()) ) {	
						data = userCntAggList.stream().mapToDouble(Double::intValue).toArray(); 
					}else {
						data = Arrays.asList((tempItem.get(jsonDataColumn).toString()).split(",")).stream().mapToDouble(Double::parseDouble).toArray();
					}
				
					
					//4. map을 생성해 해당 정보를 list에 담는다.
					Map<String, Object> dayItem = new HashMap<String, Object>();
				
					// 해당 그래프 페이지에 표출된 값
					switch(sVO.getAnal_type()) {
					case "transferCnt_method" :
							//System.out.println("환승_수단별통행_그래프");

							dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn))[0]);
							dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn))[1]);
							dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn))[2]);
							dayItem.put("data", data);
							
							listOfDay.add(dayItem);
							break;
							
					case "transferCnt_route" :
							//System.out.println("환승_노선별통행_그래프");

							dayItem.put("label", "합계(승차+하차)");
							dayItem.put("backgroundColor","#ffb6b6");
							dayItem.put("borderColor",  "rgb(255, 99, 132)");
							dayItem.put("data", data);
						
							listOfDay.add(dayItem);
							
							break;
						
					case "transferCnt_num" :
							//System.out.println("환승_횟수별통행_그래프");
							
							dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn).toString())[0]);
							dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[1]);
							dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[2]);
							dayItem.put("data", data);
							
							listOfDay.add(dayItem);
							
							break;
						
					case "transferTime_method" :
							//System.out.println("환승_수단별 환승통행시간_그래프");

							dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn))[0]);
							dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn))[1]);
							dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn))[2]);
							dayItem.put("data", data);
							
							listOfDay.add(dayItem);
							
							break;
						
					case "transferTime_num" :
							//System.out.println("환승_횟수별 환승통행시간_그래프");

							dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn).toString())[0]);
							dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[1]);
							dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[2]);
							dayItem.put("data", data);
							
							listOfDay.add(dayItem);
							
							break;
						
					case "transferDistn_method" :
							//System.out.println("환승_수단별 환승통행거리_그래프");

							dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn))[0]);
							dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn))[1]);
							dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn))[2]);
							dayItem.put("data", data);
							
							listOfDay.add(dayItem);
							
							break;
						
					case "transferDistn_num" :
							//System.out.println("환승_횟수별 환승통행거리_그래프");
							
							dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn).toString())[0]);
							dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[1]);
							dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[2]);
							dayItem.put("data", data);
							
							listOfDay.add(dayItem);
							
							break;
					}
					
					
				}
				
			
				List<String> chartList = new ArrayList<String>();
				for(String key : dateListSt) {
					chartList.add(gson.toJson(allDay.get(key))); 
				}
				
				
				mv.addObject("sVO", sVO);
				mv.addObject("dateList", dateList);					// 날짜
				mv.addObject("jsonList", chartList);				// json 데이터 (x축 데이터)
				mv.addObject("labels" , labels );					// json 데이터 (x축 이름)
				mv.addObject("x" , x );								// x축 기준
				mv.addObject("y" , y );								// y축 기준
				
				System.out.println(sVO.toString());
				System.out.println("dateList:"+dateList);
				System.out.println("jsonList:"+chartList);
				
				mv.setViewName("indicator/transfer/transfer_popUp_graph");
				return mv;
	}
}
