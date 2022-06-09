package com.ybs.member.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.member.common.service.MemberService;
import com.ybs.member.common.service.MemberVO;

@Service("memberService")
@Transactional(rollbackFor = {Exception.class})
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService {
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Resource(name="memberMapper")
	private MemberMapper mapper;

	@Override
	public List<EgovMap> login(MemberVO mVO) {
		return mapper.login(mVO);
	}
}
