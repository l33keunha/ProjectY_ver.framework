package com.ybs.indicator.transfer.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface TransferService {

	List<EgovMap> selectTransferResultList(SearchVO sVO);

	void downloadTransferResultList(SearchVO sVO, HttpServletResponse res);

}
