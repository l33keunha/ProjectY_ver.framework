package com.ybs.indicator.transfer.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface TransferService {

	List<EgovMap> selectTransferResultList(SearchVO sVO);

	List<EgovMap> selectTransferResultListB(SearchVO sVO);
	
	List<EgovMap> selectTransferResultListT(SearchVO sVO);
	
	/********************** 화면용 다운로드 **********************/
	
	void downloadTransferResultList(SearchVO sVO, HttpServletResponse res);
	
	/********************** 그래프용 쿼리 **********************/

	List<EgovMap> graphTransferResultList(SearchVO sVO, HttpServletResponse res);



}
