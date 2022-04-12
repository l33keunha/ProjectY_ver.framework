package com.ybs.indicator.pass.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.ybs.indicator.pass.service.PassSearchVO;
import com.ybs.indicator.pass.service.PassService;

@Service("passService")
public class PassServiceImpl extends EgovAbstractServiceImpl implements PassService{

	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="passMapper")
	private PassMapper mapper;
	
	@Override
	public List<EgovMap> selectPassSearchAjax(PassSearchVO pVO) {
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		
		// 1. 받아오는 값이 날짜 뿐일 때, 존재하는 분석자료 찾기
		if(pVO.getPassDateEnd() != null && pVO.getPassOwner() == null) {
			System.out.println("1케이스에 도착");
			passSearchList = mapper.selectPassSearchAjaxOwner(pVO);
		} // 2. 받아오는 값에 분석자료가 있을 때, 존재하는 시도 찾기 
		else if(pVO.getPassDateEnd() != null && pVO.getPassOwner() != null 
				&& pVO.getPassSido() == null || pVO.getPassSido().equals("광역/도")) {
			System.out.println("2케이스에 도착");
			passSearchList = mapper.selectPassSearchAjaxSido(pVO);
		} // 3. 받아오는 값에 시도가 있을 때, 존재하는 시군구찾기
		else if(pVO.getPassDateEnd() != null && pVO.getPassOwner() != null && !pVO.getPassSido().equals("광역/도")) {
			System.out.println("3케이스에 도착");
			passSearchList = mapper.selectPassSearchAjaxSigungu(pVO);
		}
		
		return passSearchList;
	}


	@Override
	public List<EgovMap> selectPassResultList(PassSearchVO pVO) {
		List<EgovMap> passResultList = new ArrayList<EgovMap>();
		
		switch(pVO.getPassType()) {
		case "passCnt_purpose": 
			passResultList = mapper.selectPassResultListPurpose(pVO); break;
		case "passCnt_method":
			passResultList = mapper.selectPassResultListMethod(pVO); break;
		}
		return passResultList;
	}


	@Override
	public List<EgovMap> selectPassResultListRouteB(PassSearchVO pVO) {
		return mapper.selectPassResultListRouteB(pVO);
	}


	@Override
	public List<EgovMap> selectPassResultListRouteT(PassSearchVO pVO) {
		return mapper.selectPassResultListRouteT(pVO);
	}


	@Override
	public List<EgovMap> selectPassResultListStationB(PassSearchVO pVO) {
		return mapper.selectPassResultListStationB(pVO);
	}


	@Override
	public List<EgovMap> selectPassResultListStationT(PassSearchVO pVO) {
		return mapper.selectPassResultListStationT(pVO);
	}

	
}
