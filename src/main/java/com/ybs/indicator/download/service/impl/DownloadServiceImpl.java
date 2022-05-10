package com.ybs.indicator.download.service.impl;
	
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.support.JdbcUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ybs.indicator.common.service.SearchVO;
import com.ybs.indicator.download.service.DownloadService;

@Service("DownloadService")
@Transactional(rollbackFor = {Exception.class})
public class DownloadServiceImpl extends EgovAbstractServiceImpl implements DownloadService{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DownloadServiceImpl.class);
	
	@Resource(name="DownloadMapper")
	private DownloadMapper mapper;
	
	
	@Override
	public void selectdownloadResultList(SearchVO sVO, HttpServletRequest req, HttpServletResponse res) throws IOException {
		List<EgovMap> downloadResultList = new ArrayList<EgovMap>();
		String tableNm = null;
		
		String date_SidoText = sVO.getAnal_area_cd_sido_text()+sVO.getAnal_area_cd_text()+"_"+(sVO.getDateStart().replaceAll("-", ""));
		
		
		switch(sVO.getAnal_type()) {
		case "dlRoute_routeCnt" : 
			tableNm = "PIVOT_노선별통행";
			downloadResultList = mapper.selectdownloadResultListRouteCntB(sVO);
			CreateCSV(date_SidoText, tableNm, downloadResultList);
			break;
		}
	}

	private void CreateCSV(String date_SidoText, String tableNm, List<EgovMap> downloadResultList) throws  IOException {
		  List<EgovMap> columnNameList = new ArrayList<EgovMap>();
	      String csvHeader = null;
	      
	      // * 테이블의 컬럼명을 조회해서 헤더 생성
	      columnNameList = mapper.selectdownloadResultListColumn(tableNm);
	      
	      for (int i = 0; i < columnNameList.size(); i++) {
	         csvHeader += columnNameList.get(i).get("columnName") + ",";
	      }
	      csvHeader = csvHeader.substring(4);

	      
	      // * csv 출력 코드
	      File csv = new File("C:\\Users\\USER\\Downloads\\" + date_SidoText + ".csv");
	      BufferedWriter bw = null;
	        
	        try {
	           
	            bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(csv), "MS949"));
	            
	            // 헤더 삽입
	        	bw.write(csvHeader);
	        	bw.newLine();
	            
	            // 데이터 라인 생성
	            for (int i = 0; i < downloadResultList.size(); i++) {
	               String aData = "";
	               
	               for(int j = 0; j < columnNameList.size(); j++) {
	                  String str = JdbcUtils.convertUnderscoreNameToPropertyName((String)columnNameList.get(j).get("columnName"));
	                  aData += downloadResultList.get(i).get(str) + ",";
	               }
	               
	               bw.write(aData);
	               bw.newLine();
	               
	            }
	            
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if (bw != null) {
	                    bw.flush(); 
	                    bw.close(); 
	                }
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }

	}

}
