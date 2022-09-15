package team.mypage.model;

import java.sql.Timestamp;

import team.gallery.model.GalleryDTO;

public class UserCartDTO {
	private int ucno;
	private String u_id;
	private String u_id2;
	private int g_bno;
	private Timestamp uc_reg;
	private int amount;
	private String [] deleteCart;


	
	public String[] getDeleteCart() {
		return deleteCart;
	}
	public void setDeleteCart(String[] deleteCart) {
		this.deleteCart = deleteCart;
	}
	public String getU_id2() {
		return u_id2;
	}
	public void setU_id2(String u_id2) {
		this.u_id2 = u_id2;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getUcno() {
		return ucno;
	}
	public void setUcno(int ucno) {
		this.ucno = ucno;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getG_bno() {
		return g_bno;
	}
	public void setG_bno(int g_bno) {
		this.g_bno = g_bno;
	}
	public Timestamp getUc_reg() {
		return uc_reg;
	}
	public void setUc_reg(Timestamp uc_reg) {
		this.uc_reg = uc_reg;
	}
	
}