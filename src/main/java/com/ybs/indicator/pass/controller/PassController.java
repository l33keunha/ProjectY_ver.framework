package com.ybs.indicator.pass.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.pass.service.PassService;

@Controller
public class PassController {
	
	@Resource(name = "passService")
	private PassService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	

	
	// 모든 조회는 form를 통해 해당 RequestMapping(value="/passTest.do")에 도착.
	@RequestMapping(value="/passTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.toString());
		
		List<EgovMap> passResultList = new ArrayList<EgovMap>(); 		 // 목적or수단 리스트
		List<EgovMap> passResultListB = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 버스 리스트
		List<EgovMap> passResultListT = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 지하철 리스트
		
		// 분석지표에 따라 리스트 받아오기
		if(sVO.getAnal_type()==null 
			|| sVO.getAnal_type().equals("passCnt_purpose") 
			|| sVO.getAnal_type().equals("passCnt_method")
			|| sVO.getAnal_type().equals("passAreaODCnt_purpose")
			|| sVO.getAnal_type().equals("passAreaODCnt_method")) {
			passResultList = service.selectPassResultList(sVO);
			// 값이 담긴 리스트에 맞춰 JSP에 보내주기 - 리스트
			if(passResultList.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(passResultList.get(i).toString());
				}
				mv.addObject("passResultList", passResultList);
			}else {
				System.out.println("리스트 존재하지않음");
			}
		}
		else if(sVO.getAnal_type().equals("passCnt_route") 
			|| sVO.getAnal_type().equals("passCnt_station")) {
			passResultListB = service.selectPassResultListB(sVO);
			// 값이 담긴 리스트에 맞춰 JSP에 보내주기 - 버스리스트
			if (passResultListB.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(passResultListB.get(i).toString());
				}
				mv.addObject("passResultListB", passResultListB);
			}else {
				System.out.println("버스 리스트 존재하지않음");
			}
			
			passResultListT = service.selectPassResultListT(sVO);
			// 값이 담긴 리스트에 맞춰 JSP에 보내주기 - 지하철리스트
			if (passResultListT.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(passResultListT.get(i).toString());
				}
				mv.addObject("passResultListT", passResultListT);
			}else {
				System.out.println("지하철 리스트 존재하지않음");
			}
		} 
		
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		mv.setViewName("indicator/pass/pass_popUp");
				
		return mv;
	}
	
	@RequestMapping(value="/passDownload.do")
	public void downloadPassResultList(@ModelAttribute SearchVO sVO, HttpServletResponse res) {
		System.out.println(sVO.toString());
		service.downloadPassResultList(sVO, res);
	}
	
	@RequestMapping(value="/routeOD.do")
	public ModelAndView selectRouteOD(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		// 문자열 길이 비교하기 위한 int변수 담기
		sVO.setTmStart(sVO.getAnal_area_cd().length());
		// 운행일자 형식에 맞게 변환
		sVO.setDateStart(sVO.getDateStart().replaceAll("-", ""));
		System.out.println(sVO.toString());
		
		List<EgovMap> stationNmList = new ArrayList<EgovMap>(); // 정류장명칭 리스트
		ArrayList<ArrayList<Object>> routeOD = new ArrayList<ArrayList<Object>>(); // routeOD
		
		stationNmList = service.selectStationNmList(sVO);
		if (stationNmList.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(stationNmList.get(i).toString());
			}
			mv.addObject("stationNmList", stationNmList);
		}
		
		routeOD = service.selectRouteOD(sVO);
		if (routeOD.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(routeOD.get(i).toString());
			}
			mv.addObject("routeOD", routeOD);
		}
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		mv.setViewName("indicator/pass/tableList/pass_popUp_passRouteODmatrix");
		
		return mv;
	}
	
	
	@RequestMapping(value="/passGraph.do")
	public ModelAndView graphPassResultList(ModelAndView mv, @ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		List<EgovMap> passResultList = new ArrayList<EgovMap>(); // 정류장명칭 리스트
		System.out.println(sVO.toString());
		passResultList = service.graphPassResultList(sVO, res);
		if (passResultList.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(passResultList.get(i).toString());
			}
			mv.addObject("passResultList", passResultList);
		}
		
//		mv.setViewName("indicator/pass/pass_popUp");
		return mv;
	}
	
	
}
