<%@page import="entity.Customer"%>
<%@ page pageEncoding="utf8" %>
<!DOCTYPE html>
<html>
	<head>
	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="refresh" content="10; url=${pageContext.request.contextPath}"/>
		<title>登入成功</title>
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/style/tuna.css">
		<style>
			article{min-height:70vh }
		</style>
	</head>
	<body>
		<jsp:include page="../subviews/header.jsp">
			<jsp:param name ="subheader" value="修改會員成功"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		<article>
			<% 
			  //Customer c = (Customer)request.getAttribute("member");
			
			%>
			<h2><%= member!=null?member.getName(): "沒有member" %>，修改成功</h2>
			<p>10秒後自動轉址到<a href="./">首頁</a></p>
		</article>
		 <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>