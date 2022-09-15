package team.user.model;

import java.sql.Timestamp;

public class UserDTO {
	
	private int u_userno;
	private String u_id;
	private String u_pw;
	private String u_nick;
	private String u_email;
	private String u_sns;
	private String u_photo;
	private int u_status;
	private String u_favorite1;
	private String u_favorite2;
	private Timestamp u_reg;
	
	
	
	public int getU_userno() {
		return u_userno;
	}
	public void setU_userno(int u_userno) {
		this.u_userno = u_userno;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pw() {
		return u_pw;
	}
	public void setU_pw(String u_pw) {
		this.u_pw = u_pw;
	}
	public String getU_nick() {
		return u_nick;
	}
	public void setU_nick(String u_nick) {
		this.u_nick = u_nick;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_sns() {
		return u_sns;
	}
	public void setU_sns(String u_sns) {
		this.u_sns = u_sns;
	}
	public String getU_photo() {
		return u_photo;
	}
	public void setU_photo(String u_photo) {
		this.u_photo = u_photo;
	}
	public int getU_status() {
		return u_status;
	}
	public void setU_status(int u_status) {
		this.u_status = u_status;
	}
	public String getU_favorite1() {
		return u_favorite1;
	}
	public void setU_favorite1(String u_favorite1) {
		this.u_favorite1 = u_favorite1;
	}
	public String getU_favorite2() {
		return u_favorite2;
	}
	public void setU_favorite2(String u_favorite2) {
		this.u_favorite2 = u_favorite2;
	}
	public Timestamp getU_reg() {
		return u_reg;
	}
	public void setU_reg(Timestamp u_reg) {
		this.u_reg = u_reg;
	}
	
	
}