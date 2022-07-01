package com.ybs.indicator.map.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.map.service.MapService;

@Controller
public class MapController {
	
	@Resource(name = "mapService")
	private MapService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/mapTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		mv.setViewName("indicator/map/map_popUp");
		return mv;
	}
}
