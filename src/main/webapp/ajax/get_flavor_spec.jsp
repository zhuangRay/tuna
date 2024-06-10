<%@page import="entity.Spec"%>
<%@page import="java.util.List"%>
<%@page import="service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
 <%
 	String productId=request.getParameter("productId");
    String flavorName=request.getParameter("flavorName");
    
    
    List<Spec> list = null;
    ProductService pService = new ProductService();
    if(productId!=null && flavorName!=null){	
    	list = pService.getSpecList(productId,flavorName);	
    }
 
    if(list!=null && list.size()>0){ 
 %>
 
 
		  <select name="spec" required>
					<option value="">請選擇...</option>
					<%for(int i=0;i<list.size();i++){ 
					   Spec spec = list.get(i);
					%>
				  	<option value="<%=spec.getSpecName() %>" data-stock="<%=spec.getStock() %>" 
				  	        data-listPrice="<%=spec.getListPrice() %>" data-price="<%=spec.getPrice() %>">
				  	       <%=spec.getSpecName() %>，餘<%=spec.getStock()%>組
				  </option>
				   <% } %>
			</select>
		<% } %>	
			
		<!--  		<option value="1組(6包)" data-stock="3" data-listPrice="950" data-price="650">1組(6包)，餘3件</option>-->
		<!--		    <option value="2組(12包)" data-stock="4" data-listPrice="1900" data-price="1240">2組(12包)</option>-->
		<!--	   	<option value="4組(24包)" data-stock="5" data-listPrice="2850" data-price="2320">4組(24包)</option>	-->