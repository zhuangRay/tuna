<%@page import="entity.Customer"%>
<%@ page pageEncoding="utf8" %>


<!DOCTYPE html>
<html>
	<head>
	
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>會員修改</title>
		<link rel="stylesheet" type="text/css" href="../style/tuna.css">
		<style>
		
			article{min-height:70vh }
			.errorsDiv{color:red}
		</style>
		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
		      	crossorigin="anonymous">
		</script>
	
		<script>
		function displayPassword(theCheckbox){
			//alert("displayPassword" + theCheckbox.checked);
			if(theCheckbox.checked){
				password.type="";	
			}else{
				password.type ="password";
			}
		}
		function refreshCaptcha(){
			var now = new Date();
			//alert("refresh Captcha"+now);
			captchaImg.src="../images/captcha_login.png?attr=" + now;
			
		}
		$(init);
		function init(){
			<% if("POST".equals(request.getMethod())) {%>
				repopulateForm();
			<% }else if("GET".equals(request.getMethod())) {%>
			    populateMemberData()
			<% } %>
		}
		function populateMemberData(){
<%--			alert("你享有${sessionScope.member.discountString}優惠");--%>
			$("input[name=id]").val('${sessionScope.member.getId()}');
			$("input[name=email]").val('${sessionScope.member.getEmail()}');
			$("input[name=phone]").val('${sessionScope.member.phone}');
			$("input[name=name]").val('${sessionScope.member.name}');
			$("input[name=birthday]").val('${member.birthday}');
			$("select[name=gender]").val('${member.gender}');
			$("textarea[name=address]").val('${member.address}');
			$("input[name=subscribed]").prop("checked",${member.subscribed!=null});
			
		}
		function repopulateForm(){
			alert("修改會員失敗，請修正錯誤再重新修改");
			$("input[name=id]").val('${param.id}');
			$("input[name=email]").val('${param.email}');
			$("input[name=phone]").val('${param.phone}');
			$("input[name=name]").val('${param.name}');
			$("input[name=birthday]").val('${param.birthday}');
			$("select[name=gender]").val('${param.gender}');
			$("textarea[name=address]").val('${param.address}');
			$("input[name=subscribed]").prop("checked",${parm.subscribed!=null});
			
		}
		</script>
		</head>
	<body>
		<jsp:include page="../subviews/header.jsp">
			<jsp:param name ="subheader" value="首頁"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		
		<article>
			<div class ="errorsDiv" >
			${errors}
			</div>
			<form action="" method="POST">
				<p>
					<label class="inputLabel" >帳號:</label>
					<input type='text' readonly  name="id">
<!-- 					<span>		 -->
<!-- 					<input type="checkbox" checked disabled><label>享有VIP$<span id="disvount">85折</span></label> -->
<!-- 				    </span> -->
<!-- 				</p>	 -->
				
				<p>
					<label class="inputLabel" >email:</label>
					<input type='email' required  name="email" placeholder="請輸入email">	
				</p>	
				
				<p>
					<label class="inputLabel" >手機:</label>
					<input type='tel' required  name="phone" placeholder="請輸入手機號碼">	
				</p>
				
				<p>
					<label class="inputLabel" >姓名:</label>
					<input type='text' required  name="name" placeholder="請輸入姓名"
					         minlength="2" maxlength="20">	
				</p>
				
				<p>
					<label class="inputLabel">	密碼:</label>
					<input type="password" id="password" name="password" required placeholder="請輸入現在密碼" 
							minlength="6" maxlength="20">		
					<input type = "checkbox" onchange="displayPassword(this)"><label>顯示密碼</label>
				</p>
			<fieldset>
				<legend><input type = "checkbox">我要修改密碼</legend>
				<label class="inputLabel">新密碼:</label>
				<input type="password" name="newPassword" disabled placeholder="請輸入現在密碼" 
					minlength="6" maxlength="20">
			</fieldset>
			
			
			
			<p>
			<label class="inputLabel">	生日:</label>	
			<input type='date'  name="birthday"required max="2012-04-22">
			</p>
				
			<p>
			<label class="inputLabel">性別:</label>	
			<select name="gender" required>
				<option value="">請選擇...</option>
				<option value="M">男</option>
				<option value="F">女</option>
				<option value="O">其它</option>					
			</select>
			</p>	
			
			<p>
			<label class="inputLabel">地址:</label>	
			<textarea row="3" cols="20" name="address">	</textarea>
			</p>
			
			<p>
			<input type = "checkbox" name="subscribed" ><label>是否訂閱電子報</label>
			</p>
					
			<p>
			<label class="inputLabel">驗證碼:</label>
			<input type="text" name="captcha" required placeholder="請輸入驗證碼">
			<img id="captchaImg"alt="驗證碼圖片" src="../images/captcha_login.png" 
						title="點選圖片即可更新" onclick="refreshCaptcha()">				
			</p>	
				
			<input type="submit" value="修改會員">
	   </form>
		</article>
		 <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>