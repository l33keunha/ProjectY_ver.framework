package com.ybs.indicator.timeDistn.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import com.ybs.indicator.timeDistn.service.TimeDistnService;

@Controller	
public class TimeDistnController {
	
	@Resource(name = "timeDistnService")
	private TimeDistnService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/timeDistnTest.do")
	public ModelAndView selectTimeDistnResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		sVO.setDateStart(sVO.getDateStart().replaceAll("-", ""));
		System.out.println(sVO.toString());
		
		List<EgovMap> timeDistnResultList = new ArrayList<EgovMap>();
		
		timeDistnResultList = service.selectTimeDistnResultList(sVO);
		
		if(timeDistnResultList.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(timeDistnResultList.get(i).toString());
			}
			mv.addObject("timeDistnResultList", timeDistnResultList);
			mv.setViewName("indicator/timeDistn/timeDistn_popUp");
		} else {
			mv.setViewName("common/error");
		}
		
		//노선별 일때만
		if("timeDistn_avg_route".equals(sVO.getAnal_group())) {
			//지정한 컬럼 키의 값 개수를 찾는 방법
			List<String> valueList = timeDistnResultList.stream().filter(t -> t.containsKey("tfcmn")).map(m -> m.get("tfcmn").toString()).collect(Collectors.toList());
			
			mv.addObject("busCnt",Collections.frequency(valueList, "버스"));
			mv.addObject("trainCnt",Collections.frequency(valueList, "지하철"));
		}
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		
		return mv;
	}

	@RequestMapping(value="/timeDistnDownload.do")
	public void donwloadTimeDistnResultList(@ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		System.out.println(sVO.toString());
		service.downloadTimeDistnResultList(sVO, res);
	}
	
	@RequestMapping(value="/timeDistnGraph.do")
	public ModelAndView graphTimeDistnResultList(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		//날짜 사이 날짜리스트 출력
		String dataFormatReturn = YbsUtil.getStringDateFormat(sVO.getDateStart() ,"yyyyMMdd" ,"yyyy-MM-dd");		
		sVO.setDateStart(dataFormatReturn);
		
		List<String> dateList = new ArrayList<String>();		//yyyy-MM-dd 형식
		List<String> dateListSt = new ArrayList<String>();		//yyyyMMdd 형식
	

		// 1일 조회 일떄 (통행량_노선별 통행)
		if("timeDistn_avg_route".equals(sVO.getAnal_group()) ) {
			
			dateList.add(sVO.getDateStart());
			dateListSt.add((sVO.getDateStart()).replaceAll("-", ""));
			
			
			//여러 날 조회 일때 
		}else {
			dateList =YbsUtil.getDayBetween( sVO.getDateStart(), sVO.getDateEnd(), "yyyy-MM-dd");
			dateListSt =YbsUtil.getDayBetween( (sVO.getDateStart()).replace("-", ""), (sVO.getDateEnd()).replace("-", ""), "yyyyMMdd");
		}
		
	
		
		List<EgovMap> dataList = service.graphTimeDistnResultList(sVO, res); // 그래프 데이터 리스트
		List<Integer> routeNmaListDst = new ArrayList<Integer>();
		List<Integer> routeNmaListTm = new ArrayList<Integer>();
		
		
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

		codeMap.put("B-dst", new Object[] {"버스-거리", 	"#84b2d9", "#84b2d9", "bar"});
		codeMap.put("T-dst", new Object[] {"지하철-거리", 	"#b6bcff", "#b6bcff", "bar"});
		codeMap.put("B-tm",  new Object[] {"버스-시간", 	"#ffb6b6", "#ffb6b6", "bar"});
		codeMap.put("T-tm",  new Object[] {"지하철-시간", 	"#ffc39f", "#ffc39f", "bar"});
		

		codeMap.put("dst", new Object[] {"거리", 	"#b6bcff", "#b6bcff", "y2" ,"line"});
		codeMap.put("tm",  new Object[] {"시간", 	"#ffb6b6", "#ffb6b6", "y", "bar"});
		

		String dateColumn ="";
		String jsonDataColumn = "";
		String dataCodeColumn = "";
		String labels = "";
		List<String> labelsArray = new ArrayList<String>();
		String x = "";
		String y = "";
		String y_right = "";
		String y_left = "";
		
		Gson gson = new Gson();
		
		
		
		//수단통행 평균 통행시간거리 그래프
		if("timeDistn_avg_method".equals(sVO.getAnal_group())) {
			
			List<String> brdngTmAvg_useDstAvg = new ArrayList<String>(); 
			List<String> btName = new ArrayList<String>(); 
			List<String> opratDate = new ArrayList<String>(); 
			
			for(int j=0; j<dataList.size(); j++) {
				
				//버스,지하철 - 시간 or 거리
				btName.add((String)dataList.get(j).get("tfcmn")+"-tm");
				btName.add((String)dataList.get(j).get("tfcmn")+"-dst");
				
				//날짜
				opratDate.add((String) dataList.get(j).get("opratDate"));
				opratDate.add((String) dataList.get(j).get("opratDate"));
				
				//시간 or 거리 데이터
				brdngTmAvg_useDstAvg.add((String) dataList.get(j).get("brdngTmAvg"));
				brdngTmAvg_useDstAvg.add((String) dataList.get(j).get("useDstAvg"));
			}
			
			int cnt = dataList.size()*2;
			dataList = new ArrayList<EgovMap>(); 
			
			//막대그래프를 먼저 넣고, 선그래프를 나중에 넣어야 데이터가 가려지지 않음
			for(int j=0; j<2; j++) {
			
				for(int k=0; k<cnt; k++) {
					
					if((j==1) && (k%2 == 0)) {
						EgovMap methodMap = new EgovMap();
						methodMap.put("opratDate", opratDate.get(k));
						methodMap.put("tfcmn", btName.get(k));
						methodMap.put("brdngtmavgUsedstavg", brdngTmAvg_useDstAvg.get(k));
						dataList.add(methodMap);
						
					}else if((j==0) && (k%2 != 0))  {
						EgovMap methodMap = new EgovMap();
						methodMap.put("opratDate", opratDate.get(k));
						methodMap.put("tfcmn", btName.get(k));
						methodMap.put("brdngtmavgUsedstavg", brdngTmAvg_useDstAvg.get(k));
						dataList.add(methodMap);
						
					}
					
				}
			}
			
		// 노선별 평균 통행시간거리_그래프;
		}else if("timeDistn_avg_route".equals(sVO.getAnal_group())) {
			List<String> routeNmaList = new ArrayList<String>();
			
		
			EgovMap routeMap =  new EgovMap();
			
			for(int i=0; i<dataList.size(); i++) {
				
				routeNmaList.add((String) dataList.get(i).get("routeNma"));
				routeNmaListDst.add(Integer.parseInt(dataList.get(i).get("useDstAvg").toString()));
				routeNmaListTm.add(Integer.parseInt(dataList.get(i).get("brdngTmAvg").toString()));
			}
	
			routeMap.put("opratDate", dataList.get(0).get("opratDate"));
			routeMap.put("routeNma", routeNmaList);
			routeMap.put("useDstAvg", routeNmaListDst);
			routeMap.put("brdngTmAvg", routeNmaListTm);
			
			dataList = new ArrayList<EgovMap>();
			dataList.add(routeMap);
			
		// 1일 평균 통행시간거리_그래프, 목적통행 평균 통행시간거리_그래프");	
		}else{
			
			List<String> btName = new ArrayList<String>(); 
			List<String> opratDate = new ArrayList<String>(); 
			List<String> brdngTmAvg_useDstAvg = new ArrayList<String>(); 
			
			for(int j=0; j<dataList.size(); j++) {
				
				//버스,지하철 - 시간 or 거리
				btName.add("dst");
				btName.add("tm");
				
				//날짜
				opratDate.add((String) dataList.get(j).get("opratDate"));
				opratDate.add((String) dataList.get(j).get("opratDate"));
				
				//시간 or 거리 데이터
				brdngTmAvg_useDstAvg.add((String) dataList.get(j).get("useDstAvg"));
				brdngTmAvg_useDstAvg.add((String) dataList.get(j).get("brdngTmAvg"));
			}
			
			int cnt = dataList.size()*2;
			dataList = new ArrayList<EgovMap>(); 
			
			for(int k=0; k<cnt; k++) {
				EgovMap methodMap = new EgovMap();
				
				methodMap.put("opratDate", opratDate.get(k));
				methodMap.put("tfcmn", btName.get(k));
				methodMap.put("brdngtmavgUsedstavg", brdngTmAvg_useDstAvg.get(k));
			
				dataList.add(methodMap);
			}
			
		}
	
		
		for(int v=0; v<sVO.getCd_no().length; v++) {
			if("00".equals(sVO.getCd_no()[v])) {
				continue;
			}
			labelsArray.add((String)codeMap.get(sVO.getCd_no()[v])[0]);
		}
		
		
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
				//System.out.println("1일 평균 통행시간거리_그래프");
				dateColumn = "opratDate";						// 날짜 컬럼
				jsonDataColumn = "brdngtmavgUsedstavg";			// 표출 데이터 컬럼
				dataCodeColumn = "tfcmn";						// 그래프 속성 컬럼
				labels = gson.toJson(labelsArray);				// x축 표출 이름
				
				x = "이용자유형";					// x축
				y_left = "평균시간";				// 왼쪽 y축 
				y_right = "평균거리";				// 오른쪽 y축 
				
				break;
			
		case "timeDistn_avg_purpose" :
				//System.out.println("목적통행 평균 통행시간거리_그래프");
				dateColumn = "opratDate";						// 날짜 컬럼
				jsonDataColumn = "brdngtmavgUsedstavg";			// 표출 데이터 컬럼
				dataCodeColumn = "tfcmn";						// 그래프 속성 컬럼
				labels = gson.toJson(labelsArray);				// x축 표출 이름
				
				x = "이용자유형";					// x축
				y_left = "평균시간";				// 왼쪽 y축 
				y_right = "평균거리";				// 오른쪽 y축 
			
				break;
		
		case "timeDistn_avg_method" :
				//System.out.println("수단통행 평균 통행시간거리_그래프");
				dateColumn = "opratDate";						// 날짜 컬럼
				jsonDataColumn = "brdngtmavgUsedstavg";			// 표출 데이터 컬럼
				dataCodeColumn = "tfcmn";						// 그래프 속성 컬럼
				labels = gson.toJson(labelsArray);				// x축 표출 이름
				
				x = "이용자유형";					// x축
				y_left = "평균시간";				// 왼쪽 y축 
				y_right = "평균거리";				// 오른쪽 y축 
				
				
				break;
			
		case "timeDistn_avg_route" :
				//System.out.println("노선별통행 평균 통행시간거리_그래프");
				dateColumn = "opratDate";									// 날짜 컬럼
				labels = gson.toJson(dataList.get(0).get("routeNma"));		// x축 표출 이름
				
				x = "노선명";					// x축
				y_left = "평균시간";				// 왼쪽 y축 
				y_right = "평균거리";				// 오른쪽 y축 
				
				break;
		}
		
		
		
		
		
		//데이터 가공 후, 출력
		/////////////////////////////////////////////////////////////////////
		
		
		Map<String, List<Map<String, Object>>> allDay = new HashMap<String, List<Map<String, Object>>> ();
		
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
				allDay.put((String) tempItem.get(dateColumn), listOfDay);
			}
			
			//string 배열 -> int 배열 변환
			int[] data;
			int[] data1 = null;
			
			//노선별통행 평균 통행시간거리_그래프
			if("timeDistn_avg_route".equals(sVO.getAnal_group()) ) {	
				
				 data = routeNmaListDst.stream().mapToInt(Integer::intValue).toArray(); 
				 data1 = routeNmaListTm.stream().mapToInt(Integer::intValue).toArray(); 
			}else {
				data = Arrays.asList((tempItem.get(jsonDataColumn).toString()).split(",")).stream().mapToInt(Integer::parseInt).toArray();
			}
			
			
			//4. map을 생성해 해당 정보를 list에 담는다.
			Map<String, Object> dayItem = new HashMap<String, Object>();
		
			
			switch(sVO.getAnal_group()) {
			case "timeDistn_avg_day": 														   
				//System.out.println("1일 평균 통행시간거리_그래프");

				dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn).toString())[0]);
				dayItem.put("type", codeMap.get(tempItem.get(dataCodeColumn).toString())[4]);
				dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[1]);
				dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[2]);
				dayItem.put("data", data);
				dayItem.put("yAxisID", codeMap.get(tempItem.get(dataCodeColumn).toString())[3]);
				
				listOfDay.add(dayItem);
				
				break;
			case "timeDistn_avg_purpose":                                                         
				//System.out.println("목적통행 평균 통행시간거리_그래프");
				
				dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn).toString())[0]);
				dayItem.put("type", codeMap.get(tempItem.get(dataCodeColumn).toString())[4]);
				dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[1]);
				dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[2]);
				dayItem.put("data", data);
				dayItem.put("yAxisID", codeMap.get(tempItem.get(dataCodeColumn).toString())[3]);
				
				listOfDay.add(dayItem);
				
				break;
			case "timeDistn_avg_method":                                                
				//System.out.println("수단통행 평균 통행시간거리_그래프");
				
				dayItem.put("label", codeMap.get(tempItem.get(dataCodeColumn).toString())[0]);
				dayItem.put("type", codeMap.get(tempItem.get(dataCodeColumn).toString())[3]);
				dayItem.put("backgroundColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[1]);
				dayItem.put("borderColor", codeMap.get(tempItem.get(dataCodeColumn).toString())[2]);
				dayItem.put("data", data);
				
				listOfDay.add(dayItem);
				
				break;	
			case "timeDistn_avg_route":                                                
				//System.out.println("노선별통행 평균 통행시간거리_그래프");
				
				dayItem = new HashMap<String, Object>();
				dayItem.put("label", "거리");
				dayItem.put("type", "line");
				dayItem.put("backgroundColor", "#b6bcff" );
				dayItem.put("borderColor", "#b6bcff");
				dayItem.put("data", data);
				dayItem.put("yAxisID", "y2");
				listOfDay.add(dayItem);
				
				dayItem = new HashMap<String, Object>();
				dayItem.put("label", "시간");
				dayItem.put("type", "bar");
				dayItem.put("backgroundColor", "#ffb6b6" );
				dayItem.put("borderColor", "rgb(255, 99, 132)");
				dayItem.put("data", data1);
				dayItem.put("yAxisID", "y");
				listOfDay.add(dayItem);
				
				break;	
			}
			
			
		}
		
	
	
		
		if("timeDistn_avg_method".equals(sVO.getAnal_group())) {
			List<String> chartListTm = new ArrayList<String>();
			List<String> chartListDst = new ArrayList<String>();
			
			Map<String, Object> allDayTm = new HashMap<String, Object>();
			Map<String, Object> allDayDst = new HashMap<String, Object>();
			
			List<Map<String,Object>> mapListTm = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> mapListDst = new ArrayList<Map<String,Object>>();
			
			for(String key : dateListSt) {
		
				mapListTm = new ArrayList<Map<String,Object>>();
				mapListTm.add((Map<String, Object>) (allDay.get(key)).get(0));
				mapListTm.add((Map<String, Object>) (allDay.get(key)).get(1));
				allDayTm.put((String)key, (Object)mapListTm);				
				chartListTm.add(gson.toJson(allDayTm.get(key)));
				
				mapListDst = new ArrayList<Map<String,Object>>();
				mapListDst.add((Map<String, Object>) (allDay.get(key)).get(2));
				mapListDst.add((Map<String, Object>) (allDay.get(key)).get(3));
				allDayDst.put((String)key, (Object)mapListDst);
				chartListDst.add(gson.toJson(allDayDst.get(key)));
			
			}
			
			mv.addObject("jsonListTm", chartListTm);				// json 데이터 (시간 데이터)
			mv.addObject("jsonListDst", chartListDst);				// json 데이터 (거리 데이터)
			
			
		}else{
			
			List<String> chartList = new ArrayList<String>();
			for(String key : dateListSt) {
				chartList.add(gson.toJson(allDay.get(key)));
			}
			
			mv.addObject("jsonList", chartList);				// json 데이터 (x축 데이터)
			
		}
	
		mv.addObject("dateList", dateList);					// 날짜
		mv.addObject("sVO", sVO);
		mv.addObject("labels" , labels );					// json 데이터 (x축 이름)
		mv.addObject("x" , x );								// x축 기준
		mv.addObject("y" , y );								// y축 기준
		mv.addObject("y_left" , y_left );					// y축 왼쪽 기준
		mv.addObject("y_right" , y_right );					// y축 오른쪽 기준
		
		
		mv.setViewName("indicator/timeDistn/timeDistn_popUp_graph");
		return mv;
	}
}

