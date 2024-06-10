<%@page import="entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
	    <!-- nav.jsp start -->
		

		<nav style=" position: sticky;top: 0;background-color: #17517E;font-weight:bold;z-index:1">
		<style>
			header{background:#dddfd9}
			.label1Link{background-color:#dddfd9;height:30px;}
			.label1Link a{color:#00AEAE;}
			.label1Link a:hover{color: orange;} #categoryList a:active{color: red;}
			.label1Link a{                  /*登入 註冊 修改按鈕*/
				    color: #fff; border-radius: 5px;  
				    font-weight: bold;font-size: 1.3em;cursor: pointer;}
			.label1LinkA{ background-color: #64beaa;}/*登入 註冊 修改按鈕背景顏色*/	
		
			
			    
		</style>
		<div class="label1Link">
		<a class="label1LinkA" href="<%=request.getContextPath() %>/products_list.jsp">找鮮生</a> 
		<%
		Customer member =(Customer)session.getAttribute("member");
		if(member==null){%>
		<a class="label1LinkA" href="<%=request.getContextPath() %>/login.jsp">會員登入</a> 
		<a class="label1LinkA" href="<%=request.getContextPath() %>/register.jsp">會員註冊</a> 
		
		<%}else{ %>
		<a class="label1LinkA" href="<%=request.getContextPath() %>/logout.do">會員登出</a> 
		<a class="label1LinkA" href="<%=request.getContextPath() %>/member/update.jsp">會員修改</a> 
		<% }%>
		<span id='welcomeSpan'>
		<span>${member==null?"Hello!":member.getName()}</span>，你好
		<a href="<%=request.getContextPath() %>/member/cart.jsp">
		    <img src="<%=request.getContextPath() %>/images/cart_shopping.png" alt="購物車" title="購物車">(<span id="cartQty">${cart==null || cart.isEmpty()?"0":cart.getTotalQuantity()}</span>)
		 </a>
		</span>
		</div>
		
		</nav>
		<!-- nav.jsp end -->