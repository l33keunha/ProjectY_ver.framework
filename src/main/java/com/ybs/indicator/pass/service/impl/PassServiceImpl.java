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
	public List<EgovMap> selectPassResultList(PassSearchVO pVO) {
		List<EgovMap> passResultList = new ArrayList<EgovMap>();
		
		
		if(pVO.getPassGroup().equals("passCnt")) {
			switch(pVO.getPassType()) {
			case "passCnt_purpose": 
				passResultList = mapper.selectPassResultListPurpose(pVO); break;
			case "passCnt_method":
				passResultList = mapper.selectPassResultListMethod(pVO); break;
			case "passCnt_route":
				passResultList = mapper.selectPassResultListRoute(pVO); break;
			case "passCnt_station":
				passResultList = mapper.selectPassResultListStation(pVO); break;
			}
		}
		
		return passResultList;
	}


	@Override
	public List<EgovMap> selectPassGroup(PassSearchVO pVO) {
		List<EgovMap> passGroupList = new ArrayList<EgovMap>();
		return passGroupList = mapper.selectPassGroup(pVO); 
	}



	
}
