package shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductRepository extends JDBConnection {

	/**
	 * 상품 목록
	 * 
	 * @return
	 */
	public List<Product> list() {
		List<Product> productList = new ArrayList<Product>();

		String sql = "SELECT * " + " FROM  product";

		try {

			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();

			while (rs.next()) {
				Product product = new Product();

				product.setProductId(rs.getString("product_id"));
				product.setName(rs.getString("name"));
				product.setUnitPrice(rs.getInt("unit_price"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setUnitsInStock(rs.getInt("units_in_stock"));
				product.setCondition(rs.getString("condition"));
				product.setFile(rs.getString("file"));
				product.setQuantity(rs.getInt("quantity"));

				productList.add(product);

			}

		} catch (Exception e) {
			System.err.println("ProductRepository : list 목록 불러오는 중 예외발생");
			e.printStackTrace();
		}
		return productList;
	}

	/**
	 * 상품 목록 검색
	 * 
	 * @param keyword
	 * @return
	 */
	public List<Product> list(String keyword) {
		List<Product> productList = new ArrayList<Product>();
		
	String sql = "SELECT *"
			+" FROM product"
		+" WHERE name LIKE ?";
		
	try {

		psmt = con.prepareStatement(sql);
		psmt.setString(1, "%" + keyword +"%");
		
		
		rs = psmt.executeQuery();

		while (rs.next()) {
			Product product = new Product();

			product.setProductId(rs.getString("product_id"));
			product.setName(rs.getString("name"));
			product.setUnitPrice(rs.getInt("unit_price"));
			product.setDescription(rs.getString("description"));
			product.setManufacturer(rs.getString("manufacturer"));
			product.setCategory(rs.getString("category"));
			product.setUnitsInStock(rs.getInt("units_in_stock"));
			product.setCondition(rs.getString("condition"));
			product.setFile(rs.getString("file"));
			product.setQuantity(rs.getInt("quantity"));

			productList.add(product);

		}

	} catch (Exception e) {
		System.err.println("ProductRepository : list 검색중 예외발생");
		e.printStackTrace();
	}
	return productList;
}


	/**
	 * 상품 조회
	 * 
	 * @param productId
	 * @return
	 */
	public Product getProductById(String productId) {
			String sql = "SELECT *"
					+ " FROM product"
					+ " WHERE product_id = ?";
			Product result = null;
			
			try {
				psmt = con.prepareStatement(sql);
				psmt.setString(1, productId);
				rs=psmt.executeQuery();
				if (rs.next()) {
					result = new Product();
					
					result.setProductId(rs.getString("product_id"));
					result.setName(rs.getString("name"));
					result.setUnitPrice(rs.getInt("unit_price"));
					result.setDescription(rs.getString("description"));
					result.setManufacturer(rs.getString("manufacturer"));
					result.setCategory(rs.getString("category"));
					result.setUnitsInStock(rs.getInt("units_in_stock"));
					result.setCondition(rs.getString("condition"));
					result.setFile(rs.getString("file"));
					result.setQuantity(rs.getInt("quantity"));
					}
				} catch (Exception e) {
					System.err.println("ProductRepository : 상품 번호로 조회 시 예외발생");
					e.printStackTrace();
			}
			return result;
	 }

	/**
	 * 상품 등록
	 * 
	 * @param product
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;

		String sql = " INSERT INTO product(product_id, name, unit_price, description, manufacturer, category, units_in_stock, condition, file, quantity)"
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product.getProductId());
			psmt.setString(2, product.getName());
			psmt.setInt(3, product.getUnitPrice());
			psmt.setString(4, product.getDescription());
			psmt.setString(5, product.getManufacturer());
			psmt.setString(6, product.getCategory());
			psmt.setLong(7, product.getUnitsInStock());
			psmt.setString(8, product.getCondition());
			psmt.setString(9, product.getFile());
			psmt.setInt(10, product.getQuantity());
			
			
			result = psmt.executeUpdate();

		
		} catch (Exception e) {
			System.err.println("ProductRepository : insert 시, 예외 발생");
			e.printStackTrace();
		}
		return result;

	}

	/**
	 * 상품 수정
	 * 
	 * @param product
	 * @return
	 */
	public int update(Product product) {
		int result = 0;
		String sql = "UPDATE board"
				+ " SET name = ?,"
				+ " unit_price = ?,"
				+ " description = ?,"
				+ " manufacturer = ?,"
				+ " category = ?,"
				+ " units_in_stock = ?,"
				+ " condition = ?,"
				+ " file = ?,"
				+ " quantity = ?"
				+ " WHERE product_id = ?";
		
		try {
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, product.getName());
			psmt.setInt(2, product.getUnitPrice());
			psmt.setString(3, product.getDescription());
			psmt.setString(4, product.getManufacturer());
			psmt.setString(5, product.getCategory());
			psmt.setLong(6, product.getUnitsInStock());
			psmt.setString(7, product.getCondition());
			psmt.setString(8, product.getFile());
			psmt.setInt(9, product.getQuantity());
			psmt.setString(10, product.getProductId());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("ProductRepository : update 시 예외 발생");
			e.printStackTrace();
		}
		return result;					

	}

	/**
	 * 상품 삭제
	 * 
	 * @param product
	 * @return
	 */
		public int delete(String productId) {
		int result = 0;
		String sql = "DELETE "
				+ " FROM product"
				+ " WHERE product_id = ?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, productId);
			
			result = psmt.executeUpdate();
					
		} catch (Exception e) {
			System.err.println("BoardDAO : update 시 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

}
