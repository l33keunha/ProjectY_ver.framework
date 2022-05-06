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
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별통행_일별");
				transferResultList = mapper.selectTransferResultListMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별통행");
				transferResultList = mapper.selectTransferResultListMethod(sVO); break;
			}
			
		case "transferCnt_station" :
			System.out.println("환승_정류장별통행");
			transferResultList = mapper.selectTransferResultListStation(sVO);break;
			
		case "transferCnt_route" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_노선별통행_일별");
				transferResultList = mapper.selectTransferResultListRoute_d(sVO); break;
			} else {
				System.out.println("환승_노선별통행");
				transferResultList = mapper.selectTransferResultListRoute(sVO); break;
			}	
			
		case "transferCnt_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별통행_일별");
				transferResultList = mapper.selectTransferResultListNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별통행");
				transferResultList = mapper.selectTransferResultListNum(sVO); break;
			}
			
		case "transferTime_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행시간_일별");
				transferResultList = mapper.selectTransferResultListTimeMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별 환승통행시간");
				transferResultList = mapper.selectTransferResultListTimeMethod(sVO); break;
			}
			
		case "transferTime_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행시간_일별");
				transferResultList = mapper.selectTransferResultListTimeNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별 환승통행시간");
				transferResultList = mapper.selectTransferResultListTimeNum(sVO); break;
			}
			
		case "transferDistn_method" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_수단별 환승통행거리_일별");
				transferResultList = mapper.selectTransferResultListDistnMethod_d(sVO); break;
			} else {
				System.out.println("환승_수단별 환승통행거리");
				transferResultList = mapper.selectTransferResultListDistnMethod(sVO); break;
			}
			
		case "transferDistn_num" :
			if("allDay".equals(sVO.getTm())) {
				System.out.println("환승_횟수별 환승통행거리_일별");
				transferResultList = mapper.selectTransferResultListDistnNum_d(sVO); break;
			} else {
				System.out.println("환승_횟수별 환승통행거리");
				transferResultList = mapper.selectTransferResultListDistnNum(sVO); break;
			}
			
		}
		
		
		return transferResultList;
	}

}
