package com.ybs.indicator.pass.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.javassist.expr.NewArray;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.pass.service.PassSearchVO;
import com.ybs.indicator.pass.service.PassService;

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
	public ModelAndView selectPassSearchAjax(@ModelAttribute PassSearchVO pVO) {
		ModelAndView mv = new ModelAndView("jsonView");
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		pVO.setPassDateStart(pVO.getPassDateStart().replace("-", "").toString());
		pVO.setPassDateEnd(pVO.getPassDateEnd().replace("-", "").toString());
		
		System.out.println(pVO.toString());
		
		passSearchList = service.selectPassSearchAjax(pVO);
		
		for(int i = 0; i < passSearchList.size(); i++) {
			System.out.println(passSearchList.get(i).toString());
		}
		
		mv.addObject("passSearchList", passSearchList);
		
		return mv;
	}
	
	// 모든 조회는 form를 통해 해당 RequestMapping(value="/passTest.do")에 도착.
	@RequestMapping(value="/passTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, @ModelAttribute PassSearchVO pVO) {
		pVO.setPassDateStart(pVO.getPassDateStart().replace("-", "").toString());
		pVO.setPassDateEnd(pVO.getPassDateEnd().replace("-", "").toString());
		System.out.println(pVO.toString());
		
		List<EgovMap> passResultList = new ArrayList<EgovMap>();  // 목적or수단 리스트
		List<EgovMap> passResultListB = new ArrayList<EgovMap>(); // 노선별or정류장별 버스 리스트
		List<EgovMap> passResultListT = new ArrayList<EgovMap>(); // 노선별or정류장별 지하철 리스트
				
		passResultList = service.selectPassResultList(pVO);  // 목적,수단 리스트
		
		if(pVO.getPassGroup().equals("passCnt")) {
			if(pVO.getPassType().equals("passCnt_purpose")) {
				passResultList = service.selectPassResultList(pVO); 
			} else if (pVO.getPassType().equals("passCnt_method")) {
				passResultList = service.selectPassResultList(pVO); 
			} else if (pVO.getPassType().equals("passCnt_route")) {
				passResultListB = service.selectPassResultListRouteB(pVO);
				passResultListT = service.selectPassResultListRouteT(pVO); 
			} else if (pVO.getPassType().equals("passCnt_station")) {
				passResultListB = service.selectPassResultListStationB(pVO); 
				passResultListT = service.selectPassResultListStationT(pVO); 
			}
		}
		
		if(passResultList.size() > 0) {
			for(int i = 0; i < passResultList.size(); i++) {
				System.out.println(passResultList.get(i).toString());
			}
			mv.addObject("passResultList", passResultList);
		} else if (passResultListB.size() > 0 && passResultListT.size() > 0) {
			for(int i = 0; i < passResultListB.size(); i++) {
				System.out.println(passResultListB.get(i).toString());
			}
			
			for(int i = 0; i < passResultListT.size(); i++) {
				System.out.println(passResultListT.get(i).toString());
			}
			mv.addObject("passResultListB", passResultListB);
			mv.addObject("passResultListT", passResultListT);
		}
		
		mv.addObject("pVO", pVO);
		mv.setViewName("indicator/pass_popUp");
				
		return mv;
	}
	

	
}
