package egovframework.example.sample.service;

public class MainVO {
	private String ref_date;
	private String top;
	
	public MainVO() {}

	public MainVO(String ref_date, String top) {
		super();
		this.ref_date = ref_date;
		this.top = top;
	}

	public String getRef_date() {
		return ref_date;
	}

	public void setRef_date(String ref_date) {
		this.ref_date = ref_date;
	}

	public String getTop() {
		return top;
	}

	public void setTop(String top) {
		this.top = top;
	}

	@Override
	public String toString() {
		return "MainVO [ref_date=" + ref_date + ", top=" + top + "]";
	}

}
