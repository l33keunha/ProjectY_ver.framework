package com.ybs.indicator.pass.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface PassService {
	
	List<EgovMap> selectPassSearchList(SearchVO sVO);
	
	List<EgovMap> selectPassResultList(SearchVO sVO);

	List<EgovMap> selectPassResultListB(SearchVO sVO);

	List<EgovMap> selectPassResultListT(SearchVO sVO);



}
