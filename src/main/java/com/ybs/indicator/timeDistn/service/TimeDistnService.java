package com.ybs.indicator.timeDistn.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface TimeDistnService {

	List<EgovMap> selectTimeDistnResultListT(SearchVO sVO);

	List<EgovMap> selectTimeDistnResultListD(SearchVO sVO);
}
