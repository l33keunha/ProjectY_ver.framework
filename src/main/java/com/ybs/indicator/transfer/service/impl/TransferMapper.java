package com.ybs.indicator.transfer.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("transferMapper")
public interface TransferMapper {
	
	// 환승 수단별통행
	List<EgovMap> selectTransferResultListMethod(SearchVO sVO);
	
	// 환승 수단별통행 일별
	List<EgovMap> selectTransferResultListMethod_d(SearchVO sVO);

	// 환승 정류장별통행 버스
	List<EgovMap> selectTransferResultListStationB(SearchVO sVO);
	
	// 환승 정류장별통행 지하철
	List<EgovMap> selectTransferResultListStationT(SearchVO sVO);

	// 환승 노선별통행 버스
	List<EgovMap> selectTransferResultListRouteB(SearchVO sVO);
	
	// 환승 노선별통행 지하철
	List<EgovMap> selectTransferResultListRouteT(SearchVO sVO);
	
	// 환승 노선별통행 버스 일별
	List<EgovMap> selectTransferResultListRouteB_d(SearchVO sVO);

	// 환승 노선별통행 지하철 일별
	List<EgovMap> selectTransferResultListRouteT_d(SearchVO sVO);
	
	// 환승 횟수별통행
	List<EgovMap> selectTransferResultListNum(SearchVO sVO);

	// 환승 횟수별통행 일별
	List<EgovMap> selectTransferResultListNum_d(SearchVO sVO);

	// 환승 수단별 환승통행시간 
	List<EgovMap> selectTransferResultListTimeMethod(SearchVO sVO);
	
	// 환승 수단별 환승통행시간 일별
	List<EgovMap> selectTransferResultListTimeMethod_d(SearchVO sVO);

	// 환승 횟수별 환승통행시간
	List<EgovMap> selectTransferResultListTimeNum(SearchVO sVO);
	
	// 환승 횟수별 환승통행시간 일별
	List<EgovMap> selectTransferResultListTimeNum_d(SearchVO sVO);

	// 환승 수단별 환승통행거리
	List<EgovMap> selectTransferResultListDistnMethod(SearchVO sVO);
	
	// 환승 수단별 환승통행거리 일별
	List<EgovMap> selectTransferResultListDistnMethod_d(SearchVO sVO);

	// 환승 횟수별 환승통행거리
	List<EgovMap> selectTransferResultListDistnNum(SearchVO sVO);
	
	// 환승 횟수별 환승통행거리 일별
	List<EgovMap> selectTransferResultListDistnNum_d(SearchVO sVO);
	
	
	/********************** 화면용 다운로드 **********************/

	// PIVOT 환승 수단별통행
	List<EgovMap> downloadTransferResultListMethod(SearchVO sVO);

	// PIVOT 환승 수단별통행 일별
	List<EgovMap> downloadTransferResultListMethod_d(SearchVO sVO);

	// PIVOT 환승 정류장별통행
	List<EgovMap> downloadTransferResultListStation(SearchVO sVO);

	// PIVOT 환승 노선별통행
	List<EgovMap> downloadTransferResultListRoute(SearchVO sVO);

	// PIVOT 환승 노선별통행 일별
	List<EgovMap> downloadTransferResultListRoute_d(SearchVO sVO);

	// PIVOT 환승 횟수별통행
	List<EgovMap> downloadTransferResultListNum(SearchVO sVO);

	// PIVOT 환승 횟수별통행 일별
	List<EgovMap> downloadTransferResultListNum_d(SearchVO sVO);

	// PIVOT 환승 수단별 환승통행시간 
	List<EgovMap> downloadTransferResultListTimeMethod(SearchVO sVO);

	// PIVOT 환승 수단별 환승통행시간 일별
	List<EgovMap> downloadTransferResultListTimeMethod_d(SearchVO sVO);

	// PIVOT 환승 횟수별 환승통행시간
	List<EgovMap> downloadTransferResultListTimeNum(SearchVO sVO);

	// PIVOT 환승 횟수별 환승통행시간 일별
	List<EgovMap> downloadTransferResultListTimeNum_d(SearchVO sVO);

	// PIVOT 환승 수단별 환승통행거리
	List<EgovMap> downloadTransferResultListDistnMethod(SearchVO sVO);

	// PIVOT 환승 수단별 환승통행거리 일별
	List<EgovMap> downloadTransferResultListDistnMethod_d(SearchVO sVO);

	// PIVOT 환승 횟수별 환승통행거리
	List<EgovMap> downloadTransferResultListDistnNum(SearchVO sVO);

	// PIVOT 환승 횟수별 환승통행거리 일별
	List<EgovMap> downloadTransferResultListDistnNum_d(SearchVO sVO);

}
