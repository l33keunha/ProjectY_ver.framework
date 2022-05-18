package com.ybs.indicator.transfer.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.transfer.service.TransferService;

@Controller
public class TransferController {
	
	@Resource(name = "transferService")
	private TransferService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/transferTest.do")
	public ModelAndView selectTransferResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.toString());
		
		List<EgovMap> transferResultList = new ArrayList<EgovMap>();
		List<EgovMap> transferResultListB = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 버스 리스트
		List<EgovMap> transferResultListT = new ArrayList<EgovMap>(); 		 // 노선별or정류장별 지하철 리스트
		
		if(sVO.getAnal_type().equals("transferCnt_station")
			|| sVO.getAnal_type().equals("transferCnt_route")) {
			transferResultListB = service.selectTransferResultListB(sVO);
			if(transferResultListB.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(transferResultListB.get(i).toString());
				}
				mv.addObject("transferResultListB", transferResultListB);
			}
			
			transferResultListT = service.selectTransferResultListT(sVO);
			if(transferResultListT.size() > 0) {
				for(int i = 0; i < 2; i++) {
					System.out.println(transferResultListT.get(i).toString());
				}
				mv.addObject("transferResultListT", transferResultListT);
			}
		}
		
		transferResultList = service.selectTransferResultList(sVO);
		
		if(transferResultList.size() > 0) {
			for(int i = 0; i < 2; i++) {
				System.out.println(transferResultList.get(i).toString());
			}
			mv.addObject("transferResultList", transferResultList);
		}
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		mv.setViewName("indicator/transfer/transfer_popUp");
		
		return mv;
	}
	
	@RequestMapping(value="/transferDownload.do")
	public void donwloadTransferResultList(@ModelAttribute SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		System.out.println(sVO.toString());
		service.downloadTransferResultList(sVO, res);
	}

}
