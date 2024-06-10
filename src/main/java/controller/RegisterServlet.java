package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Customer;
import exception.TUNADataInvalidException;
import exception.TUNAException;
import service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do")//http://localhost:8080/tuna/register.do
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		// 1.取得request中的form data
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String birthday = request.getParameter("birthday");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		String subscribed = request.getParameter("subscribed");
		
		String captcha = request.getParameter("captcha");;
		
		if(id==null || (id=id.trim()).length()==0) {
			errors.add("必須輸入帳號");
		}
		if(email==null || (email=email.trim()).length()==0) {
			errors.add("必須輸入email");
		}
		if(phone==null || (phone=phone.trim()).length()==0) {
			errors.add("必須輸入手機號碼");
		}
		if(name==null || (name=name.trim()).length()==0) {
			errors.add("必須輸入姓名");
		}
		if(password==null || password.length()==0) {
			errors.add("必須輸入password");
		}
		if(birthday==null || (birthday=birthday.trim()).length()==0) {
			errors.add("必須輸入生日");
		}
		if(gender==null || (gender=gender.trim()).length()!=1) {
			errors.add("必須選擇性別");
		}
		if(address!=null) { // for <textarea>防呆
			address=address.trim();
		}
		if(captcha==null || (captcha=captcha.trim()).length()==0) {
			errors.add("必須輸入驗證碼");
		}else {
		//檢查驗證碼
			String sessionCaptcha = (String)session.getAttribute("captcha");
			if(!captcha.equalsIgnoreCase(sessionCaptcha)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("captcha");
		if(errors.isEmpty()) {
			//2.若無誤，呼叫商業邏輯
			Customer c = new Customer();
			try {
				c.setId(id);
				c.setEmail(email);
				c.setPhone(phone);
				c.setName(name);
				c.setPassword(password);
				c.setGender(gender.charAt(0));
				c.setBirthday(birthday);
				c.setAddress(address);
				c.setSubscribed(subscribed!=null);
				
				CustomerService cService = new CustomerService();
				cService.register(c);
				
				request.setAttribute("customer", c);
				//3.1 forward([內部]轉交) 註冊成功網頁:register_ok.jsp
				RequestDispatcher dispatcher = request.getRequestDispatcher("register_ok.jsp");
				dispatcher.forward(request, response);
				return;
				
			}catch(TUNADataInvalidException e) {
				errors.add(e.getMessage());
			} catch (TUNAException e) {
				this.log(e.getMessage(),e);
				errors.add(e.getMessage());
			}catch(Exception e) {
				this.log("系統發生非預期錯誤",e);
				errors.add("系統發生錯誤"+e.getMessage()+",請聯絡管理人員");
			}
		}
		request.setAttribute("errors", errors);	
		//3.2 forward([內部]轉交) 註冊網頁:register.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
		dispatcher.forward(request, response);
	
	}
 }

