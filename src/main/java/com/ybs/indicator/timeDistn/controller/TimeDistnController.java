package com.ybs.indicator.timeDistn.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
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

import com.ybs.indicator.common.service.SearchVO;
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
		List<EgovMap> dataList = service.graphTimeDistnResultList(sVO, res); // 그래프 데이터 리스트
		
		mv.setViewName("indicator/transfer/timeDistn_popUp_graph");
		return mv;
	}

}

