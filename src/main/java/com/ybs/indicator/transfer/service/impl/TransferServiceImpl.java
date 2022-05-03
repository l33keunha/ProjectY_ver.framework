package com.ybs.indicator.transfer.service.impl;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.pass.service.impl.PassServiceImpl;
import com.ybs.indicator.transfer.service.TransferService;

@Service("transferService")
@Transactional(rollbackFor = {Exception.class})
public class TransferServiceImpl extends EgovAbstractServiceImpl implements TransferService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="transferMapper")
	private TransferMapper mapper;

}
