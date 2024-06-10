<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>404</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/tuna.css">
	<style>
	    h1{text-align: center}
	     img{
	      width:85%;
	      display:block;
	      margin:auto;
	      max-width:720px;
	     }
	</style>	
	<script>
	  //自訂的javascript function
	</script>
	
  </head>
	<body>
	   <jsp:include page="/subviews/header.jsp">
	   		<jsp:param name="subheader" value="找不到網頁"/>
	   </jsp:include>
	   <%@ include file="/subviews/nav.jsp" %>
	   <article>
	   		<div>
	   			<h1>網頁URL: <br><%= request.getAttribute("javax.servlet.error.request_uri") %></h1>
	   			<img src="<%=request.getContextPath() %>/images/404.png">
	   		</div>
	   
	   </article>
	   <%@ include file ="/subviews/footer.jsp" %>
	</body>
</html>