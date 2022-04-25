package com.ybs.indicator.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.service.CommonService;
import com.ybs.indicator.common.service.SearchVO;

@Controller
public class CommonController {
	
	@Resource(name = "commonService")
	private CommonService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	// cell1. Ajax (날짜, 분석자료, 지역)
	@ResponseBody
	@RequestMapping(value="/searchAnal.do")
	public ModelAndView selectPassSearchList(@ModelAttribute SearchVO sVO) {
		ModelAndView mv = new ModelAndView("jsonView");
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		
		sVO.setAnal_fin(sVO.getAnal_type());
		if(sVO.getAnal_group().equals("passRouteODCnt")
			|| sVO.getAnal_group().equals("passTopRotue")
			|| sVO.getAnal_group().equals("passTopStation")) {
			sVO.setAnal_fin(sVO.getAnal_group());
		}
		System.out.println(sVO.toString());
		
		passSearchList = service.selectPassSearchList(sVO);
		
		for(int i = 0; i < passSearchList.size(); i++) {
			System.out.println(passSearchList.get(i).toString());
		}
		mv.addObject("passSearchList", passSearchList);
		
		return mv;
	}
		
		
	@ResponseBody
	@RequestMapping(value="/searchRouteId.do")
	public ModelAndView selectPassRoutdIdList(@ModelAttribute SearchVO sVO) {
		ModelAndView mv = new ModelAndView("jsonView");
		System.out.println(sVO.toString());
		List<EgovMap> passRouteIdList = new ArrayList<EgovMap>();
		
		passRouteIdList = service.selectPassRouteIdList(sVO);
		
		for(int i = 0; i < 10; i++) {
			System.out.println(passRouteIdList.get(i).toString());
		}
		
		mv.addObject("passRouteIdList", passRouteIdList);
		
		return mv;
	}
}
