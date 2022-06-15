package com.ybs.user.common.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.user.common.service.UserService;
import com.ybs.user.common.service.UserVO;

@Service("userService")
@Transactional(rollbackFor = {Exception.class})
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {
	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	
	
	@Resource(name="userMapper")
	private UserMapper mapper;

	@Override
	public List<EgovMap> checkUser(UserVO uVO) {
		return mapper.checkUser(uVO);
	}
	
	@Override
	public UserVO login(UserVO uVO) {
		return mapper.login(uVO);
	}
}
