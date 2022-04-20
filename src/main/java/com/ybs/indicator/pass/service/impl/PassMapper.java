package com.ybs.indicator.pass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.pass.service.SearchVO;

@Mapper("passMapper")
public interface PassMapper {
	
	List<EgovMap> selectPassSearchAjaxOwner(SearchVO sVO);

	List<EgovMap> selectPassSearchAjaxSido(SearchVO sVO);

	List<EgovMap> selectPassSearchAjaxSigungu(SearchVO sVO);

	List<EgovMap> selectPassResultListPurpose(SearchVO sVO);

	List<EgovMap> selectPassResultListMethod(SearchVO sVO);

	List<EgovMap> selectPassResultListRouteB(SearchVO sVO);

	List<EgovMap> selectPassResultListRouteT(SearchVO sVO);

	List<EgovMap> selectPassResultListStationB(SearchVO sVO);

	List<EgovMap> selectPassResultListStationT(SearchVO sVO);

	List<EgovMap> selectPassResultListAreaODPurpose(SearchVO sVO);

	List<EgovMap> selectPassResultListAreaODMethod(SearchVO sVO);

	List<EgovMap> selectPassResultListRouteOD(SearchVO sVO);

	List<EgovMap> selectPassREsultListTopRoute(SearchVO sVO);

	List<EgovMap> selectPassResultListTopStation(SearchVO sVO);


	
}