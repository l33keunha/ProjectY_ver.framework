package com.ybs.indicator.download.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("DownloadMapper")
public interface DownloadMapper {
	
	// 정류장간OD 목적통행
	List<EgovMap> selectdownloadResultListStationOD_purpose(SearchVO sVO);
	
	// 정류장간OD 수단통행
	List<EgovMap> selectdownloadResultListStationOD_method(SearchVO sVO);

	// 노선별 정류장간OD
	List<EgovMap> selectdownloadResultListRouteOD(SearchVO sVO);

	// 행정동간OD 목적통행
	List<EgovMap> selectdownloadResultListAreaOD_purpose(SearchVO sVO);

	// 행정동간OD 수단통행
	List<EgovMap> selectdownloadResultListAreaOD_method(SearchVO sVO);

	// 정류장별통행 버스
	List<EgovMap> selectdownloadResultListStationCntB(SearchVO sVO);

	// 정류장별통행 지하철
	List<EgovMap> selectdownloadResultListStationCntT(SearchVO sVO);
	
	// 노선별통행 버스
	List<EgovMap> selectdownloadResultListRouteCntB(SearchVO sVO);

	// 노선별통행 지하철
	List<EgovMap> selectdownloadResultListRouteCntT(SearchVO sVO);

}
