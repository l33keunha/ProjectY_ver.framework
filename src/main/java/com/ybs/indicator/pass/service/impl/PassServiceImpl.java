package com.ybs.indicator.pass.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.pass.service.PassService;

@Service("passService")
@Transactional(rollbackFor = {Exception.class})
public class PassServiceImpl extends EgovAbstractServiceImpl implements PassService{

	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="passMapper")
	private PassMapper mapper;

	@Override
	public List<EgovMap> selectPassResultList(SearchVO sVO) {
	List<EgovMap> passResultList = new ArrayList<EgovMap>();
		if(sVO.getAnal_type()!=null) { 															// # 분석유형이 있음 : 통행량, 행정동간OD
			switch(sVO.getAnal_type()) {
			case "passCnt_purpose": 														    // 통행량_목적통행
				System.out.println("목적통행");
				if("allDay".equals(sVO.getTm())) {
					passResultList = mapper.selectPassResultListPurpose_d(sVO); break;
				} else {
					passResultList = mapper.selectPassResultListPurpose(sVO); break;
				}
				
			case "passCnt_method":                                                              // 통행량_수단통행
				System.out.println("수단통행");
				if("allDay".equals(sVO.getTm())) {
					passResultList = mapper.selectPassResultListMethod_d(sVO); break;
				} else {
				passResultList = mapper.selectPassResultListMethod(sVO); break;
				}
				
			case "passAreaODCnt_purpose":                                                       // 행정동간OD_ 목적통행
				System.out.println("행정동목적");
				passResultList = mapper.selectPassResultListAreaODPurpose(sVO); break;
				
			case "passAreaODCnt_method":                                                        // 행정동간OD_ 수단통행
				System.out.println("행정동수단");
				passResultList = mapper.selectPassResultListAreaODMethod(sVO); break;
				
			}
		} else if(sVO.getAnal_type()==null){                                                    // # 분석유형이 없음 : 노선별OD, 상위...
			switch(sVO.getAnal_group()) {
			case "passRouteODCnt":                                                              // 노선별OD
				System.out.println("노선별od");if("allDay".equals((String)sVO.getTm())) {
					passResultList = mapper.selectPassResultListRouteOD_d(sVO); break;
				}
				passResultList = mapper.selectPassResultListRouteOD(sVO); break;
				
			case "passTopRotue":                                                                // 상위이용노선
				System.out.println("상위이용노선");
				passResultList = mapper.selectPassREsultListTopRoute(sVO); break;
				
			case "passTopStation":                                                              // 상위이용정류장
				if("B".equals(sVO.getTfcmn())) {
					System.out.println("상위이용정류장 버스");
					passResultList = mapper.selectPassResultListTopStationB(sVO); break;
				} else if("T".equals(sVO.getTfcmn())){
					System.out.println("상위이용정류장 지하철");
					passResultList = mapper.selectPassResultListTopStationT(sVO); break;
				} else {
					System.out.println("상위이용정류장 전체");
					passResultList = mapper.selectPassResultListTopStation(sVO); break;
				}
				
			}
		}
		return passResultList;
	}

	@Override
	public List<EgovMap> selectPassResultListB(SearchVO sVO) {
		List<EgovMap> passResultListB = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "passCnt_route":
			if("allDay".equals(sVO.getTm())) {
				passResultListB = mapper.selectPassResultListRouteB_d(sVO); break;
			} else {
				passResultListB = mapper.selectPassResultListRouteB(sVO); break;                //노선버스
			}
			
		case "passCnt_station":
			passResultListB = mapper.selectPassResultListStationB(sVO); break;                  //정류장버스
			
		}
		return passResultListB;
	}

	@Override
	public List<EgovMap> selectPassResultListT(SearchVO sVO) {
		List<EgovMap> passResultListT = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "passCnt_route":
			if("allDay".equals(sVO.getTm())) {
				passResultListT = mapper.selectPassResultListRouteT_d(sVO); break;
			} else {
				passResultListT = mapper.selectPassResultListRouteT(sVO); break;                //노선지하철
			}
			
		case "passCnt_station":
			passResultListT = mapper.selectPassResultListStationT(sVO); break;                  //정류장지하철
			
		}
		return passResultListT;
	}
	
}