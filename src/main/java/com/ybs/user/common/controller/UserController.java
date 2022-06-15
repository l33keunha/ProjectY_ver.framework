package com.ybs.user.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.user.common.service.UserService;
import com.ybs.user.common.service.UserVO;

@Controller
public class UserController {
	
	@Resource(name = "userService")
	private UserService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@ResponseBody
	@RequestMapping(value="/checkUser.do")
	public ModelAndView checkUser (@ModelAttribute UserVO uVO, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("jsonView");
		System.out.println(uVO.toString());
		
		/* 존재 유저 체크 */
		List<EgovMap> uList = new ArrayList<EgovMap>();
		uList = service.checkUser(uVO);
		
		if(uList.size() > 0) {
			mv.addObject("uList", uList);
		} else {
			mv.addObject("uList", null);
		}
		
		System.out.println(uList.toString());
		
		return mv;
	}
	
	@RequestMapping(value="/login.do")
	public ModelAndView login (ModelAndView mv, @ModelAttribute UserVO uVO, HttpServletRequest request) {
		
		/* 로그인 정보 담기 */
		uVO = service.login(uVO);
		
		
		/* 세션에 로그인 정보 담기 */
		// 세션생성
		HttpSession session = request.getSession();
		// 값 저장
		session.setAttribute("uVO", uVO);
		
		mv.setViewName("indicator/pass/pass_index");
		
		return mv;
	}
	
	@RequestMapping("/logout.do")
	public String logout(SessionStatus session) {
		session.setComplete();
		
		return "../../index";
	}
	

}
