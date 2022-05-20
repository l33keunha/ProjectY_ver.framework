package com.ybs.indicator.congestion.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface CongestionService {

	List<EgovMap> selectCongestionResultList(SearchVO sVO);

	void downloadCongestionResultList(SearchVO sVO, HttpServletResponse res);

}
