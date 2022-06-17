package com.ybs.indicator.map.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.map.service.MapService;

@Controller
public class MapController {
	
	@Resource(name = "mapService")
	private MapService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	

	
}
