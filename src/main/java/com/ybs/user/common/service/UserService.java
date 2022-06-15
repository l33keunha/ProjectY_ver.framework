package com.ybs.user.common.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface UserService {

	List<EgovMap> checkUser(UserVO uVO);
	
	UserVO login(UserVO uVO);


}
