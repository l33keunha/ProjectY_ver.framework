package com.ybs.indicator.congestion.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("congestionMapper")
public interface CongestionMapper {
	
	// 노선별 재차인원 및 혼잡도
	List<EgovMap> selectCongestionResultListRouteCBP(SearchVO sVO);

	// 노선별 상위 5개 최대 및 평균 혼잡구
	List<EgovMap> selectCongestionResultListTopRouteOD(SearchVO sVO);

	// 정류장간 상위 100개 최대 및 평균 혼잡도
	List<EgovMap> selectCongestionResultListTopStationOD(SearchVO sVO);

}
