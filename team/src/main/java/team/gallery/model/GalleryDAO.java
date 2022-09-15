package	team.gallery.model;
import java.sql.Connection;	
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class GalleryDAO {
	// 커넥션 --> DB 연결
	private Connection getConnection() throws NamingException, SQLException {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		
		return ds.getConnection();
	}
	// 게시글 등록 메서드.
	public void insertGallery(GalleryDTO gallery) {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection(); 
			String sql = "insert into galleryUpload ";
			sql += " values(g_bno_seq.nextval, ?, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gallery.getU_id());
			pstmt.setString(2, gallery.getG_subject());
			pstmt.setString(3, gallery.getG_content());
			pstmt.setString(4, gallery.getG_img());
			pstmt.setString(5, gallery.getU_email());
			pstmt.setString(6, gallery.getU_sns());
			pstmt.setInt(7, gallery.getG_price());
			pstmt.setString(8, gallery.getG_imgLocation());
			pstmt.setString(9, gallery.getG_imgLens());
			pstmt.setString(10, gallery.getG_imgCamera());
			pstmt.setString(11, gallery.getG_imgQuality());
			pstmt.setString(12, gallery.getG_tag());
			pstmt.setInt(13, gallery.getCategory1());
			pstmt.setInt(14, gallery.getCategory2());
			pstmt.setInt(15, gallery.getG_status());
			pstmt.setString(16, "nocomment");
			pstmt.setInt(17, gallery.getG_like());
			pstmt.setInt(18, gallery.getG_readCount());
			pstmt.executeUpdate(); 
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	// 전체 게시글 가져 오는 메서드. (페이징 처리 O)
	public List<GalleryDTO> getGalleryList(int start, int end) {
		List<GalleryDTO> list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from "
		               + "(select * from galleryUpload where g_status=1 order by g_reg desc) A ) B "
		               + "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<GalleryDTO>();
				do {
					GalleryDTO photography = new GalleryDTO();
					
					photography.setG_bno(rs.getInt("g_bno"));
					photography.setG_status(rs.getInt("g_status"));
					photography.setG_img(rs.getString("g_img"));
					photography.setG_like(rs.getInt("g_like"));
					photography.setG_readCount(rs.getInt("g_readCount"));
					list.add(photography);
				} while(rs.next());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try { rs.close();} catch(SQLException e) { e.printStackTrace();}}
			if(pstmt != null) { try { pstmt.close();} catch(SQLException e) { e.printStackTrace();}}
			if(conn != null) { try { conn.close();} catch(SQLException e) { e.printStackTrace();}}
		}
		return list;
		
	}
	// 중분류 카테고리 띄워주는 메서드.
	public List<GalleryDTO> getGalleryCategoryList(int value, int start, int end) {
		List<GalleryDTO> categoryList = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select B.* from (select rownum r, A.* from "
		               + "(select * from galleryUpload where category2=? and g_status=1 order by g_reg desc) A ) B "
		               + "where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, value);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				categoryList = new ArrayList<GalleryDTO>();
				do {
					GalleryDTO photography = new GalleryDTO();
					
					photography.setG_bno(rs.getInt("g_bno"));
					//photography.setG_subject(rs.getString("g_subject"));
					photography.setG_status(rs.getInt("g_status"));
					photography.setG_img(rs.getString("g_img"));
					photography.setG_like(rs.getInt("g_like"));
					photography.setG_readCount(rs.getInt("g_readCount"));
					categoryList.add(photography);
				} while(rs.next());
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) { try { rs.close();} catch(SQLException e) { e.printStackTrace();}}
			if(pstmt != null) { try { pstmt.close();} catch(SQLException e) { e.printStackTrace();}}
			if(conn != null) { try { conn.close();} catch(SQLException e) { e.printStackTrace();}}
		}
		return categoryList;
		
	}
	// 게시글 하나 가져오는 메서드.
	public GalleryDTO getOneGallery(int g_bno) {
		GalleryDTO gallery = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select * from galleryUpload where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) {
				gallery = new GalleryDTO(); 
				gallery.setG_bno(rs.getInt("g_bno"));
				gallery.setU_id(rs.getString("u_id"));
				gallery.setG_subject(rs.getString("g_subject"));
				gallery.setG_content(rs.getString("g_content"));
				gallery.setG_img(rs.getString("g_img"));				
				gallery.setU_email(rs.getString("u_email"));
				gallery.setG_price(rs.getInt("g_price"));
				gallery.setG_imgLocation(rs.getString("g_imgLocation"));
				gallery.setG_imgLens(rs.getString("g_imgLens"));
				gallery.setG_imgCamera(rs.getString("g_imgCamera"));
				gallery.setG_imgQuality(rs.getString("g_imgQuality"));
				gallery.setG_tag(rs.getString("g_tag"));
				gallery.setCategory1(rs.getInt("category1"));
				gallery.setCategory2(rs.getInt("category2"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return gallery;
		
	}
	// 전체 게시글 개수 카운팅 메서드.
	public int getGalleryCount() {
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
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count; 
		
	}
	// category2(중분류) 값에 해당하는 레코드 수 조회
	public int getGalleryCategoryCount(int cate2) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where category2 = ? and g_status = 1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cate2);
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
	
	// 검색한 글의 총 개수 
	public int getGallerySearchCount(String sel, String search) {
		int count = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select count(*) from galleryUpload where "+sel+" like '%"+search.trim()+"%' and g_status = 1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { count = rs.getInt(1); }
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return count;
		
	}
	// 검색한 글 목록 가져오는 메서드 
	public List<GalleryDTO> getGallerySearch(int start, int end, String sel, String search) {
		List<GalleryDTO> list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select B.* from (select rownum r, A.* from "
					   + "(select * from galleryUpload where "+sel+" like '%"+search.trim()+"%' and g_status = 1 "
					   + "order by g_reg desc) A) B "
					   + "where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				list = new ArrayList<GalleryDTO>();
				do {
					GalleryDTO gallery = new GalleryDTO();
					gallery.setG_bno(rs.getInt("g_bno"));
					gallery.setG_subject(rs.getString("g_subject"));
					gallery.setG_status(rs.getInt("g_status"));
					gallery.setG_img(rs.getString("g_img"));
					gallery.setG_like(rs.getInt("g_like"));
					gallery.setG_readCount(rs.getInt("g_readCount"));
					list.add(gallery);
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
	// 글 수정 처리 
	@SuppressWarnings("resource")
	public int updateArticle(GalleryDTO gallery) {
		int result = 0; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql = "select * from GalleryUpload where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gallery.getG_bno());
			
			
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { // 결과 가져왔다 -> 비밀번호 맞으면 
				
				sql = "update GalleryUpload set g_subject=?, g_content=?, u_email=?, u_sns=?, g_price=?, g_imgLocation=?, g_imgLens=?, g_imgCamera=?, g_imgQuality=?, g_tag=?, category1=?, category2=?, g_img=? where g_bno=?"; 
				pstmt = conn.prepareStatement(sql);
		
				pstmt.setString(1, gallery.getG_subject());
				pstmt.setString(2, gallery.getG_content());
				pstmt.setString(3, gallery.getU_email());
				pstmt.setString(4, gallery.getU_sns());
				pstmt.setInt(5, gallery.getG_price());
				pstmt.setString(6, gallery.getG_imgLocation());
				pstmt.setString(7, gallery.getG_imgLens());
				pstmt.setString(8, gallery.getG_imgCamera());
				pstmt.setString(9, gallery.getG_imgQuality());
				pstmt.setString(10, gallery.getG_tag());
				pstmt.setInt(11, gallery.getCategory1());
				pstmt.setInt(12, gallery.getCategory2());
				pstmt.setString(13, gallery.getG_img());
				pstmt.setInt(14, gallery.getG_bno());
		
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

// 게시글 숨기기
	public void sleepArticle(int g_bno){
		
		Connection conn = null; 
		PreparedStatement pstmt = null; 
	
		try {
			conn = getConnection();
			String sql =  "update GalleryUpload set g_status=2 where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);

			pstmt.executeUpdate(); 
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}

// 게시글 다시 올리기	
public void wakeArticle(int g_bno){
		
		Connection conn = null; 
		PreparedStatement pstmt = null; 
	
		try {
			conn = getConnection();
			String sql =  "update GalleryUpload set g_status=1 where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);

			pstmt.executeUpdate(); 
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
	}
	// 형준 : 갤러리 삭제하는 메서드(관리자가 승인하기전에 아예 지우는 용도임)
	public void RequestDelete(int g_bno) {
      Connection conn = null; 
      PreparedStatement pstmt = null; 
   
      try {
         conn = getConnection();
         String sql =  "delete from GalleryUpload where g_bno=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, g_bno);

         pstmt.executeUpdate(); 
      
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
      }
      
   }
	// 가장 높은 조회수를 가진 글 가져오는 메서드.
	public GalleryDTO getMaxReadCountGallery() {
		GalleryDTO gallery = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select * from galleryUpload where g_readCount = (select max(g_readCount) from galleryUpload)";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) {
				gallery = new GalleryDTO();
				gallery.setG_bno(rs.getInt("g_bno"));
				gallery.setG_img(rs.getString("g_img"));				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return gallery;
	}
	// 가장 높은 좋아요를 가진 글 가져오는 메서드.
	public GalleryDTO getMaxLikeGallery() {
		GalleryDTO gallery2 = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		try {
			conn = getConnection(); 
			String sql = "select * from galleryUpload where g_like = (select max(g_like) from galleryUpload)";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) {
				gallery2 = new GalleryDTO();
				gallery2.setG_bno(rs.getInt("g_bno"));
				gallery2.setG_img(rs.getString("g_img"));				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace();}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
			if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
		}
		return gallery2;
		
	}
	// 조회수 불러오기 메서드.
	public void addReadCount(int g_bno) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		
		try {
			conn = getConnection(); 
			String sql = "update galleryUpload set g_readCount = g_readCount+1 where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }}
		}
	}
	// 좋아요 불러오기 메서드.
	public void addLikeCount(int g_bno) {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		
		try {
			conn = getConnection(); 
			String sql = "update galleryUpload set g_like = g_like+1 where g_bno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, g_bno);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) { try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }}
			if(conn != null) { try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }}}
	}
	
}