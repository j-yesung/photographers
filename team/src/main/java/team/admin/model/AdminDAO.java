package team.admin.model;

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
import team.mypage.model.PaymentDTO;
import team.user.model.UserDTO;

public class AdminDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}	
	
	// 관리자 : 모든 회원의 게시물 갯수 카운팅메서드(상태 1: 판매중, 2 : 휴면상품)
	public int getAllGallerysCount() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=1 or g_status=2";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("모든 회원의 갤러리 갯수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}	
	
	// 관리자 : 모든 회원 게시물 목록 가져오는 메서드(상태 1: 판매중, 2 : 휴면상품)
	public List getAllGallerys(int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from galleryUpload where g_status=1 or g_status=2 order by g_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGallery = new GalleryDTO(); 
					myGallery.setG_bno(rs.getInt("g_bno"));
					myGallery.setU_id(rs.getString("u_id"));
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
	
	// 관리자 : 모든 회원의 판매중인 상품만 카운팅메서드(g_status=1)
	public int getSellNow() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=1";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("모든 회원의 판매중인 갤러리 갯수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}	
	
	// 관리자 : 모든 회원의 휴면상품만 카운팅메서드(g_status=2)
	public int getSellSleep() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=2";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("모든 회원의 휴면 갯수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}	
	
	// 관리자 : 검색한 키워드의 모든 회원의 게시물 갯수 카운팅메서드
	public int getAllGallerySearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=1 or g_status=2 and " + sel + " like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			
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
	
	// 관리자 : 검색한 키워드의 모든 판매글 목록 가져오는 메서드
	public List getAllGallerySearch(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from galleryUpload where "+sel+" like '%"+search+"%'"
					+ " order by g_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				list = new ArrayList();
				do {
					GalleryDTO myGallery = new GalleryDTO(); 
					myGallery.setG_bno(rs.getInt("g_bno"));
					myGallery.setU_id(rs.getString("u_id"));
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
	
	
	// 관리자 : 모든 회원수 카운팅메서드
	public int getAllUserCount() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from signUp where u_status=1 or u_status=2";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("모든 회원의 수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}	
	
	// 관리자 : 모든 회원목록 가져오는 메서드
	public List getAllUser(int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from signUp where u_status=1 or u_status=2 order by u_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					UserDTO user = new UserDTO(); 
					user.setU_userno(rs.getInt("u_userno"));
					user.setU_id(rs.getString("u_id"));
					user.setU_pw(rs.getString("u_pw"));
					user.setU_nick(rs.getString("u_nick"));
					user.setU_email(rs.getString("u_email"));
					user.setU_sns(rs.getString("u_sns"));
					user.setU_photo(rs.getString("u_photo"));
					user.setU_status(rs.getInt("u_status"));
					user.setU_favorite1(rs.getString("u_favorite1"));
					user.setU_favorite2(rs.getString("u_favorite2"));
					user.setU_reg(rs.getTimestamp("u_reg"));
					
					list.add(user);
				}while(rs.next());
			}
			System.out.println("모든 회원 리스트 : " + list);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return list;
	}		
	
	// 관리자 : 모든 회원 중 정상이용 계정만 카운팅하기(u_status=1)
	public int getUserNow() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from signUp where u_status=1";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("정상이용계정 회원의 수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}
	
	// 관리자 : 모든 회원 중 휴면 계정만 카운팅하기(u_status=2)
	public int getUserSleep() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from signUp where u_status=2";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("휴면계정 회원의 수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}		
	
	
	// 관리자 : 검색한 회원정보 카운팅메서드
	public int getAllUserSearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from signUp where " + sel + " like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			
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
	
	// 관리자 : 검색한 회원정보 불러오는 메서드 
	public List getAllUserSearch(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from signUp where "+sel+" like '%"+search+"%'"
					+ " order by u_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				list = new ArrayList();
				do {
					UserDTO user = new UserDTO(); 
					user.setU_userno(rs.getInt("u_userno"));
					user.setU_id(rs.getString("u_id"));
					user.setU_pw(rs.getString("u_pw"));
					user.setU_nick(rs.getString("u_nick"));
					user.setU_email(rs.getString("u_email"));
					user.setU_sns(rs.getString("u_sns"));
					user.setU_photo(rs.getString("u_photo"));
					user.setU_status(rs.getInt("u_status"));
					user.setU_favorite1(rs.getString("u_favorite1"));
					user.setU_favorite2(rs.getString("u_favorite2"));
					user.setU_reg(rs.getTimestamp("u_reg"));
					
					list.add(user);
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
	
	// 관리자 : 회원정보 하나 가져오는 메서드
	public UserDTO adGetUser(String u_id) {
		UserDTO user = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select * from signup where u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과가 있으면
				user = new UserDTO();
				user.setU_id(u_id);
				user.setU_pw(rs.getString("u_pw"));
				user.setU_nick(rs.getString("u_nick"));
				user.setU_email(rs.getString("u_email"));
				user.setU_photo(rs.getString("u_photo"));
				user.setU_sns(rs.getString("u_sns"));
				user.setU_favorite1(rs.getString("u_favorite1"));
				user.setU_favorite2(rs.getString("u_favorite2"));
				user.setU_reg(rs.getTimestamp("u_reg"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
		}
		return user;
	} 	
	
	// 관리자 : 전체 결제완료건 카운팅 메서드
	public int getAllPaymentCount() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where p_status=1";
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
	
	// 관리자 : 전체 결제완료된 건 가져오는 메서드
	public List getAllPayment(int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment order by p_reg desc) A) B "
					+ "where p_status=1 and r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);			
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					PaymentDTO payment = new PaymentDTO(); 
					payment.setPno(rs.getInt("pno"));
					payment.setG_bno(rs.getInt("g_bno"));
					payment.setG_subject(rs.getString("g_subject"));
					payment.setU_id(rs.getString("u_id"));
					payment.setP_id(rs.getString("p_id"));
					payment.setG_price(rs.getInt("g_price"));
					payment.setP_finalPrice(rs.getInt("p_finalPrice"));
					payment.setP_point(rs.getInt("p_point"));
					payment.setP_option(rs.getString("p_option"));
					payment.setP_status(rs.getInt("p_status"));
					payment.setP_reg(rs.getTimestamp("p_reg"));
					
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
	
	// 관리자 : 검색한 결제완료글의 총 개수 카운팅 메서드
	public int getAllPaymentSearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			
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
	
	// 관리자 : 검색한 결제완료글 목록 가져오는 메서드
	public List getAllPaymentSearch(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where "+sel+" like '%"+search+"%'"
					+ " order by p_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				list = new ArrayList();
				do {
					PaymentDTO payment = new PaymentDTO(); 
					payment.setPno(rs.getInt("pno"));	// 결제고유번호
					payment.setG_bno(rs.getInt("g_bno"));
					payment.setG_subject(rs.getString("g_subject"));
					payment.setU_id(rs.getString("u_id"));
					payment.setP_id(rs.getString("p_id"));
					payment.setG_price(rs.getInt("g_price"));
					payment.setP_finalPrice(rs.getInt("p_finalPrice"));
					payment.setP_point(rs.getInt("p_point"));
					payment.setP_option(rs.getString("p_option"));
					payment.setP_status(rs.getInt("p_status"));
					payment.setP_reg(rs.getTimestamp("p_reg"));
					
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
	
	// 관리자 : 판매완료된건 토탈 금액 계산하는 메서드
	public int getTotalPrice() {
		List list = null;
		int total = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select g_price from payment";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					PaymentDTO payment = new PaymentDTO();
					payment.setG_price(rs.getInt("g_price"));
					
					total += rs.getInt("g_price");
					list.add(total);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return total;
	}	
	
	
	// 관리자 : 승인요청 대기건 카운팅 메서드(g_status=0)
	public int getAllRequestCount() {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=0";
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
	
	
	// 관리자 : 승인요청 대기건 불러오는 메서드(g_status=0)
	public List getAllRequest(int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from galleryUpload where g_status=0 order by g_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGallery = new GalleryDTO(); 
					myGallery.setG_bno(rs.getInt("g_bno"));
					myGallery.setU_id(rs.getString("u_id"));
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
	
	// 관리자 : 승인요청건중 검색 키워드에 해당하는 목록 카운팅 메서드
	public int getAllRequestSearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=0 and "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			
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
	
	// 관리자 : 승인요청건 중 검색키워드에 해당하는 목록 가져오는 메서드
	public List getAllRequestSearch(int start, int end, String sel, String search) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from galleryUpload where g_status=0 and "+sel+" like '%"+search+"%'"
					+ " order by g_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGallery = new GalleryDTO(); 
					myGallery.setG_bno(rs.getInt("g_bno"));
					myGallery.setU_id(rs.getString("u_id"));
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
	
	// 반려시 g_comment 추가하는 메서드 
	public int rejectRequest(int g_bno, String g_comment) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from GalleryUpload where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {  
				sql = "update galleryUpload set g_comment=? where g_bno=?"; 
				pstmt = conn.prepareStatement(sql);
		
				pstmt.setString(1, g_comment);
				pstmt.setInt(2, g_bno);
				
				result = pstmt.executeUpdate(); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result;
	}	
	
	
	//---------------------------찬욱----------------------------------------------------
	// siteimg 이미지 이름값들 받아오는 메서드
public AdminDTO getLoad() {
		AdminDTO loading = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select * from siteimg";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
				if(rs.next()) {
					loading = new AdminDTO(); 
					loading.setSi_Loading(rs.getString("si_Loading"));
					loading.setSi_MainImg(rs.getString("si_MainImg"));
					loading.setSi_TodayImg(rs.getString("si_TodayImg"));
				
					System.out.println("DAO에 들어가서 데이터 가져옴!");
					System.out.println("dao loading   " + loading.getSi_Loading());
					System.out.println("dao MainImg   " + loading.getSi_MainImg());
					System.out.println("dao TodayImg  " + loading.getSi_TodayImg());
					
					}
			
			}catch(Exception e) {
				e.printStackTrace();
			
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		return loading;
	}

// 이미지값 이름 업데이트
	public int updateLoading(AdminDTO loading) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "update SiteImg set si_loading=?";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loading.getSi_Loading());
			pstmt.executeUpdate(); 
			result = pstmt.executeUpdate(); 
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result;
	}
	// siteimg 이미지 이름값들 받아오는 메서드 (메인 & 오늘의 이미지)
	public AdminDTO getImg() {
		AdminDTO img = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select * from siteimg";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
				if(rs.next()) {
					img = new AdminDTO(); 
					img.setSi_MainImg(rs.getString("si_MainImg"));
					img.setSi_TodayImg(rs.getString("si_TodayImg"));
				
					System.out.println("DAO에 들어가서 데이터 가져옴!");
					System.out.println(img.getSi_MainImg());
					System.out.println(img.getSi_TodayImg());
				}
			
			}catch(Exception e) {
				e.printStackTrace();
			
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		return img;
	}

	// 이미지값 이름 업데이트 (메인 & 오늘의 이미지)
	public int updateImg(AdminDTO img) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "update SiteImg set si_MainImg=?, si_TodayImg=?";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, img.getSi_MainImg());
			pstmt.setString(2, img.getSi_TodayImg());
			result = pstmt.executeUpdate(); 
			
			System.out.println("result >> " + result);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return result;
	}	
	
//-------------------- 형준 : 기간조회 메서드 삽입 ------------------------
	
	// adBoardManage 기간조회 카운팅 메서드 
	public int getAllDateCount(String startDate, String endDate) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where (g_status=1 or g_status=2) and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"' order by g_reg";
			pstmt = conn.prepareStatement(sql);
			
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
	
	// adBoardManage 기간 조회 목록 불러오기 (전체)
	public List getAllDate(int startRow, int endRow, String startDate, String endDate) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from galleryUpload where (g_status=1 or g_status=2) and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"'"
					+ " order by g_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGallery = new GalleryDTO(); 
					myGallery.setG_bno(rs.getInt("g_bno"));
					myGallery.setU_id(rs.getString("u_id"));
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
	
	// adUserSearch 기간조회시 모든 회원수 카운팅메서드
	public int getAllUserDateCount(String startDate, String endDate) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from signUp where (u_status=1 or u_status=2) and u_reg >= '"+startDate+"' and u_reg <= '"+endDate+"'";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); // 결과에서 1번 컬럼 값꺼내기, 숫자결과라 getInt (DB에서 숫자는 1 2 3 ~) 
			}
			System.out.println("해당기간 가입한 모든 회원의 수 :" + count);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
	}	
	
	// adUserSearch 기간조회시 모든 회원수 목록 불러오기
	public List getAllUserDate(int startRow, int endRow, String startDate, String endDate) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from signUp where (u_status=1 or u_status=2) and u_reg >= '"+startDate+"' and u_reg <= '"+endDate+"') A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					UserDTO user = new UserDTO(); 
					user.setU_userno(rs.getInt("u_userno"));
					user.setU_id(rs.getString("u_id"));
					user.setU_pw(rs.getString("u_pw"));
					user.setU_nick(rs.getString("u_nick"));
					user.setU_email(rs.getString("u_email"));
					user.setU_sns(rs.getString("u_sns"));
					user.setU_photo(rs.getString("u_photo"));
					user.setU_status(rs.getInt("u_status"));
					user.setU_favorite1(rs.getString("u_favorite1"));
					user.setU_favorite2(rs.getString("u_favorite2"));
					user.setU_reg(rs.getTimestamp("u_reg"));
					
					list.add(user);
				}while(rs.next());
			}
			System.out.println("모든 회원 리스트 : " + list);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return list;
	}			
	
	// adSalesManage 기간으로 조회했을때 판매내역 카운팅 메서드
	public int getAllPaymentDateCount(String startDate, String endDate) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where p_reg >= '"+startDate+"' and p_reg <= '"+endDate+"' order by p_reg";
			pstmt = conn.prepareStatement(sql);
			
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
	
	// adSalesManage 기간으로 조회했을때 판매내역 불러오는 메서드
	public List getAllPaymentDate(int startRow, int endRow, String startDate, String endDate) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where p_reg >= '"+startDate+"' and p_reg <= '"+endDate+"'"
					+ " order by p_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					PaymentDTO payment = new PaymentDTO(); 
					payment.setPno(rs.getInt("pno"));	// 결제고유번호
					payment.setG_bno(rs.getInt("g_bno"));
					payment.setG_subject(rs.getString("g_subject"));
					payment.setU_id(rs.getString("u_id"));
					payment.setP_id(rs.getString("p_id"));
					payment.setG_price(rs.getInt("g_price"));
					payment.setP_finalPrice(rs.getInt("p_finalPrice"));
					payment.setP_point(rs.getInt("p_point"));
					payment.setP_option(rs.getString("p_option"));
					payment.setP_status(rs.getInt("p_status"));
					payment.setP_reg(rs.getTimestamp("p_reg"));
					
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
	
	// adSellRequest : 기간조회시 승인요청 대기건 카운팅 메서드(g_status=0)
	public int getAllRequestDateCount(String startDate, String endDate) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where g_status=0 and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"'";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) {
				count = rs.getInt(1); //  
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
	
	// adSellRequest 기간조회 시 승인요청 대기건 카운팅 메서드(g_status=0)
	public List getAllRequestDate(int startRow, int endRow, String startDate, String endDate) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from galleryUpload where g_status=0 and g_reg >= '"+startDate+"' and g_reg <= '"+endDate+"' order by g_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGallery = new GalleryDTO(); 
					myGallery.setG_bno(rs.getInt("g_bno"));
					myGallery.setU_id(rs.getString("u_id"));
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