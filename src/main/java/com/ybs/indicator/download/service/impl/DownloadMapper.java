package com.ybs.indicator.download.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("DownloadMapper")
public interface DownloadMapper {
	

	int selectdownloadResultListColumnCnt(String tableNm);

	List<EgovMap> selectdownloadResultListColumn(String tableNm);
	
	// 노선별통행 버스
	List<EgovMap> selectdownloadResultListRouteCnt(SearchVO sVO);
	
	// 정류장별통행 버스
	List<EgovMap> selectdownloadResultListStationCnt(SearchVO sVO);

	// 행정동간OD 목적통행
	List<EgovMap> selectdownloadResultListAreaOD_purpose(SearchVO sVO);

	// 행정동간OD 수단통행
	List<EgovMap> selectdownloadResultListAreaOD_method(SearchVO sVO);
	
	// 정류장간OD 목적통행
	List<EgovMap> selectdownloadResultListStationOD_purpose(SearchVO sVO);
	
	// 정류장간OD 수단통행
	List<EgovMap> selectdownloadResultListStationOD_method(SearchVO sVO);

	// 노선별 정류장간OD
	List<EgovMap> selectdownloadResultListRouteOD(SearchVO sVO);

	// 노선별 재차인원
	List<EgovMap> selectdownloadResultListRouteCBP(SearchVO sVO);

	
	
	// 정류장간OD 목적통행 _ 서울||인천
	List<EgovMap> selectdownloadResultListStationOD_purpose_small(SearchVO sVO);
	
	// 정류장간OD 수단통행 _ 서울||인천
	List<EgovMap> selectdownloadResultListStationOD_method_small(SearchVO sVO);


}
