package com.ybs.indicator.pass.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface PassService {
	
	List<EgovMap> selectPassSearchAjax(PassSearchVO pVO);
	
	List<EgovMap> selectPassResultList(PassSearchVO pVO);

	List<EgovMap> selectPassResultListRouteB(PassSearchVO pVO);

	List<EgovMap> selectPassResultListRouteT(PassSearchVO pVO);

	List<EgovMap> selectPassResultListStationB(PassSearchVO pVO);

	List<EgovMap> selectPassResultListStationT(PassSearchVO pVO);



}
