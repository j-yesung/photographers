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
import javax.websocket.Session;

import team.gallery.model.GalleryDAO;
import team.gallery.model.GalleryDTO;
import team.user.model.UserDTO;

public class UserLikeDAO {
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); 
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 관심상품 추가
	public void insertLike(String u_id, String u_id2, int g_bno){
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		try {
			conn = getConnection(); 
			String sql = "insert into userLike values(ulno_seq.nextval,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, u_id);
			pstmt.setString(2, u_id2);
			pstmt.setInt(3, g_bno);
						
			
			pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}

	
	// 관심상품 삭제
	public void likeDelete(int ulno){
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
	
	// 관심상품 검색 카운팅 메서드
	public int getLikeSearchCount(String u_id, String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		System.out.println("search count sel : " + sel);
		System.out.println("search count search: " + search);
		try {
			conn = getConnection(); 
			String sql = "select count(*) from (select g.*, c.ul_reg, c.ulno from galleryUpload g, userLike c "
					+ " where g.g_bno = c.g_bno and c.u_id=? and g."+sel+" like '%"+search+"%')";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) {
					count = rs.getInt(1);
					System.out.println("like Seach count : " + count);
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
	
	// 장바구니 검색 목록 가져오는 메서드
		public List getLikeSearch(int start, int end, String u_id, String sel, String search) {
			List list = null; 
			Connection conn = null; 
			PreparedStatement pstmt = null; 
			ResultSet rs = null;
			System.out.println("sel : " + sel);
			System.out.println("search" + search);
			try {
				conn = getConnection(); 
				String sql = "select * from (select rownum r, A.* from ("
						+ "select g.*, c.ul_reg, c.ulno from galleryUpload g, userLike c "
						+ "where g.g_bno = c.g_bno and c.u_id=? and g." +sel+" like '%"+search+"%'"
						+ " order by c.uc_reg desc) A ) "
						+ "where r >= ? and r <= ?";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery(); 
				if(rs.next()) { 
					list = new ArrayList();
					do {
						GalleryDTO myGall  = new GalleryDTO(); 
						UserLikeDTO myLike = new UserLikeDTO();
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
						myLike.setU_id(u_id);
						myLike.setUl_reg(rs.getTimestamp("uc_reg"));
						myLike.setUlno(rs.getInt("ucno"));
						
						HashMap<String, Object> map = new HashMap<String, Object>();
						map.put("gall", myGall);
						map.put("like", myLike);
						
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
	
	//관심상품 갯수 카운팅 메서드
	public int getMyLikeCount(String u_id) {
		int count = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			String sql = "select count(*) from userLike where u_id=?";
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
			
	//장바구니 목록 가져오는 메서드
	public List getMyLike(String u_id, int startRow, int endRow) {
		List list = null; 
		Connection conn = null; 	
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection(); 
			/* 
			String sql = "select B.* from (select rownum r, A.* from "
					+ "(select * from userCart where u_id=? order by uc_reg desc) A) B "
					+ " where r >= ? and r <= ?";
					
					+ "-- List<HashMap> [ { gdto : Gallery DTO, cdto : Cart DTO }, { gdto : Gallery DTO, cdto : Cart DTO } , { gdto : Gallery DTO, cdto : Cart DTO }, ..... ]"
					*/
			
			
			String sql = "select * from (select rownum r, A.* from ("
					+ "select g.*, c.ul_reg, c.ulno from galleryUpload g, userLike c "
					+ "where g.g_bno = c.g_bno and c.u_id=? order by c.ul_reg desc) A ) "
					+ "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u_id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery(); 
			if(rs.next()) { // 결과 있는지 체크 + 커서 첫번째 레코드 가르키게됨.
				list = new ArrayList(); // 저장공간 생성(결과없으면 저장공간도 차지하지않게하겠다)
				do {
					GalleryDTO myGall  = new GalleryDTO(); 
					UserLikeDTO myLike = new UserLikeDTO();
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
					myLike.setU_id(u_id);
					myLike.setU_id2(rs.getString("u_id"));
					myLike.setUl_reg(rs.getTimestamp("ul_reg"));
					myLike.setUlno(rs.getInt("ulno"));
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("gall", myGall);
					map.put("like", myLike);
					
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
		   
	// 관심상품 중복 확인 메서드
	public boolean confirmLike(int g_bno, String u_id) {
		boolean result = false;
		int g_bnoCount = 0;
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			conn = getConnection(); 
			String sql = "select count(*) from userLike where g_bno=? and u_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);
			pstmt.setString(2, u_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				g_bnoCount = rs.getInt(1);
				System.out.println("g_bnoCount : " + g_bnoCount);
				if(g_bnoCount >= 1) {
					result = true;
				}
			}

			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close();} catch(SQLException e) { e.printStackTrace(); }
			if(pstmt != null) try { pstmt.close();} catch(SQLException e) { e.printStackTrace(); }
			if(conn != null) try { conn.close();} catch(SQLException e) { e.printStackTrace(); }
		}
		
		return result;
	}
	   
		}