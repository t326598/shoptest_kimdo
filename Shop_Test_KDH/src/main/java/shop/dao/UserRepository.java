package shop.dao;

import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;


import shop.dto.PersistentLogin;
import shop.dto.Product;
import shop.dto.User;

public class UserRepository extends JDBConnection {
	
	public int insert(User user) {
		int result = 0;
		String sql = "INSERT INTO user (id, password, name, gender, birth, mail, phone, address)"
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user.getId());
			psmt.setString(2, user.getPassword());
			psmt.setString(3, user.getName());
			psmt.setString(4, user.getGender());
			psmt.setString(5, user.getBirth());
			psmt.setString(6, user.getMail());
			psmt.setString(7, user.getPhone());
			psmt.setString(8, user.getAddress());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("UserRepository : 회원 등록 시, 예외 발생");
			e.printStackTrace();	
		}
		
		return result;
		
	}

	
	  /**
	    * 아이디 중복 체크
	    * @param id
	    * @return
	    */
	   public int checkId(String id) {
	      int result = 0;
	     
	       // 아이디 중복 체크
	       String sql = "SELECT COUNT(*) FROM user WHERE id = ?";
	       try {
	         psmt = con.prepareStatement(sql);
	         psmt.setString(1, id);
	         
	         rs = psmt.executeQuery();
	           if (rs.next()) {
	               result = rs.getInt(1); // 첫 번째 컬럼의 값을 가져옴
	           }
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      }
		return result;
	   }

	
	/**
	 * 
	 * @param id
	 * @param pw
	 * @return
	 */
	public User login(String id, String pw) {
	    String sql = "SELECT * "
	    		+" FROM user WHERE id = ? AND password = ?";
	    User user = null;
	  
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, id);
	        psmt.setString(2, pw);

	        rs = psmt.executeQuery();
	        
	        if (rs.next()) {
	            user = new User();
	            user.setId(rs.getString("id"));
	            user.setPassword(rs.getString("password"));
	            user.setName(rs.getString("name"));
	            user.setGender(rs.getString("gender"));
	            user.setBirth(rs.getString("birth"));
	            user.setMail(rs.getString("mail")); // 
	            user.setPhone(rs.getString("phone"));
	            user.setAddress(rs.getString("address"));
	            user.setRegistDay(rs.getTimestamp("regist_day"));
	        }
	        else {
	        	System.out.println("유저가 없습니다");
	        }
	    } catch (Exception e) {
	        System.err.println("UserRepository : 회원 정보 번호로 조회 시 예외 발생");
	        e.printStackTrace(); // 예외 메시지를 출력하여 디버깅에 도움이 되도록 합니다.
	    }
	  
	    return user;
	}


	/**
	 * 로그인을 위한 사용자 조회
	 * 
	 * @param id
	 * @param pw
	 * @return
	 */
	public User getUserById(String id) {
		String sql = "SELECT * " + " FROM user" + " WHERE id = ?";
		User user = null;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				user = new User();
				user.setId(rs.getString("id"));
				user.setPassword(rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setGender(rs.getString("gender"));
				user.setBirth(rs.getString("birth"));
				user.setMail(rs.getString("mail"));
				user.setPhone(rs.getString("phone"));
				user.setAddress(rs.getString("address"));
				user.setRegistDay(rs.getTimestamp("regist_day"));
			}
		} catch (Exception e) {
			System.err.println("UserRepository : 회원 정보 번호로 조회 시 예외 발생");
		}
		
		return user;
	
	}

		
		

	/**
	 * 회원 수정
	 * 
	 * @param user
	 * @return
	 */
	public int update(User user) {
		int result = 0;
		String sql = "UPDATE user"
				+ " SET name = ?,"
				+ " gender = ?,"
				+ " birth = ?,"
				+ " mail = ?,"
				+ " phone = ?,"
				+ " address = ?"
				+ " WHERE id = ?";
		// ??????? id로 조회?
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, user.getName());
			psmt.setString(2, user.getGender());
			psmt.setString(3, user.getBirth());
			psmt.setString(4, user.getMail());
			psmt.setString(5, user.getPhone());
			psmt.setString(6, user.getAddress());
			psmt.setString(7, user.getId());
			
				
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("UserRepostory : 회원 정보 업데이트 시 예외 발생");
		}
		return result;
	}

	/**
	 * 회원 삭제
	 * 
	 * @param id
	 * @return
	 */
	public int delete(String id) {
		int result = 0;
		String sql="DELETE "
				+ " FROM user"
				+ " WHERE id = ?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("UserDAO : 회원 id로 삭제 시 예외 발생");
		}
		return result;
	}
	/**
	 * 토큰 리프레쉬
	 * @param userId
	 */
	public String refreshToken(String userId) {
	    PersistentLogin persistentLogin = selectToken(userId);
	    String token = null;
	    if (persistentLogin == null) {
	        // 토큰이 없는 경우, 삽입
	    	token = insertToken(userId);
	    } else {
	        // 토큰이 있는 경우, 갱신
	    	token =  updateToken(userId);
	    }
	    return token;
	}

	
	
	/**
	 * 토큰 정보 조회
	 * @param userId
	 * @return
	 */
	public PersistentLogin selectToken(String userId) {
	    String sql = "SELECT * FROM persistent_logins WHERE user_id = ?";
	    
	    PersistentLogin persistentLogin = null;
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);

	        rs = psmt.executeQuery();
	        if (rs.next()) {
	        	persistentLogin = new PersistentLogin();
	        	persistentLogin.setpNo( rs.getInt("p_no")); 
	        	persistentLogin.setUserId( rs.getString("user_id") ); 
	        	persistentLogin.setToken( rs.getString("token") ); 
	        	
	        }
	        rs.close();
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 조회 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    return persistentLogin;
	}
	
	
	/**
	 * 토큰 정보 조회 - 토큰으로
	 * @param token
	 * @return
	 */
	public PersistentLogin selectTokenByToken(String token) {
	    String sql = "SELECT * FROM persistent_logins WHERE token = ?";
	    
	    PersistentLogin persistentLogin = null;
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, token);

	        rs = psmt.executeQuery();
	        if (rs.next()) {
	            persistentLogin = new PersistentLogin();
	            persistentLogin.setpNo(rs.getInt("p_no")); 
	            persistentLogin.setUserId(rs.getString("user_id")); 
	            persistentLogin.setToken(rs.getString("token")); 
	            persistentLogin.setDate(rs.getDate("date")); // date 필드로 변경
	        }
	        rs.close();
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 조회 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    return persistentLogin;
	}


	
	
	/**
	 * 자동 로그인 토큰 생성
	 * @param userId
	 * @return
	 */
	public String insertToken(String userId) {
		 int result = 0;
	    String sql = "INSERT INTO persistent_logins (user_id, token) VALUES (?, ?)";
	    String token = UUID.randomUUID().toString();
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);
	        psmt.setString(2, token);

	        result = psmt.executeUpdate(); // 퍼시스턴트 로그인 정보 등록 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 등록 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개가 등록되었습니다.");
	    return token;
	}
	
	/**
	 * 자동 로그인 토큰 갱신
	 * @param userId
	 * @return
	 */
	public String updateToken(String userId) {
	    int result = 0;
	    String sql = "UPDATE persistent_logins SET token = ?, date = now() WHERE user_id = ?";
	    String token = UUID.randomUUID().toString();
	    try {
	    	psmt = con.prepareStatement(sql);
	        psmt.setString(1, token);
	        psmt.setString(2, userId);

	        result = psmt.executeUpdate(); // 퍼시스턴트 로그인 정보 수정 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 수정 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개의 데이터가 수정되었습니다.");
	    return token;
	}
	
	
	/**
	 * 토큰 삭제
	 * - 로그아웃 시, 자동 로그인 풀림
	 * @param userId
	 * @return
	 */
	public int deleteToken(String userId) {
	    int result = 0;
	    String sql = "DELETE FROM persistent_logins WHERE user_id = ?";
	    
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, userId);

	        result = psmt.executeUpdate(); // 특정 사용자의 자동 로그인 정보 삭제 요청
	    } catch (SQLException e) {
	        System.err.println("자동 로그인 정보 삭제 중, 에러 발생!");
	        e.printStackTrace();
	    }
	    System.out.println("자동 로그인 정보 " + result + "개의 데이터가 삭제되었습니다.");
	    return result;
	}


	public boolean isValid(String token) {
		PersistentLogin persistenceLogins = selectTokenByToken(token);

		// 토큰 없음
		if (persistenceLogins == null)
			return false;
		// 토큰 만료
		Date expiryDate = persistenceLogins.getDate();
		Date today = new Date();
		if (today.after(expiryDate)) {
			return false;
		}
		return true;

	}

		
	
	
}