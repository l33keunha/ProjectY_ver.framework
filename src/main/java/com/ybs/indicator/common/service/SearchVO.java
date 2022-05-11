package com.ybs.indicator.common.service;

import java.util.Arrays;

public class SearchVO {
	
	private String anal_fin;
	private String dateStart;
	private String dateEnd;
	private String anal_area_cd_sido;
	private String anal_area_cd_sido_text;
	private String anal_area_cd;
	private String anal_area_cd_text;
	private String provider;
	private String provider_text;
	private String anal_group;
	private String anal_type;
	private String tm;
	private int tmStart;
	private int tmEnd;
	private String[] cd_no;
	private String tfcmn;
	private String routeId;
	
	public SearchVO() {}

	public SearchVO(String anal_fin, String dateStart, String dateEnd, String anal_area_cd_sido,
			String anal_area_cd_sido_text, String anal_area_cd, String anal_area_cd_text, String provider,
			String provider_text, String anal_group, String anal_type, String tm, int tmStart, int tmEnd,
			String[] cd_no, String tfcmn, String routeId) {
		super();
		this.anal_fin = anal_fin;
		this.dateStart = dateStart;
		this.dateEnd = dateEnd;
		this.anal_area_cd_sido = anal_area_cd_sido;
		this.anal_area_cd_sido_text = anal_area_cd_sido_text;
		this.anal_area_cd = anal_area_cd;
		this.anal_area_cd_text = anal_area_cd_text;
		this.provider = provider;
		this.provider_text = provider_text;
		this.anal_group = anal_group;
		this.anal_type = anal_type;
		this.tm = tm;
		this.tmStart = tmStart;
		this.tmEnd = tmEnd;
		this.cd_no = cd_no;
		this.tfcmn = tfcmn;
		this.routeId = routeId;
	}

	public String getAnal_fin() {
		return anal_fin;
	}

	public void setAnal_fin(String anal_fin) {
		this.anal_fin = anal_fin;
	}

	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}

	public String getAnal_area_cd_sido() {
		return anal_area_cd_sido;
	}

	public void setAnal_area_cd_sido(String anal_area_cd_sido) {
		this.anal_area_cd_sido = anal_area_cd_sido;
	}

	public String getAnal_area_cd_sido_text() {
		return anal_area_cd_sido_text;
	}

	public void setAnal_area_cd_sido_text(String anal_area_cd_sido_text) {
		this.anal_area_cd_sido_text = anal_area_cd_sido_text;
	}

	public String getAnal_area_cd() {
		return anal_area_cd;
	}

	public void setAnal_area_cd(String anal_area_cd) {
		this.anal_area_cd = anal_area_cd;
	}

	public String getAnal_area_cd_text() {
		return anal_area_cd_text;
	}

	public void setAnal_area_cd_text(String anal_area_cd_text) {
		this.anal_area_cd_text = anal_area_cd_text;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public String getProvider_text() {
		return provider_text;
	}

	public void setProvider_text(String provider_text) {
		this.provider_text = provider_text;
	}

	public String getAnal_group() {
		return anal_group;
	}

	public void setAnal_group(String anal_group) {
		this.anal_group = anal_group;
	}

	public String getAnal_type() {
		return anal_type;
	}

	public void setAnal_type(String anal_type) {
		this.anal_type = anal_type;
	}

	public String getTm() {
		return tm;
	}

	public void setTm(String tm) {
		this.tm = tm;
	}

	public int getTmStart() {
		return tmStart;
	}

	public void setTmStart(int tmStart) {
		this.tmStart = tmStart;
	}

	public int getTmEnd() {
		return tmEnd;
	}

	public void setTmEnd(int tmEnd) {
		this.tmEnd = tmEnd;
	}

	public String[] getCd_no() {
		return cd_no;
	}

	public void setCd_no(String[] cd_no) {
		this.cd_no = cd_no;
	}

	public String getTfcmn() {
		return tfcmn;
	}

	public void setTfcmn(String tfcmn) {
		this.tfcmn = tfcmn;
	}

	public String getRouteId() {
		return routeId;
	}

	public void setRouteId(String routeId) {
		this.routeId = routeId;
	}

	@Override
	public String toString() {
		return "SearchVO [anal_fin=" + anal_fin + ", dateStart=" + dateStart + ", dateEnd=" + dateEnd
				+ ", anal_area_cd_sido=" + anal_area_cd_sido + ", anal_area_cd_sido_text=" + anal_area_cd_sido_text
				+ ", anal_area_cd=" + anal_area_cd + ", anal_area_cd_text=" + anal_area_cd_text + ", provider="
				+ provider + ", provider_text=" + provider_text + ", anal_group=" + anal_group + ", anal_type="
				+ anal_type + ", tm=" + tm + ", tmStart=" + tmStart + ", tmEnd=" + tmEnd + ", cd_no="
				+ Arrays.toString(cd_no) + ", tfcmn=" + tfcmn + ", routeId=" + routeId + "]";
	}

}
