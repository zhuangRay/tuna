package service;

import dao.CustomersDAO;
import entity.Customer;
import exception.LoginFailedException;
import exception.TUNAException;

public class CustomerService {
	
	private CustomersDAO dao = new CustomersDAO();
	
	public Customer login(String id,String password) throws TUNAException { 
		if(id==null || id.length()==0 || password==null || password.length()==0) {
			throw new IllegalArgumentException("登入會員必須輸入帳號,密碼");
		}
		Customer c = dao.selectCustomerById(id);
		
		if(c!=null && password.endsWith(c.getPassword())) {
			return c;
		}else {
			throw new LoginFailedException ("登入失敗，帳號或密碼錯誤");//TODO:throw new LoginFailedException
		}
	}
	public void register(Customer c)throws TUNAException{
		if(c==null) throw new IllegalArgumentException("註冊會員時，customer物件不得為null");
		
		dao.insert(c);
	}
}
