package team.mypage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.gallery.model.GalleryDTO;



public class UserSellDAO {
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	
	// 해당판매자의 전체 판매완료 게시물 개수 카운팅 메서드 
	public int getGalleryCount() {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where u_id=? and p_status=1";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count; 
	}
	
	// 해당 판매자가 판매완료한 게시물 가져오기(결제상태값이 2)
		public List getGallerys(int start, int end) {
			List list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from payment order by reg desc) A) B "
						+ "where r >= ? and r <= ?"; // ★★★where u_id=?가 들어가야할듯
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						
						PaymentDTO payment = new PaymentDTO(); 
						payment.setPno(rs.getInt("pno"));		// 결제고유번호
						payment.setG_bno(rs.getInt("g_bno")); 	// 상품고유번호
						payment.setU_id(rs.getString("u_id")); 	// 유저번호
						payment.setG_subject(rs.getString("g_subject")); // 상품제목
						payment.setG_price(rs.getInt("g_price"));	   // 상품금액
						payment.setP_finalPrice(rs.getInt("p_finalPrice")); // 최종결제금액
						payment.setP_point(rs.getInt("p_point"));		// 사용포인트금액
						payment.setP_status(rs.getInt("p_status"));	// 판매상태
						payment.setP_reg(rs.getTimestamp("p_reg"));		// 판매일시
						
						list.add(payment);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list;
		}
	
		// 검색한 판매글의 총 개수 카운팅 메서드(현재판매중인 리스트와 게시글관리)
		public int getGallerySearchCount(String u_id, String sel, String search) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and "+sel+" like '%"+search+"%'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}			
		
	
		// 검색한 판매글 목록 가져오는 메서드(현재판매중인 리스트와 게시글관리)
		public List getGallerySearch(int start, int end, String u_id, String sel, String search) {
			List list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where "+sel+" like '%"+search+"%'"
						+ " order by g_reg desc) A) B "
						+ "where u_id=? and r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { 
					list = new ArrayList();
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list; 
		}
		

		
		//★★★★★ 현재 판매중인 게시물 카운팅 메서드(상태값 1=승인하여 판매중, 2=숨김처리된상품)
		// (로그인된 세션값으로 DB에 저장된 게시글 개수 가져오는)
		public int getMyGalleryCount(String u_id) {
			int count = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and g_status=1 or g_status=2";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
		//★★★★★ 현재 판매중인 게시물 목록 가져오는 메서드(상태값 1=승인하여 판매중, 2=숨김처리된상품)
		public List getMyGallerys(String u_id, int startRow, int endRow) {
			List list = null; 
			Connection conn = null; 	
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where g_status=1 or g_status=2 order by g_reg desc) A) B "
						+ "where u_id=? and r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list;
		}
		
		
		// 형준 : 판매승인요청건(미승인 : g_status=0) 카운팅 메서드
		public int getMyRequestCount(String u_id) {
			int count = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and g_status=0";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
		// 판매승인 대기건 목록 가져오는 메서드 
		public List getMyRequest(String u_id, int startRow, int endRow) {
			List list = null;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where u_id=? and g_status=0 order by g_reg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list;
		}
		
		//★★★★★ 내가 올린글 전체목록 카운팅 메서드(마이페이지 관리용)
		public int getMyAllGalleryCount(String u_id) {
			int count = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
		//★★★★★ 내가 올린글 전체목록 불러오는 메서드(마이페이지 관리용)
		public List getMyAllGallerys(String u_id, int startRow, int endRow) {
			List list = null; 
			Connection conn = null; 	
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where u_id=? order by g_reg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list;
		}	
		
		// 해당회원 휴면상품 갯수 카운팅메서드
		public int getMySellSleep(String u_id) {
			int count = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and g_status=2";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
				}
				System.out.println("해당회원의 휴면상품 갯수 :" + count);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
// --------------------------------------기간조회 메서드 관련 -----------------------------------------------------------------		
		
		// 판매중인 상품 기간으로 조회하여 카운팅하는 메서드
		public int getSearchDateCount(String u_id, String startDate, String endDate) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and g_status=1 or g_status=2 and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"' order by g_reg";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
		// 기간으로 조회하여 해당목록 가져오는 메서드 (판매상품)
		public List getSearchDate(int startRow, int endRow, String u_id, String startDate, String endDate) {
			List list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where u_id=? and g_status=1 or g_status=2 and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"'"
						+ " order by g_reg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list; 
		}		
		
		// 판매요청한 상품 기간으로 조회하여 카운팅하는 메서드
		public int getRequestDateCount(String u_id, String startDate, String endDate) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and g_status=0 and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"' order by g_reg";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
		// 기간으로 조회하여 해당목록 가져오는 메서드 (판매요청)
		public List getRequestDate(int startRow, int endRow, String u_id, String startDate, String endDate) {
			List list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where u_id=? and g_status=0 and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"'"
						+ " order by g_reg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list; 
		}	
		
		// 판매요청한 상품 기간으로 조회하여 카운팅하는 메서드
		public int getAllDateCount(String u_id, String startDate, String endDate) {
			int count = 0; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select count(*) from galleryUpload where u_id=? and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"' order by g_reg";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return count;
		}
		
		// 기간으로 조회 (전체
		public List getAllDate(int startRow, int endRow, String u_id, String startDate, String endDate) {
			List list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			try {
				conn = getConnection(); 
				String sql = "select B.* from (select rownum r, A.* from "
						+ "(select * from galleryUpload where u_id=? and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"'"
						+ " order by g_reg desc) A) B "
						+ "where r >= ? and r <= ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
					list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
					do {
						GalleryDTO myGallery = new GalleryDTO(); 
						myGallery.setG_bno(rs.getInt("g_bno"));
						myGallery.setU_id(u_id);
						myGallery.setG_subject(rs.getString("g_subject"));
						myGallery.setG_content(rs.getString("g_content"));
						myGallery.setG_img(rs.getString("g_img"));
						myGallery.setU_email(rs.getString("u_email"));
						myGallery.setU_sns(rs.getString("u_sns"));
						myGallery.setG_price(rs.getInt("g_price"));
						myGallery.setG_reg(rs.getTimestamp("g_reg"));
						myGallery.setG_imgLocation(rs.getString("g_imgLocation"));
						myGallery.setG_imgLens(rs.getString("g_imgLens"));
						myGallery.setG_imgCamera(rs.getString("g_imgCamera"));
						myGallery.setG_imgQuality(rs.getString("g_imgQuality"));
						myGallery.setG_tag(rs.getString("g_tag"));
						myGallery.setCategory1(rs.getInt("category1"));
						myGallery.setCategory2(rs.getInt("category2"));
						myGallery.setG_status(rs.getInt("g_status"));
						myGallery.setG_comment(rs.getString("g_comment"));
						myGallery.setG_like(rs.getInt("g_like"));
						myGallery.setG_readCount(rs.getInt("g_readCount"));
						
						list.add(myGallery);
					}while(rs.next());
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return list; 
		}			
		
}