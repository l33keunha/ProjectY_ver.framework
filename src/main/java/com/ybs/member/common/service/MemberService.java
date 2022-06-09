package com.ybs.member.common.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface MemberService {

	List<EgovMap> login(MemberVO mVO);

}
