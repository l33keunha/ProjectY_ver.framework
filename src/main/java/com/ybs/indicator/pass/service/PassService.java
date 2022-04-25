package com.ybs.indicator.pass.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface PassService {
	
	
	List<EgovMap> selectPassResultList(SearchVO sVO);

	List<EgovMap> selectPassResultListB(SearchVO sVO);

	List<EgovMap> selectPassResultListT(SearchVO sVO);

	List<EgovMap> selectPassResultCntList(SearchVO sVO);



}
