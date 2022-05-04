package com.ybs.indicator.pass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("passMapper")
public interface PassMapper {

	// 목적통행 시간대별 
	List<EgovMap> selectPassResultListPurpose(SearchVO sVO);
	
	// 목적통행 일별 
	List<EgovMap> selectPassResultListPurpose_d(SearchVO sVO);

	// 수단통행 시간대별 
	List<EgovMap> selectPassResultListMethod(SearchVO sVO);
	
	// 수단통행 일별 
	List<EgovMap> selectPassResultListMethod_d(SearchVO sVO);
	
	// 노선별통행 버스 시간대별
	List<EgovMap> selectPassResultListRouteB(SearchVO sVO);
	
	// 노선별통행 버스 일별 
	List<EgovMap> selectPassResultListRouteB_d(SearchVO sVO);

	// 노선별통행 지하철 시간대별 
	List<EgovMap> selectPassResultListRouteT(SearchVO sVO);
	
	// 노선별통행 지하철 일별 
	List<EgovMap> selectPassResultListRouteT_d(SearchVO sVO);

	// 정류장별통행 버스 일별 
	List<EgovMap> selectPassResultListStationB(SearchVO sVO);

	// 정류장별통행 지하철 일별 
	List<EgovMap> selectPassResultListStationT(SearchVO sVO);
	
	// 노선별 정류장간OD 시간대별 
	List<EgovMap> selectPassResultListRouteOD(SearchVO sVO);
	
	// 노선별 정류장간OD 일별 
	List<EgovMap> selectPassResultListRouteOD_d(SearchVO sVO);

	// 행정동간OD 목적통행 
	List<EgovMap> selectPassResultListAreaODPurpose(SearchVO sVO);

	// 행정동간OD 수단통행 
	List<EgovMap> selectPassResultListAreaODMethod(SearchVO sVO);

	// 상위이용노선 
	List<EgovMap> selectPassREsultListTopRoute(SearchVO sVO);

	// 상위이용정류장 
	List<EgovMap> selectPassResultListTopStation(SearchVO sVO);
	
	// 상위이용정류장 버스 : 서울 선택만
	List<EgovMap> selectPassResultListTopStationB(SearchVO sVO);
	
	// 상위이용정류장 지하철 : 서울 선택만
	List<EgovMap> selectPassResultListTopStationT(SearchVO sVO);

}