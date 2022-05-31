package com.ybs.indicator.common.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class YbsUtil {
	
	public static List<String> getDayBetween(String startDate, String endDate, String dateFormat) {
		List<String> result = new ArrayList<String>();
		int maxCnt = 365;
		try {
			SimpleDateFormat sf = new SimpleDateFormat(dateFormat);
			Calendar cal = Calendar.getInstance();
			cal.setTime(sf.parse(startDate));
			
			while(true) {
				String dateStr =  sf.format(cal.getTime());
				result.add(dateStr);
				if(dateStr.equals(endDate)) {
					break;
				}
				cal.add(Calendar.DATE, 1);
				
				if(result.size() >= maxCnt) {
					break;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	//String outputDate : 변환될 날짜포멧 
	//String inputDate : 기존 날짜포멧 
	//String date : 날짜 
	
	//ex)  getStringDateFormat("20210531" ,"yyyyMMdd" ,"yyyy-MM-dd")
	
	public static String getStringDateFormat( String date, String inputDate, String outputDate) {
		
		String dt = date;											//자료형이 string 인 변수 선언 후 날짜 정보 입력
		SimpleDateFormat input = new SimpleDateFormat(inputDate);  	//dt와 형식을 맞추어 준다.
		SimpleDateFormat output = new SimpleDateFormat(outputDate); //변환할 형식
		
		Date newdt = null;
		try {
			
			newdt = input.parse(dt);
			
		} catch (ParseException e) {
		
			e.printStackTrace();
		}

		String result = output.format(newdt);	//date 타입을 string 으로 변환
		
		return result;
	}
}
