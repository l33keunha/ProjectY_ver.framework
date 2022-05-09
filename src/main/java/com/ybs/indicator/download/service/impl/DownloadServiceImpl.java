package com.ybs.indicator.download.service.impl;
	
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
	String excelName = "";
	
	int[] ColumnWidth = new int[] {};
	String[] ColumnList = new String[] {};
	String[] ColumnList2 = new String[] {};
	Object[][] sum = new Object[][] {};
	Object[][] row1_test = new Object[][] {};
	Object[][] row2_test = new Object[][] {};
	Object[][] finalRow = new Object[][] {};
	
	String ColumnWidth_st = "";
	String[] ColumnWidth_arr ;
	String ColumnList_st = "";
	String ColumnList_st2 = "";
	
	String sum_st_0_st = "";
	String sum_st_1_st = "";
	String []sum_st_0_arr = new String[] {};
	String []sum_st_1_arr = new String[] {};

	String row1_test_st_0_st = "";
	String row1_test_st_1_st = "";
	String []row1_test_st_0_arr = new String[] {};
	String []row1_test_st_1_arr = new String[] {};
	
	String row2_test_st_0_st = "";
	String row2_test_st_1_st = "";
	String []row2_test_st_0_arr = new String[] {};
	String []row2_test_st_1_arr = new String[] {};
	
	String finalRow_st_0_st = "";
	String finalRow_st_1_st = "";
	String []finalRow_st_0_arr = new String[] {};
	String []finalRow_st_1_arr = new String[] {};
	
	String rowSelect = "1";
	
	@Override
	public void selectdownloadResultList(SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		List<EgovMap> downloadResultList = new ArrayList<EgovMap>();
		
		
		switch(sVO.getAnal_type()) {
		case "dlStation_station_purpose" : // 정류장간목적통행
			System.out.println("정류장간목적통행"); 

			//● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListStationOD_purpose(sVO); 
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "1";
			
			//● 인자값 : 시트명 
			excelName = "정류장간목적통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "3000_3000_3000_3000_3000_5000_3000_3000_5000";
			
			//● 인자값 : 컬럼명
			ColumnList_st = "analAreaSidoCdText_"+
							"analAreaCdText_"+
							"provider_"+
							"운행일자_"+
							"승차내외부_"+
							"승차역id_"+
							"승차지역명_"+
							"하차내외부_"+
							"하차역id_"+
							"하차지역명_"+
							"시간_"+
							"일반_"+
							"어린이_"+
							"청소년_"+
							"경로_"+
							"장애인_"+
							"국가유공자_"+
							"다자녀부모_"+
							"동반_"+
							"대학생_"+
							"복지_"+
							"기타";
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_"+ 
								"1_1_1_1_1_1_1_1_1_1_1"; 
			row1_test_st_1_st = "광역/도_시/군_분석자료_분석일자_승차내외부_승차역ID_승차지역명_하차내외부_하차역ID_하차지역명_시간_"+
								"일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
		
		break;
		case "dlStation_station_method" : // 정류장간수단통행
			System.out.println("정류장간수단통행"); 
			
			//● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListStationOD_method(sVO);
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "1";
			
			//● 인자값 : 시트명 
			excelName = "정류장간수단통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "3000_3000_3000_3000_3000_5000_3000_3000_5000";
			
			//● 인자값 : 컬럼명
			ColumnList_st = "analAreaSidoCdText_"+
							"analAreaCdText_"+
							"provider_"+
							"운행일자_"+
							"승차내외부_"+
							"승차역id_"+
							"승차지역명_"+
							"하차내외부_"+
							"하차역id_"+
							"하차지역명_"+
							"시간_"+
							"일반_"+
							"어린이_"+
							"청소년_"+
							"경로_"+
							"장애인_"+
							"국가유공자_"+
							"다자녀부모_"+
							"동반_"+
							"대학생_"+
							"복지_"+
							"기타";
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_"+ 
								"1_1_1_1_1_1_1_1_1_1_1"; 
			row1_test_st_1_st = "광역/도_시/군_분석자료_분석일자_승차내외부_승차역ID_승차지역명_하차내외부_하차역ID_하차지역명_시간_"+
								"일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
		
			 break;
		case "dlStation_station_run" : // 정류장간운행지표 (x)
			System.out.println("정류장간운행지표 (x)"); break;
		case "dlStation_station_runCongestion" : // 정류장간운행/혼잡지표 (x)
			System.out.println("정류장간운행/혼잡지표 (x)"); break;
		case "dlRoute_routeODCnt" : // 노선별기종점통행
			System.out.println("노선별기종점통행"); 
			
			//● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListRouteOD(sVO); 
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "1";
			
			//● 인자값 : 시트명 
			excelName = "노선별기종점통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "3000_3000_3000_2000_3000_5000_2000_5000_5000_5000_5000_5000_5000_5000";
			
			//● 인자값 : 컬럼명
			ColumnList_st = "analAreaSidoCdText_"
							+"analAreaCdText_"
							+"provider_"
							+"opratDate_"
							+"tfcmn_"
							+"routeNma_"
							+"routeType_"
							+"routeStart_"
							+"routeEnd_"
						//	+"출발정류장순번_"
							+"출발정류장id_"
							+"출발정류장명_"
							+"출발정류장행정동_"
						//	+"도착정류장순번_"
							+"도착정류장id_"
							+"도착정류장명_"
							+"도착정류장행정동_"
							+"tm_"
							+"일반_"
							+"어린이_"
							+"청소년_"
							+"경로_"
							+"장애인_"
							+"국가유공자_"
							+"다자녀부모_"
							+"동반_"
							+"대학생_"
							+"복지_"
							+"기타";
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_"+
								"1_1_1_1_1_1_1_1_1_1_1"; 
			row1_test_st_1_st = "광역/도_시/군_분석자료_분석일자_노선구분_노선명_노선유형_기점_종점_출발정류장ID_출발정류장명_출발정류장행정동_도착정류장ID_도착정류장명_도착정류장행정동_시간_"+
								"일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
			
			break;
			
		case "dlRoute_routeCBP" : // 노선별 재차인원 (x)
			System.out.println("dlRoute_routeCBP (x)"); break;
		case "dlArea_areaOD_purpose" : // 행정동간목적통행
			System.out.println("행정동간목적통행"); 
			
			//● 인자값 : 데이터 리스트
			downloadResultList = mapper.selectdownloadResultListAreaOD_purpose(sVO); 
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "1";
			
			//● 인자값 : 시트명 
			excelName = "행정동간목적통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "2000_3000_4000";
			
			//● 인자값 : 컬럼명
			ColumnList_st = "analAreaSidoCdText_"
							+"analAreaCdText_"
							+"provider_"
							+"운행일자_"
							+"승차내외부_"
							+"승차지역명_"
							+"하차내외부_"
							+"하차지역명_"
							+"stime_"
							+"일반_"
							+"어린이_"
							+"청소년_"
							+"경로_"
							+"장애인_"
							+"국가유공자_"
							+"다자녀부모_"
							+"동반_"
							+"대학생_"
							+"복지_"
							+"기타";
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1";
			row1_test_st_1_st = "광역/도_시/군_분석자료_분석일자_출발존_출발행정동_도착존_도착행정동_시간_"+
								"일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
			
			break;
			
		case "dlArea_areaOD_method"  : // 행정동간수단통행
			System.out.println("행정동간수단통행"); 
	
			//● 인자값 : 데이터 리스트
			 downloadResultList = mapper.selectdownloadResultListAreaOD_method(sVO);
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "1";
			
			//● 인자값 : 시트명 
			excelName = "행정동간수단통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "2000_3000_4000";
			
			//● 인자값 : 컬럼명
			ColumnList_st = "analAreaSidoCdText_"
							+"analAreaCdText_"
							+"provider_"
							+"운행일자_"
							+"승차내외부_"
							+"승차지역명_"
							+"하차내외부_"
							+"하차지역명_"
							+"stime_"
							+"일반_"
							+"어린이_"
							+"청소년_"
							+"경로_"
							+"장애인_"
							+"국가유공자_"
							+"다자녀부모_"
							+"동반_"
							+"대학생_"
							+"복지_"
							+"기타";

			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1";
			row1_test_st_1_st = "광역/도_시/군_분석자료_분석일자_출발존_출발행정동_도착존_도착행정동_시간_"+
								"일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
			
			break;
		}
		
		//1행 일떄
		if("1".equals(rowSelect)){
			
			
			//● 인자값 : 컬럼 Width
			ColumnWidth = new int[(ColumnWidth_st.split("_")).length];
			ColumnWidth_arr = new String[(ColumnWidth_st.split("_")).length];
			ColumnWidth_arr = ColumnWidth_st.split("_");
			for(int i=0; i<ColumnWidth_arr.length; i++) {
				ColumnWidth[i]= Integer.parseInt(ColumnWidth_arr[i]);
			}
			
			//● 인자값 : 컬럼명
			ColumnList = ColumnList_st.split("_");
			
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_arr = new String[(row1_test_st_0_st.split("_")).length];			
			row1_test_st_1_arr = new String[(row1_test_st_1_st.split("_")).length];
			row1_test = new Object[(row1_test_st_0_st.split("_")).length][(row1_test_st_0_st.split("_")).length];		
			
			row1_test_st_0_arr = row1_test_st_0_st.split("_");
			row1_test_st_1_arr = row1_test_st_1_st.split("_");
			
			for(int i=0; i<row1_test_st_0_arr.length; i++) {
				row1_test [i][0] = Integer.parseInt(row1_test_st_0_arr[i]);
				row1_test [i][1]= row1_test_st_1_arr[i];
			}
			
			
			getExcelDataList(res, downloadResultList, 
					excelName, ColumnWidth, ColumnList, 
					row1_test);
			
			
		//2행 일떄	
		}else if("2".equals(rowSelect)) {
			System.out.println("ColumnWidth_st:"+ColumnWidth_st);
			
			//● 인자값 : 컬럼 Width
			ColumnWidth = new int[(ColumnWidth_st.split("_")).length];
			ColumnWidth_arr = new String[(ColumnWidth_st.split("_")).length];
			ColumnWidth_arr = ColumnWidth_st.split("_");
			for(int i=0; i<ColumnWidth_arr.length; i++) {
				ColumnWidth[i]= Integer.parseInt(ColumnWidth_arr[i]);
			}
			
			//● 인자값 : 컬럼명
			ColumnList = ColumnList_st.split("_");
			
			
			//● 인자값 : (처음 합체 행) 칸, 엑셀표출명 
			sum_st_0_arr = new String[(sum_st_0_st.split("_")).length];		
			sum_st_1_arr = new String[(sum_st_1_st.split("_")).length];		
			sum = new Object[(sum_st_0_st.split("_")).length][(sum_st_0_st.split("_")).length];		
			
			sum_st_0_arr = sum_st_0_st.split("_");
			sum_st_1_arr = sum_st_1_st.split("_");
			
			
			for(int i=0; i<sum_st_0_arr.length; i++) {
				sum [i][0] =  Integer.parseInt(sum_st_0_arr[i]);
				sum [i][1]= sum_st_1_arr[i];
			}
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_arr = new String[(row1_test_st_0_st.split("_")).length];			
			row1_test_st_1_arr = new String[(row1_test_st_1_st.split("_")).length];
			row1_test = new Object[(row1_test_st_0_st.split("_")).length][(row1_test_st_0_st.split("_")).length];		
			
			row1_test_st_0_arr = row1_test_st_0_st.split("_");
			row1_test_st_1_arr = row1_test_st_1_st.split("_");
			
			for(int i=0; i<row1_test_st_0_arr.length; i++) {
				row1_test [i][0] = Integer.parseInt(row1_test_st_0_arr[i]);
				row1_test [i][1]= row1_test_st_1_arr[i];
			}
			
			
			
			//● 인자값 :  (2열) 칸, 엑셀표출명  
			row2_test_st_0_arr = new String[(row2_test_st_0_st.split("_")).length];			
			row2_test_st_1_arr = new String[(row2_test_st_1_st.split("_")).length];
			row2_test = new Object[(row2_test_st_0_st.split("_")).length][(row2_test_st_0_st.split("_")).length];		
			
			row2_test_st_0_arr = row2_test_st_0_st.split("_");
			row2_test_st_1_arr = row2_test_st_1_st.split("_");
			
			for(int i=0; i<row2_test_st_0_arr.length; i++) {
				row2_test [i][0] = Integer.parseInt(row2_test_st_0_arr[i]);
				row2_test [i][1]= row2_test_st_1_arr[i];
			}
			
			/*
			 * //● 인자값 : (마지막 합계) 칸, 엑셀표출명 finalRow_st_0_arr = new
			 * String[(finalRow_st_0_st.split("_")).length]; finalRow_st_1_arr = new
			 * String[(finalRow_st_1_st.split("_")).length]; finalRow = new
			 * Object[(finalRow_st_0_st.split("_")).length][(finalRow_st_0_st.split("_")).
			 * length];
			 * 
			 * finalRow_st_0_arr = finalRow_st_0_st.split("_"); finalRow_st_1_arr =
			 * finalRow_st_1_st.split("_");
			 * 
			 * for(int i=0; i<finalRow_st_0_arr.length; i++) { finalRow [i][0] =
			 * Integer.parseInt(finalRow_st_0_arr[i]); finalRow [i][1]=
			 * finalRow_st_1_arr[i]; }
			 */
			
			getExcelDataList( res, downloadResultList, 
					excelName, ColumnWidth, ColumnList, 
					sum, row1_test, row2_test, finalRow);
	
		}
		
		
		
		
		for(int i = 0; i < 10; i++) {
			System.out.println(downloadResultList.get(i).toString());
		}
	}
	
	
	/**
	 *  엑셀 다운로드
	 */

	@Override
	public void getExcelDataList(HttpServletResponse res, List<EgovMap> excelList, 
									String excelName, int[] ColumnWidth, String[] ColumnList, 
									Object[][] sum, Object [][] row1_test, Object [][] row2_test, Object [][] finalRow)	{
		try {
		
			
			SXSSFWorkbook  wb     = new SXSSFWorkbook(100);
			
			// header style
			CellStyle styleOfTheadBlackBold = wb.createCellStyle();
			styleOfTheadBlackBold.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			styleOfTheadBlackBold.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
			//배경색
			styleOfTheadBlackBold.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
			styleOfTheadBlackBold.setFillPattern(CellStyle.SOLID_FOREGROUND);
			//테두리 선 (우,좌,위,아래)
			styleOfTheadBlackBold.setBorderRight(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderTop(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			//자동 줄바꿈
			styleOfTheadBlackBold.setWrapText(true);
			
			Font font = wb.createFont();
			font.setBoldweight(Font.BOLDWEIGHT_BOLD);
			styleOfTheadBlackBold.setFont(font);
			
			
			// body style
			CellStyle styleOfTbodyBlack = wb.createCellStyle();
			styleOfTbodyBlack.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			styleOfTbodyBlack.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
			//테두리 선 (우,좌,위,아래)
			styleOfTbodyBlack.setBorderRight(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderTop(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				
			
			
			Map<String, Object[][]> mapTest = new HashMap<String, Object[][]>();
			mapTest.put("sum",sum);
			mapTest.put("row1_test",  row1_test);
			mapTest.put("row2_test" , row2_test);
			//mapTest.put("finalRow",finalRow);
	
			
			
			Map<String, Object[]> mapTest22 = new HashMap<String, Object[]>();
			mapTest22.put("sum", new Object[] {0,1});
			mapTest22.put("row1_test", new Object[] {0,0});
			mapTest22.put("row2_test", new Object[] {0,0});
			//mapTest22.put("finalRow", new Object[] {0,1});

			String[] printCnt = {"sum", "row1_test","row2_test" };
			//String[] printCnt = {"sum", "row1_test", "finalRow", "row2_test" };
			
			List<Integer> listCnt = new ArrayList<Integer>();
			List<String> listCntString = new ArrayList<String>();
			List<String> listCntString2 = new ArrayList<String>();
		
			//--------------------------------------------------------------------------------------
			
			int st = -1 ;
			int ed = -1 ;
	
			SXSSFSheet     sh     = (SXSSFSheet) wb.createSheet(excelName);
			
			for(int i= 0; i< ColumnWidth.length; i++) {
				sh.setColumnWidth(i+1, ColumnWidth[i]); //분석일자
			}
			
			
			//헤더 재료 생성
			//향상된 for 문
			 for ( String objectName : printCnt ) {
				
				 Object[][] objectArr = mapTest.get(objectName); 
				
				 for(int k=0; k<objectArr.length; k++) { 					// 해당 넣어준 object 형의 배열 개수    ex) sum.length
					
						Object[] object = objectArr[k]; 
						
						st = ed+1;
					
						if((int)object[0] == 1) {
							ed = st;
						} else {
							ed = st + ((int)object[0]-1);
						}
					
						sh.addMergedRegion(new CellRangeAddress( (int)mapTest22.get(objectName)[0], (int)mapTest22.get(objectName)[1],	st, ed ));		//시/도
						listCnt.add(st);
					
						if("sum".equals(objectName)) {
							listCntString.add( (String) object[1]);
							listCntString2.add((String) object[1]);
						
						}else if("row1_test".equals(objectName)) {
							listCntString.add((String) object[1]);
						
						}else if("row2_test".equals(objectName)) {
							listCntString2.add((String) object[1]);
						
						}else if("finalRow".equals(objectName)) {
							listCntString.add( (String) object[1]);
						
						}
					
				 }
			};

			
			
			//헤더 생성
			SXSSFRow trow0 = (SXSSFRow) sh.createRow(0);
		
			int cnt = 0;
		
			for (int i = 0; i < ed; i++) {
				SXSSFCell cell = (SXSSFCell) trow0.createCell(i);
				
				for(int j=0; j<listCntString.size(); j++) {
					if(listCnt.get(j) == i ) {
						cell.setCellStyle(styleOfTheadBlackBold);
						cell.setCellValue(listCntString.get(cnt));
						cnt ++;
					}
				}
			}
			
			SXSSFRow trow1 = (SXSSFRow) sh.createRow(1);
	
			for (int i = 0; i < listCntString2.size(); i++) {
				SXSSFCell cell = (SXSSFCell) trow1.createCell(i);
				cell.setCellStyle(styleOfTheadBlackBold);
				cell.setCellValue(listCntString2.get(i));
			}
			
			
			//데이터 생성
			if (excelList.size() > 0) {
			
				//윗 상단의 헤더가 있음으로 2번째 줄 부터 시작한다. 
				int rowNum = 2;
				
				//1. 데이터를 한개씩 조회해서 한개의 행으로 만든다.
		        for (Map<String, Object> data : excelList) {
		            
		        	//행 생성
		            Row row = (SXSSFRow) sh.createRow(rowNum++);
		            int cellNum = 0;
		            
		            //2. map에 있는 데이터를 한개씩 조회해서 열을 생성한다. (순서는 db에서 조회 컬럼 순)
		            for (String key : ColumnList) {
		            	
		            	//cell 생성
		                Cell cell = row.createCell(cellNum++);
		               	
		                //3. cell에 데이터 삽입
					     try {
   
					    	 cell.setCellValue(data.get(key).toString());
					    	 
					     }catch (Exception e) {
					    	 
					    	 cell.setCellValue(""); continue;
						}	
		            }
		        }
				
				// 생성된 엑셀 파일 쓰기
				res.reset();
				
				res.setContentType("application/vnd.ms-excel");
	
				res.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(excelName+".xlsx" , "UTF-8"));
				
				wb.write(res.getOutputStream());
				
				((SXSSFWorkbook) wb).dispose();
				
				res.getOutputStream().flush();
				res.getOutputStream().close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	@Override
	public void getExcelDataList(HttpServletResponse res, List<EgovMap> excelList, 
									String excelName, int[] ColumnWidth, String[] ColumnList, 
									Object [][] row1_test)	{
		try {
			
			SXSSFWorkbook  wb     = new SXSSFWorkbook(100);
			
			// header style
			CellStyle styleOfTheadBlackBold = wb.createCellStyle();
			styleOfTheadBlackBold.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			styleOfTheadBlackBold.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
			//배경색
			styleOfTheadBlackBold.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
			styleOfTheadBlackBold.setFillPattern(CellStyle.SOLID_FOREGROUND);
			//테두리 선 (우,좌,위,아래)
			styleOfTheadBlackBold.setBorderRight(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderTop(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			//자동 줄바꿈
			styleOfTheadBlackBold.setWrapText(true);
			
			Font font = wb.createFont();
			font.setBoldweight(Font.BOLDWEIGHT_BOLD);
			styleOfTheadBlackBold.setFont(font);
			
			
			// body style
			CellStyle styleOfTbodyBlack = wb.createCellStyle();
			styleOfTbodyBlack.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			styleOfTbodyBlack.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
			//테두리 선 (우,좌,위,아래)
			styleOfTbodyBlack.setBorderRight(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderTop(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				
			
			
			Map<String, Object[][]> mapTest = new HashMap<String, Object[][]>();
			mapTest.put("row1_test",  row1_test);
			
			String[] printCnt = {"row1_test"};
			
			List<String> listCntString = new ArrayList<String>();
	
		
			//--------------------------------------------------------------------------------------

			SXSSFSheet     sh     = (SXSSFSheet) wb.createSheet(excelName);
			
			for(int i= 0; i< ColumnWidth.length; i++) {
				sh.setColumnWidth(i+1, ColumnWidth[i]); //분석일자
			}
			
			
			//헤더 재료 생성
			//향상된 for 문
			 for ( String objectName : printCnt ) {
				
				 Object[][] objectArr = mapTest.get(objectName); 
				 for(int k=0; k<objectArr.length; k++) { 					// 해당 넣어준 object 형의 배열 개수    ex) sum.length
					
					Object[] object = objectArr[k]; 
					listCntString.add((String) object[1]);
					
				 }
			};

			
			//헤더 생성
			SXSSFRow trow0 = (SXSSFRow) sh.createRow(0);
	
			for (int i = 0; i < listCntString.size(); i++) {
				SXSSFCell cell = (SXSSFCell) trow0.createCell(i);
				cell.setCellStyle(styleOfTheadBlackBold);
				cell.setCellValue(listCntString.get(i));
			}
			
			
			//데이터 생성
			if (excelList.size() > 0) {
			
				//윗 상단의 헤더가 있음으로 1번째 줄 부터 시작한다. 
				int rowNum = 1;
				
				//1. 데이터를 한개씩 조회해서 한개의 행으로 만든다.
		        for (Map<String, Object> data : excelList) {
		            
		        	//행 생성
		            Row row = (SXSSFRow) sh.createRow(rowNum++);
		            int cellNum = 0;
		            
		            //2. map에 있는 데이터를 한개씩 조회해서 열을 생성한다. (순서는 db에서 조회 컬럼 순)
		            for (String key : ColumnList) {
		            	
		            	//cell 생성
		                Cell cell = row.createCell(cellNum++);
		               	
		                //3. cell에 데이터 삽입
					     try {
   
					    	 cell.setCellValue(data.get(key).toString());
					    	 
					     }catch (Exception e) {
					    	 
					    	 cell.setCellValue(""); continue;
						}	
		            }
		        }
				
				// 생성된 엑셀 파일 쓰기
				res.reset();
				
				res.setContentType("application/vnd.ms-excel");
	
				res.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(excelName+".xlsx" , "UTF-8"));
				
				wb.write(res.getOutputStream());
				
				((SXSSFWorkbook) wb).dispose();
				
				res.getOutputStream().flush();
				res.getOutputStream().close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@Override
	public void getExcelDataList(HttpServletResponse res, List<EgovMap> excelList, List<EgovMap> excelList2,
									String excelName, int[] ColumnWidth, String[] ColumnList,  String[] ColumnList2, 
									Object[][] sum, Object [][] row1_test, Object [][] row2_test, Object [][] finalRow)	{
		try {
		
			
			SXSSFWorkbook  wb     = new SXSSFWorkbook(100);
			
			// header style
			CellStyle styleOfTheadBlackBold = wb.createCellStyle();
			styleOfTheadBlackBold.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			styleOfTheadBlackBold.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
			//배경색
			styleOfTheadBlackBold.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
			styleOfTheadBlackBold.setFillPattern(CellStyle.SOLID_FOREGROUND);
			//테두리 선 (우,좌,위,아래)
			styleOfTheadBlackBold.setBorderRight(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderTop(HSSFCellStyle.BORDER_THIN);
			styleOfTheadBlackBold.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			//자동 줄바꿈
			styleOfTheadBlackBold.setWrapText(true);
			
			Font font = wb.createFont();
			font.setBoldweight(Font.BOLDWEIGHT_BOLD);
			styleOfTheadBlackBold.setFont(font);
			
			
			// body style
			CellStyle styleOfTbodyBlack = wb.createCellStyle();
			styleOfTbodyBlack.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
			styleOfTbodyBlack.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
			//테두리 선 (우,좌,위,아래)
			styleOfTbodyBlack.setBorderRight(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderTop(HSSFCellStyle.BORDER_THIN);
			styleOfTbodyBlack.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				
			
			
			Map<String, Object[][]> mapTest = new HashMap<String, Object[][]>();
			mapTest.put("sum",sum);
			mapTest.put("row1_test",  row1_test);
			mapTest.put("row2_test" , row2_test);
			//mapTest.put("finalRow",finalRow);
	
			
			
			Map<String, Object[]> mapTest22 = new HashMap<String, Object[]>();
			mapTest22.put("sum", new Object[] {0,1});
			mapTest22.put("row1_test", new Object[] {0,0});
			mapTest22.put("row2_test", new Object[] {0,0});
			//mapTest22.put("finalRow", new Object[] {0,1});

			String[] printCnt = {"sum", "row1_test","row2_test" };
			//String[] printCnt = {"sum", "row1_test", "finalRow", "row2_test" };
			
			List<Integer> listCnt = new ArrayList<Integer>();
			List<String> listCntString = new ArrayList<String>();
			List<String> listCntString2 = new ArrayList<String>();
		
			//--------------------------------------------------------------------------------------
			
			int st = -1 ;
			int ed = -1 ;
	
			SXSSFSheet     sh     = (SXSSFSheet) wb.createSheet(excelName);
			
			
			//--------------------------Start--------------------------
			for(int i= 0; i< ColumnWidth.length; i++) {
				sh.setColumnWidth(i, ColumnWidth[i]); //분석일자
			}
			
			
			//헤더 재료 생성
			//향상된 for 문
			 for ( String objectName : printCnt ) {
				
				 Object[][] objectArr = mapTest.get(objectName); 
				
				 for(int k=0; k<objectArr.length; k++) { 					// 해당 넣어준 object 형의 배열 개수    ex) sum.length
					
						Object[] object = objectArr[k]; 
						
						st = ed+1;
					
						if((int)object[0] == 1) {
							ed = st;
						} else {
							ed = st + ((int)object[0]-1);
						}
					
						sh.addMergedRegion(new CellRangeAddress( (int)mapTest22.get(objectName)[0], (int)mapTest22.get(objectName)[1],	st, ed ));		//시/도
						listCnt.add(st);
					
						if("sum".equals(objectName)) {
							listCntString.add( (String) object[1]);
							listCntString2.add((String) object[1]);
						
						}else if("row1_test".equals(objectName)) {
							listCntString.add((String) object[1]);
						
						}else if("row2_test".equals(objectName)) {
							listCntString2.add((String) object[1]);
						
						}else if("finalRow".equals(objectName)) {
							listCntString.add( (String) object[1]);
						
						}
					
				 }
			};

			
			
			//헤더 생성
			SXSSFRow trow0 = (SXSSFRow) sh.createRow(0);
		
			int cnt = 0;
		
			for (int i = 0; i < ed; i++) {
				SXSSFCell cell = (SXSSFCell) trow0.createCell(i);
				
				for(int j=0; j<listCntString.size(); j++) {
					if(listCnt.get(j) == i ) {
						cell.setCellStyle(styleOfTheadBlackBold);
						cell.setCellValue(listCntString.get(cnt));
						cnt ++;
					}
				}
			}
			
			SXSSFRow trow1 = (SXSSFRow) sh.createRow(1);
	
			for (int i = 0; i < listCntString2.size(); i++) {
				SXSSFCell cell = (SXSSFCell) trow1.createCell(i);
				cell.setCellStyle(styleOfTheadBlackBold);
				cell.setCellValue(listCntString2.get(i));
			}
			
			
			//데이터 생성
			if (excelList.size() > 0) {
			
				//윗 상단의 헤더가 있음으로 2번째 줄 부터 시작한다. 
				int rowNum = 2;
				
				//1. 데이터를 한개씩 조회해서 한개의 행으로 만든다.
		        
				for(int d=0; d<2; d++) {
					
					List<EgovMap> listValue = new ArrayList<EgovMap>();
					String [] ColumnListValue = null;
					listValue.clear();
					
					if(d==0) {
						ColumnListValue = new String[ColumnList.length];
						for(int f=0; f<ColumnListValue.length; f++) {
							ColumnListValue[f] = ColumnList[f];
						}
						
						listValue.addAll(excelList);
						
					}else if(d==1) {
						ColumnListValue = new String[ColumnList2.length];
						for(int f=0; f<ColumnListValue.length; f++) {
							ColumnListValue[f] = ColumnList2[f];
						}
						listValue.addAll(excelList2);
					}
					
					for (Map<String, Object> data : listValue) {
			            
			        	//행 생성
			            Row row = (SXSSFRow) sh.createRow(rowNum++);
			            int cellNum = 0;
			            
			            //2. map에 있는 데이터를 한개씩 조회해서 열을 생성한다. (순서는 db에서 조회 컬럼 순)
			            for (String key : ColumnListValue) {
			            	
			            	//cell 생성
			                Cell cell = row.createCell(cellNum++);
			               	
			                //3. cell에 데이터 삽입
						     try {
	   
						    	 cell.setCellValue(data.get(key).toString());
						    	 
						     }catch (Exception e) {
						    	 
						    	 cell.setCellValue(""); continue;
							}	
			            }
			        }
				}
			
				//--------------------------End--------------------------
		     
				
				// 생성된 엑셀 파일 쓰기
				res.reset();
				
				res.setContentType("application/vnd.ms-excel");
	
				res.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(excelName+".xlsx" , "UTF-8"));
				
				wb.write(res.getOutputStream());
				
				((SXSSFWorkbook) wb).dispose();
				
				res.getOutputStream().flush();
				res.getOutputStream().close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void selectdownloadResultListBT(SearchVO sVO, HttpServletRequest req, HttpServletResponse res) {
		List<EgovMap> downloadResultListB = new ArrayList<EgovMap>();
		List<EgovMap> downloadResultListT = new ArrayList<EgovMap>();

		switch(sVO.getAnal_type()) {
		case "dlStation_stationCnt" : // 정류장별통행
			System.out.println("정류장별통행_BT"); 
			
			//● 인자값 : 데이터 리스트
			downloadResultListB = mapper.selectdownloadResultListStationCntB(sVO); 
			downloadResultListT = mapper.selectdownloadResultListStationCntT(sVO); 
	
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "2";
			
			//● 인자값 : 시트명 
			excelName = "정류장별통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "3000_3000_3000_3000_3000_3000_5000_5000";
			
			//● 인자값 : 컬럼명
			ColumnList_st = "analAreaSidoCdText_"+
							"analAreaCdText_"+
							"provider_"+
							"opratDate_"+
							"tfcmn_"+
							"sttnId_"+
							"sttnNma_"+
							"sttnHjd_"+
							"tm_"+
							"일반SttnBusGinAgg_"+
							"일반SttnBusGffAgg_"+
							"일반SttnBusTrsAgg_"+			
							"어린이SttnBusGinAgg_"+
							"어린이SttnBusGffAgg_"+
							"어린이SttnBusTrsAgg_"+
							"청소년SttnBusGinAgg_"+
							"청소년SttnBusGffAgg_"+
							"청소년SttnBusTrsAgg_"+
							"경로SttnBusGinAgg_"+
							"경로SttnBusGffAgg_"+
							"경로SttnBusTrsAgg_"+
							"장애인SttnBusGinAgg_"+
							"장애인SttnBusGffAgg_"+
							"장애인SttnBusTrsAgg_"+
							"국가유공자SttnBusGinAgg_"+
							"국가유공자SttnBusGffAgg_"+
							"국가유공자SttnBusTrsAgg_"+
							"다자녀부모SttnBusGinAgg_"+
							"다자녀부모SttnBusGffAgg_"+
							"다자녀부모SttnBusTrsAgg_"+
							"동반SttnBusGinAgg_"+
							"동반SttnBusGffAgg_"+
							"동반SttnBusTrsAgg_"+
							"대학생SttnBusGinAgg_"+
							"대학생SttnBusGffAgg_"+
							"대학생SttnBusTrsAgg_"+
							"복지SttnBusGinAgg_"+
							"복지SttnBusGffAgg_"+
							"복지SttnBusTrsAgg_"+
							"기타SttnBusGinAgg_"+
							"기타SttnBusGffAgg_"+
							"기타SttnBusTrsAgg";
			
			ColumnList_st2 = "analAreaSidoCdText_"+
					"analAreaCdText_"+
					"provider_"+
					"opratDate_"+
					"tfcmn_"+
					"sttnId_"+
					"sttnNma_"+
					"sttnHjd_"+
					"tm_"+
					"일반SttnTrainGinAgg_"+
					"일반SttnTrainGffAgg_"+
					"일반SttnTrainTrsAgg_"+
					"어린이SttnTrainGinAgg_"+
					"어린이SttnTrainGffAgg_"+
					"어린이SttnTrainTrsAgg_"+
					"청소년SttnTrainGinAgg_"+
					"청소년SttnTrainGffAgg_"+
					"청소년SttnTrainTrsAgg_"+
					"경로SttnTrainGinAgg_"+
					"경로SttnTrainGffAgg_"+
					"경로SttnTrainTrsAgg_"+
					"장애인SttnTrainGinAgg_"+
					"장애인SttnTrainGffAgg_"+
					"장애인SttnTrainTrsAgg_"+
					"국가유공자SttnTrainGinAgg_"+
					"국가유공자SttnTrainGffAgg_"+
					"국가유공자SttnTrainTrsAgg_"+
					"다자녀부모SttnTrainGinAgg_"+
					"다자녀부모SttnTrainGffAgg_"+
					"다자녀부모SttnTrainTrsAgg_"+
					"동반SttnTrainGinAgg_"+
					"동반SttnTrainGffAgg_"+
					"동반SttnTrainTrsAgg_"+
					"대학생SttnTrainGinAgg_"+
					"대학생SttnTrainGffAgg_"+
					"대학생SttnTrainTrsAgg_"+
					"복지SttnTrainGinAgg_"+
					"복지SttnTrainGffAgg_"+
					"복지SttnTrainTrsAgg_"+
					"기타SttnTrainGinAgg_"+
					"기타SttnTrainGffAgg_"+
					"기타SttnTrainTrsAgg";
			
		
			//● 인자값 : (처음 합체 행) 칸, 엑셀표출명 
			sum_st_0_st = "1_1_1_1_1_1_1_1_1";
			sum_st_1_st = "광역/도_시/군_분석자료_분석일자_정류장구분_정류장ID_정류장명_행정동_시간";
					
		
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "3_3_3_3_3_3_3_3_3_3_3";
			row1_test_st_1_st = "일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
					

			//● 인자값 :  (2열) 칸, 엑셀표출명  
			row2_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1";
			row2_test_st_1_st = "승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승";

			
			//● 인자값 :  (마지막 합계) 칸, 엑셀표출명  
			//finalRow_st_0_st = "";
			//finalRow_st_1_st = "";
			
			break;
		case "dlRoute_routeCnt" : // 노선별통행
			System.out.println("노선별통행_BT"); 
			
			//● 인자값 : 데이터 리스트
			downloadResultListB = mapper.selectdownloadResultListRouteCntB(sVO);
			downloadResultListT = mapper.selectdownloadResultListRouteCntT(sVO); 
	
			//● 인자값 : 헤더가 1행 or 2행  여부
			rowSelect = "2";
			
			//● 인자값 : 시트명 
			excelName = "노선별통행";

			//● 인자값 : 컬럼 Width
			ColumnWidth_st = "3000_3000_3000_3000_3000_3000_3000_5000_5000";
			
			//● 인자값 : 컬럼명
			ColumnList_st ="analAreaSidoCdText_"+
							"analAreaCdText_"+
							"provider_"+
							"opratDate_"+
							"tfcmn_"+
							"routeNma_"+
							"routeType_"+
							"routeStart_"+
							"routeEnd_"+
							"tm_"+
							"일반RouteBusGinAgg_"+
							"일반RouteBusGffAgg_"+
							"일반RouteBusTrsAgg_"+
							"어린이RouteBusGinAgg_"+
							"어린이RouteBusGffAgg_"+
							"어린이RouteBusTrsAgg_"+
							"청소년RouteBusGinAgg_"+
							"청소년RouteBusGffAgg_"+
							"청소년RouteBusTrsAgg_"+
							"경로RouteBusGinAgg_"+
							"경로RouteBusGffAgg_"+
							"경로RouteBusTrsAgg_"+
							"장애인RouteBusGinAgg_"+
							"장애인RouteBusGffAgg_"+
							"장애인RouteBusTrsAgg_"+
							"국가유공자RouteBusGinAgg_"+
							"국가유공자RouteBusGffAgg_"+
							"국가유공자RouteBusTrsAgg_"+
							"다자녀부모RouteBusGinAgg_"+
							"다자녀부모RouteBusGffAgg_"+
							"다자녀부모RouteBusTrsAgg_"+
							"동반RouteBusGinAgg_"+
							"동반RouteBusGffAgg_"+
							"동반RouteBusTrsAgg_"+
							"대학생RouteBusGinAgg_"+
							"대학생RouteBusGffAgg_"+
							"대학생RouteBusTrsAgg_"+
							"복지RouteBusGinAgg_"+
							"복지RouteBusGffAgg_"+
							"복지RouteBusTrsAgg_"+
							"기타RouteBusGinAgg_"+
							"기타RouteBusGffAgg_"+
							"기타RouteBusTrsAgg";
			
			ColumnList_st2 = "analAreaSidoCdText_"+
							"analAreaCdText_"+
							"provider_"+
							"opratDate_"+
							"tfcmn_"+
							"routeNma_"+
							"routeType_"+
							"routeStart_"+
							"routeEnd_"+
							"tm_"+
							"일반RouteTrainGinAgg_"+
							"일반RouteTrainGffAgg_"+
							"일반RouteTrainTrsAgg_"+
							"어린이RouteTrainGinAgg_"+
							"어린이RouteTrainGffAgg_"+
							"어린이RouteTrainTrsAgg_"+
							"청소년RouteTrainGinAgg_"+
							"청소년RouteTrainGffAgg_"+
							"청소년RouteTrainTrsAgg_"+
							"경로RouteTrainGinAgg_"+
							"경로RouteTrainGffAgg_"+
							"경로RouteTrainTrsAgg_"+
							"장애인RouteTrainGinAgg_"+
							"장애인RouteTrainGffAgg_"+
							"장애인RouteTrainTrsAgg_"+
							"국가유공자RouteTrainGinAgg_"+
							"국가유공자RouteTrainGffAgg_"+
							"국가유공자RouteTrainTrsAgg_"+
							"다자녀부모RouteTrainGinAgg_"+
							"다자녀부모RouteTrainGffAgg_"+
							"다자녀부모RouteTrainTrsAgg_"+
							"동반RouteTrainGinAgg_"+
							"동반RouteTrainGffAgg_"+
							"동반RouteTrainTrsAgg_"+
							"대학생RouteTrainGinAgg_"+
							"대학생RouteTrainGffAgg_"+
							"대학생RouteTrainTrsAgg_"+
							"복지RouteTrainGinAgg_"+
							"복지RouteTrainGffAgg_"+
							"복지RouteTrainTrsAgg_"+
							"기타RouteTrainGinAgg_"+
							"기타RouteTrainGffAgg_"+
							"기타RouteTrainTrsAgg";
			
		
			//● 인자값 : (처음 합체 행) 칸, 엑셀표출명 
			sum_st_0_st = "1_1_1_1_1_1_1_1_1_1";
			sum_st_1_st = "광역/도_시/군_분석자료_분석일자_노선구분_노선명_노선유형_기점_종점_시간";
					
		
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_st = "3_3_3_3_3_3_3_3_3_3_3";
			row1_test_st_1_st = "일반_어린이_청소년_경로_장애인_국가유공자_다자녀부모_동반_대학생_복지_기타";
					

			//● 인자값 :  (2열) 칸, 엑셀표출명  
			row2_test_st_0_st = "1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1_1";
			row2_test_st_1_st = "승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승_승차_하차_환승";

			
			//● 인자값 :  (마지막 합계) 칸, 엑셀표출명  
			//finalRow_st_0_st = "";
			//finalRow_st_1_st = "";
			
			
			break;
		}
		
	
			
			//● 인자값 : 컬럼 Width
			ColumnWidth = new int[(ColumnWidth_st.split("_")).length];
			ColumnWidth_arr = new String[(ColumnWidth_st.split("_")).length];
			ColumnWidth_arr = ColumnWidth_st.split("_");
			for(int i=0; i<ColumnWidth_arr.length; i++) {
				ColumnWidth[i]= Integer.parseInt(ColumnWidth_arr[i]);
			}
			
			//● 인자값 : 컬럼명
			ColumnList = ColumnList_st.split("_");
			ColumnList2 = ColumnList_st2.split("_");
			
			
			//● 인자값 : (처음 합체 행) 칸, 엑셀표출명 
			sum_st_0_arr = new String[(sum_st_0_st.split("_")).length];		
			sum_st_1_arr = new String[(sum_st_1_st.split("_")).length];		
			sum = new Object[(sum_st_0_st.split("_")).length][(sum_st_0_st.split("_")).length];		
			
			sum_st_0_arr = sum_st_0_st.split("_");
			sum_st_1_arr = sum_st_1_st.split("_");
			
			
			for(int i=0; i<sum_st_0_arr.length; i++) {
				sum [i][0] =  Integer.parseInt(sum_st_0_arr[i]);
				sum [i][1]= sum_st_1_arr[i];
			}
			
			//● 인자값 :  (1열) 칸, 엑셀표출명  
			row1_test_st_0_arr = new String[(row1_test_st_0_st.split("_")).length];			
			row1_test_st_1_arr = new String[(row1_test_st_1_st.split("_")).length];
			row1_test = new Object[(row1_test_st_0_st.split("_")).length][(row1_test_st_0_st.split("_")).length];		
			
			row1_test_st_0_arr = row1_test_st_0_st.split("_");
			row1_test_st_1_arr = row1_test_st_1_st.split("_");
			
			for(int i=0; i<row1_test_st_0_arr.length; i++) {
				row1_test [i][0] = Integer.parseInt(row1_test_st_0_arr[i]);
				row1_test [i][1]= row1_test_st_1_arr[i];
			}
			
			
			
			//● 인자값 :  (2열) 칸, 엑셀표출명  
			row2_test_st_0_arr = new String[(row2_test_st_0_st.split("_")).length];			
			row2_test_st_1_arr = new String[(row2_test_st_1_st.split("_")).length];
			row2_test = new Object[(row2_test_st_0_st.split("_")).length][(row2_test_st_0_st.split("_")).length];		
			
			row2_test_st_0_arr = row2_test_st_0_st.split("_");
			row2_test_st_1_arr = row2_test_st_1_st.split("_");
			
			for(int i=0; i<row2_test_st_0_arr.length; i++) {
				row2_test [i][0] = Integer.parseInt(row2_test_st_0_arr[i]);
				row2_test [i][1]= row2_test_st_1_arr[i];
			}
			
			/*
			 * //● 인자값 : (마지막 합계) 칸, 엑셀표출명 finalRow_st_0_arr = new
			 * String[(finalRow_st_0_st.split("_")).length]; finalRow_st_1_arr = new
			 * String[(finalRow_st_1_st.split("_")).length]; finalRow = new
			 * Object[(finalRow_st_0_st.split("_")).length][(finalRow_st_0_st.split("_")).
			 * length];
			 * 
			 * finalRow_st_0_arr = finalRow_st_0_st.split("_"); finalRow_st_1_arr =
			 * finalRow_st_1_st.split("_");
			 * 
			 * for(int i=0; i<finalRow_st_0_arr.length; i++) { finalRow [i][0] =
			 * Integer.parseInt(finalRow_st_0_arr[i]); finalRow [i][1]=
			 * finalRow_st_1_arr[i]; }
			 */
			
			getExcelDataList( res, downloadResultListB, downloadResultListT, 
					excelName, ColumnWidth, ColumnList, ColumnList2,
					sum, row1_test, row2_test, finalRow);
			
			
	
		
		for(int i = 0; i < 10; i++) {
			System.out.println(downloadResultListT.get(i).toString());
		}
		
	}


}
