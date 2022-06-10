package com.ybs.user.common.service;

import java.util.Date;

public class UserVO {
	private int uNo;
	private String id;
	private String pwd;
	private String name;
	private String phone;
	private String email;
	private String address;
	private Date entDate;
	private Date dropdate;
	private String dept;
	private String status;
	
	public UserVO() {}

	public UserVO(int uNo, String id, String pwd, String name, String phone, String email, String address, Date entDate,
			Date dropdate, String dept, String status) {
		super();
		this.uNo = uNo;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.entDate = entDate;
		this.dropdate = dropdate;
		this.dept = dept;
		this.status = status;
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getEntDate() {
		return entDate;
	}

	public void setEntDate(Date entDate) {
		this.entDate = entDate;
	}

	public Date getDropdate() {
		return dropdate;
	}

	public void setDropdate(Date dropdate) {
		this.dropdate = dropdate;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "UserVO [uNo=" + uNo + ", id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone=" + phone + ", email="
				+ email + ", address=" + address + ", entDate=" + entDate + ", dropdate=" + dropdate + ", dept=" + dept
				+ ", status=" + status + "]";
	}

	
}
