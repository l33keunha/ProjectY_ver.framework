package com.ybs.indicator.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.service.CommonService;
import com.ybs.indicator.common.service.SearchVO;
import com.ybs.user.common.service.UserVO;

@Controller
public class CommonController {
	
	@Resource(name = "commonService")
	private CommonService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/goMainPage.do")
	public String goMainpage (ModelAndView mv) {
		return "redirect:/";
	}
	
	@RequestMapping(value="/goError.do")
	public ModelAndView goError (ModelAndView mv) {
		mv.setViewName("common/error");
		return mv;
	}
	
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
	
	@RequestMapping(value="/goMapIndex.do")
	public ModelAndView goMapIndex (ModelAndView mv) {
		mv.setViewName("indicator/map/map_index");
		return mv;
	}
	
	
	
	// 조회조건 공통 cell3 
	@ResponseBody
	@RequestMapping(value="/searchAnal.do")
	public ModelAndView selectPassSearchList(@ModelAttribute SearchVO sVO, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("jsonView");
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		
		HttpSession session = request.getSession();
		
		UserVO uVO = (UserVO)session.getAttribute("uVO");
		sVO.setuNo(uVO.getuNo());
		
		System.out.println(sVO.toString());
		
		passSearchList = service.selectPassSearchList(sVO);
		
		for(int i = 0; i < passSearchList.size(); i++) {
			System.out.println(passSearchList.get(i).toString());
		}
		mv.addObject("passSearchList", passSearchList);
		
		return mv;
	}
		
	
	// 노선별OD : 지역에 따른 노선Id 조회
	@ResponseBody
	@RequestMapping(value="/searchRouteId.do")
	public ModelAndView selectPassRoutdIdList(@ModelAttribute SearchVO sVO) {
		ModelAndView mv = new ModelAndView("jsonView");
		sVO.setDateStart(sVO.getDateStart().replaceAll("-", ""));
		System.out.println(sVO.toString());
		List<EgovMap> passRouteIdList = new ArrayList<EgovMap>();
		
		passRouteIdList = service.selectPassRouteIdList(sVO);
		
		for(int i = 0; i < 2; i++) {
			System.out.println(passRouteIdList.get(i).toString());
		}
		
		mv.addObject("passRouteIdList", passRouteIdList);
		
		return mv;
	}
	
	
	// 자료에 따른 이용자유형 조회
	@ResponseBody
	@RequestMapping(value="/searchCdNo.do")
	public ModelAndView selectCdNoList(@ModelAttribute SearchVO sVO) {
		ModelAndView mv = new ModelAndView("jsonView");
		sVO.setDateStart(sVO.getDateStart().replaceAll("-", ""));
		System.out.println("이용자유형 Ajax:" + sVO.toString());
		List<EgovMap> cdNoList = new ArrayList<EgovMap>();
		
		cdNoList = service.selectCdNoList(sVO);
		
		for(int i = 0; i < 2; i++) {
			System.out.println(cdNoList.get(i).toString());
		}
		
		mv.addObject("cdNoList", cdNoList);
		
		return mv;
	}
	
	
	// 다운로드 가능 지역에 따른 status 조회
	@ResponseBody
	@RequestMapping(value="/searchStatus.do")
	public ModelAndView selectSearchStatusList(@ModelAttribute SearchVO sVO, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("jsonView");
		List<EgovMap> searchStatusList = new ArrayList<EgovMap>();
		
		HttpSession session = request.getSession();
		
		UserVO uVO = (UserVO)session.getAttribute("uVO");
		sVO.setuNo(uVO.getuNo());
		
		System.out.println(sVO.toString());
		
		searchStatusList = service.selectSearchStatusList(sVO);
		
		for(int i = 0; i < searchStatusList.size(); i++) {
			System.out.println(searchStatusList.get(i).toString());
		}
		mv.addObject("searchStatusList", searchStatusList);
		
		return mv;
	}
}
