<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>建立訂單成功</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/tuna.css">
	<style>
	     /* 自訂的CSS */
	</style>	
	<script>
	  //自訂的javascript function
	</script>
	
  </head>
	<body>
		<jsp:include page="../subviews/header.jsp">
			<jsp:param name ="subheader" value="結帳成功"/>
			</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		
	  <article>
	  
	  </article>
	   <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>