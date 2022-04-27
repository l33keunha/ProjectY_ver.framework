package com.ybs.indicator.download.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.download.service.DownloadService;

@Controller
public class DownloadController {
	@Resource(name = "DownloadService")
	private DownloadService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/downloadTest.do")
	public ModelAndView selectPassResultList(ModelAndView mv, HttpServletRequest req, @ModelAttribute SearchVO sVO) {
		System.out.println(sVO.toString());
		
		service.selectdownloadResultList(sVO);
		
		mv.addObject("sVO", sVO);
		mv.addObject("req", req);
		return mv;
	}
}
