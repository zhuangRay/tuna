package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Product;
import entity.ShoppingCart;
import entity.Spec;
import exception.TUNAException;
import service.ProductService;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/add_cart.do")// http://localhost:8080/tuna/add_cary.do
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		//1.取得request中form data
		String productId = request.getParameter("productId");
		String flavorName = request.getParameter("flavor");
		String specName = request.getParameter("spec");
		String quantity = request.getParameter("quantity");
	
		//檢查
		if(productId!=null){
			//2.呼叫商業邏輯
		ProductService pService = new ProductService();
		try {
		Product p = pService.getProductById(productId);
		if(p!=null) {
		  Spec spec = null;
		  if(p.getSpecCount()>0 && specName!=null) {
			if(flavorName == null) flavorName = "";
			spec = pService.getSpecByKey(productId,flavorName,specName);
		}
		 if(quantity!=null && quantity.matches("\\d+")) {
			 ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			 if(cart==null) {
				 cart = new ShoppingCart();
				 session.setAttribute("cart", cart);
			 }
			 int qty = Integer.parseInt(quantity);
			 cart.add(p, flavorName, spec, qty);	
			 }
		  }	
	  }catch(TUNAException e) {
		  this.log("加入購物車失敗",e);
	  }catch(Exception e) {
		  this.log("加入購物車發生非預期錯誤",e);  
	  }
	}
      //3.外部轉交car.jsp
		response.sendRedirect(request.getContextPath() + "/member/cart.jsp");
   }
}
