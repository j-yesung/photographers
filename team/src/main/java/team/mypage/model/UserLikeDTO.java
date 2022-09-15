package team.mypage.model;

import java.sql.Timestamp;

public class UserLikeDTO {

	private int ulno;
	private int g_bno;
	private String u_id;
	private String u_id2;
	private Timestamp ul_reg;
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
	public int getUlno() {
		return ulno;
	}
	public void setUlno(int ulno) {
		this.ulno = ulno;
	}
	public int getG_bno() {
		return g_bno;
	}
	public void setG_bno(int g_bno) {
		this.g_bno = g_bno;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public Timestamp getUl_reg() {
		return ul_reg;
	}
	public void setUl_reg(Timestamp ul_reg) {
		this.ul_reg = ul_reg;
	}
	
}