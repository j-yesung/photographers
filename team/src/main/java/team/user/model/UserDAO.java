package team.user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 용연 : 회원가입 메서드
	public void insertUser(UserDTO user) {
	      Connection conn = null; 
	      PreparedStatement pstmt = null; 
	      try {
	         conn = getConnection(); 
	         String sql = "insert into signup values(userno_seq.nextval,?,?,?,?,?,?,sysdate,default,?,?)";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, user.getU_id());
	         pstmt.setString(2, user.getU_pw());
	         pstmt.setString(3, user.getU_nick());
	         pstmt.setString(4, user.getU_email());
	         pstmt.setString(5, user.getU_sns());
	         pstmt.setString(6, user.getU_photo());
	         pstmt.setString(7, user.getU_favorite1());
	         pstmt.setString(8, user.getU_favorite2());
	         
	         int result = pstmt.executeUpdate(); 
	         System.out.println("insert result : " + result);
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         if(pstmt != null) try{ pstmt.close(); }catch(SQLException e) { e.printStackTrace(); }
	         if(conn != null) try{ conn.close(); }catch(SQLException e) { e.printStackTrace(); }
	      }
	   }
		
		// 용연 : 아이디 중복 확인 메서드
		public boolean confirmId(String u_id) {
			boolean result = false;
			int u_idCount = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			
			try {
				conn = getConnection(); 
				String sql = "select count(*) from signup where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					u_idCount = rs.getInt(1);
					System.out.println("u_idCount : " + u_idCount);
					if(u_idCount == 1) {
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

		
		// 용연 : 닉네임 중복 확인 메서드
		public boolean confirmNick(String u_nick) {
			boolean result = false;
			int u_nickCount = 0;
			Connection conn = null; 
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			
			try {
				conn = getConnection(); 
				String sql = "select count(*) from signup where u_nick=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_nick);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					u_nickCount = rs.getInt(1);
					System.out.println("u_nickCount : " + u_nickCount);
					if(u_nickCount == 1) {
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
	
	
	
		// 형준 : 회원 한명 정보 가져오는 메서드
		public UserDTO getUser(String u_id) {
			UserDTO user = null;
			//String u_photo = null;
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
		
		// 형준 : 회원정보 수정 메서드
		public int updateUser(UserDTO user) {
			int result = 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				String sql = "update signup set u_pw=?, u_nick=?, u_email=?, u_photo=?, u_sns=?, u_favorite1=?, u_favorite2=? where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getU_pw());
				pstmt.setString(2, user.getU_nick());
				pstmt.setString(3, user.getU_email());
				pstmt.setString(4, user.getU_photo());
				pstmt.setString(5, user.getU_sns());
				pstmt.setString(6, user.getU_favorite1());
				pstmt.setString(7, user.getU_favorite2());
				pstmt.setString(8, user.getU_id());
				
				
				
				result = pstmt.executeUpdate(); // 잘되면 콘솔에 return값 1, 안되면 0
				System.out.println("updateUser result : " + result);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
			}		
			return result;
		}
		
		// 형준 : ID, PW DB에 있는지 체크하는 메서드
		public int idPwCheck(String u_id, String u_pw) {
			int result = -1;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				// 사용자가 작성한 id와 동일한 id값이 db에 있는지 꺼내오기
				String sql = "select u_id from signup where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql = "select count(*) from signup where u_id=? and u_pw=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, u_id);
					pstmt.setString(2, u_pw);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						result = rs.getInt(1); // 비번 맞으면 1, 안맞으면 0 // 만약 비번이 맞으면 DB상 count가 1로 변경되는 로직 틀리면 count 증가하지 않음
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs != null) try {rs.close();} catch(SQLException e) {e.printStackTrace();}
				if(pstmt != null) try {pstmt.close();} catch(SQLException e) {e.printStackTrace();}
				if(conn != null) try {conn.close();} catch(SQLException e) {e.printStackTrace();}
			}
			return result;
		}
		
		// 형준 : 회원정보 삭제 메서드 
		public void deleteUser(String u_id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = getConnection();
				String sql = "delete from signUp where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);
				
				int result = pstmt.executeUpdate();
				System.out.println("deleteUser result : " + result);
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if( pstmt != null ) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
				if( conn != null ) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
			}
		}
	
		// 형준 : 회원정보 휴면계정으로 전환(숨기기)
		public void sleepUser(String u_id){
			
			Connection conn = null; 
			PreparedStatement pstmt = null; 
		
			try {
				conn = getConnection();
				String sql =  "update signUp set u_status=2 where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);

				pstmt.executeUpdate(); 
				System.out.println("해당유저 휴면상태로 전환 완료!");
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		}
	
		// 형준 : 회원정보 이용가능한 상태로 전환(부활)
		public void wakeUser(String u_id){
			
			Connection conn = null; 
			PreparedStatement pstmt = null; 
		
			try {
				conn = getConnection();
				String sql =  "update signUp set u_status=1 where u_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, u_id);

				pstmt.executeUpdate(); 
				System.out.println("해당유저 계정 부활 완료!!");
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace();}
				if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace();}
			}
		}		
	
	
	
	
	
	
	
	
}