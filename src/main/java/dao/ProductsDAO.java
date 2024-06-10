package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Flavor;
import entity.Product;
import entity.Spec;
import entity.SpecialOffer;
import exception.TUNAException;


public class ProductsDAO {
	
	public static final String SELECT_ALL_PRODUCTS=
			"SELECT id, name, category, photo_url, unit_price, stock,"
			  +" description, release_date, discount FROM products_list_view";
		public List<Product> selectAllProduct() throws TUNAException{
			List<Product> list = new ArrayList<>();			
			
			try(
					Connection connection= MySQLConnection.getConnsction();
					PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCTS);								
					){
					
				//3.1.傳入傳入?的值
				
				try(
						ResultSet rs = pstmt.executeQuery();//4.執行SELECT指令
						
					){
					//5.讀取rs
					while(rs.next()) {	
						Product p;
						int discount = rs.getInt("discount");
						if(discount==0) {
							p = new Product();					
						}else {
							p = new SpecialOffer();
							((SpecialOffer)p).setDiscount(discount);
						}
						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setCategory(rs.getString("category"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setDescription(rs.getString("description"));
						p.setReleaseDate(rs.getString("release_date"));
						
						list.add(p);
					}
				}
			}catch(SQLException e) {
				throw new TUNAException("[查詢全部產品]失敗",e);
			}
			return list;
		}
		public static final String SELECT_PRODUCTS_BY_CATEGORY=SELECT_ALL_PRODUCTS
				+" WHERE category=?";
			public List<Product> selectProductsByCategory(String category) throws TUNAException{
				List<Product> list = new ArrayList<>();			
				
				try(
						Connection connection= MySQLConnection.getConnsction();
						PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_CATEGORY);								
						){
						
					//3.1.傳入傳入?的值
					pstmt.setString(1, category);
					try(
							ResultSet rs = pstmt.executeQuery();//4.執行SELECT指令
							
						){
						//5.讀取rs
						while(rs.next()) {	
							Product p;
							int discount = rs.getInt("discount");
							if(discount==0) {
								p = new Product();					
							}else {
								p = new SpecialOffer();
								((SpecialOffer)p).setDiscount(discount);
							}
							p.setId(rs.getInt("id"));
							p.setName(rs.getString("name"));
							p.setCategory(rs.getString("category"));
							p.setPhotoUrl(rs.getString("photo_url"));
							p.setUnitPrice(rs.getDouble("unit_price"));
							p.setStock(rs.getInt("stock"));
							p.setDescription(rs.getString("description"));
							p.setReleaseDate(rs.getString("release_date"));
							
							list.add(p);
						}
					}
				}catch(SQLException e) {
					throw new TUNAException("[依分類查詢產品]失敗",e);
				}
				return list;
			}	
			public static final String SELECT_PRODUCTS_BY_KEYWORD=SELECT_ALL_PRODUCTS
					+" WHERE name LIKE?";
				public List<Product> selectProductsByKeyword(String keyeord) throws TUNAException{
					List<Product> list = new ArrayList<>();			
					
					try(
							Connection connection= MySQLConnection.getConnsction();
							PreparedStatement pstmt = connection.prepareStatement( SELECT_PRODUCTS_BY_KEYWORD);								
							){
							
						//3.1.傳入傳入?的值
						pstmt.setString(1,"%"+ keyeord+"%");
						try(
								ResultSet rs = pstmt.executeQuery();//4.執行SELECT指令
								
							){
							//5.讀取rs
							while(rs.next()) {	
								Product p;
								int discount = rs.getInt("discount");
								if(discount==0) {
									p = new Product();					
								}else {
									p = new SpecialOffer();
									((SpecialOffer)p).setDiscount(discount);
								}
								p.setId(rs.getInt("id"));
								p.setName(rs.getString("name"));
								p.setCategory(rs.getString("category"));
								p.setPhotoUrl(rs.getString("photo_url"));
								p.setUnitPrice(rs.getDouble("unit_price"));
								p.setStock(rs.getInt("stock"));
								p.setDescription(rs.getString("description"));
								p.setReleaseDate(rs.getString("release_date"));
								
								list.add(p);
							}
						}
					}catch(SQLException e) { //SQLExceprion 是checked exception
						throw new TUNAException("[依關鍵字查詢產品]失敗",e);
					}
					return list;
				}		
				
				public static final int LIMIT_NUMBER=5;
				public static final String SELECT_NEWEST_PRODUCTS= SELECT_ALL_PRODUCTS
						+ " ORDER BY release_date DESC LIMIT "+ LIMIT_NUMBER;
//						"SELECT id, name, category, photo_url, unit_price, stock,"
//								  +" description, release_date, discount FROM products"
//								+" ORDER BY release_date DESC LIMIT "+ LIMIT_NUMBER;
				public List<Product> selectNewestProducts() throws TUNAException{
					List<Product> list = new ArrayList<>();
					try(
							Connection connection = MySQLConnection.getConnsction(); //1,2. 取得連線
							PreparedStatement pstmt = connection.prepareStatement(SELECT_NEWEST_PRODUCTS);					
							ResultSet rs = pstmt.executeQuery()//4.執行SELECT指令
							){
					//5.讀取rs	
					int count = 0;
					while(rs.next() && count++<LIMIT_NUMBER) {	
						Product p;
						int discount = rs.getInt("discount");
						if(discount==0) {
							p = new Product();					
						}else {
							p = new SpecialOffer();
							((SpecialOffer) p).setDiscount(discount);
						}
						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setCategory(rs.getString("category"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setDescription(rs.getString("description"));
						p.setReleaseDate(rs.getString("release_date"));
						
						list.add(p);
					}
				
				}catch(SQLException e){ 
					throw new TUNAException("[查詢最新上架產品]失敗",e);
				}
				return list;
					
				}
				public static final String SELECT_PRODUCT_BY_ID = "SELECT id, name, category, photo_url, unit_price, stock, description, release_date,discount, "
						+ "     product_id, flavor_name, flavor_stock, icon_url, flavors_photo, flavors_unit_price, "
						+ "     spec_count "
						+ " FROM tuna.product_detail_view WHERE id=?";

//						"SELECT id, name, category, photo_url, unit_price, stock, description, release_date, discount" 
//						 +"     FROM products WHERE id=?";
				 public Product selectProductById(String id) throws TUNAException{
					Product p = null;
		
					try(    
							Connection connection = MySQLConnection.getConnsction();//1, 2.取得連線
							PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_BY_ID);//3. 準備指令	
							) {
							//3.1傳入?的值
						pstmt.setString(1, id);
						
						try(
						ResultSet rs = pstmt.executeQuery();//4.執行指令
					){
					//5.處理rs
						while(rs.next()) {
						if(p==null) {
							int discount = rs.getInt("discount");
							if(discount==0) {
								p = new Product();					
							}else {
								p = new SpecialOffer();
								((SpecialOffer) p).setDiscount(discount);
							}
							p.setId(rs.getInt("id"));
							p.setName(rs.getString("name"));
							p.setCategory(rs.getString("category"));
							p.setPhotoUrl(rs.getString("photo_url"));
							p.setUnitPrice(rs.getDouble("unit_price"));
							p.setStock(rs.getInt("stock"));
							p.setDescription(rs.getString("description"));
							p.setReleaseDate(rs.getString("release_date"));	
							p.setSpecCount(rs.getInt("spec_count"));	
						}
							//讀取Flavor資料
							String flavorName = rs.getString("flavor_name");
							if(flavorName!=null) {
								Flavor flavor = new Flavor();
								flavor.setFlavorName(flavorName);
								flavor.setStock(rs.getInt("flavor_stock"));
								flavor.setIconUrl(rs.getString("icon_url"));
								flavor.setPhotoUrl(rs.getString("flavors_photo"));
								flavor.setUnitPrice(rs.getDouble("flavors_unit_price"));
								
								p.add(flavor);
							}
						}
					 }
					}catch(SQLException e) {
						throw new TUNAException("[用ID查詢產品失敗]",e);
					}		
					return p;
				}
				 public static final String SELECT_SPEC_LIST=
					  "SELECT product_id, flavor_name, spec_name, product_flavor_specs.stock,"
					+ "   product_flavor_specs.unit_price AS list_price,"
					+ "   product_flavor_specs.unit_price*(100-discount)/100 AS price,"
					+ "   ordinal"
					+ "	  FROM product_flavor_specs"
					+ "		JOIN products ON product_flavor_specs.product_id=products.id"
					+ "	 WHERE product_id=? AND flavor_name=?"
					+ "	 ORDER BY ordinal";
				 public List<Spec> selectSpecList(String productId, String flavorName) throws TUNAException{
				List<Spec> list= new ArrayList<>();
				
		        try(Connection connection = MySQLConnection.getConnsction(); //1,2取得連線
				     PreparedStatement pstmt = connection.prepareStatement(SELECT_SPEC_LIST);//3.準備指令
				 ){
		        //3.1傳入?值
		        	pstmt.setString(1, productId);  //pstmt就是資料庫
		        	pstmt.setString(2, flavorName);
		        	
		        	try(ResultSet rs = pstmt.executeQuery();){ //4. 執行指令
		        		while(rs.next()) {  //5.處理rs
		        		Spec spec = new Spec();
		        		spec.setProductId(rs.getInt("product_id"));
		        		spec.setFlavorName(rs.getString("flavor_name"));
		        		spec.setSpecName(rs.getString("spec_name"));
		        		spec.setStock(rs.getInt("stock"));
		        		spec.setListPrice(rs.getDouble("list_price"));
		        		spec.setPrice(rs.getDouble("price"));
		        		
		        		list.add(spec);
			
		        		}
		        	}
		        }catch(SQLException e) {
					String errMsg = String.format("查詢[%s-%s]規格清單失敗",productId,flavorName);
					throw new TUNAException(errMsg,e);
				}
		         return list;
			}
			
}
