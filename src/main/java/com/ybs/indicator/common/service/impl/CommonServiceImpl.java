package com.ybs.indicator.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.CommonService;
import com.ybs.indicator.common.service.SearchVO;


@Service("commonService")
@Transactional(rollbackFor = {Exception.class})
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CommonServiceImpl.class);
	
	@Resource(name="CommonMapper")
	private CommonMapper mapper;

	@Override
	public List<EgovMap> selectPassSearchList(SearchVO sVO) {
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		
		if(sVO.getAnal_area_cd_sido().equals("null") || sVO.getAnal_area_cd_sido() == null) {
			passSearchList = mapper.selectPassSearchAjaxAnalAreaCd(sVO);
		} else if(sVO.getAnal_area_cd().equals("null") || sVO.getAnal_area_cd() == null && !sVO.getAnal_area_cd_sido().equals("시/도")) {
			passSearchList = mapper.selectPassSearchAjaxAnalArea(sVO);
		} else if(sVO.getProvider() == null && !sVO.getAnal_area_cd().equals("시/군/구")) {
			passSearchList = mapper.selectPassSearchAjaxProvider(sVO);
		}
		
		return passSearchList;
	}
	
	@Override
	public List<EgovMap> selectPassRouteIdList(SearchVO sVO) {
		// 문자열 길이 비교하기 위한 int변수 담기
		sVO.setTmStart(sVO.getAnal_area_cd().length());
		System.out.println(sVO.toString());
		return mapper.selectPassRouteIdList(sVO);
	}
}
