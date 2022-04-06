package com.ybs.indicator.pass.service;

import java.util.Arrays;
import java.util.Date;

public class PassSearchVO {
	
	private String passDateStart;
	private String passDateEnd;
	private String passSido;
	private String passSigungu;
	private String passUseArea;
	private String passOwner;
	private String passGroup;
	private String passType;
	private String passTime;
	private int passTimeStart;
	private int passTimeEnd;
	private String[] passUserType;
	private String passTransport;
	
	public PassSearchVO() {}

	public PassSearchVO(String passDateStart, String passDateEnd, String passSido, String passSigungu,
			String passUseArea, String passOwner, String passGroup, String passType, String passTime, int passTimeStart,
			int passTimeEnd, String[] passUserType, String passTransport) {
		super();
		this.passDateStart = passDateStart;
		this.passDateEnd = passDateEnd;
		this.passSido = passSido;
		this.passSigungu = passSigungu;
		this.passUseArea = passUseArea;
		this.passOwner = passOwner;
		this.passGroup = passGroup;
		this.passType = passType;
		this.passTime = passTime;
		this.passTimeStart = passTimeStart;
		this.passTimeEnd = passTimeEnd;
		this.passUserType = passUserType;
		this.passTransport = passTransport;
	}

	public String getPassDateStart() {
		return passDateStart;
	}

	public void setPassDateStart(String passDateStart) {
		this.passDateStart = passDateStart;
	}

	public String getPassDateEnd() {
		return passDateEnd;
	}

	public void setPassDateEnd(String passDateEnd) {
		this.passDateEnd = passDateEnd;
	}

	public String getPassSido() {
		return passSido;
	}

	public void setPassSido(String passSido) {
		this.passSido = passSido;
	}

	public String getPassSigungu() {
		return passSigungu;
	}

	public void setPassSigungu(String passSigungu) {
		this.passSigungu = passSigungu;
	}

	public String getPassUseArea() {
		return passUseArea;
	}

	public void setPassUseArea(String passUseArea) {
		this.passUseArea = passUseArea;
	}

	public String getPassOwner() {
		return passOwner;
	}

	public void setPassOwner(String passOwner) {
		this.passOwner = passOwner;
	}

	public String getPassGroup() {
		return passGroup;
	}

	public void setPassGroup(String passGroup) {
		this.passGroup = passGroup;
	}

	public String getPassType() {
		return passType;
	}

	public void setPassType(String passType) {
		this.passType = passType;
	}

	public String getPassTime() {
		return passTime;
	}

	public void setPassTime(String passTime) {
		this.passTime = passTime;
	}

	public int getPassTimeStart() {
		return passTimeStart;
	}

	public void setPassTimeStart(int passTimeStart) {
		this.passTimeStart = passTimeStart;
	}

	public int getPassTimeEnd() {
		return passTimeEnd;
	}

	public void setPassTimeEnd(int passTimeEnd) {
		this.passTimeEnd = passTimeEnd;
	}

	public String[] getPassUserType() {
		return passUserType;
	}

	public void setPassUserType(String[] passUserType) {
		this.passUserType = passUserType;
	}

	public String getPassTransport() {
		return passTransport;
	}

	public void setPassTransport(String passTransport) {
		this.passTransport = passTransport;
	}

	@Override
	public String toString() {
		return "PassSearchVO [passDateStart=" + passDateStart + ", passDateEnd=" + passDateEnd + ", passSido="
				+ passSido + ", passSigungu=" + passSigungu + ", passUseArea=" + passUseArea + ", passOwner="
				+ passOwner + ", passGroup=" + passGroup + ", passType=" + passType + ", passTime=" + passTime
				+ ", passTimeStart=" + passTimeStart + ", passTimeEnd=" + passTimeEnd + ", passUserType="
				+ Arrays.toString(passUserType) + ", passTransport=" + passTransport + "]";
	}

}
