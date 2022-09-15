package team.mypage.model;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.charset.MalformedInputException;
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

public class UserOrderDAO {
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 검색한 구매글의 총 개수 카운팅 메서드(구매내역 페이지)
	public int getOrderSearchCount(String p_id, String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where p_id=? and "+sel+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
			
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

	// 검색한 구매글 목록 가져오는 메서드
	public List getOrderSearch(int start, int end, String p_id, String sel, String search) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where "+sel+" like '%"+search+"%'"
					+ " order by p_reg desc) A) B "
					+ "where p_id=? and r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
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
					payment.setU_id(rs.getString("u_id"));
					payment.setP_id(p_id);
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
	
	
	// 형준 : 구매완료된 건 카운팅 메서드
	public int myOrderCount(String p_id) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from payment where p_id=? and p_status=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);	// 판매자(파라미터값)
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
	
	// 형준 : 구매 완료된 건 가져오는 메서드
	public List getOrders(String p_id, int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			//String sql = "select * from payment where u_id='" + u_id + "' and p_status=1 order by p_reg desc";
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from payment where p_id=? and p_status=1 order by p_reg desc) A) B "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
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
					payment.setU_id(rs.getString("u_id"));
					payment.setP_id(p_id);
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
	
	//-------------------------------다운로드 기능 구현-------------------
	
	// 다운로드를 위한(g_img값 긁어오기위함..)게시글 하나 가져오는 메서드.
		public String getImgName(String g_bno) {
			String imgName = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			
			try {
				conn = getConnection(); 
				String sql = "select g.g_img"
						+ " from payment p, galleryUpload g"
						+ " where (p.g_bno = g.g_bno) and p.g_bno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, g_bno);
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					imgName = rs.getString(1);
				}
				System.out.println("해당 이미지 이름은 " + imgName);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
			return imgName;
			
		}
	
	
	// 형준 : 파일다운로드 구현
	
	public static void fileDown(String url, String imgName) throws MalformedInputException, IOException {
		BufferedInputStream in = null;
	    FileOutputStream fout = null;
	    try {
	        in = new BufferedInputStream(new URL(url).openStream());
	        fout = new FileOutputStream(imgName);

	        final byte data[] = new byte[1024];
	        int count;
	        while ((count = in.read(data, 0, 1024)) != -1) {
	            fout.write(data, 0, count);
	            System.out.println("아웃풋 확인 : " + fout);
	        }
	    } finally {
	        if (in != null) {
	            in.close();
	        }
	        if (fout != null) {
	            fout.close();
	        }
	    }
	}
	
	// 형준 : 구매완료된건 토탈 금액 계산하는 메서드
	public int getTotalPrice(String p_id) {
		List list = null;
		int total = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select g_price from payment where p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
			
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
	
	
	
	
}