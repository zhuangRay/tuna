package controller;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.CartItem;
import entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart!=null && !cart.isEmpty()) {
			Set<CartItem> cartItemSet = cart.getCartItemSet();
			for(CartItem cartItem:cartItemSet){
				//1.讀取request的form data
				String quantity=request.getParameter("quantity"+cartItem.hashCode());
				String delete=request.getParameter("delete"+cartItem.hashCode());
				
				if(delete==null) { //不要remove只要修改數量
					int qty;
					if(quantity!=null && quantity.matches("\\d+")) {
						qty = Integer.parseInt(quantity);
						cart.update(cartItem, qty);						
					}		
				}else {//要remove
					cart.remove(cartItem);
				}
			}
			
		}
	
		//3.外部轉交cart.jsp
		
	   String submit = request.getParameter("submit");
		if("checkOut".equals(submit)) {
			response.sendRedirect("check_out.jsp");
		}else {
	   response.sendRedirect("cart.jsp");
		}
	}
}
