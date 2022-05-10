package com.ybs.indicator.download.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	public void selectPassResultList(ModelAndView mv, HttpServletRequest req, HttpServletResponse res, @ModelAttribute SearchVO sVO) throws IOException {
      System.out.println(sVO.toString());
      
	  if(sVO.getAnal_type().equals("dlStation_stationCnt")
			  || sVO.getAnal_type().equals("dlRoute_routeCnt")) {
			/* service.selectdownloadResultListBT(sVO, req, res); */
		  service.selectdownloadResultList(sVO, req, res);
	  } else{
	     service.selectdownloadResultList(sVO, req, res);
	  }
	  
	  mv.addObject("sVO", sVO);
	  mv.addObject("req", req);
	    
	}
	
}
