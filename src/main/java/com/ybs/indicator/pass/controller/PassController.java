package com.ybs.indicator.pass.controller;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping(value="/passTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, @ModelAttribute PassSearchVO pVO) {
		pVO.setPassDateStart(pVO.getPassDateStart().replace("-", "").toString());
		System.out.println(pVO.toString());
		
		List<EgovMap> passResultList = service.selectPassResultList(pVO); 

		for(int i = 0; i < passResultList.size(); i++) {
			System.out.println(passResultList.get(i).toString());
		}
		
		mv.addObject("passResultList", passResultList);
		mv.addObject("pVO", pVO);
		mv.setViewName("indicator/pass_popUp");
				
		return mv;
	}
	
}
