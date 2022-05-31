package com.ybs.indicator.timeDistn.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("timeDistnMapper")
public interface TimeDistnMapper {
	
	// 1일 평균 통행시간
	List<EgovMap> selectTimeDistnResultListDay(SearchVO sVO);
	
	// 1일 평균 통행시간거리 일별
	List<EgovMap> selectTimeDistnResultListDay_d(SearchVO sVO);

	// 목적통행 평균 통행시간
	List<EgovMap> selectTimeDistnResultListPurpose(SearchVO sVO);

	// 목적통행 평균 통행시간거리 일별
	List<EgovMap> selectTimeDistnResultListPurpose_d(SearchVO sVO);

	// 수단통행 평균 통행시간
	List<EgovMap> selectTimeDistnResultListMethod(SearchVO sVO);

	// 수단통행 평균 통행시간거리 일별
	List<EgovMap> selectTimeDistnResultListMethod_d(SearchVO sVO);

	// 노선별 평균 통행시간
	List<EgovMap> selectTimeDistnResultListRoute(SearchVO sVO);

	// 노선별 평균 통행시간거리 일별
	List<EgovMap> selectTimeDistnResultListRoute_d(SearchVO sVO);

	
	/********************** 화면용 다운로드 **********************/
	
	
	// PIVOT 1일 평균 통행시간
	List<EgovMap> downloadTimeDistnResultListDay(SearchVO sVO);
	
	// PIVOT 1일 평균 통행시간거리 일별
	List<EgovMap> downloadTimeDistnResultListDay_d(SearchVO sVO);

	// PIVOT 목적통행 평균 통행시간
	List<EgovMap> downloadTimeDistnResultListPurpose(SearchVO sVO);

	// PIVOT 목적통행 평균 통행시간거리 일별
	List<EgovMap> downloadTimeDistnResultListPurpose_d(SearchVO sVO);

	// PIVOT 수단통행 평균 통행시간
	List<EgovMap> downloadTimeDistnResultListMethod(SearchVO sVO);

	// PIVOT 수단통행 평균 통행시간거리 일별
	List<EgovMap> downloadTimeDistnResultListMethod_d(SearchVO sVO);

	// PIVOT 노선별 평균 통행시간
	List<EgovMap> downloadTimeDistnResultListRoute(SearchVO sVO);

	// PIVOT 노선별 평균 통행시간거리 일별
	List<EgovMap> downloadTimeDistnResultListRoute_d(SearchVO sVO);
	
	
	
	
	/********************** 그래프 쿼리 **********************/

	// 1일 평균 통행시간거리_그래프
	List<EgovMap> graphTimeDistnResultListDay(SearchVO sVO);

	// 목적통행 평균 통행시간거리_그래프
	List<EgovMap> graphTimeDistnResultListPurpose(SearchVO sVO);

	// 수단통행 평균 통행시간거리_그래프
	List<EgovMap> graphTimeDistnResultListMethod(SearchVO sVO);

	// 노선별통행 평균 통행시간거리_그래프
	List<EgovMap> graphTimeDistnResultListRoute(SearchVO sVO);

}
