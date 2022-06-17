package com.ybs.indicator.map.service.impl;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.map.service.MapService;
import com.ybs.indicator.pass.service.impl.PassServiceImpl;

@Service("mapService")
@Transactional(rollbackFor = {Exception.class})
public class MapServiceImpl extends EgovAbstractServiceImpl implements MapService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PassServiceImpl.class);
	
	@Resource(name="mapMapper")
	private MapMapper mapper;
}
