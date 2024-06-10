<%@page import="entity.Customer"%>
<%@ page pageEncoding="utf8" %>
<!DOCTYPE html>
<html>
	<head>
	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="refresh" content="10; url=./"/>
		<title>登入成功</title>
		<style>
			body{font-family:  Arial, "文泉驛正黑", "WenQuanYi Zen Hei", "儷黑 Pro", 
			"LiHei Pro", "微軟正黑體", "Microsoft JhengHei", "標楷體", DFKai-SB, sans-serif;}
			article{min-height:70vh }
		</style>
	</head>
	<body>
		<header>
		<h1><a href="./">鮪魚鮮生</a><sub>註冊成功</sub></h1>
		<hr>
		</header>
		<nav>
		<a href="login.jsp">會員登入</a>
		<a href="">會員註冊</a>
		<hr>
		</nav>
		<article>
			<% 
			Customer c = (Customer)request.getAttribute("customer");
			
			%>
			<h2><%= c!=null?c.getName(): "沒有c" %>，註冊成功</h2>
			<p>10秒後自動轉址到<a href="./">首頁</a></p>
		</article>
		<footer>
			<hr>
			鮪魚鮮生&copy;2024-04~
		</footer>
	</body>
</html>