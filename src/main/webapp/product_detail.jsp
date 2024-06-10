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
	<link rel="stylesheet" type="text/css" href="./style/tuna.css">
	<style>
	  
	     .listPrice{color:gray;text-decoration: Line-through;}
	     .discount, .price{color:red;font-size:normal;}
	     #leftDiv{float:left;width:30%}
	     #leftDiv img{width:90%;}
	     #rightDiv{float:right;width:55%}
	     #descriptionDiv{clear:both}
	 	.specDiv{display:none;}
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
			.addCartButton{background-image: url(images/cart_shopping2.png);/*加入購物車圖*/
						   background-repeat: no-repeat;
						   background-size: contain;
						   border: none;
						   width: 50px; 
                           height: 50px;
                           margin-left: 30px; 
   						   margin-top: 5px; 
   						   position: relative;
   						   top:15px;   }
   			.addCartButton:hover{background-image: url(images/cart_shopping2.png);/*加入購物車圖*/
						   background-repeat: no-repeat;
						   background-size: contain;
						   border: none;
						   width: 55px; 
                           height: 55px;
                           margin-left: 30px; 
   						   margin-top: 5px; 
   						   position: relative;
   						   top:15px;   }			   
   						   
   						   
   						   
             	input,select{    /*註冊打字框變圓潤*/
				    border: 2px solid white;
				    border-radius: 10px; 
				    padding: 5px; 
				   } 
			.bodyDetail{color:black;font-weight: bold;}
				   
	</style>	
	<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
	crossorigin="anonymous"></script>
	<script>
	  $(init); //$(document).ready(init)
	  
	//自訂的javascript function
	  function init(){
		  
		 //alert($(".iconImg").first().attr("title"));
		  $(".iconImg").first().trigger("click");
	   }
	  //選擇[規格]
	  function changeSpecStock(){	 
		 // alert($("select[name=spec] option:selected").attr("data-stock"));
		 
		 
		  $(".listPrice").text($("select[name=spec] option:selected").attr("data-listPrice"));
		  $(".price").text($("select[name=spec] option:selected").attr("data-price"));
		  var specText = 
			  $("select[name=spec] option:selected").val()+
			  $("select[name=spec] option:selected").attr("data-stock")+"組";
		  $("#specStockSpan").text(specText);
		  qty.max =  $("select[name=spec] option:selected").attr("data-stock");
	  }
	  
	  //選擇[口味]
	  function changePhoto(theImg){
		  //alert(theImg.dataset.photo); for js test
		  productPhoto.src = theImg.dataset.photo;
		  stockSpan.innerHTML = theImg.title +  theImg.dataset.stock+"組";
		  qty.max = theImg.dataset.stock;
		  
		  //ajax請求該顏色規格
		  sendSpecListAjax(theImg)
	  }
	  function sendSpecListAjax(theImg){
		 //alert("ajax請求[" +theImg.title + "]該口味規格");  
		var pid = $("input[name=productId]").val();
		var flavorName="";
		
		if(theImg!=null){
		 flavorName = theImg.title;
		}
		
		 $.ajax({
			 url:"ajax/get_flavor_spec.jsp?productId=" + pid +"&flavorName="+flavorName,
			 method:"GET" 
		 }).done(sendSpecListAjax_doneHandler);//定義取得成功(done)回應時的call-back方法
	  }
	  function sendSpecListAjax_doneHandler(result, textStatus ,jqXHR){
		 // alert(result);
		  $("#specListDiv").html(result);
		  if($("select[name=spec] option").length>0){
		    $(".specDiv").show();
		    $("select[name=spec] ").change(changeSpecStock);
	  }else{
		   $(".specDiv").hide();
		   //alert("無規格!");
	     }
	  }
	  function getFoodImg(theImg){
		  theImg.src="./images/photo_off_icon.png"
		  
	  }
	</script>
	
  </head>
	<body class="bodyDetail">
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
	     <%}else{%>
	     
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
				<span>共<%=p.getStock()%>組</span>   
				<span id="stockSpan"></span>
			    <span id="specStockSpan"></span>
		   </div>
		   <p></p>
		   <form method="POST" action="add_cart.do">
		   		<input type="hidden" name="productId" value="<%= p.getId()%>">
		   		<% if(p.getFlavorsList()!=null && p.getFlavorsList().size()>0){%>
		   		<div class="flavorDiv">
		   		<label>口味:</label>
		   		<% for(int i=0;i<p.getFlavorsList().size();i++){ 
		   			Flavor theFlavor = p.getFlavorsList().get(i);
		   		%>
		   		<label>
		   		    <input type="radio" name="flavor" value="<%=theFlavor.getFlavorName() %>" required>
		   		    <img class='iconImg' onerror='getFoodImg(this)' onclick="changePhoto(this)" src="<%=theFlavor.getIconUrl() %>" 
		   		    		alt="<%=theFlavor.getFlavorName() %>" title="<%=theFlavor.getFlavorName() %>" 
		   		    		data-photo="<%=theFlavor.getPhotoUrl() %>"
		   		    		data-stock="<%=theFlavor.getStock() %>">
		   		    		
		   		</label>
		   		<% } %>
		   		</div>
		   		<% }%>
		   		
		   		<div class="specDiv">
		   			<Label>規格:</Label>
		   			<div id='specListDiv'>
		   			    請先選擇[口味]
		   		     </div>	   		
		   		</div>
		   		<label>數量:</label>
		   		<input type="number" id="qty" name="quantity" min=1 max="<%= p.getStock()%>" required>
		   		<input class="addCartButton" type="submit" value ="" title="點選加入購物車">
		   		
		   </form>
		 </div>
		 <div  id='descriptionDiv'>
		     <hr>
			<%=	p.getDescription() %>		 
	    </div>
	   <script>
	    <%
			if(p.getFlavorsList().isEmpty() && p.getSpecCount()>0){	    
	    %>
	        sendSpecListAjax(null);
	    <%
			}
	    %>
	    </script>
	    <%}%>
	    </article>
	   <%@ include file="subviews/footer.jsp" %>
	   
	</body>
</html>