package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import exception.LoginFailedException;
import exception.TUNAException;
import service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns = "/login.do",loadOnStartup = 1)
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
       System.out.println();
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<String>();
		HttpSession session = request.getSession();
		
		//request.setCharacterEncoding("utf8");//設定request中form data的編碼，login畫面剛好沒有要輸入中文的input
		
		//1.取得requset中的form data
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String captcha=request.getParameter("captcha");
		
		if(id==null || (id=id.trim()).length()==0) {
			errors.add("必須輸入帳號");
		}
		if(password==null || password.length()==0) {
			errors.add("必須輸入password");
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
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()) {
			//將XXX_lib設定web專案的底層程式庫(v)
			CustomerService cService = new CustomerService();
			
				try {
					//執行商業邏輯
					Customer member = cService.login(id, password);
					
					session.setAttribute("member", member);
					//session.setMaxInactiveInterval(10); //10 sec.
					//3.1轉交登入成功網頁(login_ok.jsp)
					RequestDispatcher dispatcher = request.getRequestDispatcher("login_ok.jsp");
					dispatcher.forward(request, response);
					return;
					
				} catch (LoginFailedException e) {
					errors.add(e.getMessage());	//for user		
			    } catch (TUNAException e) {
			    	this.log(e.getMessage(),e);//for admin,tester,developer
			    	errors.add(e.getMessage()+", 請聯絡管理員");//for user
			    }catch(Exception e) {
			    	this.log("系統發生非預期錯誤",e);// for admin,tester,developer
			    	errors.add("系統發生錯誤"+e.getMessage()+",請聯絡管理員");//for user
			    }
			    			
			
		}
		request.setAttribute("errors", errors);
		//3.2 轉交登入網頁(login.jsp)
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
		
		
		}
	}



