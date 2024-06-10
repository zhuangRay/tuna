<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>***Insert title here***</title>
	<style>
	    /* 共同的css */
			body{font-family: Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", "LiHei Pro",     
    					"微軟正黑體","Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;} 
			article{min-height: 70vh}
			#welcomeSpan{float:right}		
		/* 共同的css end */		
		
		 	.listPrice{color:gray;text-decoration: line-through;}
		 	.discount, .price{color:purple;font-size: larger;}
		 	#leftDiv{float:left;width:48%}
		 	#leftDiv img{width:85%;max-width: 325px;min-width: 170px}
		 	#rightDiv{float:left;width:50%}
		 	#descriptionDiv{clear: both}
		 	
		 	/* HIDE RADIO */
			.colorDiv input[type=radio] { 
			  position: absolute;
			  opacity: 0;
			  width: 10;
			  height: 10;
			}
			
			/* IMAGE STYLES */
			.colorDiv input[type=radio] + img {
			  cursor: pointer;
			}
			
			/* CHECKED STYLES */
			.colorDiv input[type=radio]:checked + img {
			  outline: 2px solid red;
			}
		</style>
		<script>
			//自訂的javascript function
		</script>
	</head>
	<body>
		
	<!-- header.jsp start -->
		
		<header>
			<h1>
				<a href="./">非常好書</a>
				<sub>產品明細</sub>
			</h1>
			<form action="products_list.jsp" method="GET">
				<input type="search" name="keyword" required value="">
				<input type="submit" value="搜尋">
			</form>
			<hr>
		</header>
	<!-- header.jsp end -->
		
		

	<!-- nav.jsp start -->
			<nav>
			<a href="products_list.jsp">逛書店</a> |	
			
				<a href="login.jsp">會員登入</a> | 
				<a href="register.jsp">會員註冊</a> |
			
			<span id='welcomeSpan'><span>Hello! </span>你好</span>
			<hr>
		</nav>
	<!-- nav.jsp end -->
		<article>
			
			
			
			<div id='leftDiv'>
				<img src="https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/134/81/N001348198.jpg&v=614d9446k&w=348&h=348">
			</div>
			<div id='rightDiv'>
				<h3>KUTSUWA 初學者安全圓規</h3>
				<div>
					<label>分類: </label>	
					<a href="products_list.jsp?category=文具">文具</a>
				</div>
				<div>
					<label>上架日期: </label>	
					<span>2024-04-16</span>
				</div>				
				
				<div>
					<label>優惠價: </label>
					<span class="discount"></span>
					<span class="price">190.0</span>元 
				</div>
				<div>
					<label>庫存: </label>
					<span>2</span>件
				</div>
				<form >
					<input type="hidden" name="productId" value="5">
					<div class="colorDiv">
						<label>顏色: </label>
						<label>
							<input type="radio" name="color" value="黃綠雙" required>
							<img src="https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/134/81/N001348198.jpg&v=614d9446k&w=48&h=48" alt="黃綠雙" title="黃綠雙">
						</label>
						<label>
							<input type="radio" name="color" value="藍" required>
							<img src="https://im1.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/134/81/N001348196.jpg&v=614d9446k&w=48&h=48" alt="藍" title="藍">
						</label>
						<label>
							<input type="radio" name="color" value="紫" required>
							<img src="https://im2.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/134/81/N001348197.jpg&v=614d9446k&w=48&h=48" alt="紫"  title="紫">
						</label>
						<label>
							<input type="radio" name="color" value="黑" required>
							<img src="https://im2.book.com.tw/image/getImage?i=https://www.books.com.tw/img/N00/134/81/N001348195.jpg&v=614d9446k&w=48&h=48" alt="黑"  title="黑">
						</label>
					</div>
					<label>數量: </label>					
					<input type="number" name="quantity" min=1 max="2" required >
					<input type="submit" value="加入購物車">
				</form>
			</div>
			<div id='descriptionDiv'>
				<hr>
				
			</div>
			
		</article>
		
	<!-- footer.jsp start -->
		<footer>
			<hr>
			非常好書&copy;2024-04~
		</footer>
	<!-- footer.jsp end -->
	</body>
</html>