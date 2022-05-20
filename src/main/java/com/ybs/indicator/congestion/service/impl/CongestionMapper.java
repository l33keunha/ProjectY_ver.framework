package com.ybs.indicator.congestion.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("congestionMapper")
public interface CongestionMapper {
	
	// 노선별 재차인원
	List<EgovMap> selectCongestionResultListRouteCBP(SearchVO sVO);

	// 노선별 혼잡도
	List<EgovMap> selectCongestionResultListRouteDOC(SearchVO sVO);

	// 노선별 최대 혼잡구
	List<EgovMap> selectCongestionResultListRouteDOC_max(SearchVO sVO);

	// 노선별 평균 혼잡구
	List<EgovMap> selectCongestionResultListRouteDOC_avg(SearchVO sVO);

	// 정류장간 최대 혼잡도
	List<EgovMap> selectCongestionResultListStationDOC_max(SearchVO sVO);

	// 정류장간 평균 혼잡도
	List<EgovMap> selectCongestionResultListStationDOC_avg(SearchVO sVO);
	
	/********************** 화면용 다운로드 **********************/
	
	// PIVOT 노선별 재차인원
	List<EgovMap> downloadCongestionResultListRouteCBP(SearchVO sVO);

	// PIVOT 노선별 혼잡도
	List<EgovMap> downloadCongestionResultListRouteDOC(SearchVO sVO);

	// PIVOT 노선별 최대 혼잡구
	List<EgovMap> downloadCongestionResultListRouteDOC_max(SearchVO sVO);

	// PIVOT 노선별 평균 혼잡구
	List<EgovMap> downloadCongestionResultListRouteDOC_avg(SearchVO sVO);

	// PIVOT 정류장간 최대 혼잡도
	List<EgovMap> downloadCongestionResultListStationDOC_max(SearchVO sVO);

	// PIVOT 정류장간 평균 혼잡도
	List<EgovMap> downloadCongestionResultListStationDOC_avg(SearchVO sVO);

}
