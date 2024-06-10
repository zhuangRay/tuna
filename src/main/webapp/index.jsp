<!-- <%@ page pageEncoding="utf8" %> -->
<!DOCTYPE html>
<%@page import="service.ProductService"%>
<%@page import="entity.SpecialOffer"%>
<%@page import="java.util.List"%>
<%@page import="entity.Product"%>
<%@page import="entity.Customer"%>
<html>
	<head>
		<meta charset="UTF8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>首頁</title>
		<link rel="stylesheet" type="text/css" href="./style/tuna.css">

		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
	crossorigin="anonymous"></script>
			<script type="text/javascript">
		var myInterval, index = 0;
		$(document).ready(function init() {
			$(".dot,#next,#prev").click(moveHandler);//run the same function
			myInterval = setInterval(moveHandler, 3000);//initial timer
		});
		function moveHandler(e) {
			clearInterval(myInterval);//reset timer
			myInterval = setInterval(moveHandler, 3000);//set timer
			$(".dot:eq(" + index + ")").css("backgroundColor", " #bad5db");//reset dot color
			if (this == window) {
				index++;//setInterval
			} else if ($(this).attr("myIndex")) {
				index = Number($(this).attr("myIndex"));//.dot
			} else {
				index += Number($(this).attr("direction"));// $#prev / #next
			}
			if (index > 4) index = 0;//last image
			if (index < 0) index = 4;//first image
			$(".dot:eq(" + index + ")").css("backgroundColor", "white");//set dot color
			$("#photos").stop().animate({ "marginLeft": -index * 720 + "px" }, 1000);//image width=735px
			$("#outer").stop().animate({ "backgroundPositionX": -index * 200 + "px" }, 1000);//map width=1000px/5=200px
		}
	</script>
		<style>
		body {
			
		}

		#outer {
			position: relative;
			width: 720px;
			/*image width=720 height=357*/
			overflow: hidden;
			/*background-image: url(images/map.png);*/
			background-color: #d6e5e2;
			margin: auto;
			margin-top:10px;
		}

		#photos {
			position: relative;
			width: 3600px;
			/*image width=720x5=3600px*/
			display: flex;
		}

		#prev,#next {
			position: absolute;
			width: 30px;
			height: 40px;
			color: white;
			cursor: pointer;
			font-size: 3em;
			top: 150px;
			opacity: 0.5;
		}

		#prev {
			left: 0px;
		}

		#next {
			right: 0px;
		}

		#prev:hover,#next:hover {
			opacity: 0.9;
		}

		#dots {
			width: 130px;
			/*(16+5x2)x5=130px*/
			margin: auto;
			display: flex;
		}

		.dot {
			width: 16px;
			height: 16px;
			background-color: #bad5db;
			border-radius: 50%;
			margin: 5px;
		}

		.dot:first-child {
			background-color: white;
		}
		/*文案css*/
		.indexArticle{background-image: url(./images/bar-s.png);
		front-weight:bold;color:white;}
		
		#categoryList{front-size:2em;}
		#categoryList a{color:#64BEAA;font-size:24px;font-weight:bold;display: inline-block;}
	
 

	
	
	
	    #productList{margin:auto;max-width:1280px;min-width:1024px;text-align:center;}
		.productItem img{width:300px;height:290px;display:block;margin:auto}
	  	.productItem{display:inline-block;width:300px;height:290px;vertical-align: top; box-shadow:lightgray 1px 1px 5px;padding: 4px}
	  	
	  	.articleP{color:#64BEAA;font-size:16px;font-weight:bold;display: inline-block;}
	  	
	  	#indexPImage{
				width: 300px;
				height: 290px;		
				overflow: hidden;
				position: relative;
				transition: all 0.5s;
			}
			#indexPName{
				background: #64BEAA;
				opacity: 0.8;
				font-size: 1em;
				color: white;
				text-align: center;
				width:100%;
				height: 50px;
				position: absolute;
				top: 290px;
				transition: all 0.5s;
				transition-delay: 0.2s;
			}
	
			#indexPImage:hover #indexPName{
				top: 230px;
			}
</style>
	</head>
	
	
	<body>

		<jsp:include page="subviews/header.jsp">
			<jsp:param name ="subheader" value="首頁"/>
		</jsp:include>
		<%@ include file="subviews/nav.jsp" %>
		<article>
			
		<div id="outer">
		<div id="photos">
			<a href="product_detail.jsp?productId=1"><img src="./images/image1.jpg"></a>
			<a href="product_detail.jsp?productId=7"><img src="./images/image2.jpg"></a>
			<a href="product_detail.jsp?productId=19"><img src="./images/image3.jpg"></a>
			<a href="product_detail.jsp?productId=8"><img src="./images/image4.jpg"></a>
			<a href="product_detail.jsp?productId=17"><img src="./images/image5.jpg"></a>
		</div>
		<div id="prev" direction="-1">&ltdot;</div>
		<div id="next" direction="1">&gtdot;</div>
		<div id="dots">
			<div class="dot" myIndex="0"></div>
			<div class="dot" myIndex="1"></div>
			<div class="dot" myIndex="2"></div>
			<div class="dot" myIndex="3"></div>
			<div class="dot" myIndex="4"></div>
		</div>
	   </div>
	        <p class="articleP">每日新鮮，每餐驚喜 我們的生鮮電商為您提供每日新鮮的食材，讓您的每一餐都成為一場美味驚喜。無論您是美食家還是健康愛好者，我們都能滿足您對食物的所有期待。</p>
			<p class="articleP">品質保證，新鮮第一 我們堅持只提供最新鮮、最優質的產品。每一道食材都經過嚴格挑選，以確保您和您的家人獲得最好的營養和味覺享受。</p>
			<p class="articleP">健康從這裡開始 在我們的生鮮電商平台上，您可以輕鬆獲得各種新鮮、健康的食材，幫助您開啟健康生活的新篇章。</p>

		</article>
		<div>
		<h1 class="indexArticle">商品總覽</h1>
		
		</div>
		
		
		<div>
<!-- 		帶產品 -->
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
	
	  	
	  	<div id="productList">
	  		<% for(int i=0;i<list.size();i++){
	  			Product p = list.get(i);
	  		%>
	  		<div class="productItem">
	  		<a href="product_detail.jsp?productId=<%= p.getId()%>">
	  		  <div id="indexPImage">
	  		  <img src='<%= p.getPhotoUrl()    %>'>
	  		  <h3 id="indexPName"><%= p.getName() %></h3>
	  		  </div>
	  		</a>
	  		</div>
	  		<% }%>
	  	</div>
	  
	  
	  	<% } %>
		
		</div>
	    <%@ include file="subviews/footer.jsp" %>
	

	

	
	</body>
</html>