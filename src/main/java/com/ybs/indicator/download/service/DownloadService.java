package com.ybs.indicator.download.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import com.ybs.indicator.common.service.SearchVO;

public interface DownloadService {

	void selectdownloadResultList(SearchVO sVO, HttpServletRequest req, HttpServletResponse res);

	void getExcelDataList(HttpServletResponse res, List<EgovMap> excelList, String excelName,
			int[] ColumnWidth, String[] ColumnList, 
			Object[][] sum, Object[][] row1_test, Object[][] row2_test,
			Object[][] finalRow);

	void getExcelDataList(HttpServletResponse res, List<EgovMap> excelList, String excelName,
			int[] ColumnWidth, String[] ColumnList, 
			Object[][] row1_test);

   void selectdownloadResultListBT(SearchVO sVO, HttpServletRequest req, HttpServletResponse res);

   void getExcelDataList(HttpServletResponse res, List<EgovMap> excelList, List<EgovMap> excelList2, String excelName,
		int[] ColumnWidth, String[] ColumnList, String[] ColumnList2, Object[][] sum, Object[][] row1_test,
		Object[][] row2_test, Object[][] finalRow);

/**
 *  엑셀 다운로드	
 */


}
