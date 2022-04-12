/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

//import egovframework.example.sample.service.MainService;
import egovframework.example.sample.service.MainVO;


/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

//@Controller
//public class MainController {
//
//	@Resource(name = "mainService")
//	private MainService service;
//
//	/** Validator */
//	@Resource(name = "beanValidator")
//	protected DefaultBeanValidator beanValidator;
//	
//	@RequestMapping(value = "/main.do")
//	public ModelAndView selectSampleList(int top, ModelAndView mv) throws Exception {
////		List<EgovMap> list = service.selectSampleList(top);
//		List<EgovMap> list = service.selectSampleList();
//		
//		for(int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).toString());
//		}
//		
//		mv.addObject("list", list);
//		mv.setViewName("main");
//		
//		return mv;
//	}
//
//}
