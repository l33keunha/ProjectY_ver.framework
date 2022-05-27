package com.ybs.indicator.timeDistn.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("timeDistnMapper")
public interface TimeDistnMapper {
	
	// 1일 평균 통행시간
	List<EgovMap> selectTimeDistnResultListDay(SearchVO sVO);
	
	// 1일 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListDay_d(SearchVO sVO);

	// 목적통행 평균 통행시간
	List<EgovMap> selectTimeDistnResultListPurpose(SearchVO sVO);

	// 목적통행 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListPurpose_d(SearchVO sVO);

	// 수단통행 평균 통행시간
	List<EgovMap> selectTimeDistnResultListMethod(SearchVO sVO);

	// 수단통행 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListMethod_d(SearchVO sVO);

	// 노선별 평균 통행시간
	List<EgovMap> selectTimeDistnResultListRoute(SearchVO sVO);

	// 노선별 평균 통행시간 일별
	List<EgovMap> selectTimeDistnResultListRoute_d(SearchVO sVO);


}
