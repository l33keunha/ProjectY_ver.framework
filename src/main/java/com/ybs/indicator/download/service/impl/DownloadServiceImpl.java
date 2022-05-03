package com.ybs.indicator.download.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.swing.plaf.synth.SynthOptionPaneUI;

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

	@Override
	public void selectdownloadResultList(SearchVO sVO) {
		List<EgovMap> downloadResultList = new ArrayList<EgovMap>();
		
		switch(sVO.getAnal_type()) {
		case "dlStation_stationCnt" : // 정류장별통행
			System.out.println("정류장별통행"); 
			downloadResultList = mapper.selectdownloadResultListStationCnt(sVO); break;
		case "dlStation_station_purpose" : // 정류장간목적통행
			System.out.println("정류장간목적통행"); 
			downloadResultList = mapper.selectdownloadResultListStationOD_purpose(sVO); break;
		case "dlStation_station_method" : // 정류장간수단통행
			System.out.println("정류장간수단통행"); 
			downloadResultList = mapper.selectdownloadResultListStationOD_method(sVO); break;
		case "dlStation_station_run" : // 정류장간운행지표 (x)
			System.out.println("정류장간운행지표 (x)"); break;
		case "dlStation_station_runCongestion" : // 정류장간운행/혼잡지표 (x)
			System.out.println("정류장간운행/혼잡지표 (x)"); break;
		case "dlRoute_routeCnt" : // 노선별통행
			System.out.println("노선별통행"); 
			downloadResultList = mapper.selectdownloadResultListRouteCnt(sVO); break;
		case "dlRoute_routeODCnt" : // 노선별기종점통행
			System.out.println("노선별기종점통행"); 
			downloadResultList = mapper.selectdownloadResultListRouteOD(sVO); break;
		case "dlRoute_routeCBP" : // 노선별 재차인원 (x)
			System.out.println("dlRoute_routeCBP (x)"); break;
		case "dlArea_areaOD_purpose" : // 행정동간목적통행
			System.out.println("행정동간목적통행"); 
			downloadResultList = mapper.selectdownloadResultListAreaOD_purpose(sVO); break;
		case "dlArea_areaOD_method"  : // 행정동간수단통행
			System.out.println("행정동간수단통행"); 
			downloadResultList = mapper.selectdownloadResultListAreaOD_method(sVO); break;
		}
		
		for(int i = 0; i < downloadResultList.size(); i++) {
			System.out.println(downloadResultList.get(i).toString());
		}
	}

}
