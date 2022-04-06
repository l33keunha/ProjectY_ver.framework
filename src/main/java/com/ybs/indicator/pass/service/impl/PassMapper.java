package com.ybs.indicator.pass.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.pass.service.PassSearchVO;

@Mapper("passMapper")
public interface PassMapper {

	List<EgovMap> selectPassResultListPurpose(PassSearchVO pVO);

	List<EgovMap> selectPassResultListMethod(PassSearchVO pVO);

	List<EgovMap> selectPassGroup(PassSearchVO pVO);

	
}
