<%@page import="entity.Flavor"%>
<%@page import="entity.SpecialOffer"%>
<%@page import="service.ProductService"%>
<%@page import="entity.Product"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>產品明細</title>
	<style>
		  /* 共用css*/
			body{font-family:  Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", 
			      "LiHei Pro", "微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;}
			article{min-height:70vh }
	     	#welcomeSpan{float:right}
		  /* 共用css end*/
		  
	     .ListPrice{color:gray;text-decoration: Line-through;}
	     .discount, .price{color:red;font-size:normal;}
	     #leftDiv{float:left;width:30%}
	     #leftDiv img{width:90%;}
	     #rightDiv{float:right;width:55%}
	     #descriptionDiv{clear:both}
	 
	        /* HIDE RADIO */
			
			.flavorDiv input[type=radio] { 
			  position: absolute;
			  opacity: 0;
			  width: 10;
			  height: 10;
			}
			
			/* IMAGE STYLES */
			.flavorDiv input[type=radio] + img {
			  cursor: pointer;
			  
			}
			
			/* CHECKED STYLES */
			.flavorDiv input[type=radio]:checked + img {
			  outline: 2px solid #f00;
			}
			.flavorDiv img{
			   width: 40px;
			   height: 40px;
			}
	</style>	
	<script>
	  //自訂的javascript function
	  function changePhoto(theImg){
		  //alert(theImg.dataset.photo);
		  productPhoto.src = theImg.dataset.photo;
		  stockSpan.innerHTML = theImg.dataset.stock;
		  qty.max = theImg.dataset.stock;		  
	  }
	  function getFoodImg(theImg){
		  theImg.src="./images/photo_off_icon.png"
		  
	  }
	</script>
	
  </head>
	<body>
		<jsp:include page="subviews/header.jsp">
		   <jsp:param name="subheader" value="產品明細"/>
		 </jsp:include>
		   <%@ include file="subviews/nav.jsp" %>
	   <article>
	   <%
	   		String productId = request.getParameter("productId");
	        ProductService pService = new ProductService();
	        Product p = null;
	        
	        if(productId!=null){
	        	p  = pService.getProductById(productId);
	        }
	   %>
	     <% if(p==null){ %>
	     	<h2>查無產品!</h2>
	     <%}else{ %>
	     
	   <div id='leftDiv'>
	     <img onerror='getFoodImg(this)'id="productPhoto"  src="<%=p.getPhotoUrl () %>">
	   </div>
	  <div id='rightDiv'>
		   <h3><%= p.getName() %></h3>
		   <div>
		   		<label>分類:</label>
		   		<a href="products_list.jsp?category=鮮活水產">鮮活水產</a>
		   </div>
		   <div>
		   		<label>上架日期:</label>
		   		<span><%=p.getReleaseDate() %></span>
		   </div>
		   <%if(p instanceof SpecialOffer){%>
		   <div>
				<label>定價:</label>
				<span class="listPrice"><%=((SpecialOffer)p).getListPrice() %></span>元      
		   </div>
		   <% } %>
		    <div>
				<label>優惠價:</label>
				<span class="discount"><%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %></span>  
				<span class="price"><%=p.getUnitPrice() %></span>元
		   </div>
		    <div>
				<label>庫存:</label>
				<span id="stockSpan"><%=p.getStock()%></span>件      
		   </div>
		   <p></p>
		   <form>
		   		<input type="hidden" name="productId" value="<%= p.getId()%>">
		   		<%if(p.getFlavorsList()!=null && p.getFlavorsList().size()>0){%>
		   		<div class="flavorDiv">
		   		<label>口味:</label>
		   		<% for(int i=0;i<p.getFlavorsList().size();i++){ 
		   			Flavor theFlavor = p.getFlavorsList().get(i);
		   		%>
		   		<label>
		   		    <input type="radio" name="flavor" value="<%=theFlavor.getFlavorName() %>" required>
		   		    <img onclick="changePhoto(this)" src="<%=theFlavor.getIconUrl() %>" 
		   		    		alt="<%=theFlavor.getFlavorName() %>" title="<%=theFlavor.getFlavorName() %>" 
		   		    		data-photo="<%=theFlavor.getPhotoUrl() %>"
		   		    		data-stock="<%=theFlavor.getStock() %>">
		   		    		
		   		</label>
		   		<% } %>
		   		</div>
		   		<% }%>
		   		<label>數量:</label>
		   		<input type="number" id="qty" name="quantity" min=1 max="<%= p.getStock()%>" required>
		   		<input type="submit" value ="加入購物車">
		   		
		   </form>
		 </div>
		 <div  id='descriptionDiv'>
		     <hr>
			<%=	p.getDescription() %>		 
	    </div>
	    <% } %>
	   </article>
	   <%@ include file="subviews/footer.jsp" %>
	</body>
</html>