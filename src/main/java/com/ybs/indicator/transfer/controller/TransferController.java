package com.ybs.indicator.transfer.controller;

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

}
