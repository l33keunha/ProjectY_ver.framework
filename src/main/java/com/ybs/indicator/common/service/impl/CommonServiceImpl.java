package com.ybs.indicator.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.CommonService;
import com.ybs.indicator.common.service.SearchVO;


@Service("commonService")
@Transactional(rollbackFor = {Exception.class})
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CommonServiceImpl.class);
	
	@Resource(name="CommonMapper")
	private CommonMapper mapper;

	@Override
	public List<EgovMap> selectPassSearchList(SearchVO sVO) {
		List<EgovMap> passSearchList = new ArrayList<EgovMap>();
		
		if(sVO.getAnal_group().equals("dlStation") || sVO.getAnal_group().equals("dlRoute") || sVO.getAnal_group().equals("dlArea")) {
			if(sVO.getAnal_area_cd_sido() == null || sVO.getAnal_area_cd_sido().equals("null")) {
				passSearchList = mapper.selectPassSearchAjaxAnalAreaCd_dl(sVO);
			} else if(sVO.getAnal_area_cd() == null || sVO.getAnal_area_cd().equals("null") && !sVO.getAnal_area_cd_sido().equals("시/도")) {
				passSearchList = mapper.selectPassSearchAjaxAnalArea_dl(sVO);
			} else if(sVO.getProvider() == null || sVO.getProvider().equals("null") && !sVO.getAnal_area_cd().equals("시/군/구")) {
				passSearchList = mapper.selectPassSearchAjaxProvider_dl(sVO);
			} else if(sVO.getDateStart() == null || sVO.getDateStart().equals("null")) {
				passSearchList = mapper.selectPassSearchAjaxDate_dl(sVO);
			}
		} else {
			if(sVO.getAnal_area_cd_sido() == null || sVO.getAnal_area_cd_sido().equals("null")) {
				passSearchList = mapper.selectPassSearchAjaxAnalAreaCd(sVO);
			} else if(sVO.getAnal_area_cd() == null || sVO.getAnal_area_cd().equals("null") && !sVO.getAnal_area_cd_sido().equals("시/도")) {
				passSearchList = mapper.selectPassSearchAjaxAnalArea(sVO);
			} else if(sVO.getProvider() == null || sVO.getProvider().equals("null") && !sVO.getAnal_area_cd().equals("시/군/구")) {
				passSearchList = mapper.selectPassSearchAjaxProvider(sVO);
			} else if(sVO.getDateStart() == null || sVO.getDateStart().equals("null")) {
				passSearchList = mapper.selectPassSearchAjaxDate(sVO);
			}
		}
		
		return passSearchList;
	}
	
	@Override
	public List<EgovMap> selectPassRouteIdList(SearchVO sVO) {
		// 문자열 길이 비교하기 위한 int변수 담기
		sVO.setTmStart(sVO.getAnal_area_cd().length());
		System.out.println(sVO.toString());
		return mapper.selectPassRouteIdList(sVO);
	}

	@Override
	public List<EgovMap> selectCdNoList(SearchVO sVO) {
		return mapper.selectCdNoList(sVO);
	}

	@Override
	public List<EgovMap> selectSearchStatusList(SearchVO sVO) {
		if(sVO.getAnal_type().equals("dlStation_stationCnt")) {
			sVO.setAnal_fin("PIVOT_정류장별통행");
		} else if(sVO.getAnal_type().equals("dlStation_station_purpose")) {
			sVO.setAnal_fin("PIVOT_정류장별OD_목적통행");
		} else if(sVO.getAnal_type().equals("dlStation_station_method")) {
			sVO.setAnal_fin("PIVOT_정류장별OD_수단통행");
		} else if(sVO.getAnal_type().equals("dlStation_station_run")) {
			
		} else if(sVO.getAnal_type().equals("dlStation_station_runCongestion")) {
			
		} else if(sVO.getAnal_type().equals("dlRoute_routeCnt")) {
			sVO.setAnal_fin("PIVOT_노선별통행");
		} else if(sVO.getAnal_type().equals("dlRoute_routeODCnt")) {
			sVO.setAnal_fin("PIVOT_노선별OD");
		} else if(sVO.getAnal_type().equals("dlRoute_routeCBP")) {
			sVO.setAnal_fin("혼잡_노선별_재차인원");
		} else if(sVO.getAnal_type().equals("dlArea_areaOD_purpose")) {
			sVO.setAnal_fin("PIVOT_행정동별OD_목적통행");
		} else if(sVO.getAnal_type().equals("dlArea_areaOD_method")) {
			sVO.setAnal_fin("PIVOT_행정동별OD_수단통행");
		}
			
		return mapper.selectSearchStatusList(sVO);
	}
}
