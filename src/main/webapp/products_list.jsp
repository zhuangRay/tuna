<%@page import="entity.SpecialOffer"%>
<%@page import="entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>產品清單</title>
	<link rel="stylesheet" type="text/css" href="./style/tuna.css">
	<style>
	  

	  
	  
	  	#productList{margin:auto;max-width:1280px;min-width:1024px;text-align:center;}
		.productItem img{width:300px;height:290px;display:block;margin:auto}
	  	.productItem{display:inline-block;width:360px;height:460px;vertical-align: top; box-shadow:lightgray 1px 1px 5px;padding: 4px}
	  	
				
				/*  #categoryList a{display: inline-block;}  
	  			#categoryList a:hover{color: orange;} #categoryList a:active{color: red;}
	  			#categoryList ul{list-style: none;margin: 0px;width: 750px;margin: auto;}
	  				#categoryList li{float: left;padding: 10px 10px;border-left: 1px solid white;margin: 0px 0px;}*/
	 
	  	#categoryList{background:#DDDFD9;height:52px;opacity:0.9;}
	  	#categoryList a{color:#b69664;font-size:24px;font-weight:bold;display: inline-block;}
	  	#categoryList a:hover{color: orange;} #categoryList a:active{color: red;}
		#categoryList ul{list-style: none;margin: 0px;width: 750px;margin: auto;}
	  	#categoryList li{float: left;padding: 10px 10px;border-left: 1px solid white;margin: 0px 0px;}

	    .lastLi{border-right: 1px solid white;}
		/*連結底線特效*/
		#categoryList{
		display: flex;
	}
	.categoryListA{
		width: 100px;
		text-align: center;
		border:0px solid silver;
	}
	.categoryListA:hover div{
		width: 50px;
	}
	.categoryListA div{
		border-bottom: 3px solid white;
		width: 0px;
		margin: auto;
		transition: width 0.5s;
	}
		/*連結底線特效*/
	</style>	
	<script>
	  //自訂的javascript function
	</script>
  </head>
	<body>
		<jsp:include page="subviews/header.jsp">
		   <jsp:param name="subheader" value=""/>
		   </jsp:include>
		<%@ include file="subviews/nav.jsp" %>
	
	  <article>
	  <%
	   //request.setCharacterEncoding("utf8"); //當request為get請求可省略，url中的queryString資料一棟是utf8
	   //1. 讀取request 的query string中指定parameter
	  	String category = request.getParameter("category");
	    String keyword = request.getParameter("keyword");
	    
	  	ProductService pService = new ProductService();
  		List<Product> list ;
  		if("NEWEST".equals(category)){
  			list = pService.getNewestProducts();
  		}else if(category!=null&&category.length()>0){
  			list = pService.getProductsByCategory(category);
  		}else if(keyword!=null && (keyword=keyword.trim()).length()>0){
  	  		list = pService.getProductsByKeyword(keyword);
  		}else{
  			list = pService.getAllProducts();
  		}
	  %>
<%-- 	  <%= list %> --%>
		<% if(list==null || list.isEmpty()){ %>
		<h2>查無產品資料!</h2>
		<% }else{%>
		<div id = "categoryList">
		<ul>
		<li><a class="categoryListA" href="?category=NEWEST">最新上架<div></div></a></li>	
		<li><a class="categoryListA" href="?category=鮮活水產">鮮活水產<div></div></a></li>
		<li><a class="categoryListA" href="?category=鮮肉">鮮肉<div></div></a></li>
		<li><a class="categoryListA" href="?category=冷凍食品">冷凍食品<div></div></a></li>
		<li><a class="categoryListA" href="?category=常溫">常溫<div></div></a></li>
		<li class="lastLi"><a class="categoryListA" href="?">全部<div></div></a></li>
		</ul>
		</div>
	  	
	  	<div id="productList">
	  		<% for(int i=0;i<list.size();i++){
	  			Product p = list.get(i);
	  		%>
	  		<div class="productItem">
	  		<a href="product_detail.jsp?productId=<%= p.getId()%>">
	  		  <img src='<%= p.getPhotoUrl()    %>'>
	  		  <h3><%= p.getName() %></h3>
	  		</a>
	  		<div>
	  		  優惠價:<%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %><%=p.getUnitPrice() %>  元
	  		</div>
	  		  <span>庫存:<%=p.getStock()%>件</span> 
	  		</div>
	  		<% }%>
	  	</div>
	  
	  	<% } %>
	  </article> 
		<%@ include file="subviews/footer.jsp" %>
	</body>
</html>