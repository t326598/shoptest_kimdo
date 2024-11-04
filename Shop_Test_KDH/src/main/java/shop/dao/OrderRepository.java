package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		
		String sql = " INSERT INTO `order`(ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone)"
				+ " VALUES(?, ?, ?,?,?,?,?,?,?)";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, order.getShipName());
			psmt.setString(2, order.getZipCode());
			psmt.setString(3, order.getCountry());
			psmt.setString(4, order.getAddress());
			psmt.setString(5, order.getDate());
			psmt.setString(6, order.getOrderPw());
			psmt.setString(7, order.getUserId());
			psmt.setInt(8, order.getTotalPrice());
			psmt.setString(9, order.getPhone());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("OrderRepository : 입출고 등록, 예외 발생");
			e.printStackTrace();
				}
	return result;		
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		int result = 0;
		String sql = "SELECT MAX(order_no) last_order "
				+  	 "FROM `order`";
		
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("last_order");
			}
		
			
		} catch (Exception e) {
			System.err.println("OrderRepository : 최근 주문 번호 조회 시 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> productList = new ArrayList<Product>();
		
		String  sql = "SELECT o.order_no, p.name, p.unit_price, io.amount"
	      		+ " FROM `order` o JOIN product_io io ON o.order_no = io.order_no JOIN product p ON io.product_id = p.product_id"
	      		+ " WHERE o.user_id = ?";
		try {
		    psmt = con.prepareStatement(sql);
		    psmt.setString(1, userId);
		    
		    rs = psmt.executeQuery();
		    
		    if (!rs.next()) {
		        System.out.println("주문 내역이 없습니다.");
		    } else {
		        do {
		            Product product = new Product();
		            product.setName(rs.getString("name"));
		            product.setUnitPrice(rs.getInt("unit_price"));
		            product.setAmount(rs.getInt("amount"));
		            product.setOrderNo(rs.getInt("order_no"));
		            productList.add(product);
		        } while (rs.next());
		    }
		    
		} catch (Exception e) {
		    System.err.println("OrderRepository: 주문 내역 조회 시 예외 발생");
		    e.printStackTrace();
		}

		
		return productList;
		
		
		
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
	    List<Product> productList = new ArrayList<>();
	    
	    String sql = "SELECT o.order_no, p.product_id, p.name, p.unit_price, io.amount " +
	                 "FROM `order` o " +
	                 "JOIN product_io io ON o.order_no = io.order_no " +
	                 "JOIN product p ON io.product_id = p.product_id " +
	                 "WHERE o.phone = ? AND o.order_pw = ?";
	    
	    try {
	        psmt = con.prepareStatement(sql);
	        psmt.setString(1, phone);
	        psmt.setString(2, orderPw);
	        
	        rs = psmt.executeQuery();
	        
	        while (rs.next()) {
	            Product product = new Product();
	            product.setOrderNo(rs.getInt("order_no")); // 주문번호 설정
	            product.setProductId(rs.getString("product_id"));
	            product.setName(rs.getString("name"));
	            product.setUnitPrice(rs.getInt("unit_price"));
	            product.setAmount(rs.getInt("amount"));
	            
	            productList.add(product);
	        }
	        
	    } catch (Exception e) {
	        System.err.println("OrderRepository : 비회원 주문 내역 조회 시 예외 발생");
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (psmt != null) psmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    return productList;
	}


	
}






























