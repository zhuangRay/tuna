<%@page import="entity.SpecialOffer"%>
<%@page import="entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>購物車</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/tuna.css">
	<style>
	     
	     /* 自訂的CSS */
		 	.cart {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
			}
			
			.cart td, .cart th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}
			
			.cart tr:nth-child(even){background-color: #f2f2f2;}
			
			.cart tr:hover {background-color: #ddd;}
			
			.cart caption {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align:center;
			  background-color: #04AA6D;
			  color: white;
			}
			.cartItemPhoto{
				height:50px;
				width:50px;
			}
			.cart .total_tr td{text-align: right}
	</style>	
	<script>
	  //自訂的javascript function
	</script>
	
  </head>
	<body>
			<jsp:include page="../subviews/header.jsp">
			<jsp:param name ="subheader" value="購物車"/>
			</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		
	  <article>
	     
<!-- 	     <div style="white-space:pre"> -->
<%-- 	     	${sessionScope.cart} --%>
<!-- 	     </div> -->
	   		<%
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
	   			if(cart==null || cart.isEmpty()){
	   		%>
	   			<h2>購物車是空的，請先購物才能檢視購物車內容</h2>
	   		<%}else{%>
	   <form id="cartForm" action ="update_cart.do" method="POST">
	   <table class ="cart">
	   		<caption>購物車</caption>
	   		<thead>
	   			<tr>
		   			<td>編號</td>
		   			<td>名稱</td>
		   			<td>flavor</td>
		   			<td>spec</td>
		   			<td>price</td>
		   			<td>數量</td>
		   			<td>小記</td>	
		   			<td>刪除?</td>
	   			</tr>
	   		
	   		</thead>
	   		<tbody>
			<% 
				Set<CartItem> cartItemSet = cart.getCartItemSet();
				for(CartItem cartItem:cartItemSet){
			%>	
				<tr>
					<td><%= cartItem.getProductId() %></td>
					<td>
					  <a href="<%=request.getContextPath() %>/product_detail.jsp?productId=<%= cartItem.getProductId() %>">
					  <img class="cartItemPhoto" src="<%= cartItem.getPhotoUrl() %>">
					  <%= cartItem.getProductName() %>
					  </a>
					</td>
					<td><%= cartItem.getFlavorName() %></td>
					<td><%= cartItem.getSpecName() %></td>
				
					<td>
						<% if(cartItem.getProduct() instanceof SpecialOffer) {%>
						<div class='listPriceDiv'><%= cartItem.getListPrice() %>元</div>
						<span class='discountSpan'><%= cartItem.getDiscountString() %></span>
						<% } %>
						<%= cartItem.getUnitPrice() %>元
					</td>
					
			
					<td><input type='number' name="quantity<%=cartItem.hashCode()%>" value='<%= cart.getQuantity(cartItem) %>' min='1' max="<%= cartItem.getStock()%>"></td>
					<td><%= cart.getAmount(cartItem)%></td>
					<td><input type="checkbox" name="delete<%=cartItem.hashCode()%>"></td>
				</tr>
				<% }%>							
			</tbody>
	   		<tfoot>
				<tr class='total_tr'>
					<td colspan="5" >共<%= cart.size() %>項, <%=cart.getTotalQuantity() %>件 </td>
					<td>總金額: </td>
					<td colspan="2">
					<div style=""> <%= cart.getTotalAmount() %>元</div>
<!-- 					<div>VIP 85折 8080.95元</div> -->
					</td>
				</tr>
				<tr>
					<td colspan="6"></td>
					<td colspan="2">
						<input type="submit" value="修改購物車">
						<button type="submit" name="submit" value="checkOut">我要結帳</button>
						
					</td>				
				
				</tr>
			</tfoot>
	   </table>
	   
	   </form>
	      <% } %>
	   </article>
	   <%@ include file="/subviews/footer.jsp" %>
	   <script>
	   function checkOut{
		   location.href="check_out.jsp";
		   
	   }
	   </script>
	</body>
</html>