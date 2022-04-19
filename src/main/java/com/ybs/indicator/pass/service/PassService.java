package com.ybs.indicator.pass.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface PassService {
	
	List<EgovMap> selectPassSearchList(PassSearchVO pVO);
	
	List<EgovMap> selectPassResultList(PassSearchVO pVO);

	List<EgovMap> selectPassResultListB(PassSearchVO pVO);

	List<EgovMap> selectPassResultListT(PassSearchVO pVO);



}
