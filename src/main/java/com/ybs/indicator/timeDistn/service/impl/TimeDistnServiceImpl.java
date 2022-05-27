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
	public List<EgovMap> selectTimeDistnResultList(SearchVO sVO) {
		List<EgovMap> transferResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_group()) {
		case "timeDistn_avg_day" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("1일 평균 통행시간_일별");
				transferResultList = mapper.selectTimeDistnResultListDay_d(sVO); break;
			} else {
				System.out.println("1일 평균 통행시간");
				transferResultList = mapper.selectTimeDistnResultListDay(sVO); break;
			}
			
		case "timeDistn_avg_purpose" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("목적통행 평균 통행시간_일별");
				transferResultList = mapper.selectTimeDistnResultListPurpose_d(sVO); break;
			} else {
				System.out.println("목적통행 평균 통행시간");
				transferResultList = mapper.selectTimeDistnResultListPurpose(sVO); break;
			}
			
		case "timeDistn_avg_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("수단통행 평균 통행시간_일별");
				transferResultList = mapper.selectTimeDistnResultListMethod_d(sVO); break;
			} else {
				System.out.println("수단통행 평균 통행시간");
				transferResultList = mapper.selectTimeDistnResultListMethod(sVO); break;
			}
			
		case "timeDistn_avg_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("노선별 평균 통행시간_일별");
				transferResultList = mapper.selectTimeDistnResultListRoute_d(sVO); break;
			} else {
				System.out.println("노선별 평균 통행시간");
				transferResultList = mapper.selectTimeDistnResultListRoute(sVO); break;
			}
		}
		
		return transferResultList;
	}



	

}
