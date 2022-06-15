package com.ybs.user.common.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.user.common.service.UserVO;

@Mapper("userMapper")
public interface UserMapper {

	List<EgovMap> checkUser(UserVO uVO);
	
	UserVO login(UserVO uVO);

	
}
