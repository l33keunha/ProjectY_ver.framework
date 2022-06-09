package com.ybs.member.common.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.member.common.service.MemberVO;

@Mapper("memberMapper")
public interface MemberMapper {

	List<EgovMap> login(MemberVO mVO);
	
}
