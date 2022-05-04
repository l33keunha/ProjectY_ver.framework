package com.ybs.indicator.timeDistn.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
		System.out.println(sVO.toString());
		
		List<EgovMap> timeDistnResultListT = new ArrayList<EgovMap>();
		List<EgovMap> timeDistnResultListD = new ArrayList<EgovMap>();
		
		timeDistnResultListT = service.selectTimeDistnResultListT(sVO);
		timeDistnResultListD = service.selectTimeDistnResultListD(sVO);
		
		if(timeDistnResultListT.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(timeDistnResultListT.get(i).toString());
			}
			mv.addObject("timeDistnResultListT", timeDistnResultListT);
		} 
		
		if(timeDistnResultListD.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(timeDistnResultListD.get(i).toString());
			}
			mv.addObject("timeDistnResultListD", timeDistnResultListD);
		} 
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
//		mv.setViewName("indicator/timeDistn/timeDistn_popUp");
		
		return mv;
	}

}

