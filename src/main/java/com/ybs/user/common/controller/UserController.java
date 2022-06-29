package com.ybs.user.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.indicator.common.controller.CommonController;
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
	
	
	
	/* 로그인 페이지 이동 ( 이전페이지 함께 저장 ) */
	@RequestMapping(value="/goLoginPage.do")
	public String goLoginPage (HttpServletRequest request) {
		
		/* 이전 페이지 기억 */
		HttpSession session = request.getSession();
		session.setAttribute("refererPage", request.getHeader("Referer"));
		
		return "user/login";
	}
	
	/* 로그인 페이지 이동 ( 팝업에서 넘어왔을 시 메인페이지로 이동 ) */
	@RequestMapping(value="/goLoginPagePopUp.do")
	public String goLoginPagePopUp (HttpServletRequest request) {
		
		/* 세션에 메인페이지 저장 */
		HttpSession session = request.getSession();
		session.setAttribute("refererPage", "/");
		
		return "user/login";
	}
	
	
	@RequestMapping(value="/login.do")
	public String login (ModelAndView mv, @ModelAttribute UserVO uVO, HttpServletRequest request, HttpSession session) {
		/* 로그인 정보 담기 */
		uVO = service.login(uVO);
		
		/* 세션에 로그인 정보 담기 */
		// 세션생성
		session = request.getSession();
		// 값 저장
		session.setAttribute("uVO", uVO);
		
		return "redirect:"+(String) session.getAttribute("refererPage");
	}
	


	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		return "redirect:/";
	}
	

}
