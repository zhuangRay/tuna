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
		 body{font-family:  Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", 
		       "LiHei Pro", "微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;}
		article{min-height:70vh }
		#welcomeSpan{float:right}
		
		
		#welcomeSpan{float:right}
		.productItem img{width:150px;display:block;margin:auto}
	  	.productItem{display:inline-block;width:190px;height:260px;vertical-align: top; box-shadow:lightgray 1px 1px 5px;padding: 4px}
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
  		
  		//3.將資料顯示在畫面上
	  %>
<%-- 	  <%= list %> --%>
		<% if(list==null || list.isEmpty()){ %>
		<h2>查無產品資料!</h2>
		<% }else{%>
		<div id = "categoryList">
		<a href="?category=NEWEST">最新上架</a>	
		<a href="?category=鮮活水產">鮮活水產</a>
		<a href="?category=鮮肉">鮮肉</a>
		<a href="?">全部</a>	
		</div>
	  	<div id="productList">
	  		<% for(int i=0;i<list.size();i++){
	  			Product p = list.get(i);
	  		%>
	  		<div class="productItem">
	  		<img src='<%= p.getPhotoUrl()    %>'>
	  		<h3><%= p.getName() %></h3>
	  		<div><%= p instanceof SpecialOffer?((SpecialOffer)p).getDiscountString():"" %><%=p.getUnitPrice() %>  元</div>
	  		</div>
	  		<% }%>

	  	</div>
	  	<% } %>
	  </article> 
		<%@ include file="subviews/footer.jsp" %>
	</body>
</html>