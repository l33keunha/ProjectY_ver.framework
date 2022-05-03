package com.ybs.indicator.download.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("DownloadMapper")
public interface DownloadMapper {
	
	// 정류장별 통행
	List<EgovMap> selectdownloadResultListStationCnt(SearchVO sVO);

	// 정류장간OD 목적통행
	List<EgovMap> selectdownloadResultListStationOD_purpose(SearchVO sVO);
	
	// 정류장간OD 수단통행
	List<EgovMap> selectdownloadResultListStationOD_method(SearchVO sVO);

	// 노선별 통행
	List<EgovMap> selectdownloadResultListRouteCnt(SearchVO sVO);

	// 노선별 정류장간OD
	List<EgovMap> selectdownloadResultListRouteOD(SearchVO sVO);

	// 행정동간OD 목적통행
	List<EgovMap> selectdownloadResultListAreaOD_purpose(SearchVO sVO);

	// 행정동간OD 수단통행
	List<EgovMap> selectdownloadResultListAreaOD_method(SearchVO sVO);

}
