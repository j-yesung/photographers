package team.mypage.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team.gallery.model.GalleryDTO;
import team.user.model.UserDTO;



public class PaymentDAO { 
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	
	
	// 형준 : sellStatus, 판매완료된 건 카운팅 메서드
	public int myPaymentCount(String u_id) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where u_id=? and p_status=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);	// 판매자(파라미터값)
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
	
	// 형준 : 판매 완료된 건 가져오는 메서드
	public List getPayments(String u_id, int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where u_id=? order by p_reg desc) A) B "
					+ "where p_status=1 and r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);			
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					PaymentDTO payment = new PaymentDTO(); 
					payment.setPno(rs.getInt("pno"));
					payment.setG_bno(rs.getInt("g_bno"));
					payment.setG_subject(rs.getString("g_subject"));
					payment.setU_id(u_id);
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
	
	// 형준 : 판매완료된건 토탈 금액 계산하는 메서드
	public int getTotalPrice(String u_id) {
		List list = null;
		int total = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select g_price from payment where u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			
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
	
	// 형준 : 검색한 판매글의 총 개수 카운팅 메서드(판매현황 페이지)
	public int getPaymentSearchCount(String u_id, String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where u_id=? and "+sel+" like '%"+search+"%'";
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

	// 형준 : 검색한 판매글 목록 가져오는 메서드
	public List getPaymentSearch(int start, int end, String u_id, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where "+sel+" like '%"+search+"%'"
					+ " order by p_reg desc) A) B "
					+ "where u_id=? and r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				list = new ArrayList();
				do {
					PaymentDTO payment = new PaymentDTO(); 
					payment.setPno(rs.getInt("pno"));	// 결제고유번호
					payment.setG_bno(rs.getInt("g_bno"));
					payment.setG_subject(rs.getString("g_subject"));
					payment.setU_id(u_id);
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
	
	// 형준 : 기간으로 조회했을때 판매내역 카운팅 메서드
	public int getSearchDateCount(String u_id, String startDate, String endDate) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where u_id=? and p_reg >= '"+startDate+"' and p_reg <= '"+endDate+"' order by p_reg";
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
	
	// 형준 : 기간으로 조회하여 해당목록 가져오는 메서드 (판매완료내역)
	public List getSearchDate(int startRow, int endRow, String u_id, String startDate, String endDate) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where u_id=? and p_reg >= '"+startDate+"' and p_reg <= '"+endDate+"'"
					+ " order by p_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					PaymentDTO payment = new PaymentDTO(); 
					payment.setPno(rs.getInt("pno"));	// 결제고유번호
					payment.setG_bno(rs.getInt("g_bno"));
					payment.setG_subject(rs.getString("g_subject"));
					payment.setU_id(u_id);
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
	
	
	// ------------------------------- 용연 ---------------------------------
	
	// 주문서 추가 메서드
	public void insertOrder(PaymentDTO payment){
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "insert into payment values(payment_seq.nextval,?,?,?,?,?,?,default,?,default,sysdate)";
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, payment.getG_bno());
			pstmt.setString(2, payment.getG_subject());
			pstmt.setString(3,payment.getU_id());
			pstmt.setString(4, payment.getP_id());
			pstmt.setInt(5, payment.getG_price());
			pstmt.setInt(6, payment.getP_finalPrice());
			pstmt.setString(7, payment.getP_option());
			
			pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	
	//주문서 갯수 카운팅 메서드
	public int getMyOrderCount(String u_id) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from userCart where u_id=?";
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
	
	//주문서 목록 가져오는 메서드
	public List getMyOrders(String u_id) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			
			String sql = "select g.*, c.uc_reg, c.ucno from galleryUpload g, userCart c where g.g_bno = c.g_bno and c.u_id=? order by c.uc_reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);

			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGall  = new GalleryDTO(); 
					UserCartDTO myCart = new UserCartDTO();
					myGall.setG_bno(rs.getInt("g_bno"));
					myGall.setU_id(u_id);
					myGall.setG_subject(rs.getString("g_subject"));
					myGall.setG_content(rs.getString("g_content"));
					myGall.setG_img(rs.getString("g_img"));
					myGall.setU_email(rs.getString("u_email"));
					myGall.setU_sns(rs.getString("u_sns"));
					myGall.setG_price(rs.getInt("g_price"));
					myGall.setG_reg(rs.getTimestamp("g_reg"));
					myGall.setG_imgLocation(rs.getString("g_imgLocation"));
					myGall.setG_imgLens(rs.getString("g_imgLens"));
					myGall.setG_imgCamera(rs.getString("g_imgCamera"));
					myGall.setG_imgQuality(rs.getString("g_imgQuality"));
					myGall.setG_tag(rs.getString("g_tag"));
					myGall.setCategory1(rs.getInt("category1"));
					myGall.setCategory2(rs.getInt("category2"));
					myGall.setG_status(rs.getInt("g_status"));
					myGall.setG_comment(rs.getString("g_comment"));
					myGall.setG_like(rs.getInt("g_like"));
					myGall.setG_readCount(rs.getInt("g_readCount"));
					myCart.setU_id(u_id);
					myCart.setU_id2(rs.getString("u_id"));
					myCart.setUc_reg(rs.getTimestamp("uc_reg"));
					myCart.setUcno(rs.getInt("ucno"));
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("gall", myGall);
					map.put("cart", myCart);
					
					list.add(map);
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
	
	// 장바구니 개별 삭제 메서드
	public void cartUnitDelete(int ucno){
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "delete from userCart where ucno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ucno);
			pstmt.executeUpdate();


		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}

		}
	}
	
	// 관심상품 개별 삭제 메서드
	public void likeUnitDelete(int ulno){
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "delete from userLike where ulno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ulno);
			pstmt.executeUpdate();


		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}

		}
	}
	
	// 장바구니에서 주문하면 장바구니 목록에서 사라지는 메서드
			public void afterOrderCartDelete(int g_bno){
				Connection conn = null; 
				PreparedStatement pstmt = null; 
				ResultSet rs = null;
				try {
					conn = getConnection(); 
					String sql = "delete from userCart where g_bno=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, g_bno);
					pstmt.executeUpdate();


				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
					if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
					if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}

				}
			}	
			
		// 회원 한명 정보 가져오는 메서드 (구매자 정보 불러오기용)
		public UserDTO getUser(String p_id) {
			UserDTO user = null;
			String u_photo = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select * from signup where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, p_id);
				
				rs = pstmt.executeQuery();
				if(rs.next()) { // 결과가 있으면
					user = new UserDTO();
					user.setU_id(p_id);
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

}