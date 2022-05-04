package com.ybs.indicator.congestion.service.impl;

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
import com.ybs.indicator.congestion.service.CongestionService;
import com.ybs.indicator.pass.service.impl.PassServiceImpl;

@Service("congestionService")
@Transactional(rollbackFor = {Exception.class})
public class CongestionServiceImpl extends EgovAbstractServiceImpl implements CongestionService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="congestionMapper")
	private CongestionMapper mapper;

	@Override
	public List<EgovMap> selectCongestionResultList(SearchVO sVO) {
		List<EgovMap> congestionResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_group()) {
		case "congestion_route_CBP" :
			System.out.println("노선별 재차인원 및 혼잡도");
			congestionResultList = mapper.selectCongestionResultListRouteCBP(sVO); break;
			
		case "congestion_TopRouteOD" :
			System.out.println("노선별 상위 5개 최대 및 평균 혼잡구");
			congestionResultList = mapper.selectCongestionResultListTopRouteOD(sVO); break;
			
		case "congestion_TopStationOD" :
			System.out.println("정류장간 상위 100개 최대 및 평균 혼잡도");
			congestionResultList = mapper.selectCongestionResultListTopStationOD(sVO); break;
			
		}
		return congestionResultList;
	}


}
