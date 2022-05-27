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
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		
		return mv;
	}

}

