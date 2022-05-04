package com.ybs.indicator.transfer.service.impl;

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
import com.ybs.indicator.transfer.service.TransferService;

@Service("transferService")
@Transactional(rollbackFor = {Exception.class})
public class TransferServiceImpl extends EgovAbstractServiceImpl implements TransferService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="transferMapper")
	private TransferMapper mapper;

	@Override
	public List<EgovMap> selectTransferResultList(SearchVO sVO) {
		List<EgovMap> transferResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "transferCnt_method" :
			System.out.println("환승_수단별통행");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListMethod_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListMethod(sVO); break;
			}
			
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행");
			transferResultList = mapper.selectTransferResultListStation(sVO);break;
			
		case "transferCnt_route" :
			System.out.println("환승_노선별통행");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListRoute_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListRoute(sVO); break;
			}	
			
		case "transferCnt_num" :
			System.out.println("환승_횟수별통행");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListNum_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListNum(sVO); break;
			}
			
		case "transferTime_method" :
			System.out.println("환승_수단별 환승통행시간");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListTimeMethod_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListTimeMethod(sVO); break;
			}
			
		case "transferTime_num" :
			System.out.println("환승_횟수별 환승통행시간");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListTimeNum_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListTimeNum(sVO); break;
			}
			
		case "transferDistn_method" :
			System.out.println("환승_수단별 환승통행거리");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListDistnMethod_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListDistnMethod(sVO); break;
			}
			
		case "transferDistn_num" :
			System.out.println("환승_횟수별 환승통행거리");
			if("allDay".equals(sVO.getTm())) {
				transferResultList = mapper.selectTransferResultListDistnNum_d(sVO); break;
			} else {
				transferResultList = mapper.selectTransferResultListDistnNum(sVO); break;
			}
			
		}
		
		
		return transferResultList;
	}

}
