package team.gallery.model;
import java.sql.Timestamp;

public class GalleryDTO {
	
	private int g_bno;
	private String u_id;
	private String g_subject;
	private String g_content;
	private String g_img;
	private String u_email;
	private String u_sns;
	private int g_price;
	private Timestamp g_reg;
	private String g_imgLocation;
	private String g_imgLens;
	private String g_imgCamera;
	private String g_imgQuality;
	private String g_tag;
	private int category1;
	private int category2;
	private int	g_status;
	private String g_comment;
	private int g_like;
	private int g_readCount;
	public GalleryDTO() {}

	public int getG_bno() { return g_bno; }
	public void setG_bno(int g_bno) { this.g_bno = g_bno; }
	public String getU_id() { return u_id; }
	public void setU_id(String u_id) { this.u_id = u_id; }
	public String getG_subject() { return g_subject; }
	public void setG_subject(String g_subject) { this.g_subject = g_subject; }
	public String getG_content() { return g_content; }
	public void setG_content(String g_content) { this.g_content = g_content; }
	public String getG_img() { 	return g_img; }
	public void setG_img(String g_img) { this.g_img = g_img; }
	public String getU_email() { 	return u_email; }
	public void setU_email(String u_email) { this.u_email = u_email; }
	public String getU_sns() { return u_sns; }
	public void setU_sns(String u_sns) { this.u_sns = u_sns; }
	public int getG_price() { return g_price; }
	public void setG_price(int g_price) { this.g_price = g_price; }
	public Timestamp getG_reg() { return g_reg; }
	public void setG_reg(Timestamp g_reg) { this.g_reg = g_reg; }
	public String getG_imgLocation() { return g_imgLocation; }
	public void setG_imgLocation(String g_imgLocation) { this.g_imgLocation = g_imgLocation; } 
	public String getG_imgLens() { return g_imgLens; }
	public void setG_imgLens(String g_imgLens) { this.g_imgLens = g_imgLens; }
	public String getG_imgCamera() { return g_imgCamera; }
	public void setG_imgCamera(String g_imgCamera) { this.g_imgCamera = g_imgCamera; }
	public String getG_imgQuality() { return g_imgQuality; }
	public void setG_imgQuality(String g_imgQuality) { this.g_imgQuality = g_imgQuality; }
	public String getG_tag() { return g_tag; }
	public void setG_tag(String g_tag) { this.g_tag = g_tag; }
	public int getCategory1() { return category1; }
	public void setCategory1(int category1) { this.category1 = category1; }
	public int getCategory2() { return category2; }
	public void setCategory2(int category2) { this.category2 = category2; }
	public int getG_status() { return g_status; }
	public void setG_status(int g_status) { this.g_status = g_status; }
	public String getG_comment() { return g_comment; }
	public void setG_comment(String g_comment) { this.g_comment = g_comment; }
	public int getG_like() { return g_like; }
	public void setG_like(int g_like) { this.g_like = g_like; }
	public int getG_readCount() { return g_readCount; }
	public void setG_readCount(int g_readCount) { this.g_readCount = g_readCount; }
	
}