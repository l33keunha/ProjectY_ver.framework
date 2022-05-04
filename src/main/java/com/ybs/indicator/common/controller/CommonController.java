package com.ybs.indicator.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@RequestMapping(value="/goPassIndex.do")
	public ModelAndView goPassIndex (ModelAndView mv) {
		mv.setViewName("indicator/pass/pass_index");
		return mv;
	}
	
	@RequestMapping(value="/goDownloadIndex.do")
	public ModelAndView goDownloadIndex (ModelAndView mv) {
		mv.setViewName("indicator/download/download_index");
		return mv;
	}
		
	@RequestMapping(value="/goTransferIndex.do")
	public ModelAndView goTransferIndex (ModelAndView mv) {
		mv.setViewName("indicator/transfer/transfer_index");
		return mv;
	}
	
	@RequestMapping(value="/goCongestionIndex.do")
	public ModelAndView goCongestionIndex (ModelAndView mv) {
		mv.setViewName("indicator/congestion/congestion_index");
		return mv;
	}
	
	@RequestMapping(value="/goTimeDistnIndex.do")
	public ModelAndView goTimeDistnIndex (ModelAndView mv) {
		mv.setViewName("indicator/timeDistn/timeDistn_index");
		return mv;
	}
	
	// cell1. Ajax (날짜, 분석자료, 지역)
	@ResponseBody
	@RequestMapping(value="/searchAnal.do")
	public ModelAndView selectPassSearchList(@ModelAttribute SearchVO sVO) {
		ModelAndView mv = new ModelAndView("jsonView");
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		
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
		sVO.setDateStart(sVO.getDateStart().replaceAll("-", ""));
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
