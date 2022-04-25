package com.ybs.indicator.common.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface CommonService {
	
	List<EgovMap> selectPassSearchList(SearchVO sVO);
	
	List<EgovMap> selectPassRouteIdList(SearchVO sVO);
}
