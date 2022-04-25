package com.ybs.indicator.common.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("CommonMapper")
public interface CommonMapper {
	List<EgovMap> selectPassSearchAjaxAnalAreaCd(SearchVO sVO);
	
	List<EgovMap> selectPassSearchAjaxAnalArea(SearchVO sVO);
	
	List<EgovMap> selectPassSearchAjaxProvider(SearchVO sVO);
	
	List<EgovMap> selectPassRouteIdList(SearchVO sVO);
}
