package com.ybs.indicator.congestion.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface CongestionService {

	List<EgovMap> selectCongestionResultList(SearchVO sVO);

}
