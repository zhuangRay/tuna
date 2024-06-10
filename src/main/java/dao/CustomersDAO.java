package dao;

import java.sql.*;
import entity.Customer;
import entity.VIP;
import exception.TUNADataInvalidException;
import exception.TUNAException;


public class CustomersDAO {
	
	//搜尋客戶ID、信箱、手機號碼、密碼、名子、生日、性別、地址、訂閱、折扣
	private static final StringBuilder SELECT_CUSTOMER_BY_ID = new StringBuilder()
			.append(" SELECT id, email, phone, password, name, birthday, ")
			.append(" gender, address, subscribed, discount FROM customers ")
			.append(" WHERE id = ? OR email = ? OR phone = ? ");
	
	 public Customer selectCustomerById(String id) throws TUNAException{
		Customer c = null;
		
		try (
				Connection connection = MySQLConnection.getConnsction();//1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_CUSTOMER_BY_ID.toString());//3.準備指令
			){
			//3.1.傳入?的值
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setString(3, id);
			
			try(
				ResultSet rs = pstmt.executeQuery();//4.執行SELECT指令
				
			){
				//5.讀取rs
			while(rs.next()) {	
				int discount = rs.getInt("discount");
				if(discount>0) {
					c = new VIP();
						((VIP)c).setDiscount(discount);
				}else {
				c = new Customer();
				}
				c.setId(rs.getString("id"));
				c.setEmail(rs.getString("email"));
				c.setPhone(rs.getString("phone"));
				
				c.setPassword(rs.getString("password"));
				c.setName(rs.getString("name"));
				c.setBirthday(rs.getString("birthday"));
				
				c.setGender(rs.getString("gender").charAt(0));
				c.setAddress(rs.getString("address"));
				c.setSubscribed(rs.getBoolean("subscribed"));
			  }				
			}
			return c;
		} catch (SQLException e) {
		
			throw new TUNAException("查詢客戶失敗",e);  //TODO:throw new XxxException
			
		}
			
	}
	 
	private static final StringBuilder INSERT_CUSTOMER = new StringBuilder()
			.append(" INSERT INTO customers  (id, email, phone, password, name, ")
			.append(" birthday, gender, address, subscribed) ")
			.append(" VALUES(?,?,?, ?,?,?, ?,?,?) ");
	public void insert(Customer c) throws TUNAException{
		
	try(
			Connection connection = MySQLConnection.getConnsction(); //1,2. 取得連線
			PreparedStatement pstmt = connection.prepareStatement(INSERT_CUSTOMER.toString());
			
			){
			//3.1傳入?的值
			pstmt.setString(1, c.getId());
			pstmt.setString(2, c.getEmail());
			pstmt.setString(3, c.getPhone());
			
			pstmt.setString(4, c.getPassword());
			pstmt.setString(5, c.getName());
			pstmt.setString(6, c.getBirthday().toString());
			
			pstmt.setString(7, String.valueOf(c.getGender()));
			pstmt.setString(8, c.getAddress());
			pstmt.setBoolean(9, c.isSubscribed());
			
		    pstmt.executeUpdate();//4.執行指令
	}catch(SQLIntegrityConstraintViolationException e) {
		String colName="id";
		
		if(e.getMessage().lastIndexOf("null")>0) {
			throw new TUNAException("[建立客戶]失敗"+e.getErrorCode(),e);
		}else if (e.getMessage().lastIndexOf("email_UNIQUE")>0) {
			colName="email";
		}else if (e.getMessage().lastIndexOf("phone_UNIQUE")>0) {
			colName="手機號碼";	
		}
		String errMsg = String.format("%s已經重複註冊", colName);
		throw new TUNADataInvalidException(errMsg,e);
	}catch (SQLException e) {
		throw new TUNAException("[建立客戶]失敗"+e.getErrorCode(),e);
	}	
	 }
		
}

