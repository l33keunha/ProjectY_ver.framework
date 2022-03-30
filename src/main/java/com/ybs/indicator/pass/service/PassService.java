package com.ybs.indicator.pass.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface PassService {

	List<EgovMap> selectPassResultList(PassSearchVO pVO);


}
