package com.ybs.indicator.timeDistn.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("timeDistnMapper")
public interface TimeDistnMapper {
	
	// 1일 평균 통행시간
	List<EgovMap> selectTimeDistnResultListDayTime(SearchVO sVO);
	
	// 1일 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListDayTime_d(SearchVO sVO);

	// 목적통행 평균 통행시간
	List<EgovMap> selectTimeDistnResultListPurposeTime(SearchVO sVO);

	// 목적통행 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListPurposeTime_d(SearchVO sVO);

	// 수단통행 평균 통행시간
	List<EgovMap> selectTimeDistnResultListMethodTime(SearchVO sVO);

	// 수단통행 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListMethodTime_d(SearchVO sVO);

	// 노선별 평균 통행시간
	List<EgovMap> selectTimeDistnResultListRouteTime(SearchVO sVO);

	// 노선별 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListRouteTime_d(SearchVO sVO);

	// 1일 평균 통행거리
	List<EgovMap> selectTimeDistnResultListDayDistn(SearchVO sVO);

	// 1일 평균 통행거리 일별
	List<EgovMap> selectTimeDistnResultListDayDistn_d(SearchVO sVO);
	
	// 목적통행 평균 통행거리
	List<EgovMap> selectTimeDistnResultListPurposeDistn(SearchVO sVO);
	
	// 목적통행 평균 통행거리 일별
	List<EgovMap> selectTimeDistnResultListPurposeDistn_d(SearchVO sVO);
	
	// 수단통행 평균 통행거리
	List<EgovMap> selectTimeDistnResultListMethodDistn(SearchVO sVO);
	
	// 수단통행 평균 통행거리 일별
	List<EgovMap> selectTimeDistnResultListMethodDistn_d(SearchVO sVO);
	
	// 노선별 평균 통행거리
	List<EgovMap> selectTimeDistnResultListRouteDistn(SearchVO sVO);
	
	// 노선별 평균 통행거리 일별
	List<EgovMap> selectTimeDistnResultListRouteDistn_d(SearchVO sVO);

}
