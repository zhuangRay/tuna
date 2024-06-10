package dao;

import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

import exception.TUNAException;

import java.sql.*;

public class MySQLConnection {
	//blank (static final variables)
	private static final String driver;//="com.mysql.jdbc.Driver";
	private static final String url;//="jdbc:mysql://localhost:3306/tuna"; //blank static final 屬性
	private static final String userid; //= "root";//mysql 內建管理者帳號
	private static final String pwd;// ="1234" // root的密碼


	static {
		ResourceBundle jdbcBundle = ResourceBundle.getBundle("dao.mysql_jdbc");
		
		driver = jdbcBundle.getString("jdbc.driver");
		//System.out.println(driver);
		
		url = jdbcBundle.getString("jdbc.url");
		//System.out.println(url);
		
		userid = jdbcBundle.getString("jdbc.userid");
		//System.out.println(userid);

		pwd = jdbcBundle.getString("jdbc.pwd");
		//System.out.println(pwd);
				
		
	}
	public static Connection getConnsction() throws TUNAException {
		//1.載入Driver
		try {
			Class.forName(driver);
			
			try {
				Connection connection = DriverManager.getConnection(url, userid, pwd);
				return connection;
			} catch (SQLException e) {
				//Logger.getLogger("MySQLConnection").log(Level.SEVERE,"連線失敗",e);
				throw new TUNAException("連線失敗",e);//TODO: 改成throw new XxxException
			}
			
		} catch (ClassNotFoundException e) {
			//Logger.getLogger("MySQLConnection").log(Level.SEVERE,"載入JDBC Drive失敗",e);
			throw new TUNAException("載入JDBC Drive失敗",e);//TODO: 改成throw new XxxException
		}
		
	}
}
