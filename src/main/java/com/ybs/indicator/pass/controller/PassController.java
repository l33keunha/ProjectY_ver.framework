package com.ybs.indicator.pass.controller;

import java.text.ParseException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.google.gson.Gson;
import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.common.service.YbsUtil;
import com.ybs.indicator.pass.service.PassService;

@Controller
public class PassController {
	
	@Resource(name = "passService")
	private PassService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	

	
	// 모든 조회는 form를 통해 해당 RequestMapping(value="/passTest.do")에 도착.
	@RequestMapping(value="/passTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.toString());
		
		List<EgovMap> passResultList = new ArrayList<EgovMap>(); 		 // 목적or수단 리스트
		List<EgovMap> passResultListB = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 버스 리스트
		List<EgovMap> passResultListT = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 지하철 리스트
		
		// 분석지표에 따라 리스트 받아오기
		if(sVO.getAnal_type()==null 
			|| sVO.getAnal_type().equals("passCnt_purpose") 
			|| sVO.getAnal_type().equals("passCnt_method")
			|| sVO.getAnal_type().equals("passAreaODCnt_purpose")
			|| sVO.getAnal_type().equals("passAreaODCnt_method")) {
			passResultList = service.selectPassResultList(sVO);
			// 값이 담긴 리스트에 맞춰 JSP에 보내주기 - 리스트
			if(passResultList.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(passResultList.get(i).toString());
				}
				mv.addObject("passResultList", passResultList);
				mv.setViewName("indicator/pass/pass_popUp");
			}else {
				System.out.println("리스트 존재하지않음");
				mv.setViewName("common/error");
			}
		}
		else if(sVO.getAnal_type().equals("passCnt_route") 
			|| sVO.getAnal_type().equals("passCnt_station")) {
			passResultListB = service.selectPassResultListB(sVO);
			// 값이 담긴 리스트에 맞춰 JSP에 보내주기 - 버스리스트
			if (passResultListB.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(passResultListB.get(i).toString());
				}
				mv.addObject("passResultListB", passResultListB);
				mv.setViewName("indicator/pass/pass_popUp");
			}else {
				System.out.println("버스 리스트 존재하지않음");
			}
			
			passResultListT = service.selectPassResultListT(sVO);
			// 값이 담긴 리스트에 맞춰 JSP에 보내주기 - 지하철리스트
			if (passResultListT.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(passResultListT.get(i).toString());
				}
				mv.addObject("passResultListT", passResultListT);
				mv.setViewName("indicator/pass/pass_popUp");
			}else {
				System.out.println("지하철 리스트 존재하지않음");
			}
		} 
		
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
				
		return mv;
	}
	
	@RequestMapping(value="/passDownload.do")
	public void downloadPassResultList(@ModelAttribute SearchVO sVO, HttpServletResponse res) {
		System.out.println(sVO.toString());
		service.downloadPassResultList(sVO, res);
	}
	
	@RequestMapping(value="/routeOD.do")
	public ModelAndView selectRouteOD(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		// 문자열 길이 비교하기 위한 int변수 담기
		sVO.setTmStart(sVO.getAnal_area_cd().length());
		// 운행일자 형식에 맞게 변환
		sVO.setDateStart(sVO.getDateStart().replaceAll("-", ""));
		System.out.println(sVO.toString());
		
		List<EgovMap> stationNmList = new ArrayList<EgovMap>(); // 정류장명칭 리스트
		ArrayList<ArrayList<Object>> routeOD = new ArrayList<ArrayList<Object>>(); // routeOD
		
		stationNmList = service.selectStationNmList(sVO);
		if (stationNmList.size() > 0) {
			mv.addObject("stationNmList", stationNmList);
		}  
		
		routeOD = service.selectRouteOD(sVO);
		if (routeOD.size() > 0) {
			mv.addObject("routeOD", routeOD);
		} 
		
		mv.setViewName("indicator/pass/pass_popUp");
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		
		
		return mv;
	}
	
	
	@RequestMapping(value="/passGraph.do")
	public ModelAndView graphPassResultList(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) throws ParseException {
			//날짜 사이 날짜리스트 출력
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			
				List<String> dateList = new ArrayList<String>();	//yyyy-MM-dd 형식
				List<String> dateListSt = new ArrayList<String>();		//yyyyMMdd 형식
			

				// 1일 조회 일떄 (통행량_노선별 통행)
				if("passCnt_route".equals(sVO.getAnal_type()) ) {
					
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
						timeList.add(k+"시");
					}
				}
				
				
				
				
				List<EgovMap> dataList = service.graphPassResultList(sVO, res); // 그래프 데이터 리스트
				List<String> routeNmaList = new ArrayList<String>();
				List<Integer> userCntAggList = new ArrayList<Integer>();
				
				//통행지표_노선별통행_그래프 (행 수가 너무 많은 관계로 for 문으로 데이터를 차트형식에 맞춰준다. )
				if("passCnt_route".equals(sVO.getAnal_type()) ) {
					
					EgovMap routeMap =  new EgovMap();
					
					for(int i=0; i<dataList.size(); i++) {
						
						routeNmaList.add((String) dataList.get(i).get("routeNma"));
						userCntAggList.add(Integer.parseInt(dataList.get(i).get("ginGffSum").toString()));
					}
			
					routeMap.put("opratDate", dataList.get(0).get("opratDate"));
					routeMap.put("routeNma", routeNmaList);
					routeMap.put("userCntAgg", userCntAggList);
					
					dataList = new ArrayList<EgovMap>();
					dataList.add(routeMap);
				}
				
				
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

				

				String dateColumn ="";
				String jsonDataColumn = "";
				String dataCodeColumn = "";
				String labels = "";
				String [] labelsArray; 
				String x = "";
				String y = "";
				
				Gson gson = new Gson();
				
				System.out.println("sVO.getAnal_type():"+sVO.getAnal_type());
				switch(sVO.getAnal_type()) {
				case "passCnt_purpose": 														    // 통행량_목적통행
					System.out.println("목적통행_그래프");

					dateColumn = "opratDate";						// 날짜 컬럼
					jsonDataColumn = "userCntAgg";					// 표출 데이터 컬럼
					dataCodeColumn = "cdNo";						// 그래프 속성 컬럼
					labels = gson.toJson(timeList);					// x축 표출 이름
					x = "시간";			// x축
					y = "통행량";			// y축 
					break;
				case "passCnt_method":                                                              // 통행량_수단통행
					System.out.println("수단통행_그래프");

					dateColumn = "opratDate";						// 날짜 컬럼
					jsonDataColumn = "userCntAgg";					// 표출 데이터 컬럼
					dataCodeColumn = "cdNo";						// 표출 기준 컬럼
					labels = gson.toJson(timeList);					// x축 표출 이름
					x = "시간";			// x축
					y = "통행량";			// y축 
					break;
				case "passCnt_route":                                                       		// 통행량_노선별통행
					System.out.println("노선별통행_그래프");
					
					dateColumn = "opratDate";									// 날짜 컬럼
					jsonDataColumn = "ginGffSum";								// 표출 데이터 컬럼
					labels = gson.toJson(dataList.get(0).get("routeNma"));		// x축 표출 이름
					x = "노선";			// x축
					y = "통행량";			// y축 
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
					int[] data;
					
					//환승_노선별통행_그래프
					if("passCnt_route".equals(sVO.getAnal_type()) ) {	
						data = userCntAggList.stream().mapToInt(Integer::intValue).toArray(); 
					}else {
						data = Arrays.asList((tempItem.get(jsonDataColumn).toString()).split(",")).stream().mapToInt(Integer::parseInt).toArray();
					}
					
					
					//4. map을 생성해 해당 정보를 list에 담는다.
					Map<String, Object> dayItem = new HashMap<String, Object>();
				
					
					switch(sVO.getAnal_type()) {
					case "passCnt_purpose": 														    // 통행량_목적통행
						//System.out.println("목적통행_그래프");
						
						dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn))[0]);
						dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn))[1]);
						dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn))[2]);
						dayItem.put("data", data);
						
						listOfDay.add(dayItem);
						break;
					case "passCnt_method":                                                              // 통행량_수단통행
						//System.out.println("수단통행_그래프");
						
						dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn))[0]);
						dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn))[1]);
						dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn))[2]);
						dayItem.put("data", data);
						
						listOfDay.add(dayItem);
						break;
					case "passCnt_route":                                                       		// 통행량_노선별통행
						//System.out.println("노선별통행_그래프");
							
						dayItem.put("label", "합계(승차+하차)");
						dayItem.put("backgroundColor","#ffb6b6");
						dayItem.put("borderColor",  "rgb(255, 99, 132)");
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
				
				
				mv.setViewName("indicator/pass/pass_popUp_graph");
				return mv;
	}
	
	
	@RequestMapping(value="/passMap.do")
	public ModelAndView passMap(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		
		mv.setViewName("indicator/pass/pass_popUp_map");
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		
		return mv;
	}
	
	
}
