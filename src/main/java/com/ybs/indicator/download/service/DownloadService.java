package com.ybs.indicator.download.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface DownloadService {

	void selectdownloadResultList(SearchVO sVO, HttpServletRequest req, HttpServletResponse res) throws  IOException;

	void writeCsvOutput(HttpServletResponse res, List<EgovMap> excelList, String excelName, String headerListSt, String columnListSt);

}
