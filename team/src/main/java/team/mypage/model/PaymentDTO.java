package team.mypage.model;

import java.sql.Timestamp;

public class PaymentDTO {
	private int pno;
	private int g_bno;
	private String g_subject;
	private String u_id;
	private String p_id;
	private int g_price;
	private int p_finalPrice;
	private int p_point;
	private String p_option;
	private int p_status;
	private Timestamp p_reg;
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public int getG_bno() {
		return g_bno;
	}
	public void setG_bno(int g_bno) {
		this.g_bno = g_bno;
	}
	public String getG_subject() {
		return g_subject;
	}
	public void setG_subject(String g_subject) {
		this.g_subject = g_subject;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public int getG_price() {
		return g_price;
	}
	public void setG_price(int g_price) {
		this.g_price = g_price;
	}
	public int getP_finalPrice() {
		return p_finalPrice;
	}
	public void setP_finalPrice(int p_finalPrice) {
		this.p_finalPrice = p_finalPrice;
	}
	public int getP_point() {
		return p_point;
	}
	public void setP_point(int p_point) {
		this.p_point = p_point;
	}
	public String getP_option() {
		return p_option;
	}
	public void setP_option(String p_option) {
		this.p_option = p_option;
	}
	public int getP_status() {
		return p_status;
	}
	public void setP_status(int p_status) {
		this.p_status = p_status;
	}
	public Timestamp getP_reg() {
		return p_reg;
	}
	public void setP_reg(Timestamp p_reg) {
		this.p_reg = p_reg;
	}
	
	
	
	
}