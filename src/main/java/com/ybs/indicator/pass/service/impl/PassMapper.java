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
	List<EgovMap> selectPassResultListTopRoute(SearchVO sVO);

	// 상위이용정류장 
	List<EgovMap> selectPassResultListTopStation(SearchVO sVO);
	
	// 상위이용정류장 버스 : 서울 선택만
	List<EgovMap> selectPassResultListTopStationB(SearchVO sVO);
	
	// 상위이용정류장 지하철 : 서울 선택만
	List<EgovMap> selectPassResultListTopStationT(SearchVO sVO);

	
	/********************** 화면용 다운로드 **********************/
	
	// PIVOT 목적통행 일별 
	List<EgovMap> downloadPassResultListPurpose_d(SearchVO sVO);

	// PIVOT 목적통행 시간대별 
	List<EgovMap> downloadPassResultListPurpose(SearchVO sVO);

	// PIVOT 수단통행 일별 
	List<EgovMap> downloadPassResultListMethod_d(SearchVO sVO);

	// PIVOT 수단통행 시간대 
	List<EgovMap> downloadPassResultListMethod(SearchVO sVO);
	
	// PIVOT 노선별통행 일별
	List<EgovMap> downloadPassResultListRoute_d(SearchVO sVO);

	// PIVOT 노선별통행 시간대
	List<EgovMap> downloadPassResultListRoute(SearchVO sVO);

	// PIVOT 정류장별통행 일별
	List<EgovMap> downloadPassResultListStation(SearchVO sVO);

	// PIVOT 행정동간OD 목적통행
	List<EgovMap> downloadPassResultListAreaODPurpose(SearchVO sVO);

	// PIVOT 행정동간OD 수단통행
	List<EgovMap> downloadPassResultListAreaODMethod(SearchVO sVO);

	// PIVOT 노선별 정류장간OD 일별
	List<EgovMap> downloadPassResultListRouteOD_d(SearchVO sVO);

	// PIVOT 노선별 정류장간OD 시간대별 
	List<EgovMap> downloadPassResultListRouteOD(SearchVO sVO);

	// PIVOT 상위이용노선 
	List<EgovMap> downloadPassResultListTopRoute(SearchVO sVO);

	// PIVOT 상위이용정류장 버스 : 서울 선택
	List<EgovMap> downloadPassResultListTopStationB(SearchVO sVO);

	// PIVOT 상위이용정류장 지하철 : 서울 선택만
	List<EgovMap> downloadPassResultListTopStationT(SearchVO sVO);

	// PIVOT 상위이용정류장 
	List<EgovMap> downloadPassResultListTopStation(SearchVO sVO);
	
	// 노선별OD 매트릭스
	List<EgovMap> downloadPassResultListRouteOD_m(SearchVO sVO);
	
	/********************** 노선별OD 매트릭스 **********************/

	List<EgovMap> selectStationNmList(SearchVO sVO);

	int selectStatioCnt(SearchVO sVO);

	List<EgovMap> selectRouteOD(SearchVO sVO);
	
	/********************** 행정동OD 매트릭스 **********************/
	
	List<EgovMap> downloadPassResultListAreaODMatrixPurpose(SearchVO sVO);
	
	List<EgovMap> downloadPassResultListAreaODMatrixMethod(SearchVO sVO);
	
	/********************** 그래프 쿼리 **********************/
	
	//  목적통행 그래프 시간대별 
	List<EgovMap> graphPassResultListPurpose(SearchVO sVO);
	
	//  목적통행 그래프 일별 
	List<EgovMap> graphPassResultListPurpose_d(SearchVO sVO);
	
	//  수단통행 그래프 시간대별 
	List<EgovMap> graphPassResultListMethod(SearchVO sVO);
	
	//  수단통행 그래프 일별 
	List<EgovMap> graphPassResultListMethod_d(SearchVO sVO);
	
	//  노선별통행 그래프  시간대별
	List<EgovMap> graphPassResultListRoute(SearchVO sVO);
	
	//  노선별통행 그래프  일별
	List<EgovMap> graphPassResultListRoute_d(SearchVO sVO);





	
	

}