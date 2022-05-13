package com.ybs.indicator.pass.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface PassService {
	
	
	List<EgovMap> selectPassResultList(SearchVO sVO);

	List<EgovMap> selectPassResultListB(SearchVO sVO);

	List<EgovMap> selectPassResultListT(SearchVO sVO);


	/********************** 화면용 다운로드  **********************/
	
	void downloadPassResultList(SearchVO sVO, HttpServletRequest req, HttpServletResponse res);

}
