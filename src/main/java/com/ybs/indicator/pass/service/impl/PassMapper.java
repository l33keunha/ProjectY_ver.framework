package com.ybs.indicator.pass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.pass.service.PassSearchVO;

@Mapper("passMapper")
public interface PassMapper {
	List<EgovMap> selectPassGroup(PassSearchVO pVO);

	List<EgovMap> selectPassResultListPurpose(PassSearchVO pVO);

	List<EgovMap> selectPassResultListMethod(PassSearchVO pVO);

	List<EgovMap> selectPassResultListRouteB(PassSearchVO pVO);

	List<EgovMap> selectPassResultListRouteT(PassSearchVO pVO);

	List<EgovMap> selectPassResultListStationB(PassSearchVO pVO);

	List<EgovMap> selectPassResultListStationT(PassSearchVO pVO);

	
}
