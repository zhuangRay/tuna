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
	<style>
		  /* 共用css*/
			body{font-family:  Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", 
			      "LiHei Pro", "微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;}
			article{min-height:70vh }
	     	#welcomeSpan{float:right}
		  /* 共用css end*/
		  #tunaImg{height:90px;width:90px;margin:-100px 295px 0px;opacity:0.5;}
		.productItem img{height:150px;width:150px;display:block;margin:auto}
	  	.productItem{display:inline-block;width:190px;height:270px;vertical-align: top; box-shadow:lightgray 1px 1px 5px;padding: 4px}
	  	
	  	
	  	.productPrice{margin-top: auto;}
	  	#categoryList{background:#003E52;height:52px;opacity:0.9;}
	  	#categoryList a{color:#b69664;font-size:24px;font-weight:bold;display: inline-block;}
	  	#categoryList a:hover{color: orange;}
		#categoryList a:active{color: red;}
	  	#categoryList ul{list-style: none;margin: 0px;width: 750px;margin: auto;}
	  	#categoryList li{float: left;padding: 10px 10px;border-left: 1px solid white;margin: 0px 0px;}
	  	.lastLi{border-right: 1px solid white;}
	
	  	a   {text-decoration: overline;
			text-decoration: underline;
			text-decoration: line-through;
			text-decoration: none;
		    }
		a:link{color: #bc955c;}a:visited{color: #bc955c;}a:hover{color: orange;}a:active{color: red;}
	</style>	
	<script>
	  //自訂的javascript function
	</script>
  </head>
	<body>
		<jsp:include page="subviews/header.jsp">
		   <jsp:param name="subheader" value="我的鮮生"/>
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
		<li><a href="?category=NEWEST">最新上架</a></li>	
		<li><a href="?category=鮮活水產">鮮活水產</a></li>
		<li><a href="?category=鮮肉">鮮肉</a></li>
		<li><a href="?category=冷凍食品">冷凍食品</a></li>
		<li><a href="?category=常溫">常溫</a></li>
		<li class="lastLi"><a href="?">全部</a></li>
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
	  		<div class="productPrice"><%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %><%=p.getUnitPrice() %>  元</div>
	  		</div>
	  		<% }%>

	  	</div>
	  	<% } %>
	  </article> 
		<%@ include file="subviews/footer.jsp" %>
	</body>
</html>