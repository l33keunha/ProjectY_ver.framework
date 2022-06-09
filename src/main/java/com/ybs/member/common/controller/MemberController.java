package com.ybs.member.common.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ybs.member.common.service.MemberService;
import com.ybs.member.common.service.MemberVO;

@Controller
public class MemberController {
	
	@Resource(name = "memberService")
	private MemberService service;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@RequestMapping(value="/login.do")
	public ModelAndView login (ModelAndView mv, @ModelAttribute MemberVO mVO, HttpServletRequest request) {
		
		/* 로그인 정보 담기 */
		List<EgovMap> mList = new ArrayList<EgovMap>();
		mList = service.login(mVO);
		
		/* 세션에 로그인 정보 담기 */
		// 세션생성
		HttpSession session = request.getSession();
		// 값 저장
		session.setAttribute("mNo", mList.get(0).get("no"));
		session.setAttribute("name", mList.get(0).get("name"));
		session.setAttribute("dept", mList.get(0).get("dept"));
		
		mv.setViewName("indicator/pass/pass_index");
		
		return mv;
	}
	

}
