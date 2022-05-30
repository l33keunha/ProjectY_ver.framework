package com.ybs.indicator.common.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
}
