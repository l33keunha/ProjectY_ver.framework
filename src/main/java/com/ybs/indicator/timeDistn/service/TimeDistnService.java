package com.ybs.indicator.timeDistn.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface TimeDistnService {

	List<EgovMap> selectTimeDistnResultList(SearchVO sVO);

	void downloadTimeDistnResultList(SearchVO sVO, HttpServletResponse res);

	List<EgovMap> graphTimeDistnResultList(SearchVO sVO, HttpServletResponse res);

}
