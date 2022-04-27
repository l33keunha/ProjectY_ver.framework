package com.ybs.indicator.download.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.ybs.indicator.common.service.SearchVO;

@Mapper("DownloadMapper")
public interface DownloadMapper {

	void selectdownloadResultListStationCnt(SearchVO sVO);

}
