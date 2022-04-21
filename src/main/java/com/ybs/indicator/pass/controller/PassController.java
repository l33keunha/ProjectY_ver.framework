package com.ybs.indicator.pass.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.pass.service.PassService;
import com.ybs.indicator.pass.service.SearchVO;

@Controller
public class PassController {
	
	@Resource(name = "passService")
	private PassService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	// cell1. Ajax (날짜, 분석자료, 지역)
	@ResponseBody
	@RequestMapping(value="/selectPassSearchAjax.do")
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
	
	// 모든 조회는 form를 통해 해당 RequestMapping(value="/passTest.do")에 도착.
	@RequestMapping(value="/passTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.getDateStart().toString());
		System.out.println(sVO.toString());
		
		
		List<EgovMap> passResultList = new ArrayList<EgovMap>();  // 목적or수단 리스트
		List<EgovMap> passResultListB = new ArrayList<EgovMap>(); // 노선별or정류장별 버스 리스트
		List<EgovMap> passResultListT = new ArrayList<EgovMap>(); // 노선별or정류장별 지하철 리스트
				
		// 분석지표에 따라 리스트 받아오기
		if(sVO.getAnal_type()==null 
			|| sVO.getAnal_type().equals("passCnt_purpose") 
			|| sVO.getAnal_type().equals("passCnt_method")
			|| sVO.getAnal_type().equals("passAreaODCnt_purpose")
			|| sVO.getAnal_type().equals("passAreaODCnt_method")) {
			passResultList = service.selectPassResultList(sVO);
		}
		else if(sVO.getAnal_type().equals("passCnt_route") 
			|| sVO.getAnal_type().equals("passCnt_station")) {
			passResultListB = service.selectPassResultListB(sVO);
			passResultListT = service.selectPassResultListT(sVO);
		}
		
		// 값이 담긴 리스트에 맞춰 JSP에 보내주기
		if(passResultList.size() > 0) {
			for(int i = 0; i < 10; i++) {
				System.out.println(passResultList.get(i).toString());
			}
			mv.addObject("passResultList", passResultList);
		} else if (passResultListB.size() > 0 && passResultListT.size() > 0) {
			for(int i = 0; i < 10; i++) {
				System.out.println(passResultListB.get(i).toString());
			}
			
			for(int i = 0; i < 10; i++) {
				System.out.println(passResultListT.get(i).toString());
			}
			mv.addObject("passResultListB", passResultListB);
			mv.addObject("passResultListT", passResultListT);
		}
		
		mv.addObject("sVO", sVO);
//		mv.setViewName("indicator/pass_popUp");
				
		return mv;
	}
	

	
}
