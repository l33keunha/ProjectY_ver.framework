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
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("1일 평균 통행시간_일별");
				transferResultListT = mapper.selectTimeDistnResultListDayTime_d(sVO); break;
			} else {
				System.out.println("1일 평균 통행시간");
				transferResultListT = mapper.selectTimeDistnResultListDayTime(sVO); break;
			}
			
		case "timeDistn_avg_purpose" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("목적통행 평균 통행시간_일별");
				transferResultListT = mapper.selectTimeDistnResultListPurposeTime_d(sVO); break;
			} else {
				System.out.println("목적통행 평균 통행시간");
				transferResultListT = mapper.selectTimeDistnResultListPurposeTime(sVO); break;
			}
			
		case "timeDistn_avg_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("수단통행 평균 통행시간_일별");
				transferResultListT = mapper.selectTimeDistnResultListMethodTime_d(sVO); break;
			} else {
				System.out.println("수단통행 평균 통행시간");
				transferResultListT = mapper.selectTimeDistnResultListMethodTime(sVO); break;
			}
			
		case "timeDistn_avg_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("노선별 평균 통행시간_일별");
				transferResultListT = mapper.selectTimeDistnResultListRouteTime_d(sVO); break;
			} else {
				System.out.println("노선별 평균 통행시간");
				transferResultListT = mapper.selectTimeDistnResultListRouteTime(sVO); break;
			}
		}
		
		return transferResultListT;
	}

	@Override
	public List<EgovMap> selectTimeDistnResultListD(SearchVO sVO) {
		List<EgovMap> transferResultListD = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("1일 평균 통행거리_일별");
				transferResultListD = mapper.selectTimeDistnResultListDayDistn_d(sVO); break;
			} else {
				System.out.println("1일 평균 통행거리");
				transferResultListD = mapper.selectTimeDistnResultListDayDistn(sVO); break;
			}
			
		case "timeDistn_avg_purpose" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("목적통행 평균 통행거리 일별");
				transferResultListD = mapper.selectTimeDistnResultListPurposeDistn_d(sVO); break;
			} else {
				System.out.println("목적통행 평균 통행거리");
				transferResultListD = mapper.selectTimeDistnResultListPurposeDistn(sVO); break;
			}
			
		case "timeDistn_avg_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("수단통행 평균 통행거리 일별");
				transferResultListD = mapper.selectTimeDistnResultListMethodDistn_d(sVO); break;
			} else {
				System.out.println("수단통행 평균 통행거리");
				transferResultListD = mapper.selectTimeDistnResultListMethodDistn(sVO); break;
			}
			
		case "timeDistn_avg_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("노선별 평균 통행거리 일별");
				transferResultListD = mapper.selectTimeDistnResultListRouteDistn_d(sVO); break;
			} else {
				System.out.println("노선별 평균 통행거리");
				transferResultListD = mapper.selectTimeDistnResultListRouteDistn(sVO); break;
			}
		}
		return transferResultListD;
	}


	

}
