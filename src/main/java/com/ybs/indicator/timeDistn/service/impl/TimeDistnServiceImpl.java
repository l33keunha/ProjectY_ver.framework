package com.ybs.indicator.timeDistn.service.impl;

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
import com.ybs.indicator.pass.service.impl.PassServiceImpl;
import com.ybs.indicator.timeDistn.service.TimeDistnService;

@Service("timeDistnService")
@Transactional(rollbackFor = {Exception.class})
public class TimeDistnServiceImpl extends EgovAbstractServiceImpl implements TimeDistnService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="timeDistnMapper")
	private TimeDistnMapper mapper;

	@Override
	public List<EgovMap> selectTimeDistnResultListT(SearchVO sVO) {
		List<EgovMap> transferResultListT = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "timeDistn_avg_day" :
			System.out.println("1일 평균 통행시간");
			if("allDay".equals(sVO.getTm())) {
				transferResultListT = mapper.selectTimeDistnResultListDayTime_d(sVO); break;
			} else {
				transferResultListT = mapper.selectTimeDistnResultListDayTime(sVO); break;
			}
			
		case "timeDistn_avg_purpose" :
			System.out.println("목적통행 평균 통행시간");
			if("allDay".equals(sVO.getTm())) {
				transferResultListT = mapper.selectTimeDistnResultListPurposeTime_d(sVO); break;
			} else {
				transferResultListT = mapper.selectTimeDistnResultListPurposeTime(sVO); break;
			}
			
		case "timeDistn_avg_method" :
			System.out.println("수단통행 평균 통행시간");
			if("allDay".equals(sVO.getTm())) {
				transferResultListT = mapper.selectTimeDistnResultListMethodTime_d(sVO); break;
			} else {
				transferResultListT = mapper.selectTimeDistnResultListMethodTime(sVO); break;
			}
			
		case "timeDistn_avg_route" :
			System.out.println("노선별 평균 통행시간");
			if("allDay".equals(sVO.getTm())) {
				transferResultListT = mapper.selectTimeDistnResultListRouteTime_d(sVO); break;
			} else {
				transferResultListT = mapper.selectTimeDistnResultListRouteTime(sVO); break;
			}
		}
		return transferResultListT;
	}

	@Override
	public List<EgovMap> selectTimeDistnResultListD(SearchVO sVO) {
		List<EgovMap> transferResultListD = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "timeDistn_avg_day" :
			System.out.println("1일 평균 통행거리");
			if("allDay".equals(sVO.getTm())) {
				transferResultListD = mapper.selectTimeDistnResultListDayDistn_d(sVO); break;
			} else {
				transferResultListD = mapper.selectTimeDistnResultListDayDistn(sVO); break;
			}
			
		case "timeDistn_avg_purpose" :
			System.out.println("목적통행 평균 통행거리");
			if("allDay".equals(sVO.getTm())) {
				transferResultListD = mapper.selectTimeDistnResultListPurposeDistn_d(sVO); break;
			} else {
				transferResultListD = mapper.selectTimeDistnResultListPurposeDistn(sVO); break;
			}
			
		case "timeDistn_avg_method" :
			System.out.println("수단통행 평균 통행거리");
			if("allDay".equals(sVO.getTm())) {
				transferResultListD = mapper.selectTimeDistnResultListMethodDistn_d(sVO); break;
			} else {
				transferResultListD = mapper.selectTimeDistnResultListMethodDistn(sVO); break;
			}
			
		case "timeDistn_avg_route" :
			System.out.println("노선별 평균 통행거리");
			if("allDay".equals(sVO.getTm())) {
				transferResultListD = mapper.selectTimeDistnResultListRouteDistn_d(sVO); break;
			} else {
				transferResultListD = mapper.selectTimeDistnResultListRouteDistn(sVO); break;
			}
		}
		return transferResultListD;
	}


	

}
