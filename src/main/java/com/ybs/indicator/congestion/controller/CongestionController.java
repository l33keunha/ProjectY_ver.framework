package com.ybs.indicator.congestion.controller;

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
import com.ybs.indicator.congestion.service.CongestionService;

@Controller
public class CongestionController {
	
	@Resource(name = "congestionService")
	private CongestionService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/congestionTest.do")
	public ModelAndView selectCongestionResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.toString());
		
		List<EgovMap> congestionResultList = new ArrayList<EgovMap>();
		
		congestionResultList = service.selectCongestionResultList(sVO);
		
		if(congestionResultList.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(congestionResultList.get(i).toString());
			}
			mv.addObject("congestionResultList", congestionResultList);
		}
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
//		mv.setViewName("indicator/congestion/congestion_popUp");
		
		return mv;
	}

	

}
