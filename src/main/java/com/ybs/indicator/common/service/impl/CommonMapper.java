package com.ybs.indicator.common.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("CommonMapper")
public interface CommonMapper {
	// Ajax: 분석지역 시도 조회 
	List<EgovMap> selectPassSearchAjaxAnalAreaCd(SearchVO sVO);
	
	// Ajax: 분석지역 시군구 조회 
	List<EgovMap> selectPassSearchAjaxAnalArea(SearchVO sVO);
	
	// Ajax: 분석자료 조회 
	List<EgovMap> selectPassSearchAjaxProvider(SearchVO sVO);
	
	// Ajax: 날짜 조회 
	List<EgovMap> selectPassSearchAjaxDate(SearchVO sVO);
	
	// Ajax: 분석 노선번호 조회 
	List<EgovMap> selectPassRouteIdList(SearchVO sVO);

	// Ajax: 이용자유형 리스트 조회
	List<EgovMap> selectCdNoList(SearchVO sVO);
	
	
	
	
	
	// Ajax: 분석지역 시도 조회 _다운로드
	List<EgovMap> selectPassSearchAjaxAnalAreaCd_dl(SearchVO sVO);

	// Ajax: 분석지역 시군구 조회 _다운로드
	List<EgovMap> selectPassSearchAjaxAnalArea_dl(SearchVO sVO);

	// Ajax: 분석자료 조회 _다운로드
	List<EgovMap> selectPassSearchAjaxProvider_dl(SearchVO sVO);

	// Ajax: 날짜 조회 _다운로드
	List<EgovMap> selectPassSearchAjaxDate_dl(SearchVO sVO);
	
	// Ajax: 지역에 따른 가능 여부 status조회
	List<EgovMap> selectSearchStatusList(SearchVO sVO);

}
