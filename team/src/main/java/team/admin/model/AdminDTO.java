package team.admin.model;

public class AdminDTO {
	
	private int bc_no;
	private String bc_name;
	private String bc_img;
	private int mc_no;
	private String mc_name;
	private String mc_img;
	private String si_Loading;
	private String si_MainImg;
	private String si_TodayImg;
	private int ono;
	private int TotalSales;
	private int TotalQty;
	
	public int getBc_no() {
		return bc_no;
	}
	public void setBc_no(int bc_no) {
		this.bc_no = bc_no;
	}
	public String getBc_name() {
		return bc_name;
	}
	public void setBc_name(String bc_name) {
		this.bc_name = bc_name;
	}
	public String getBc_img() {
		return bc_img;
	}
	public void setBc_img(String bc_img) {
		this.bc_img = bc_img;
	}
	public int getMc_no() {
		return mc_no;
	}
	public void setMc_no(int mc_no) {
		this.mc_no = mc_no;
	}
	public String getMc_name() {
		return mc_name;
	}
	public void setMc_name(String mc_name) {
		this.mc_name = mc_name;
	}
	public String getMc_img() {
		return mc_img;
	}
	public void setMc_img(String mc_img) {
		this.mc_img = mc_img;
	}
	public String getSi_Loading() {
		return si_Loading;
	}
	public void setSi_Loading(String si_Loading) {
		this.si_Loading = si_Loading;
	}
	public String getSi_MainImg() {
		return si_MainImg;
	}
	public void setSi_MainImg(String si_MainImg) {
		this.si_MainImg = si_MainImg;
	}
	public String getSi_TodayImg() {
		return si_TodayImg;
	}
	public void setSi_TodayImg(String si_TodayImg) {
		this.si_TodayImg = si_TodayImg;
	}
	public int getOno() {
		return ono;
	}
	public void setOno(int ono) {
		this.ono = ono;
	}
	public int getTotalSales() {
		return TotalSales;
	}
	public void setTotalSales(int totalSales) {
		TotalSales = totalSales;
	}
	public int getTotalQty() {
		return TotalQty;
	}
	public void setTotalQty(int totalQty) {
		TotalQty = totalQty;
	}
	
}