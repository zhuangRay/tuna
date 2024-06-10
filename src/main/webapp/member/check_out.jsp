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
			<jsp:param name ="subheader" value="結帳"/>
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
	   <form id="cartForm" action ="check_out_ok.jsp" method="">
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
					
			
					<td><%= cart.getQuantity(cartItem) %>
					<td><%= cart.getAmount(cartItem)%></td>
					
				</tr>
				<% }%>							
			</tbody>
	   		<tfoot>
				<tr class='total_tr'>
					<td colspan="4" >共<%= cart.size() %>項, <%=cart.getTotalQuantity() %>件 </td>
					<td>總金額: </td>
					<td colspan="2">
					<div style=""> <%= cart.getTotalAmount() %>元</div>
<!-- 					<div>VIP 85折 8080.95元</div> -->
					</td>
				</tr>
				<tr>
					<td colspan="7">
						<span style>
							<label>貨運方式:</label>
							<select name="shippingType" required>
								<option value="">請選擇...</option>
								<option value="SHOP">店面自取</option>
								<option value="HOME" data-fee="150">宅配，150元</option>
								<option value="STORE" data-fee="60">超商取貨，60元</option>
							</select>
						</span>
						<span >
							<label>付款方式:</label>
							<select name="paymentType" required>
								<option value="">請選擇...</option>
								<option value="ATM">ATM轉帳</option>
								<option value="HOME" data-fee="50">貨到付款，50元</option>
								<option value="STORE">超商付款</option>
								<option value="CARD">信用卡</option>
							</select>
						</span>
					</td>
				</tr>
				<tr>
					<td colspan="7">
						<fieldset>
							<legend>收件人:<input type='button' value='同訂購人'></legend>
							<label>姓名:</label><input name="recipientName" required><br>
							<label>EMAIL:</label><input type=email name="recipientEmail" required><br>
							<label>手機:</label><input type=tel name="recipientPhone" required><br>
							<label>地址:</label><input name="ShippingAddress" required>
						
						</fieldset>
					</td>
				
				</tr>
				
				
				
				<tr>
					<td colspan="5"></td>
					<td colspan="2"><input type="submit" value="送出訂單"></td>				
				
				</tr>
			</tfoot>
	   </table>
	   
	   </form>
	   <%} %>
	   </article>
	   <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>